<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed, watch, nextTick } from 'vue';
// Import html2canvas library - add this line
import html2canvas from 'html2canvas';
import Navbar from '../Navbar.vue';
import Footer from '../Footer.vue';

const stream = ref<MediaStream | null>(null);
const video = ref<HTMLVideoElement | null>(null);
const photoCount = ref<number>(4);
const countdown = ref<number>(0);
const photos = ref<string[]>([]);
const selectedFilter = ref<string>('none');
const isCapturing = ref<boolean>(false);
const cardBackgroundColor = ref<string>('#ffffff');
const showPreview = ref<boolean>(true);
const availableCameras = ref<MediaDeviceInfo[]>([]);
const selectedCameraId = ref<string>('');
const isCameraListLoading = ref<boolean>(true);
const orientation = ref<'horizontal' | 'vertical'>('horizontal');
const theme = ref<'dark' | 'light'>('dark');
const isFullscreen = ref<boolean>(false);
const photosPerRow = ref<number>(2);

// Additional settings
const filterIntensity = ref<number>(100);
const borderRadius = ref<number>(8);
const photoSpacing = ref<number>(2);
const showCountdownAnimation = ref<boolean>(true);

const isDarkTheme = computed(() => theme.value === 'dark');

const filters = {
    none: '',
    grayscale: () => `grayscale(${filterIntensity.value}%)`,
    sepia: () => `sepia(${filterIntensity.value}%)`,
    blur: () => `blur(${filterIntensity.value / 50}px)`,
    brightness: () => `brightness(${100 + filterIntensity.value}%)`,
    contrast: () => `contrast(${100 + filterIntensity.value}%)`,
    invert: () => `invert(${filterIntensity.value}%)`,
    saturate: () => `saturate(${filterIntensity.value + 100}%)`,
};

const currentFilter = computed(() => {
    const filterFn = filters[selectedFilter.value as keyof typeof filters];
    return typeof filterFn === 'function' ? filterFn() : '';
});

const cardPreviewStyle = computed(() => {
    return {
        backgroundColor: cardBackgroundColor.value,
        borderRadius: `${borderRadius.value}px`,
    };
});

const gridTemplateColumns = computed(() => {
    if (orientation.value === 'horizontal') {
        return `repeat(${photosPerRow.value}, 1fr)`;
    }
    return '1fr';
});

const photocardAspectRatio = computed(() => {
    return orientation.value === 'horizontal' ? 'aspect-w-16 aspect-h-9' : 'aspect-w-9 aspect-h-16';
});

const themeClasses = computed(() => {
    return isDarkTheme.value ? {
        bg: 'bg-gray-900',
        text: 'text-white',
        card: 'bg-gray-800',
        input: 'bg-gray-700 text-white',
        button: {
            primary: 'bg-blue-600 hover:bg-blue-700',
            secondary: 'bg-gray-600 hover:bg-gray-700',
            success: 'bg-green-600 hover:bg-green-700',
            danger: 'bg-red-600 hover:bg-red-700',
        },
        border: 'border-gray-700',
    } : {
        bg: 'bg-gray-100',
        text: 'text-gray-900',
        card: 'bg-white shadow-md',
        input: 'bg-gray-200 text-gray-900',
        button: {
            primary: 'bg-blue-500 hover:bg-blue-600',
            secondary: 'bg-gray-300 hover:bg-gray-400',
            success: 'bg-green-500 hover:bg-green-600',
            danger: 'bg-red-500 hover:bg-red-600',
        },
        border: 'border-gray-300',
    };
});

onMounted(async () => {
    try {
        await loadCameras();
        
        // Listen for fullscreen change events
        document.addEventListener('fullscreenchange', updateFullscreenState);
        document.addEventListener('webkitfullscreenchange', updateFullscreenState);
    } catch (err) {
        console.error('Error accessing camera devices:', err);
    }
});

onUnmounted(() => {
    stopMediaStream();
    document.removeEventListener('fullscreenchange', updateFullscreenState);
    document.removeEventListener('webkitfullscreenchange', updateFullscreenState);
});

// Watch for changes to orientation and adjust photos per row
watch(orientation, (newValue) => {
    if (newValue === 'vertical') {
        photosPerRow.value = 1;
    } else if (photosPerRow.value < 2) {
        photosPerRow.value = 2;
    }
});

// Watch for changes to isCapturing state and reconnect camera when needed
watch(isCapturing, async (newValue) => {
    if (newValue) {
        // When starting capture, wait for DOM update then reconnect camera
        await nextTick();
        await connectStreamToVideo();
    }
});

const updateFullscreenState = () => {
    isFullscreen.value = Boolean(
        document.fullscreenElement || 
        (document as any).webkitFullscreenElement
    );
};

const toggleFullscreen = async () => {
    try {
        if (!isFullscreen.value) {
            const elem = document.documentElement;
            if (elem.requestFullscreen) {
                await elem.requestFullscreen();
            } else if ((elem as any).webkitRequestFullscreen) {
                await (elem as any).webkitRequestFullscreen();
            }
        } else {
            if (document.exitFullscreen) {
                await document.exitFullscreen();
            } else if ((document as any).webkitExitFullscreen) {
                await (document as any).webkitExitFullscreen();
            }
        }
    } catch (err) {
        console.error('Error toggling fullscreen:', err);
    }
};

const loadCameras = async () => {
    isCameraListLoading.value = true;
    try {
        // First request permission to access media devices
        const initialStream = await navigator.mediaDevices.getUserMedia({ video: true });
        
        // Stop the initial stream since we just needed it for permissions
        initialStream.getTracks().forEach(track => track.stop());
        
        // Now get the list of available video devices
        const devices = await navigator.mediaDevices.enumerateDevices();
        availableCameras.value = devices.filter(device => device.kind === 'videoinput');
        
        if (availableCameras.value.length > 0) {
            selectedCameraId.value = availableCameras.value[0].deviceId;
            await startCamera();
        }
    } catch (err) {
        console.error('Error loading cameras:', err);
    } finally {
        isCameraListLoading.value = false;
    }
};

const stopMediaStream = () => {
    if (stream.value) {
        stream.value.getTracks().forEach(track => track.stop());
        stream.value = null;
    }
};

// Connect existing stream to video element
const connectStreamToVideo = async () => {
    await nextTick();
    if (video.value && stream.value) {
        video.value.srcObject = stream.value;
        
        // Make sure video is playing
        try {
            await video.value.play();
        } catch (err) {
            console.error('Error playing video:', err);
        }
    }
};

const startCamera = async () => {
    stopMediaStream();
    
    if (!selectedCameraId.value) return;
    
    try {
        stream.value = await navigator.mediaDevices.getUserMedia({
            video: {
                deviceId: { exact: selectedCameraId.value }
            }
        });
        
        await connectStreamToVideo();
    } catch (err) {
        console.error('Error starting camera:', err);
    }
};

const handleCameraChange = async () => {
    await startCamera();
};

const startCapture = async () => {
    if (photos.value.length > 0) {
        photos.value = [];
    }

    isCapturing.value = true;
    
    // Make sure stream is connected to video
    await connectStreamToVideo();
    
    for (let i = 0; i < photoCount.value; i++) {
        if (showCountdownAnimation.value) {
            countdown.value = 3;
            while (countdown.value > 0) {
                await new Promise(resolve => setTimeout(resolve, 1000));
                countdown.value--;
            }
        } else {
            // Brief pause before taking photo
            await new Promise(resolve => setTimeout(resolve, 500));
        }
        takePhoto();
        if (i < photoCount.value - 1) {
            await new Promise(resolve => setTimeout(resolve, 1000));
        }
    }
    isCapturing.value = false;
};

const takePhoto = () => {
    if (video.value) {
        const canvas = document.createElement('canvas');
        canvas.width = video.value.videoWidth;
        canvas.height = video.value.videoHeight;
        const ctx = canvas.getContext('2d');
        if (ctx) {
            ctx.filter = currentFilter.value;
            ctx.drawImage(video.value, 0, 0);
            photos.value.push(canvas.toDataURL('image/png'));
        }
    }
};

const downloadPhotos = async () => {
    try {
        const container = document.createElement('div');
        container.style.display = 'grid';
        container.style.gridTemplateColumns = gridTemplateColumns.value;
        // Fix here: removed .value from photoSpacing since it's a primitive number
        container.style.padding = '20px';
        container.style.backgroundColor = cardBackgroundColor.value;
        container.style.borderRadius = `${borderRadius.value}px`;
        
        // Set the orientation of the container
        if (orientation.value === 'vertical') {
            container.style.width = '600px';
            container.style.height = '900px';
        } else {
            container.style.width = '900px';
            container.style.height = '600px';
        }

        photos.value.forEach(photo => {
            const imgContainer = document.createElement('div');
            imgContainer.style.overflow = 'hidden';
            imgContainer.style.borderRadius = `${borderRadius.value}px`;
            
            const img = document.createElement('img');
            img.src = photo;
            img.style.width = '100%';
            img.style.height = '100%';
            img.style.objectFit = 'cover';
            img.style.filter = currentFilter.value;
            
            imgContainer.appendChild(img);
            container.appendChild(imgContainer);
        });

        document.body.appendChild(container);
        // Now html2canvas should be properly recognized
        const canvas = await html2canvas(container);
        document.body.removeChild(container);

        const link = document.createElement('a');
        link.download = `photocard-${orientation.value}.png`;
        link.href = canvas.toDataURL('image/png');
        link.click();
    } catch (err) {
        console.error('Error downloading photos:', err);
        // Fallback method
        if (photos.value.length > 0) {
            const link = document.createElement('a');
            link.download = 'photo.png';
            link.href = photos.value[0];
            link.click();
        }
    }
};

// Reset everything and start over
const reset = () => {
    photos.value = [];
    selectedFilter.value = 'none';
    startCamera();
};

// Toggle between dark and light themes

</script>

<template>
    <Navbar/>
    <div :class="[themeClasses.bg, themeClasses.text, 'min-h-screen transition-colors duration-300 pt-24']">
        <div class="container max-w-6xl p-4 mx-auto">
            <div v-if="isCameraListLoading" class="flex items-center justify-center p-8">
                <div class="w-12 h-12 border-4 rounded-full border-t-transparent animate-spin" :class="themeClasses.border"></div>
                <span class="ml-3 text-lg">Loading cameras...</span>
            </div>

            <div v-else-if="availableCameras.length === 0" class="p-6 mb-4 text-center text-red-800 bg-red-100 rounded-lg">
                <p class="text-lg font-semibold">No cameras detected</p>
                <p class="mt-2">Please connect a camera and refresh the page.</p>
            </div>

            <div v-else>
                <!-- Settings Panel (when no photos taken yet) -->
                <div class="mb-8" v-if="!isCapturing && photos.length === 0">
                    <div class="grid grid-cols-1 gap-6 lg:grid-cols-3 md:grid-cols-2">
                        <!-- Camera Settings -->
                        <div class="p-4 rounded-lg" :class="themeClasses.card">
                            <h2 class="mb-4 text-xl font-semibold">Camera Settings</h2>
                            
                            <label class="block mb-4 text-left">
                                Select Camera:
                                <select 
                                    v-model="selectedCameraId" 
                                    @change="handleCameraChange"
                                    class="w-full px-2 py-2 mt-1 transition-colors rounded"
                                    :class="themeClasses.input">
                                    <option 
                                        v-for="camera in availableCameras" 
                                        :key="camera.deviceId" 
                                        :value="camera.deviceId">
                                        {{ camera.label || `Camera ${availableCameras.indexOf(camera) + 1}` }}
                                    </option>
                                </select>
                            </label>
                            
                            <div class="mb-4">
                                <label class="flex items-center mb-2">
                                    <input type="checkbox" v-model="showCountdownAnimation" class="mr-2">
                                    Show Countdown Timer
                                </label>
                            </div>
                        </div>
                        
                        <!-- Photocard Settings -->
                        <div class="p-4 rounded-lg" :class="themeClasses.card">
                            <h2 class="mb-4 text-xl font-semibold">Photocard Settings</h2>
                            
                            <label class="block mb-4 text-left">
                                Orientation:
                                <div class="flex gap-2 mt-1">
                                    <button 
                                        @click="orientation = 'horizontal'" 
                                        class="flex items-center justify-center flex-1 px-3 py-2 font-medium transition-colors rounded"
                                        :class="orientation === 'horizontal' ? themeClasses.button.primary : themeClasses.button.secondary">
                                        Horizontal
                                    </button>
                                    <button 
                                        @click="orientation = 'vertical'" 
                                        class="flex items-center justify-center flex-1 px-3 py-2 font-medium transition-colors rounded"
                                        :class="orientation === 'vertical' ? themeClasses.button.primary : themeClasses.button.secondary">
                                        Vertical
                                    </button>
                                </div>
                            </label>
                            
                            <label class="block mb-4 text-left">
                                Number of photos:
                                <input 
                                    type="number" 
                                    v-model="photoCount" 
                                    min="1" 
                                    max="8" 
                                    class="w-full px-2 py-2 mt-1 transition-colors rounded"
                                    :class="themeClasses.input">
                            </label>
                            
                            <label v-if="orientation === 'horizontal'" class="block mb-4 text-left">
                                Photos per row:
                                <input 
                                    type="number" 
                                    v-model="photosPerRow" 
                                    min="1" 
                                    :max="photoCount" 
                                    class="w-full px-2 py-2 mt-1 transition-colors rounded"
                                    :class="themeClasses.input">
                            </label>
                            
                            <label class="block mb-4 text-left">
                                Photo spacing:
                                <input 
                                    type="range" 
                                    v-model="photoSpacing" 
                                    min="0" 
                                    max="6" 
                                    class="w-full mt-1"
                                    :class="themeClasses.input">
                            </label>
                        </div>
                        
                        <!-- Style Settings -->
                        <div class="p-4 rounded-lg" :class="themeClasses.card">
                            <h2 class="mb-4 text-xl font-semibold">Style Settings</h2>
                            
                            <label class="block mb-4 text-left">
                                Background Color:
                                <input 
                                    type="color" 
                                    v-model="cardBackgroundColor" 
                                    class="w-full h-10 mt-1 rounded"
                                    :class="themeClasses.input">
                            </label>
                            
                            <label class="block mb-4 text-left">
                                Border Radius:
                                <input 
                                    type="range" 
                                    v-model="borderRadius" 
                                    min="0" 
                                    max="24" 
                                    class="w-full mt-1"
                                    :class="themeClasses.input">
                            </label>
                        </div>
                    </div>

                    <!-- Preview & Capture Button -->
                    <div class="grid grid-cols-1 gap-6 mt-6 md:grid-cols-3">
                        <div class="p-4 rounded-lg md:col-span-2" :class="themeClasses.card">
                            <div class="overflow-hidden rounded-lg" :style="{ borderRadius: `${borderRadius}px` }">
                                <video 
                                    ref="video" 
                                    autoplay 
                                    playsinline 
                                    class="object-cover w-full"
                                    :class="[orientation === 'vertical' ? 'aspect-w-9 aspect-h-16' : 'aspect-w-16 aspect-h-9']">
                                </video>
                            </div>
                        </div>
                        
                        <div class="flex flex-col p-4 rounded-lg" :class="themeClasses.card">
                            <h2 class="mb-4 text-xl font-semibold">Photocard Preview</h2>
                            <div class="flex-grow p-3 rounded-lg" :style="cardPreviewStyle">
                                <div class="grid h-full gap-2" :style="{ gridTemplateColumns: gridTemplateColumns }">
                                    <div 
                                        v-for="i in photoCount" 
                                        :key="i" 
                                        class="flex items-center justify-center text-gray-500 bg-gray-200 rounded"
                                        :style="{ borderRadius: `${borderRadius}px` }">
                                        Photo {{ i }}
                                    </div>
                                </div>
                            </div>
                            <button 
                                @click="startCapture" 
                                class="w-full px-6 py-3 mt-4 text-lg font-semibold text-white transition-colors rounded-lg"
                                :class="themeClasses.button.primary">
                                Start Capture
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Camera view during capture -->
                <div class="relative" v-if="(showPreview && photos.length === 0) || isCapturing">
                    <video 
                        v-if="isCapturing"
                        ref="video" 
                        autoplay 
                        playsinline 
                        class="w-full mx-auto rounded-lg shadow-lg"
                        :class="[
                            orientation === 'vertical' ? 'max-w-md' : 'max-w-2xl'
                        ]">
                    </video>

                    <div v-if="countdown > 0"
                        class="absolute inset-0 flex flex-col items-center justify-center bg-black bg-opacity-50 rounded-lg">
                        <div class="relative">
                            <div 
                                class="flex items-center justify-center w-24 h-24 text-6xl font-bold text-white rounded-full"
                                :class="themeClasses.button.primary">
                                {{ countdown }}
                            </div>
                            <svg class="absolute inset-0 w-24 h-24 -rotate-90">
                                <circle
                                    cx="48"
                                    cy="48"
                                    r="46"
                                    fill="transparent"
                                    stroke="white"
                                    stroke-width="4"
                                    stroke-dasharray="289"
                                    :stroke-dashoffset="(countdown / 3) * 289"
                                    class="transition-all duration-1000"
                                />
                            </svg>
                        </div>
                        <p class="mt-4 text-lg text-white">Get ready!</p>
                    </div>
                </div>

                <!-- Photo Results and Editing -->
                <div v-if="photos.length > 0" class="mt-8">
                    <div class="grid grid-cols-1 gap-6 lg:grid-cols-3 md:grid-cols-2">
                        <!-- Photo Settings -->
                        <div class="p-4 rounded-lg" :class="themeClasses.card">
                            <h2 class="mb-4 text-xl font-semibold">Photo Settings</h2>
                            
                            <div class="mb-4">
                                <label class="block mb-2">Filter:</label>
                                <select 
                                    v-model="selectedFilter" 
                                    class="w-full px-4 py-2 transition-colors rounded"
                                    :class="themeClasses.input">
                                    <option v-for="(_, filter) in filters" :key="filter" :value="filter">
                                        {{ filter.charAt(0).toUpperCase() + filter.slice(1) }}
                                    </option>
                                </select>
                            </div>
                            
                            <div class="mb-4">
                                <label class="block mb-2">Filter Intensity: {{ filterIntensity }}%</label>
                                <input 
                                    type="range" 
                                    v-model="filterIntensity" 
                                    min="0" 
                                    max="100" 
                                    class="w-full"
                                    :class="themeClasses.input">
                            </div>
                            
                            <div class="mb-4">
                                <label class="block mb-2">Background Color:</label>
                                <input 
                                    type="color" 
                                    v-model="cardBackgroundColor" 
                                    class="w-full h-10 transition-colors rounded"
                                    :class="themeClasses.input">
                            </div>
                            
                            <div class="mb-4">
                                <label class="flex items-center mb-2">
                                    <input type="checkbox" v-model="showPreview" class="mr-2">
                                    Show Camera Preview
                                </label>
                            </div>
                            
                            <div class="mb-4">
                                <label class="block mb-2">Layout:</label>
                                <div class="flex gap-2">
                                    <button 
                                        @click="orientation = 'horizontal'" 
                                        class="flex-1 px-3 py-2 font-medium transition-colors rounded"
                                        :class="orientation === 'horizontal' ? themeClasses.button.primary : themeClasses.button.secondary">
                                        Horizontal
                                    </button>
                                    <button 
                                        @click="orientation = 'vertical'" 
                                        class="flex-1 px-3 py-2 font-medium transition-colors rounded"
                                        :class="orientation === 'vertical' ? themeClasses.button.primary : themeClasses.button.secondary">
                                        Vertical
                                    </button>
                                </div>
                            </div>
                            
                            <div v-if="orientation === 'horizontal'" class="mb-4">
                                <label class="block mb-2">Photos per row:</label>
                                <input 
                                    type="number" 
                                    v-model="photosPerRow" 
                                    min="1" 
                                    :max="photoCount" 
                                    class="w-full px-4 py-2 transition-colors rounded"
                                    :class="themeClasses.input">
                            </div>
                        </div>
                        
                        <!-- Photocard Preview -->
                        <div class="p-4 rounded-lg md:col-span-2" :class="themeClasses.card">
                            <h2 class="mb-4 text-xl font-semibold">Photocard Preview</h2>
                            <div 
                                class="p-3 mx-auto rounded-lg"
                                :class="[photocardAspectRatio, orientation === 'vertical' ? 'max-w-sm' : 'max-w-2xl']"
                                :style="cardPreviewStyle">
                                <div class="grid h-full" :style="{ gridTemplateColumns, gap: `${photoSpacing * 0.25}rem` }">
                                    <div 
                                        v-for="(photo, index) in photos" 
                                        :key="index" 
                                        class="overflow-hidden"
                                        :style="{ borderRadius: `${borderRadius}px` }">
                                        <img 
                                            :src="photo" 
                                            :style="{ filter: currentFilter }"
                                            class="object-cover w-full h-full">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex flex-wrap justify-center gap-4 mt-8">
                        <button 
                            @click="startCapture" 
                            class="px-6 py-3 text-white transition-colors rounded-lg"
                            :class="themeClasses.button.primary">
                            Retake Photos
                        </button>
                        <button 
                            @click="downloadPhotos" 
                            class="px-6 py-3 text-white transition-colors rounded-lg"
                            :class="themeClasses.button.success">
                            Download Photocard
                        </button>
                        <button 
                            @click="reset" 
                            class="px-6 py-3 text-white transition-colors rounded-lg"
                            :class="themeClasses.button.secondary">
                            Reset All
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <Footer/>
</template>