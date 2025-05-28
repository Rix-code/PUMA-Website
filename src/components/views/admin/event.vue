<script>
import AdminLayout from './Layout.vue'; 

export default {
    components: {
        AdminLayout
    },
    data() {
        return {
            events: [
                {
                    title: 'Regenetics 2024/2025',
                    date: '1 September 2024',
                    description: 'The PUMA Informatics Regeneration is an event to recruit new members who are enthusiastic and committed to joining the organization.',
                    images: [
                        'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
                        '/sample1.jpg', 
                        '/sample2.jpg'  
                    ],
                    status: 'completed'
                },
                {
                    title: 'UNITICS 2025',
                    date: '15 October 2025',
                    description: 'Unitics (Unity of Informatics) is organized to welcome new members to PUMA IT. The primary focus is to create an inclusive environment.',
                    images: [
                        'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
                    ],
                    status: 'upcoming'
                },
                {
                    title: 'INFORUUM 2025',
                    date: '10 December 2025',
                    description: 'Inforuum (Informatics Continuum) is a farewell event for PUMA IT members, allowing them to bid farewell and reminisce about shared moments.',
                    images: [
                        'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
                    ],
                    status: 'planned'
                },
                {
                    title: 'TEMU ALUMNI 2024',
                    date: '20 November 2024',
                    description: 'Temu Alumni is an event aimed at enhancing the relationship between students and alumni in the field of informatics through sharing sessions.',
                    images: [
                        'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', 
                    ],
                    status: 'completed'
                }
            ],
            currentItem: {
                title: '',
                date: '',
                description: '',
                images: [],
                status: 'upcoming' 
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
            fileCounter: 0, 
            eventStatuses: ['upcoming', 'completed', 'postponed', 'cancelled', 'planned'] 
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
                event.description.toLowerCase().includes(query) ||
                event.status.toLowerCase().includes(query) 
            );
        },
        currentGalleryImage() {
            if (!this.selectedItem.images || this.selectedItem.images.length === 0) {
                return 'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg'; 
            }
            const images = this.selectedItem.images;
            if (this.galleryIndex >= images.length || this.galleryIndex < 0) {
                this.galleryIndex = 0;
            }
            return images[this.galleryIndex];
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
            return this.uploadedFiles.map(fileData => ({
                url: URL.createObjectURL(fileData.file), 
                id: fileData.id, 
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
            this.isEditing = false; 
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
                return new Promise((resolve, reject) => {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        resolve({
                            dataUrl: e.target.result, 
                            name: fileData.file.name, 
                        });
                    };
                    reader.onerror = (error) => reject(error);
                    reader.readAsDataURL(fileData.file);
                });
            }));
        },

        async saveEvent() {
            const processedUploadedImageObjects = await this.processUploadedFiles();
            const newDataUrlsFromUploads = processedUploadedImageObjects.map(imgObj => imgObj.dataUrl);

            const urlsFromTextarea = this.imagesInput.split('\n')
                .map(url => url.trim())
                .filter(url => url);

            let finalImages = [];

            if (this.isEditing) {
                finalImages = [...urlsFromTextarea, ...newDataUrlsFromUploads];
                finalImages = [...new Set(finalImages)];
            } else {
                finalImages = [...urlsFromTextarea, ...newDataUrlsFromUploads];
            }

            if (finalImages.length === 0 && !this.isEditing) { 
                finalImages.push('https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg');
            }

            const eventData = {
                ...this.currentItem, 
                images: finalImages 
            };

            if (this.isEditing) {
                this.events.splice(this.editIndex, 1, eventData);
            } else {
                this.events.push(eventData);
            }

            this.showEditModal = false;
            this.resetForm();
        },

        editItem(eventItem, index) {
            this.isEditing = true;
            this.editIndex = index;
            this.currentItem = JSON.parse(JSON.stringify(eventItem));
            this.imagesInput = (this.currentItem.images || []).join('\n');
            this.uploadedFiles = []; 
            this.showEditModal = true;
        },

        deleteItem(index) {
            this.itemToDeleteIndex = index;
            this.showDeleteModal = true;
        },

        confirmDelete() {
            if (this.itemToDeleteIndex >= 0 && this.itemToDeleteIndex < this.events.length) {
                this.events.splice(this.itemToDeleteIndex, 1);
            }
            this.showDeleteModal = false;
            this.itemToDeleteIndex = -1; 
        },

        viewDetails(eventItem, index) {
            this.selectedItem = { ...eventItem }; 
            this.galleryIndex = 0; 
            this.showDetailsModal = true;
        },

        resetForm() {
            this.currentItem = {
                title: '',
                date: '',
                description: '',
                images: [], 
                status: 'upcoming' 
            };
            this.imagesInput = '';
            this.uploadedFiles = []; 
            this.dragover = false;
            if (this.$refs.fileInput) { 
                this.$refs.fileInput.value = '';
            }
        },

        closeEditModal() {
            this.showEditModal = false;
            this.resetForm(); 
        },

        nextImage() {
            if (!this.selectedItem.images || this.selectedItem.images.length === 0) return;
            this.galleryIndex = (this.galleryIndex + 1) % this.selectedItem.images.length;
        },

        prevImage() {
            if (!this.selectedItem.images || this.selectedItem.images.length === 0) return;
            this.galleryIndex = (this.galleryIndex - 1 + this.selectedItem.images.length) % this.selectedItem.images.length;
        },

        removeImagePreview(indexToRemove, type) {
            if (type === 'file') {
                const fileIdToRemove = this.filePreviews[indexToRemove]?.id;
                if (fileIdToRemove !== undefined) {
                    this.uploadedFiles = this.uploadedFiles.filter(fileData => fileData.id !== fileIdToRemove);
                }
            } else if (type === 'url') {
                const urlIndexInUrlPreviews = indexToRemove - this.filePreviews.length;
                if (urlIndexInUrlPreviews >= 0) {
                    const urls = this.imagesInput.split('\n')
                        .map(url => url.trim())
                        .filter(url => url); 

                    if (urlIndexInUrlPreviews < urls.length) {
                        urls.splice(urlIndexInUrlPreviews, 1); 
                        this.imagesInput = urls.join('\n'); 
                    }
                }
            }
        }
    },
};
</script>

<template>
    <AdminLayout>
    <div class="container relative p-4 mx-auto overflow-hidden font-mono">
        <div class="absolute inset-0 z-0 grid-lines opacity-10"></div>

        <div class="relative z-10">
            <div class="mb-6">
                <button @click="openAddModal"
                    class="flex items-center px-4 py-3 font-medium text-gray-800 transition-all duration-300 bg-white border rounded-lg shadow-md border-black/20 hover:bg-black hover:text-white group">
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
                    <div class="flex flex-col items-start justify-between mb-6 sm:flex-row sm:items-center">
                        <h2 class="mb-3 text-xl font-bold tracking-wider text-gray-800 uppercase sm:mb-0">Event Lineup</h2>
                        <div class="relative w-full sm:w-auto">
                            <input v-model="searchQuery" placeholder="Search events (title, desc, status)..."
                                class="w-full p-2 pl-3 font-mono text-sm text-gray-700 border rounded-lg md:w-64 border-black/20 bg-white/80 backdrop-blur-sm focus:ring-2 focus:ring-black focus:border-transparent">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 gap-4 mb-4 md:grid-cols-2 lg:grid-cols-3">
                        <div v-for="(event, index) in filteredEvents" :key="event.title + '-' + index + '-' + event.date" 
                            class="flex flex-col overflow-hidden transition-all duration-300 bg-white border rounded-lg shadow-md border-black/10 hover:shadow-xl group">

                            <div class="relative overflow-hidden aspect-video bg-black/5">
                                <img :src="getImageSrc(event.images[0] || 'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg')" alt="Event cover" class="object-cover w-full h-full transition-transform duration-300 group-hover:scale-105">
                                <div class="absolute flex gap-1 top-2 right-2">
                                    <span class="px-2 py-1 text-xs font-semibold text-white capitalize bg-blue-500 rounded shadow">
                                        {{ event.status }}
                                    </span>
                                    <span class="px-2 py-1 text-xs font-semibold text-white bg-black rounded shadow">
                                        #{{ (index + 1).toString().padStart(2, '0') }}
                                    </span>
                                </div>
                            </div>

                            <div class="flex flex-col flex-grow p-4">
                                <div class="flex items-start justify-between mb-2">
                                    <h3 class="text-lg font-bold text-gray-800">{{ event.title }}</h3>
                                    <span class="px-2 py-1 ml-2 text-xs text-gray-600 bg-white border rounded-full whitespace-nowrap border-black/20">{{
                                        event.date }}</span>
                                </div>
                                <p class="flex-grow mb-4 text-sm text-gray-600 line-clamp-2">{{ event.description }}</p>
                                <div class="flex flex-wrap gap-2 mt-auto">
                                    <button @click="viewDetails(event, index)"
                                        class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                        <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">01</span> View
                                    </button>
                                    <button @click="editItem(event, index)"
                                        class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                        <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">02</span> Edit
                                    </button>
                                    <button @click="deleteItem(index)"
                                        class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                        <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">03</span> Delete
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div v-if="filteredEvents.length === 0" class="p-8 text-center col-span-full text-black/50">
                            No events found matching your search criteria.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="showEditModal"
            class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm">
            <div class="bg-white rounded-lg w-full max-w-2xl p-0 shadow-2xl relative overflow-hidden max-h-[90vh] flex flex-col">
                <div class="absolute inset-0 grid-lines opacity-10"></div>

                <div class="relative flex items-center justify-between p-6 pb-4 border-b border-black/10">
                    <div class="flex items-center">
                        <div class="flex items-center justify-center w-8 h-8 mr-3 bg-black rounded-full">
                            <span class="text-xs font-bold text-white">{{ isEditing ? 'ED' : 'NEW' }}</span>
                        </div>
                        <h3 class="text-xl font-bold tracking-wider text-gray-800 uppercase">{{ isEditing ? 'Edit Event' : 'Add New Event' }}</h3>
                    </div>
                    <button @click="closeEditModal" class="text-2xl leading-none transition-colors text-black/50 hover:text-black">
                        &times;
                    </button>
                </div>

                <form @submit.prevent="saveEvent" class="relative flex-grow p-6 overflow-y-auto">
                    <div class="grid grid-cols-1 gap-5 mb-6">
                        <div>
                            <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Event Title</label>
                            <input v-model="currentItem.title" type="text"
                                class="w-full p-3 font-mono text-sm border rounded border-black/20 bg-white/90 focus:ring-2 focus:ring-black" required>
                        </div>

                        <div class="grid grid-cols-1 gap-5 sm:grid-cols-2">
                            <div>
                                <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Event Date</label>
                                <input v-model="currentItem.date" type="text" placeholder="e.g., 1 September 2024"
                                    class="w-full p-3 font-mono text-sm border rounded border-black/20 bg-white/90 focus:ring-2 focus:ring-black" required>
                            </div>
                            <div>
                                <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Event Status</label>
                                <select v-model="currentItem.status" class="w-full p-3 font-mono text-sm border rounded border-black/20 bg-white/90 focus:ring-2 focus:ring-black" required>
                                    <option disabled value="">Select status</option>
                                    <option v-for="statusOpt in eventStatuses" :key="statusOpt" :value="statusOpt" class="capitalize">{{ statusOpt }}</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Description</label>
                            <textarea v-model="currentItem.description" rows="4"
                                class="w-full p-3 font-mono text-sm border rounded border-black/20 bg-white/90 focus:ring-2 focus:ring-black"
                                required></textarea>
                        </div>

                        <div>
                            <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Upload Images</label>
                            <div class="flex items-center mb-2">
                                <input type="file" ref="fileInput" @change="handleFileUpload" accept="image/*" multiple class="hidden">
                                <button type="button" @click="$refs.fileInput.click()"
                                    class="flex items-center px-3 py-2 text-sm font-medium text-gray-700 transition-all duration-300 border rounded border-black/20 hover:bg-black/5">
                                    <span class="mr-1.5 text-base leading-none">+</span> Select Files
                                </button>
                                <span class="ml-3 text-xs text-black/60">or drag & drop into area below</span>
                            </div>
                            <div @dragover.prevent="dragover = true" @dragleave.prevent="dragover = false" @drop.prevent="onDrop"
                                :class="{ 'bg-black/5 border-black/40 ring-2 ring-black/30': dragover, 'border-black/20': !dragover }"
                                class="flex flex-col items-center justify-center min-h-[80px] p-6 transition-colors border-2 border-dashed rounded">
                                <span v-if="!dragover && uploadedFiles.length === 0" class="text-sm text-black/60">Drop images here</span>
                                <span v-if="dragover" class="text-sm font-semibold text-black/70">Drop to upload!</span>
                                <span v-if="!dragover && uploadedFiles.length > 0" class="text-sm text-black/80">{{ uploadedFiles.length }} file(s) selected for upload</span>
                            </div>
                        </div>

                        <div>
                            <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">External Image URLs (or Public Paths)</label>
                            <textarea v-model="imagesInput" rows="3"
                                class="w-full p-3 font-mono text-sm border rounded border-black/20 bg-white/90 focus:ring-2 focus:ring-black"
                                placeholder="https://example.com/image1.jpg&#10;/images/public-image.png&#10;data:image/jpeg;base64,..."></textarea>
                            <p class="mt-1 text-xs text-black/60">One URL/path per line. For files in 'public' folder, use paths like '/images/foo.jpg'.</p>
                        </div>

                        <div v-if="combinedPreviews.length > 0" class="mb-2">
                            <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Image Previews (Staged & URLs)</label>
                            <div class="grid grid-cols-3 gap-2 sm:grid-cols-4 md:grid-cols-5">
                                <div v-for="(preview, idx) in combinedPreviews" :key="preview.type + '-' + idx + '-' + (preview.url ? preview.url.slice(-20) : '')"
                                    class="relative overflow-hidden rounded aspect-video bg-black/10">
                                    <img :src="preview.url" alt="Preview" class="object-cover w-full h-full">
                                    <button type="button" @click="removeImagePreview(idx, preview.type)"
                                        class="absolute flex items-center justify-center w-5 h-5 text-xs text-white bg-red-500 rounded-full opacity-75 top-1 right-1 hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-red-600"
                                        aria-label="Remove image preview">
                                        &times;
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-end gap-3 pt-4 mt-auto border-t border-black/10"> <button type="button" @click="closeEditModal"
                            class="flex items-center px-4 py-2 text-sm font-medium text-gray-700 uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black/10">
                            Cancel
                        </button>
                        <button type="submit"
                            class="flex items-center px-4 py-2 text-sm font-medium text-white uppercase transition-all duration-300 bg-black border border-black rounded hover:bg-black/80">
                            {{ isEditing ? 'Update' : 'Save' }} Event
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div v-if="showDetailsModal"
            class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm">
            <div class="bg-white rounded-lg w-full max-w-3xl shadow-2xl relative overflow-hidden max-h-[90vh] flex flex-col">
                <div class="absolute inset-0 grid-lines opacity-10"></div>

                <div class="relative bg-gray-900 aspect-video">
                    <img :src="getImageSrc(currentGalleryImage || 'https://i.pinimg.com/474x/39/2a/26/392a261b73dbcd361a0dac2e93a05284.jpg')" alt="Selected event image" class="object-contain w-full h-full">
                    <div class="absolute bottom-0 left-0 right-0 p-4 text-white bg-gradient-to-t from-black/80 via-black/50 to-transparent">
                        <h2 class="text-2xl font-bold">{{ selectedItem.title }}</h2>
                        <p class="text-sm text-white/90">{{ selectedItem.date }}</p>
                    </div>
                    <button v-if="selectedItem.images && selectedItem.images.length > 1" @click="prevImage" aria-label="Previous image"
                        class="absolute flex items-center justify-center w-10 h-10 text-2xl text-white transition-colors transform -translate-y-1/2 rounded-full left-3 top-1/2 bg-black/40 hover:bg-black/70 focus:outline-none focus:ring-2 focus:ring-white">
                        &lt;
                    </button>
                    <button v-if="selectedItem.images && selectedItem.images.length > 1" @click="nextImage" aria-label="Next image"
                        class="absolute flex items-center justify-center w-10 h-10 text-2xl text-white transition-colors transform -translate-y-1/2 rounded-full right-3 top-1/2 bg-black/40 hover:bg-black/70 focus:outline-none focus:ring-2 focus:ring-white">
                        &gt;
                    </button>
                    <button @click="showDetailsModal = false" aria-label="Close details"
                        class="absolute flex items-center justify-center w-8 h-8 text-xl text-white transition-colors rounded-full top-3 right-3 bg-black/40 hover:bg-black/70 focus:outline-none focus:ring-2 focus:ring-white">
                        &times;
                    </button>
                </div>

                <div class="flex-grow p-6 overflow-y-auto">
                    <div class="flex items-center justify-between mb-1">
                        <h3 class="text-2xl font-bold text-gray-800">{{ selectedItem.title }}</h3>
                        <span class="px-3 py-1 text-sm font-semibold text-white capitalize bg-blue-500 rounded-full shadow">{{ selectedItem.status }}</span>
                    </div>
                    <div class="mb-4">
                        <span class="inline-block px-2 py-1 mt-1 text-xs text-gray-600 bg-gray-100 border rounded-full border-black/10">{{ selectedItem.date }}</span>
                    </div>

                    <div v-if="selectedItem.images && selectedItem.images.length > 1" class="flex gap-2 pb-3 mb-4 overflow-x-auto border-b border-black/10">
                        <div v-for="(img, idx) in selectedItem.images" :key="idx + '-thumb-' + (img ? img.slice(-10) : '')" @click="galleryIndex = idx"
                            class="flex-shrink-0 w-20 h-20 overflow-hidden transition-all duration-150 border-2 rounded-md cursor-pointer hover:opacity-80 focus:outline-none focus:ring-2 focus:ring-offset-1 focus:ring-black"
                            :class="{ 'ring-2 ring-offset-1 ring-black border-transparent': galleryIndex === idx, 'border-black/10': galleryIndex !== idx }">
                            <img :src="getImageSrc(img)" alt="Thumbnail" class="object-cover w-full h-full">
                        </div>
                    </div>
                    
                    <h4 class="mb-2 text-sm font-semibold tracking-wider uppercase text-black/70">Event Description</h4>
                    <p class="mb-6 leading-relaxed text-gray-700 whitespace-pre-wrap">{{ selectedItem.description }}</p>

                    <div class="flex justify-end pt-4 mt-auto border-t border-black/10">
                        <button @click="showDetailsModal = false"
                            class="flex items-center px-4 py-2 text-sm font-medium text-gray-700 uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                            Close
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="showDeleteModal"
            class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm">
            <div class="relative w-full max-w-md overflow-hidden bg-white rounded-lg shadow-2xl">
                <div class="absolute inset-0 grid-lines opacity-10"></div>
                <div class="relative p-6">
                    <div class="flex items-center justify-between pb-4 mb-4 border-b border-black/10">
                        <div class="flex items-center">
                            <div class="flex items-center justify-center w-8 h-8 mr-3 text-red-500 border-2 border-red-500 rounded-full">
                                <span class="text-lg font-bold">!</span>
                            </div>
                            <h3 class="text-xl font-bold tracking-wider text-gray-800 uppercase">Confirm Delete</h3>
                        </div>
                        <button @click="showDeleteModal = false" class="text-2xl leading-none transition-colors text-black/50 hover:text-black">
                            &times;
                        </button>
                    </div>
                    <p class="mb-6 text-gray-700">Are you sure you want to delete the event titled "<strong>{{ events[itemToDeleteIndex] ? events[itemToDeleteIndex].title : 'this event' }}</strong>"?<br> This action cannot be undone.</p>
                    <div class="flex justify-end gap-3 pt-4 border-t border-black/10">
                        <button @click="showDeleteModal = false"
                            class="flex items-center px-4 py-2 text-sm font-medium text-gray-700 uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black/10">
                            Cancel
                        </button>
                        <button @click="confirmDelete"
                            class="flex items-center px-4 py-2 text-sm font-medium text-white uppercase transition-all duration-300 bg-red-600 border border-red-600 rounded hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-1 focus:ring-red-500">
                            Delete Event
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
        linear-gradient(to right, rgba(0, 0, 0, 0.03) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(0, 0, 0, 0.03) 1px, transparent 1px);
    background-size: 20px 20px; 
}

.line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}
.whitespace-pre-wrap {
    white-space: pre-wrap; 
}

.overflow-y-auto::-webkit-scrollbar {
    width: 8px;
}
.overflow-y-auto::-webkit-scrollbar-track {
    background: rgba(0,0,0,0.05);
    border-radius: 10px;
}
.overflow-y-auto::-webkit-scrollbar-thumb {
    background: rgba(0,0,0,0.3);
    border-radius: 10px;
}
.overflow-y-auto::-webkit-scrollbar-thumb:hover {
    background: rgba(0,0,0,0.5);
}
</style>