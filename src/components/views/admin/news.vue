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
                    ADD NEW ITEM
                </button>
            </div>

            <div class="relative overflow-hidden bg-white border rounded-lg shadow-lg border-black/10">
                <div class="absolute inset-0 grid-lines opacity-5"></div>

                <div class="relative p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-xl font-bold tracking-wider uppercase">News Items</h2>

                        <div class="relative">
                            <input v-model="searchQuery" placeholder="Search items..."
                                class="w-full p-2 pl-3 font-mono text-sm border rounded-lg md:w-64 border-black/20 bg-white/80 backdrop-blur-sm">
                        </div>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full border-collapse">
                            <thead>
                                <tr>
                                    <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                        ID</th>
                                    <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                        Category</th>
                                    <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                        Date</th>
                                    <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                        Title</th>
                                    <th class="p-3 text-xs tracking-wider text-left uppercase border-b border-black/10">
                                        Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in filteredNews" :key="item.id"
                                    class="transition-colors border-b border-black/5 hover:bg-black/5">
                                    <td class="p-3">
                                        <span class="inline-block px-2 py-1 text-xs text-white bg-black rounded">{{
                                            item.id.toString().padStart(2, '0') }}</span>
                                    </td>
                                    <td class="p-3">
                                        <span class="px-2 py-1 text-xs bg-white border rounded-full border-black/20">{{
                                            item.category }}</span>
                                    </td>
                                    <td class="p-3 text-black/70">{{ formatDate(item.date) }}</td>
                                    <td class="p-3 font-medium">{{ item.title }}</td>
                                    <td class="p-3">
                                        <div class="flex gap-2">
                                            <button @click="viewDetails(item)"
                                                class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">01</span>
                                                View
                                            </button>
                                            <button @click="editItem(item)"
                                                class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">02</span>
                                                Edit
                                            </button>
                                            <button @click="deleteItem(item.id)"
                                                class="flex items-center px-2 py-1 text-xs font-medium uppercase transition-all duration-300 border rounded border-black/20 hover:bg-black hover:text-white">
                                                <span class="mr-1 text-[9px] px-1 rounded-sm bg-black/10">03</span>
                                                Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr v-if="filteredNews.length === 0">
                                    <td colspan="5" class="p-4 text-center text-black/50">No news items found</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="showEditModal"
            class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
            <div class="relative w-full max-w-2xl p-0 overflow-hidden bg-white rounded-lg shadow-2xl">
                <div class="absolute inset-0 grid-lines opacity-10"></div>

                <div class="relative p-6">
                    <div class="flex items-center justify-between pb-4 mb-6 border-b border-black/10">
                        <div class="flex items-center">
                            <div class="flex items-center justify-center w-8 h-8 mr-3 bg-black rounded-full">
                                <span class="text-xs font-bold text-white">{{ isEditing ? 'ED' : 'NEW' }}</span>
                            </div>
                            <h3 class="text-xl font-bold tracking-wider uppercase">{{ isEditing ? 'Edit News Item' :
                                'Add New News Item' }}</h3>
                        </div>
                        <button @click="showEditModal = false" class="transition-colors text-black/50 hover:text-black">
                            &times;
                        </button>
                    </div>

                    <form @submit.prevent="saveNewsItem">
                        <div class="grid grid-cols-1 gap-4 mb-6 md:grid-cols-2">
                            <div class="mb-2">
                                <label
                                    class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Category</label>
                                <input v-model="currentItem.category" type="text"
                                class="w-full p-3 font-mono border rounded border-black/20 bg-white/80" required>
                            </div>

                            <div class="mb-2">
                                <label
                                    class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Date</label>
                                <input v-model="currentItem.date" type="date"
                                    class="w-full p-3 font-mono border rounded border-black/20 bg-white/80" required>
                            </div>

                            <div class="mb-2 md:col-span-2">
                                <label
                                class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Title</label>
                                <input v-model="currentItem.title" type="text"
                                    class="w-full p-3 font-mono border rounded border-black/20 bg-white/80" required>
                            </div>

                            <div class="mb-2 md:col-span-2">
                                <label
                                    class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Description</label>
                                <textarea v-model="currentItem.description" rows="2"
                                    class="w-full p-3 font-mono border rounded border-black/20 bg-white/80"
                                    required></textarea>
                            </div>

                            <div class="mb-2 md:col-span-2">
                                <label
                                    class="block mb-1 text-xs font-bold tracking-wider uppercase text-black/70">Content
                                    (Optional)</label>
                                <textarea v-model="currentItem.content" rows="4"
                                    class="w-full p-3 font-mono border rounded border-black/20 bg-white/80"></textarea>
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
                                {{ isEditing ? 'Update' : 'Add' }} Item
                            </button>
                        </div>
                    </form>
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
                                <span class="text-xs font-bold text-white">{{ selectedItem.id?.toString().padStart(2,
                                    '0') || '00' }}</span>
                            </div>
                            <h3 class="text-xl font-bold tracking-wider uppercase">{{ selectedItem.title }}</h3>
                        </div>
                        <button @click="showDetailsModal = false"
                            class="transition-colors text-black/50 hover:text-black">
                            &times;
                        </button>
                    </div>
                    
                    <div class="mb-4">
                        <span
                            class="inline-block px-2 py-1 mr-2 text-xs bg-white border rounded-full border-black/20">{{
                            selectedItem.category }}</span>
                        <span class="text-black/70">{{ formatDate(selectedItem.date) }}</span>
                    </div>

                    <div class="p-4 mb-4 font-medium rounded-lg bg-black/5">
                        {{ selectedItem.description }}
                    </div>

                    <div v-if="selectedItem.content" class="pt-4 mt-4 border-t border-black/10">
                        <h4 class="mb-2 text-xs font-bold tracking-wider uppercase text-black/70">Full Content</h4>
                        <p class="leading-relaxed text-black/80">{{ selectedItem.content }}</p>
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

                    <p class="mb-6">Are you sure you want to delete this news item? This action cannot be undone.</p>
                    
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

<script>
import AdminLayout from './Layout.vue';
export default {
    data() {
        return {
            newsItems: [
                {
                    id: 1,
                    category: "lorem",
                    date: "2025-03-15",
                    title: "Lorem Ipsum",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus."
                },
                {
                    id: 2,
                    category: "lorem",
                    date: "2025-03-15",
                    title: "Lorem Ipsum",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus."
                },
                {
                    id: 3,
                    category: "lorem",
                    date: "2025-03-15",
                    title: "Lorem Ipsum",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus."
                },
                {
                    id: 4,
                    category: "lorem",
                    date: "2025-03-15",
                    title: "Lorem Ipsum",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus."
                }
                
            ],
            currentItem: {
                id: null,
                category: "",
                date: "",
                title: "",
                description: "",
                content: ""
            },
            isEditing: false,
            searchQuery: "",
            showDetailsModal: false,
            showEditModal: false,
            showDeleteModal: false,
            selectedItem: {},
            itemToDeleteId: null
        };
    },
    computed: {
        filteredNews() {
            if (!this.searchQuery) {
                return this.newsItems;
            }

            const query = this.searchQuery.toLowerCase();
            return this.newsItems.filter(item =>
                item.title.toLowerCase().includes(query) ||
                item.category.toLowerCase().includes(query)
            );
        }
    },
    methods: {
        formatDate(dateStr) {
            const date = new Date(dateStr);
            return new Intl.DateTimeFormat('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            }).format(date);
        },

        openAddModal() {
            this.resetForm();
            this.showEditModal = true;
        },

        saveNewsItem() {
            if (this.isEditing) {
                const index = this.newsItems.findIndex(item => item.id === this.currentItem.id);
                if (index !== -1) {
                    this.newsItems[index] = { ...this.currentItem };
                }
            } else {
                const newId = this.newsItems.length > 0
                    ? Math.max(...this.newsItems.map(item => item.id)) + 1
                    : 1;

                this.newsItems.push({
                    ...this.currentItem,
                    id: newId
                });
            }

            this.showEditModal = false;
            this.resetForm();
        },

        editItem(item) {
            this.currentItem = { ...item };
            this.isEditing = true;
            this.showEditModal = true;
        },

        deleteItem(id) {
            this.itemToDeleteId = id;
            this.showDeleteModal = true;
        },

        confirmDelete() {
            this.newsItems = this.newsItems.filter(item => item.id !== this.itemToDeleteId);
            this.showDeleteModal = false;
            this.itemToDeleteId = null;
        },

        viewDetails(item) {
            this.selectedItem = { ...item };
            this.showDetailsModal = true;
        },

        resetForm() {
            this.currentItem = {
                id: null,
                category: "",
                date: "",
                title: "",
                description: "",
                content: ""
            };
            this.isEditing = false;
        }
    }
};
</script>

<style scoped>
.grid-lines {
    background-image:
        linear-gradient(to right, rgba(0, 0, 0, 0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(0, 0, 0, 0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}
</style>