<script>
import AdminLayout from './Layout.vue';
export default {
    data() {
        return {
            events: [
                {
                    title: 'Regenetics',
                    date: '2025',
                    description: 'The PUMA Informatics Regeneration is an event to recruit new members who are enthusiastic and committed to joining the organization.',
                    images: [
                        'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
                        'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg',
                        'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg'
                    ]
                },
                {
                    title: 'UNITICS',
                    date: '2025',
                    description: 'Unitics (Unity of Informatics) is organized to welcome new members to PUMA IT. The primary focus is to create an inclusive environment.',
                    images: [
                        'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
                        'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg',
                        'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg'
                    ]
                },
                {
                    title: 'INFORUUM',
                    date: '2025',
                    description: 'Inforuum (Informatics Continuum) is a farewell event for PUMA IT members, allowing them to bid farewell and reminisce about shared moments.',
                    images: [
                        'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
                        'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg',
                        'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg'
                    ]
                },
                {
                    title: 'TEMU ALUMNI',
                    date: '2025',
                    description: 'Temu Alumni is an event aimed at enhancing the relationship between students and alumni in the field of informatics through sharing sessions.',
                    images: [
                        'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
                        'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg',
                        'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg'
                    ]
                }
            ],
            currentItem: {
                title: '',
                date: '',
                description: '',
                images: []
            },
            imagesInput: '',
            isEditing: false,
            editIndex: -1,
            searchQuery: '',
            showDetailsModal: false,
            showEditModal: false,
            showDeleteModal: false,
            selectedItem: {},
            itemToDeleteIndex: -1,
            galleryIndex: 0,
            uploadedFiles: [],
            dragover: false,
            fileCounter: 0
        };
    },
    computed: {
        filteredEvents() {
            if (!this.searchQuery) {
                return this.events;
            }

            const query = this.searchQuery.toLowerCase();
            return this.events.filter(event =>
                event.title.toLowerCase().includes(query) ||
                event.description.toLowerCase().includes(query)
            );
        },
        currentGalleryImage() {
            if (!this.selectedItem.images || this.selectedItem.images.length === 0) {
                return 'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg';
            }
            return this.selectedItem.images[this.galleryIndex];
        },
        urlPreviews() {
            return this.imagesInput.split('\n')
                .map(url => url.trim())
                .filter(url => url)
                .map(url => ({ 
                    url: url,
                    type: 'url'
                }));
        },
        filePreviews() {
            return this.uploadedFiles.map(file => ({
                url: URL.createObjectURL(file.file),
                id: file.id,
                type: 'file'
            }));
        },
        combinedPreviews() {
            return [...this.filePreviews, ...this.urlPreviews];
        }
    },
    methods: {
        openAddModal() {
            this.resetForm();
            this.showEditModal = true;
        },

        getImageSrc(src) {
            if (typeof src === 'object' && src.hasOwnProperty('dataUrl')) {
                return src.dataUrl;
            }
            return src;
        },

        handleFileUpload(event) {
            const files = event.target.files;
            if (!files.length) return;
            
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                if (file.type.startsWith('image/')) {
                    this.uploadedFiles.push({
                        id: this.fileCounter++,
                        file: file,
                        name: file.name
                    });
                }
            }
            
            event.target.value = '';
        },

        onDrop(event) {
            this.dragover = false;
            const files = event.dataTransfer.files;
            
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                if (file.type.startsWith('image/')) {
                    this.uploadedFiles.push({
                        id: this.fileCounter++,
                        file: file,
                        name: file.name
                    });
                }
            }
        },

        processUploadedFiles() {
            return Promise.all(this.uploadedFiles.map((fileData) => {
                return new Promise((resolve) => {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        resolve({
                            dataUrl: e.target.result,
                            name: fileData.file.name,
                            type: 'uploaded'
                        });
                    };
                    reader.readAsDataURL(fileData.file);
                });
            }));
        },

        async saveEvent() {
            const uploadedImages = await this.processUploadedFiles();
            
            const urlImages = this.imagesInput.split('\n')
                .map(url => url.trim())
                .filter(url => url);
            
            let allImages = [...uploadedImages, ...urlImages];
            
            if (allImages.length === 0) {
                allImages.push('https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg');
            }
            
            const eventData = {
                ...this.currentItem,
                images: allImages
            };

            if (this.isEditing) {
                this.events[this.editIndex] = eventData;
            } else {
                this.events.push(eventData);
            }

            this.showEditModal = false;
            this.resetForm();
        },

        editItem(event, index) {
            this.currentItem = { ...event };
            
            const urlImages = event.images.filter(img => typeof img === 'string');
            this.imagesInput = urlImages.join('\n');
            
            this.uploadedFiles = [];
            
            this.isEditing = true;
            this.editIndex = index;
            this.showEditModal = true;
        },

        deleteItem(index) {
            this.itemToDeleteIndex = index;
            this.showDeleteModal = true;
        },

        confirmDelete() {
            this.events.splice(this.itemToDeleteIndex, 1);
            this.showDeleteModal = false;
            this.itemToDeleteIndex = -1;
        },

        viewDetails(event, index) {
            this.selectedItem = { ...event };
            this.galleryIndex = 0;
            this.showDetailsModal = true;
        },

        resetForm() {
            this.currentItem = {
                title: '',
                date: '',
                description: '',
                images: []
            };
            this.imagesInput = '';
            this.uploadedFiles = [];
            this.isEditing = false;
            this.editIndex = -1;
            this.dragover = false;
        },

        nextImage() {
            if (!this.selectedItem.images || this.selectedItem.images.length <= 1) return;
            this.galleryIndex = (this.galleryIndex + 1) % this.selectedItem.images.length;
        },

        prevImage() {
            if (!this.selectedItem.images || this.selectedItem.images.length <= 1) return;
            this.galleryIndex = (this.galleryIndex - 1 + this.selectedItem.images.length) % this.selectedItem.images.length;
        },

        removeImage(index, type) {
            if (type === 'file') {
                const filePreview = this.filePreviews[index];
                this.uploadedFiles = this.uploadedFiles.filter(file => file.id !== filePreview.id);
            } else {
                const fileIndex = index - this.filePreviews.length;
                if (fileIndex >= 0) {
                    const urls = this.imagesInput.split('\n')
                        .map(url => url.trim())
                        .filter(url => url);
                    
                    urls.splice(fileIndex, 1);
                    this.imagesInput = urls.join('\n');
                }
            }
        }
    }
};
</script>

<template>
    <AdminLayout>
    <div class="container relative p-4 mx-auto overflow-hidden font-mono">
        <div class="absolute inset-0 z-0 grid-lines opacity-10"></div>

        <div class="relative z-10">
            <div class="mb-6">
                <button @click="openAddModal"
                    class="flex items-center px-4 py-3 font-medium transition-all duration-300 bg-white border rounded-lg shadow-md border-black/20 hover:bg-black hover:text-white group">
                    <span
                        class="mr-2 text-xs px-1.5 py-0.5 rounded-sm bg-black/10 text-black/80 group-hover:bg-white group-hover:text-black transition-colors duration-300">
                        01
                    </span>
                    ADD NEW EVENT
                </button>
            </div>

            <div class="relative overflow-hidden bg-white border rounded-lg shadow-lg border-black/10">
                <div class="absolute inset-0 grid-lines opacity-5"></div>

                <div class="relative p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-xl font-bold tracking-wider uppercase">Event Lineup</h2>

                        <div class="relative">
                            <input v-model="searchQuery" placeholder="Search events..."
                                class="w-full p-2 pl-3 font-mono text-sm border rounded-lg md:w-64 border-black/20 bg-white/80 backdrop-blur-sm">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 gap-4 mb-4 md:grid-cols-2 lg:grid-cols-3">
                        <div v-for="(event, index) in filteredEvents" :key="index"
                            class="overflow-hidden transition-all duration-300 bg-white border rounded-lg shadow-md border-black/10 hover:shadow-lg">

                            <div class="relative overflow-hidden aspect-video bg-black/5">
                                <img :src="getImageSrc(event.images[0])" alt="Event cover" class="object-cover w-full h-full">
                                <div class="absolute flex gap-1 top-2 right-2">
                                    <span class="px-2 py-1 text-xs text-white bg-black rounded">
                                        {{ (index + 1).toString().padStart(2, '0') }}
                                    </span>
                                </div>
                            </div>

                            <div class="p-4">
                                <div class="flex items-start justify-between mb-2">
                                    <h3 class="text-lg font-bold">{{ event.title }}</h3>
                                    <span class="px-2 py-1 text-xs bg-white border rounded-full border-black/20">{{
                                        event.date }}</span>
                                </div>

                                <p class="mb-4 text-sm text-black/70 line-clamp-2">{{ event.description }}</p>

                                <div class="flex gap-2 mt-2">
                                    <button @click="viewDetails(event, index)"
                                        class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                        <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                        View
                                    </button>
                                    <button @click="editItem(event, index)"
                                        class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                        <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">02</span>
                                        Edit
                                    </button>
                                    <button @click="deleteItem(index)"
                                        class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                        <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">03</span>
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div v-if="filteredEvents.length === 0" class="p-8 text-center col-span-full text-black/50">
                            No events found matching your search
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="showEditModal"
            class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
            <div
                class="bg-white rounded-lg w-full max-w-2xl p-0 shadow-2xl relative overflow-hidden max-h-[90vh] overflow-y-auto">
                <div class="absolute inset-0 grid-lines opacity-10"></div>

                <div class="relative p-6">
                    <div class="flex items-center justify-between pb-4 mb-6 border-b border-black/10">
                        <div class="flex items-center">
                            <div class="flex items-center justify-center w-8 h-8 mr-3 bg-black rounded-full">
                                <span class="text-xs font-bold text-white">{{ isEditing ? 'ED' : 'NEW' }}</span>
                            </div>
                            <h3 class="text-xl font-bold tracking-wider uppercase">{{ isEditing ? 'Edit Event' : 'Add New Event' }}</h3>
                        </div>
                        <button @click="showEditModal = false" class="transition-colors text-black/50 hover:text-black">
                            &times;
                        </button>
                    </div>

                    <form @submit.prevent="saveEvent">
                        <div class="grid grid-cols-1 gap-4 mb-6">
                            <div class="mb-2">
                                <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Event
                                    Title</label>
                                <input v-model="currentItem.title" type="text"
                                    class="w-full p-3 font-mono border rounded border-black/20 bg-white/80" required>
                            </div>

                            <div class="mb-2">
                                <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Event
                                    Year</label>
                                <input v-model="currentItem.date" type="text"
                                    class="w-full p-3 font-mono border rounded border-black/20 bg-white/80" required>
                            </div>

                            <div class="mb-2">
                                <label
                                    class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Description</label>
                                <textarea v-model="currentItem.description" rows="3"
                                    class="w-full p-3 font-mono border rounded border-black/20 bg-white/80"
                                    required></textarea>
                            </div>

                            <div class="mb-2">
                                <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                    Upload Images
                                </label>
                                <div class="flex items-center mb-2">
                                    <input 
                                        type="file" 
                                        ref="fileInput" 
                                        @change="handleFileUpload" 
                                        accept="image/*"
                                        multiple
                                        class="hidden"
                                    >
                                    <button 
                                        type="button" 
                                        @click="$refs.fileInput.click()"
                                        class="flex items-center px-3 py-2 text-sm font-medium transition-all duration-300 border rounded border-black/20 hover:bg-black/10"
                                    >
                                        <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">+</span>
                                        Select Files
                                    </button>
                                    <span class="ml-3 text-xs text-black/60">or drag & drop</span>
                                </div>
                                
                                <div 
                                    @dragover.prevent="dragover = true" 
                                    @dragleave.prevent="dragover = false"
                                    @drop.prevent="onDrop"
                                    :class="{ 'bg-black/5 border-black/40': dragover }"
                                    class="flex flex-col items-center justify-center p-6 transition-colors border-2 border-dashed rounded border-black/20"
                                >
                                    <span v-if="uploadedFiles.length === 0" class="text-sm text-black/60">
                                        Drop images here
                                    </span>
                                    <span v-else class="mb-2 text-sm text-black/80">
                                        {{ uploadedFiles.length }} file(s) selected
                                    </span>
                                </div>
                            </div>

                            <div class="mb-2">
                                <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                    External Image URLs (Optional)
                                </label>
                                <textarea v-model="imagesInput" rows="2"
                                    class="w-full p-3 font-mono border rounded border-black/20 bg-white/80"
                                    placeholder="https://example.com/image1.jpg&#10;https://example.com/image2.jpg"></textarea>
                                <p class="mt-1 text-xs text-black/60">Enter one URL per line (optional)</p>
                            </div>

                            <div v-if="combinedPreviews.length > 0" class="mb-2">
                                <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                    Image Previews
                                </label>
                                <div class="grid grid-cols-3 gap-2">
                                    <div v-for="(preview, idx) in combinedPreviews" :key="idx"
                                        class="relative overflow-hidden rounded aspect-video bg-black/5">
                                        <img :src="preview.url" class="object-cover w-full h-full">
                                        <button type="button" @click="removeImage(idx, preview.type)"
                                            class="absolute flex items-center justify-center w-5 h-5 text-xs text-white bg-black rounded top-1 right-1">
                                            &times;
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex justify-end gap-3 pt-4 border-t border-black/10">
                            <button type="button" @click="showEditModal = false"
                                class="flex items-center px-4 py-2 text-sm font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black/10">
                                <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                Cancel
                            </button>
                            <button type="submit"
                                class="flex items-center px-4 py-2 text-sm font-medium text-white uppercase transition-all duration-300 bg-black border border-black rounded hover:bg-black/80">
                                <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-white/20">02</span>
                                {{ isEditing ? 'Update' : 'Add' }} Event
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div v-if="showDetailsModal"
            class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
            <div
                class="bg-white rounded-lg w-full max-w-3xl shadow-2xl relative overflow-hidden max-h-[90vh] overflow-y-auto">
                <div class="absolute inset-0 grid-lines opacity-10"></div>

                <div class="relative">
                    <div class="relative bg-black aspect-video">
                        <img :src="getImageSrc(currentGalleryImage)" class="object-cover w-full h-full">
                        <div
                            class="absolute bottom-0 left-0 right-0 p-4 text-white bg-gradient-to-t from-black/70 to-transparent">
                            <h2 class="text-xl font-bold">{{ selectedItem.title }}</h2>
                            <p class="text-white/90">{{ selectedItem.date }}</p>
                        </div>

                        <button v-if="selectedItem.images && selectedItem.images.length > 1" @click="prevImage"
                            class="absolute flex items-center justify-center w-8 h-8 text-white transform -translate-y-1/2 rounded-full left-2 top-1/2 bg-black/50 hover:bg-black">
                            &lt;
                        </button>
                        <button v-if="selectedItem.images && selectedItem.images.length > 1" @click="nextImage"
                            class="absolute flex items-center justify-center w-8 h-8 text-white transform -translate-y-1/2 rounded-full right-2 top-1/2 bg-black/50 hover:bg-black">
                            &gt;
                        </button>

                        <button @click="showDetailsModal = false"
                            class="absolute flex items-center justify-center w-8 h-8 text-white rounded-full top-2 right-2 bg-black/50 hover:bg-black">
                            &times;
                        </button>
                    </div>

                    <div class="p-6">
                        <div v-if="selectedItem.images && selectedItem.images.length > 1"
                            class="flex gap-2 pb-2 mb-4 overflow-x-auto">
                            <div v-for="(img, idx) in selectedItem.images" :key="idx" @click="galleryIndex = idx"
                                class="flex-shrink-0 w-16 h-16 overflow-hidden transition-opacity rounded cursor-pointer hover:opacity-80"
                                :class="{ 'ring-2 ring-black': galleryIndex === idx }">
                                <img :src="getImageSrc(img)" class="object-cover w-full h-full">
                            </div>
                        </div>

                        <div class="pt-4 border-t border-black/10">
                            <h3 class="text-xl font-bold">{{ selectedItem.title }}</h3>
                            <div class="mb-4">
                                <span
                                    class="inline-block px-2 py-1 mt-1 text-xs bg-white border rounded-full border-black/20">{{
                                    selectedItem.date }}</span>
                            </div>

                            <h4 class="mb-2 text-xs font-bold tracking-wider uppercase text-black/70">Event Description
                            </h4>
                            <p class="mb-6 leading-relaxed text-black/80">{{ selectedItem.description }}</p>

                            <div class="flex justify-end pt-4 mt-6 border-t border-black/10">
                                <button @click="showDetailsModal = false"
                                    class="flex items-center px-4 py-2 text-sm font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                    <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                    Close
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="showDeleteModal"
            class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
            <div class="relative w-full max-w-md overflow-hidden bg-white rounded-lg shadow-2xl">
                <div class="absolute inset-0 grid-lines opacity-10"></div>

                <div class="relative p-6">
                    <div class="flex items-center justify-between pb-4 mb-6 border-b border-black/10">
                        <div class="flex items-center">
                            <div class="flex items-center justify-center w-8 h-8 mr-3 bg-black rounded-full">
                                <span class="text-xs font-bold text-white">DEL</span>
                            </div>
                            <h3 class="text-xl font-bold tracking-wider uppercase">Confirm Delete</h3>
                        </div>
                    </div>

                    <p class="mb-6">Are you sure you want to delete this event? This action cannot be undone.</p>

                    <div class="flex justify-end gap-3 pt-4 border-t border-black/10">
                        <button @click="showDeleteModal = false"
                            class="flex items-center px-4 py-2 text-sm font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black/10">
                            <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                            Cancel
                        </button>
                        <button @click="confirmDelete"
                            class="flex items-center px-4 py-2 text-sm font-medium text-white uppercase transition-all duration-300 bg-black border border-black rounded hover:bg-black/80">
                            <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-white/20">02</span>
                            Delete
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </AdminLayout>
</template>

<style scoped>
.grid-lines {
    background-image:
        linear-gradient(to right, rgba(0, 0, 0, 0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(0, 0, 0, 0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}

.line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>