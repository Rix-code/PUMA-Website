<template>
    <AdminLayout>
        <div class="container relative p-4 mx-auto overflow-hidden font-mono">
            <div class="absolute inset-0 z-0 grid-lines opacity-10"></div>
            
            <div class="relative z-10">
                <div class="relative overflow-hidden bg-white border rounded-lg shadow-lg border-black/10">
                    <div class="absolute inset-0 grid-lines opacity-5"></div>

                    <div class="relative p-6">
                        <div class="flex flex-col justify-between mb-6 md:flex-row md:items-center">
                            <h2 class="mb-4 text-xl font-bold tracking-wider uppercase md:mb-0">Guest Accounts</h2>

                            <div class="flex flex-col gap-4 md:flex-row">
                                <div class="relative">
                                    <input v-model="searchQuery" placeholder="Search guests..."
                                        class="w-full p-2 pl-3 font-mono text-sm border rounded-lg md:w-64 border-black/20 bg-white/80 backdrop-blur-sm">
                                </div>
                            </div>
                        </div>

                        <div class="overflow-x-auto">
                            <table class="w-full border-collapse">
                                <thead>
                                    <tr>
                                        <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            ID</th>
                                        <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Avatar</th>
                                        <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Name</th>
                                        <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Email</th>
                                        <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Registration Date</th>
                                        <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                            Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="guest in paginatedGuests" :key="guest.id"
                                        class="transition-colors border-b border-black/5 hover:bg-black/5">
                                        <td class="p-3">
                                            <span class="inline-block px-2 py-1 text-xs text-white bg-black rounded">
                                                {{ guest.id.toString().padStart(2, '0') }}
                                            </span>
                                        </td>
                                        <td class="p-3">
                                            <div class="w-10 h-10 overflow-hidden rounded-full">
                                                <img :src="guest.avatar" alt="Avatar" class="object-cover w-full h-full">
                                            </div>
                                        </td>
                                        <td class="p-3 font-medium">{{ guest.name }}</td>
                                        <td class="p-3 text-black/70">{{ guest.email }}</td>
                                        <td class="p-3 text-black/70">{{ guest.registrationDate }}</td>
                                        <td class="p-3">
                                            <div class="flex gap-2">
                                                <button @click="viewDetails(guest)"
                                                    class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                    <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                                    View
                                                </button>
                                                <button @click="deleteItem(guest.id)"
                                                    class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                    <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">02</span>
                                                    Delete
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr v-if="paginatedGuests.length === 0">
                                        <td colspan="6" class="p-4 text-center text-black/50">No guest accounts found</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="flex items-center justify-between pt-4 mt-4 border-t border-black/10">
                            <div class="text-sm text-black/60">
                                Showing {{ startIndex + 1 }}-{{ endIndex }} of {{ filteredGuests.length }} guests
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
            </div>

            <div v-if="showDetailsModal"
                class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
                <div class="relative w-full max-w-2xl overflow-hidden bg-white rounded-lg shadow-2xl">
                    <div class="absolute inset-0 grid-lines opacity-10"></div>

                    <div class="relative p-6">
                        <div class="flex items-center justify-between pb-4 mb-6 border-b border-black/10">
                            <div class="flex items-center">
                                <div class="flex items-center justify-center w-8 h-8 mr-3 bg-black rounded-full">
                                    <span class="text-xs font-bold text-white">{{ selectedGuest.id?.toString().padStart(2,
                                        '0') || '00' }}</span>
                                </div>
                                <h3 class="text-xl font-bold tracking-wider uppercase">{{ selectedGuest.name }}</h3>
                            </div>
                            <button @click="showDetailsModal = false"
                                class="transition-colors text-black/50 hover:text-black">
                                &times;
                            </button>
                        </div>
                        
                        <div class="flex flex-col gap-6 md:flex-row">
                            <div class="flex-shrink-0">
                                <div class="w-32 h-32 mx-auto overflow-hidden rounded-full">
                                    <img :src="selectedGuest.avatar" alt="Avatar" class="object-cover w-full h-full">
                                </div>
                            </div>
                            
                            <div class="flex-1">
                                <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
                                    <div>
                                        <h4 class="text-xs font-bold tracking-wider uppercase text-black/70">Email</h4>
                                        <p class="font-medium">{{ selectedGuest.email }}</p>
                                    </div>
                                    
                                    <div>
                                        <h4 class="text-xs font-bold tracking-wider uppercase text-black/70">Registration Date</h4>
                                        <p class="font-medium">{{ selectedGuest.registrationDate }}</p>
                                    </div>
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

                        <p class="mb-6">Are you sure you want to delete this guest account? This action cannot be undone.</p>
                        
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

<script setup>
import { ref, computed, watch } from 'vue';
import AdminLayout from './Layout.vue';

const guests = ref([
    {
        id: 1,
        name: 'Guest User 1',
        email: 'guest1@example.com',
        registrationDate: '2025-01-15',
        avatar: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg'
    },
    {
        id: 2,
        name: 'Guest User 2',
        email: 'guest2@example.com',
        registrationDate: '2025-02-03',
        avatar: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg'
    },
    {
        id: 3,
        name: 'Guest User 3',
        email: 'guest3@example.com',
        registrationDate: '2025-02-20',
        avatar: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg'
    },
    {
        id: 4,
        name: 'Guest User 4',
        email: 'guest4@example.com',
        registrationDate: '2025-03-01',
        avatar: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg'
    },
    {
        id: 5,
        name: 'Guest User 5',
        email: 'guest5@example.com',
        registrationDate: '2025-03-10',
        avatar: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg'
    }
]);

const searchQuery = ref('');
const pageNum = ref(1);
const itemsPerPage = 5;

const showDetailsModal = ref(false);
const showDeleteModal = ref(false);
const selectedGuest = ref({});
const deleteId = ref(null);

const filteredGuests = computed(() => {
    if (!searchQuery.value) {
        return [...guests.value];
    }
    
    const query = searchQuery.value.toLowerCase();
    return guests.value.filter(guest => 
        guest.name.toLowerCase().includes(query) || 
        guest.email.toLowerCase().includes(query)
    );
});

const totalPages = computed(() => {
    return Math.max(1, Math.ceil(filteredGuests.value.length / itemsPerPage));
});

const startIndex = computed(() => {
    return (pageNum.value - 1) * itemsPerPage;
});

const endIndex = computed(() => {
    const calculatedEnd = startIndex.value + itemsPerPage;
    return Math.min(calculatedEnd, filteredGuests.value.length);
});

const paginatedGuests = computed(() => {
    return filteredGuests.value.slice(startIndex.value, endIndex.value);
});

function viewDetails(guest) {
    selectedGuest.value = { ...guest };
    showDetailsModal.value = true;
}

function deleteItem(id) {
    deleteId.value = id;
    showDeleteModal.value = true;
}

function confirmDelete() {
    if (deleteId.value !== null) {
        guests.value = guests.value.filter(guest => guest.id !== deleteId.value);
        showDeleteModal.value = false;
        deleteId.value = null;
        
        if (paginatedGuests.value.length === 0 && pageNum.value > 1) {
            pageNum.value = 1;
        }
    }
}

watch(searchQuery, () => {
    pageNum.value = 1;
});

const style = document.createElement('style');
style.textContent = `
.grid-lines {
    background-image: 
        linear-gradient(to right, rgba(0,0,0,0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(0,0,0,0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}
`;
document.head.appendChild(style);
</script>