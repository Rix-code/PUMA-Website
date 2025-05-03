<template>
    <AdminLayout>
        <div class="container relative p-4 mx-auto overflow-hidden font-mono">
            <div class="absolute inset-0 z-0 grid-lines opacity-10"></div>

            <div class="relative z-10">
                <div class="relative mb-6 overflow-hidden bg-white border rounded-lg shadow-lg border-black/10">
                    <div class="absolute inset-0 grid-lines opacity-5"></div>

                    <div class="relative p-6">
                        <div class="flex flex-col justify-between mb-6 md:flex-row md:items-center">
                            <h2 class="mb-4 text-xl font-bold tracking-wider uppercase md:mb-0">Divisions</h2>

                            <div class="flex flex-col gap-4 md:flex-row">
                                <div class="relative">
                                    <input v-model="searchQuery" placeholder="Search divisions..."
                                        class="w-full p-2 pl-3 font-mono text-sm border rounded-lg md:w-64 border-black/20 bg-white/80 backdrop-blur-sm">
                                </div>
                                <div class="relative">
                                    <select v-model="selectedCabinetFilter"
                                        class="w-full p-2 pl-3 font-mono text-sm border rounded-lg md:w-48 border-black/20 bg-white/80 backdrop-blur-sm">
                                        <option value="">All Cabinets</option>
                                        <option v-for="cabinet in cabinets" :key="cabinet.id" :value="cabinet.id">
                                            {{ cabinet.name }}
                                        </option>
                                    </select>
                                </div>
                                <button @click="openCreateModal()"
                                    class="flex items-center px-3 py-2 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                    <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">ADD</span>
                                    New Division
                                </button>
                            </div>
                        </div>

                        <div class="overflow-x-auto">
                            <table class="w-full border-collapse">
                                <thead>
                                    <tr>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            ID</th>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Image</th>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Name</th>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Title</th>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Cabinet</th>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="division in paginatedDivisions" :key="division.id"
                                        class="transition-colors border-b border-black/5 hover:bg-black/5">
                                        <td class="p-3">
                                            <span class="inline-block px-2 py-1 text-xs text-white bg-black rounded">
                                                {{ division.id.toString().padStart(2, '0') }}
                                            </span>
                                        </td>
                                        <td class="p-3">
                                            <div class="w-10 h-10 overflow-hidden rounded-full">
                                                <img :src="division.image" alt="Division Image"
                                                    class="object-cover w-full h-full">
                                            </div>
                                        </td>
                                        <td class="p-3 font-medium">{{ division.name }}</td>
                                        <td class="p-3 text-black/70">{{ division.title }}</td>
                                        <td class="p-3 text-black/70">{{ getCabinetName(division.cabinetId) }}</td>
                                        <td class="p-3">
                                            <div class="flex gap-2">
                                                <button @click="viewDetails(division)"
                                                    class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                    <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                                    View
                                                </button>
                                                <button @click="editDivision(division)"
                                                    class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                    <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">02</span>
                                                    Edit
                                                </button>
                                                <button @click="deleteDivision(division.id)"
                                                    class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                    <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">03</span>
                                                    Delete
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr v-if="paginatedDivisions.length === 0">
                                        <td colspan="6" class="p-4 text-center text-black/50">No divisions found</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="flex items-center justify-between pt-4 mt-4 border-t border-black/10">
                            <div class="text-sm text-black/60">
                                Showing {{ startIndex + 1 }}-{{ endIndex }} of {{ filteredDivisions.length }} divisions
                            </div>
                            <div class="flex gap-2">
                                <button @click="pageNum--" :disabled="pageNum === 1"
                                    class="flex items-center px-3 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-black hover:text-white">
                                    Prev
                                </button>
                                <span class="flex items-center px-3 py-1 text-xs font-medium">
                                    {{ pageNum }} / {{ totalPages }}
                                </span>
                                <button @click="pageNum++" :disabled="pageNum === totalPages"
                                    class="flex items-center px-3 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-black hover:text-white">
                                    Next
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="relative overflow-hidden bg-white border rounded-lg shadow-lg border-black/10">
                    <div class="absolute inset-0 grid-lines opacity-5"></div>

                    <div class="relative p-6">
                        <div class="flex flex-col justify-between mb-6 md:flex-row md:items-center">
                            <h2 class="mb-4 text-xl font-bold tracking-wider uppercase md:mb-0">Cabinets</h2>

                            <div class="flex flex-col gap-4 md:flex-row">
                                <div class="relative">
                                    <input v-model="cabinetSearchQuery" placeholder="Search cabinets..."
                                        class="w-full p-2 pl-3 font-mono text-sm border rounded-lg md:w-64 border-black/20 bg-white/80 backdrop-blur-sm">
                                </div>
                                <button @click="openCreateCabinetModal()"
                                    class="flex items-center px-3 py-2 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                    <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">ADD</span>
                                    New Cabinet
                                </button>
                            </div>
                        </div>

                        <div class="overflow-x-auto">
                            <table class="w-full border-collapse">
                                <thead>
                                    <tr>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            ID</th>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Name</th>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Associated Division</th>
                                        <th
                                            class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="cabinet in paginatedCabinets" :key="cabinet.id"
                                        class="transition-colors border-b border-black/5 hover:bg-black/5">
                                        <td class="p-3">
                                            <span class="inline-block px-2 py-1 text-xs text-white bg-black rounded">
                                                {{ cabinet.id.toString().padStart(2, '0') }}
                                            </span>
                                        </td>
                                        <td class="p-3 font-medium">{{ cabinet.name }}</td>
                                        <td class="p-3 text-black/70">{{ getAssociatedDivision(cabinet.id) }}</td>
                                        <td class="p-3">
                                            <div class="flex gap-2">
                                                <button @click="editCabinet(cabinet)"
                                                    class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                    <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                                    Edit
                                                </button>
                                                <button @click="deleteCabinet(cabinet.id)"
                                                    class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                    <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">02</span>
                                                    Delete
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr v-if="paginatedCabinets.length === 0">
                                        <td colspan="4" class="p-4 text-center text-black/50">No cabinets found</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="flex items-center justify-between pt-4 mt-4 border-t border-black/10">
                            <div class="text-sm text-black/60">
                                Showing {{ cabinetStartIndex + 1 }}-{{ cabinetEndIndex }} of {{ filteredCabinets.length
                                }} cabinets
                            </div>
                            <div class="flex gap-2">
                                <button @click="cabinetPageNum--" :disabled="cabinetPageNum === 1"
                                    class="flex items-center px-3 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-black hover:text-white">
                                    Prev
                                </button>
                                <span class="flex items-center px-3 py-1 text-xs font-medium">
                                    {{ cabinetPageNum }} / {{ cabinetTotalPages }}
                                </span>
                                <button @click="cabinetPageNum++" :disabled="cabinetPageNum === cabinetTotalPages"
                                    class="flex items-center px-3 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-black hover:text-white">
                                    Next
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div v-if="showDetailsModal"
                class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
                <div class="relative w-full max-w-2xl overflow-hidden bg-white rounded-lg shadow-2xl">
                    <div class="absolute inset-0 grid-lines opacity-10"></div>

                    <div class="relative p-6">
                        <div class="flex items-center justify-between pb-4 mb-6 border-b border-black/10">
                            <div class="flex items-center">
                                <div class="flex items-center justify-center w-8 h-8 mr-3 bg-black rounded-full">
                                    <span class="text-xs font-bold text-white">{{
                                        selectedDivision.id?.toString().padStart(2,
                                            '0') || '00' }}</span>
                                </div>
                                <h3 class="text-xl font-bold tracking-wider uppercase">{{ selectedDivision.name }}</h3>
                            </div>
                            <button @click="showDetailsModal = false"
                                class="transition-colors text-black/50 hover:text-black">
                                &times;
                            </button>
                        </div>

                        <div class="flex flex-col gap-6 md:flex-row">
                            <div class="flex-shrink-0">
                                <div class="w-32 h-32 mx-auto overflow-hidden rounded-full">
                                    <img :src="selectedDivision.image" alt="Division Image"
                                        class="object-cover w-full h-full">
                                </div>
                            </div>

                            <div class="flex-1">
                                <div class="grid grid-cols-1 gap-4 mb-4">
                                    <div>
                                        <h4 class="text-xs font-bold tracking-wider uppercase text-black/70">Title</h4>
                                        <p class="font-medium">{{ selectedDivision.title }}</p>
                                    </div>

                                    <div>
                                        <h4 class="text-xs font-bold tracking-wider uppercase text-black/70">Cabinet
                                        </h4>
                                        <p class="font-medium">{{ getCabinetName(selectedDivision.cabinetId) }}</p>
                                    </div>
                                </div>

                                <div>
                                    <h4 class="text-xs font-bold tracking-wider uppercase text-black/70">Description
                                    </h4>
                                    <p class="mt-1 text-black/80">{{ selectedDivision.description }}</p>
                                </div>
                            </div>
                        </div>

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


            <div v-if="showFormModal"
                class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
                <div class="relative w-full max-w-2xl p-0 overflow-hidden bg-white rounded-lg shadow-2xl">
                    <div class="absolute inset-0 grid-lines opacity-10"></div>

                    <div class="relative p-6">
                        <div class="flex items-center justify-between pb-4 mb-6 border-b border-black/10">
                            <div class="flex items-center">
                                <div class="flex items-center justify-center w-8 h-8 mr-3 bg-black rounded-full">
                                    <span class="text-xs font-bold text-white">{{ isEditMode ? 'ED' : 'NEW' }}</span>
                                </div>
                                <h3 class="text-xl font-bold tracking-wider uppercase">
                                    {{ isEditMode ? 'Edit Division' : 'Add New Division' }}
                                </h3>
                            </div>
                            <button @click="showFormModal = false"
                                class="transition-colors text-black/50 hover:text-black">
                                &times;
                            </button>
                        </div>

                        <form @submit.prevent="saveDivision">
                            <div class="grid grid-cols-1 gap-4 mb-6 md:grid-cols-2">
                                <div class="mb-2 md:col-span-2">
                                    <label class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                        Division Image
                                    </label>
                                    <div class="flex items-center gap-4">
                                        <div v-if="formDivision.image" class="w-16 h-16 overflow-hidden rounded-full">
                                            <img :src="formDivision.image" alt="Division Image"
                                                class="object-cover w-full h-full">
                                        </div>
                                        <input type="file" accept="image/*" @change="handleImageUpload"
                                            class="flex-1 p-3 font-mono border rounded border-black/20 bg-white/80" />
                                    </div>
                                </div>

                                <div class="mb-2">
                                    <label for="name"
                                        class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                        Division Name
                                    </label>
                                    <input type="text" id="name" v-model="formDivision.name" required
                                        class="w-full p-3 font-mono border rounded border-black/20 bg-white/80" />
                                </div>

                                <div class="mb-2">
                                    <label for="title"
                                        class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                        Division Title
                                    </label>
                                    <input type="text" id="title" v-model="formDivision.title" required
                                        class="w-full p-3 font-mono border rounded border-black/20 bg-white/80" />
                                </div>

                                <div class="mb-2">
                                    <label for="cabinet"
                                        class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                        Associated Cabinet
                                    </label>
                                    <select id="cabinet" v-model="formDivision.cabinetId"
                                        class="w-full p-3 font-mono border rounded border-black/20 bg-white/80">
                                        <option value="">None</option>
                                        <option v-for="cabinet in availableCabinets" :key="cabinet.id"
                                            :value="cabinet.id">
                                            {{ cabinet.name }}
                                        </option>
                                    </select>
                                </div>

                                <div class="mb-2 md:col-span-2">
                                    <label for="description"
                                        class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                        Description
                                    </label>
                                    <textarea id="description" v-model="formDivision.description" rows="4"
                                        class="w-full p-3 font-mono border rounded border-black/20 bg-white/80"></textarea>
                                </div>
                            </div>

                            <div class="flex justify-end gap-3 pt-4 border-t border-black/10">
                                <button type="button" @click="showFormModal = false"
                                    class="flex items-center px-4 py-2 text-sm font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black/10">
                                    <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                    Cancel
                                </button>
                                <button type="submit"
                                    class="flex items-center px-4 py-2 text-sm font-medium text-white uppercase transition-all duration-300 bg-black border border-black rounded hover:bg-black/80">
                                    <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-white/20">02</span>
                                    {{ isEditMode ? 'Update' : 'Add' }} Division
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div v-if="showCabinetFormModal"
                class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
                <div class="relative w-full max-w-2xl p-0 overflow-hidden bg-white rounded-lg shadow-2xl">
                    <div class="absolute inset-0 grid-lines opacity-10"></div>

                    <div class="relative p-6">
                        <div class="flex items-center justify-between pb-4 mb-6 border-b border-black/10">
                            <div class="flex items-center">
                                <div class="flex items-center justify-center w-8 h-8 mr-3 bg-black rounded-full">
                                    <span class="text-xs font-bold text-white">{{ isEditCabinetMode ? 'ED' : 'NEW'
                                        }}</span>
                                </div>
                                <h3 class="text-xl font-bold tracking-wider uppercase">
                                    {{ isEditCabinetMode ? 'Edit Cabinet' : 'Add New Cabinet' }}
                                </h3>
                            </div>
                            <button @click="showCabinetFormModal = false"
                                class="transition-colors text-black/50 hover:text-black">
                                &times;
                            </button>
                        </div>

                        <form @submit.prevent="saveCabinet">
                            <div class="grid grid-cols-1 gap-4 mb-6">
                                <div class="mb-2">
                                    <label for="cabinetName"
                                        class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">
                                        Cabinet Name
                                    </label>
                                    <input type="text" id="cabinetName" v-model="formCabinet.name" required
                                        class="w-full p-3 font-mono border rounded border-black/20 bg-white/80" />
                                </div>
                            </div>

                            <div class="flex justify-end gap-3 pt-4 border-t border-black/10">
                                <button type="button" @click="showCabinetFormModal = false"
                                    class="flex items-center px-4 py-2 text-sm font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black/10">
                                    <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                    Cancel
                                </button>
                                <button type="submit"
                                    class="flex items-center px-4 py-2 text-sm font-medium text-white uppercase transition-all duration-300 bg-black border border-black rounded hover:bg-black/80">
                                    <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-white/20">02</span>
                                    {{ isEditCabinetMode ? 'Update' : 'Add' }} Cabinet
                                </button>
                            </div>
                        </form>
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
                                <h3 class="text-xl font-bold tracking-wider uppercase">
                                    Delete {{ deleteType.charAt(0).toUpperCase() + deleteType.slice(1) }}
                                </h3>
                            </div>
                            <button @click="showDeleteModal = false"
                                class="transition-colors text-black/50 hover:text-black">
                                &times;
                            </button>
                        </div>

                        <div class="mb-6">
                            <p class="mb-4">
                                Are you sure you want to delete this {{ deleteType }}? This action cannot be undone.
                                {{ deleteType === 'cabinet' ? 'This may affect associated divisions.' : '' }}
                            </p>

                            <div v-if="deleteType === 'division'"
                                class="p-4 mt-4 border rounded-lg border-black/10 bg-black/5">
                                <p class="font-medium">
                                    {{divisions.find(d => d.id === deleteItemId)?.name || 'Unknown Division'}}
                                </p>
                                <p class="mt-1 text-sm text-black/60">
                                    {{divisions.find(d => d.id === deleteItemId)?.title || ''}}
                                </p>
                            </div>

                            <div v-if="deleteType === 'cabinet'"
                                class="p-4 mt-4 border rounded-lg border-black/10 bg-black/5">
                                <p class="font-medium">
                                    {{cabinets.find(c => c.id === deleteItemId)?.name || 'Unknown Cabinet'}}
                                </p>
                            </div>
                        </div>

                        <div class="flex justify-end gap-3 pt-4 border-t border-black/10">
                            <button @click="showDeleteModal = false"
                                class="flex items-center px-4 py-2 text-sm font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black/10">
                                <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                Cancel
                            </button>
                            <button @click="confirmDelete"
                                class="flex items-center px-4 py-2 text-sm font-medium text-white uppercase transition-all duration-300 bg-black border border-black rounded hover:bg-black/80">
                                <span class="mr-1.5 text-[9px] px-1 rounded-sm bg-white/20">02</span>
                                Delete {{ deleteType }}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import AdminLayout from './Layout.vue';

const divisions = ref([]);
const cabinets = ref([]);
const nextDivisionId = ref(1);
const nextCabinetId = ref(1);

const showDetailsModal = ref(false);
const showFormModal = ref(false);
const showCabinetFormModal = ref(false);
const showDeleteModal = ref(false);
const isEditMode = ref(false);
const isEditCabinetMode = ref(false);
const selectedDivision = ref({});
const formDivision = ref({
    name: '',
    title: '',
    description: '',
    image: '',
    cabinetId: ''
});
const formCabinet = ref({
    name: ''
});
const deleteType = ref('');
const deleteItemId = ref(null);

const pageNum = ref(1);
const itemsPerPage = 5;
const searchQuery = ref('');
const selectedCabinetFilter = ref(''); 

watch([searchQuery, selectedCabinetFilter], () => {
    pageNum.value = 1;
});

const filteredDivisions = computed(() => {
    let result = divisions.value;

    if (searchQuery.value) {
        const query = searchQuery.value.toLowerCase();
        result = result.filter(division =>
            division.name.toLowerCase().includes(query) ||
            division.title.toLowerCase().includes(query)
        );
    }

    if (selectedCabinetFilter.value) {
        result = result.filter(division =>
            division.cabinetId === Number(selectedCabinetFilter.value)
        );
    }

    return result;
});

const totalPages = computed(() => Math.ceil(filteredDivisions.value.length / itemsPerPage) || 1);
const startIndex = computed(() => (pageNum.value - 1) * itemsPerPage);
const endIndex = computed(() => Math.min(startIndex.value + itemsPerPage, filteredDivisions.value.length));
const paginatedDivisions = computed(() => filteredDivisions.value.slice(startIndex.value, endIndex.value));

const cabinetPageNum = ref(1);
const cabinetItemsPerPage = 5;
const cabinetSearchQuery = ref('');

watch(cabinetSearchQuery, () => {
    cabinetPageNum.value = 1;
});

const filteredCabinets = computed(() => {
    if (!cabinetSearchQuery.value) return cabinets.value;
    const query = cabinetSearchQuery.value.toLowerCase();
    return cabinets.value.filter(cabinet =>
        cabinet.name.toLowerCase().includes(query)
    );
});

const cabinetTotalPages = computed(() => Math.ceil(filteredCabinets.value.length / cabinetItemsPerPage) || 1);
const cabinetStartIndex = computed(() => (cabinetPageNum.value - 1) * cabinetItemsPerPage);
const cabinetEndIndex = computed(() => Math.min(cabinetStartIndex.value + cabinetItemsPerPage, filteredCabinets.value.length));
const paginatedCabinets = computed(() => filteredCabinets.value.slice(cabinetStartIndex.value, cabinetEndIndex.value));

const availableCabinets = computed(() => {
    if (isEditMode.value) {
        const assignedCabinetIds = divisions.value
            .filter(d => d.id !== formDivision.value.id)
            .map(d => d.cabinetId);

        return cabinets.value.filter(c => !assignedCabinetIds.includes(c.id) || c.id === formDivision.value.cabinetId);
    } else {
        const assignedCabinetIds = divisions.value.map(d => d.cabinetId);
        return cabinets.value.filter(c => !assignedCabinetIds.includes(c.id));
    }
});

function getCabinetName(cabinetId) {
    const cabinet = cabinets.value.find(c => c.id === cabinetId);
    return cabinet ? cabinet.name : 'Unassigned';
}

function getAssociatedDivision(cabinetId) {
    const division = divisions.value.find(d => d.cabinetId === cabinetId);
    return division ? division.name : 'No Division';
}

function viewDetails(division) {
    selectedDivision.value = division;
    showDetailsModal.value = true;
}

function openCreateModal() {
    isEditMode.value = false;
    formDivision.value = {
        name: '',
        title: '',
        description: '',
        image: '',
        cabinetId: ''
    };
    showFormModal.value = true;
}

function editDivision(division) {
    isEditMode.value = true;
    formDivision.value = { ...division };
    showFormModal.value = true;
}

function handleImageUpload(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            formDivision.value.image = e.target.result;
        };
        reader.readAsDataURL(file);
    }
}

function saveDivision() {
    if (isEditMode.value) {
        const index = divisions.value.findIndex(d => d.id === formDivision.value.id);
        if (index !== -1) {
            divisions.value[index] = { ...formDivision.value };
        }
    } else {
        formDivision.value.id = nextDivisionId.value++;
        divisions.value.push({ ...formDivision.value });
    }
    showFormModal.value = false;
}

function openCreateCabinetModal() {
    isEditCabinetMode.value = false;
    formCabinet.value = {
        name: ''
    };
    showCabinetFormModal.value = true;
}

function editCabinet(cabinet) {
    isEditCabinetMode.value = true;
    formCabinet.value = { ...cabinet };
    showCabinetFormModal.value = true;
}

function saveCabinet() {
    if (isEditCabinetMode.value) {
        const index = cabinets.value.findIndex(c => c.id === formCabinet.value.id);
        if (index !== -1) {
            cabinets.value[index] = { ...formCabinet.value };
        }
    } else {
        formCabinet.value.id = nextCabinetId.value++;
        cabinets.value.push({ ...formCabinet.value });
    }
    showCabinetFormModal.value = false;
}

function deleteDivision(id) {
    deleteType.value = 'division';
    deleteItemId.value = id;
    showDeleteModal.value = true;
}

function deleteCabinet(id) {
    deleteType.value = 'cabinet';
    deleteItemId.value = id;
    showDeleteModal.value = true;
}

function confirmDelete() {
    if (deleteType.value === 'division') {
        divisions.value = divisions.value.filter(d => d.id !== deleteItemId.value);
    } else if (deleteType.value === 'cabinet') {
        cabinets.value = cabinets.value.filter(c => c.id !== deleteItemId.value);
    }
    showDeleteModal.value = false;
}

onMounted(() => {
    divisions.value = [
        {
            id: 1,
            name: 'BOD',
            title: 'Board of Directors',
            image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
            description: 'lorem',
            cabinetId: 1
        },
        {
            id: 2,
            name: 'RNT',
            title: 'Research and Technology',
            image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
            description: 'lorem',
            cabinetId: 2
        },
        {
            id: 1,
            name: 'HRD',
            title: 'Human Resources Development',
            image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
            description: 'lorem',
            cabinetId: 1
        },
        {
            id: 2,
            name: 'ICM',
            title: 'Information and Creative Media',
            image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
            description: 'lorem',
            cabinetId: 1
        }
    ];

    cabinets.value = [
        {
            id: 1,
            name: 'Kaustav Cabinet'
        },
        {
            id: 2,
            name: 'Kopi Cabinet'
        },
    ];

    nextDivisionId.value = divisions.value.length + 1;
    nextCabinetId.value = cabinets.value.length + 1;
});
</script>

<style scoped>
.grid-lines {
    background-image: linear-gradient(to right, rgba(0, 0, 0, 0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(0, 0, 0, 0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}
</style>