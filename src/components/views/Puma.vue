<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import Navbar from '../Navbar.vue'
import Footer from '../Footer.vue'

interface Division {
    name: string
    title: string
    image: string
    description: string
}

interface Member {
    id: number
    name: string
    email: string
    position: string
    cabinet: string
    batch: string
    division: string
    avatar: string
    instagram: string
    linkedin: string
    personalDescription: string
}

const route = useRoute()
const selectedDivision = ref<string>('all')
const selectedCabinet = ref<string>('all')
const searchQuery = ref<string>('')
const isLoading = ref<boolean>(true)
const currentPage = ref<number>(1)
const itemsPerPage = ref<number>(12)
const selectedMember = ref<Member | null>(null)
const isModalOpen = ref<boolean>(false)

const divisions: Division[] = [
    {
        name: 'BOD',
        title: 'Board of Directors',
        image: 'D:\PUMA Web\PUMA-Website\public\DSC_0926.JPG',
        description: 'lorem'
    },
    {
        name: 'RNT',
        title: 'Research and Technology',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'HRD',
        title: 'Human Resources Development',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'ICM',
        title: 'Information and Creative Media',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'IR',
        title: 'Internal Relations',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'ER',
        title: 'External Relations',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'SAC',
        title: 'Student Academic & Competition',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'SPT',
        title: 'Student Passions & Talents',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    },
    {
        name: 'TECHNOPRENEUR',
        title: 'Technopreneur',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'lorem'
    }
]

const cabinets = ['Kaustav', 'Kopi']

const memberAvatars = [
    'https://i.pinimg.com/474x/2d/66/90/2d669016a3e3f5316b0589741e8ca834.jpg',
    'https://i.pinimg.com/474x/9c/58/0a/9c580ad4644fffdb9bf4eedb7b61eec2.jpg',
    'https://i.pinimg.com/474x/d5/14/5e/d5145e0284dcf8b0d828b78d2ebeaacc.jpg',
    'https://i.pinimg.com/474x/a1/da/a6/a1daa6f2d1416629a2af13989ebcaa9f.jpg',
    'https://i.pinimg.com/474x/8f/72/31/8f723127ce24c5983fd21d6fa84733a8.jpg',
    'https://i.pinimg.com/474x/1c/02/5f/1c025fa699fe372269009dad8681ca9e.jpg'
]

const generateMembers = (): Member[] => {
    const members: Member[] = []
    const regularPositions = ['HOD', 'VOD', 'Member']
    const bodPositions = ['CP', 'VCP1', 'VCP2', 'Treasurer', 'Secretary']
    const batches = ['2023', '2024']
    const firstNames = ['Jonas', 'Martha', 'Ulrich', 'Katharina', 'Hannah', 'Magnus', 'Bartosz', 'Franziska', 'Elisabeth', 'Noah', 'Helge', 'Claudia', 'Regina', 'Tronte', 'Charlotte', 'Jana', 'Egon', 'Aleksander', 'Gretchen', 'Silja']
    const lastNames = ['Kahnwald', 'Nielsen', 'Doppler', 'Tiedemann', 'Obendorf', 'Albers', 'Wöller', 'Conwald', 'Boris', 'Schmidt', 'Tauber', 'Winden', 'Erdmann', 'Krüger', 'Pauls', 'Bergen', 'Lorenz', 'Fischer', 'Meier', 'Schwarz']

    const assignedBodPositions = new Set()

    for (let i = 0; i < 100; i++) {
        const firstName = firstNames[Math.floor(Math.random() * firstNames.length)]
        const lastName = lastNames[Math.floor(Math.random() * lastNames.length)]
        const name = `${firstName} ${lastName}`
        const email = `${firstName.toLowerCase()}.${lastName.toLowerCase()}@puma.org`
        const cabinet = cabinets[Math.floor(Math.random() * cabinets.length)]
        const batch = batches[Math.floor(Math.random() * batches.length)]
        const division = divisions[Math.floor(Math.random() * divisions.length)].name
        const avatar = memberAvatars[i % memberAvatars.length]
        const instagram = `https://instagram.com/${firstName.toLowerCase()}_${lastName.toLowerCase()}`
        const linkedin = `https://linkedin.com/in/${firstName.toLowerCase()}-${lastName.toLowerCase()}`
        const personalDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

        let position
        if (division === 'BOD') {
            if (assignedBodPositions.size < bodPositions.length) {
                let availablePositions = bodPositions.filter(pos => !assignedBodPositions.has(pos))
                position = availablePositions[Math.floor(Math.random() * availablePositions.length)]
                assignedBodPositions.add(position)
            } else {
                const otherDivisions = divisions.filter(d => d.name !== 'BOD')
                const newDivision = otherDivisions[Math.floor(Math.random() * otherDivisions.length)].name
                position = regularPositions[Math.floor(Math.random() * regularPositions.length)]
                members.push({
                    id: i + 1,
                    name,
                    email,
                    position,
                    cabinet,
                    batch,
                    division: newDivision,
                    avatar,
                    instagram,
                    linkedin,
                    personalDescription
                })
                continue
            }
        } else {
            position = regularPositions[Math.floor(Math.random() * regularPositions.length)]
        }

        members.push({
            id: i + 1,
            name,
            email,
            position,
            cabinet,
            batch,
            division,
            avatar,
            instagram,
            linkedin,
            personalDescription
        })
    }

    return members
}

const allMembers = ref<Member[]>([])
const filteredMembers = computed(() => {
    let result = [...allMembers.value]

    if (selectedDivision.value !== 'all') {
        result = result.filter(member => member.division === selectedDivision.value)
    }

    if (selectedCabinet.value !== 'all') {
        result = result.filter(member => member.cabinet === selectedCabinet.value)
    }

    if (searchQuery.value) {
        const query = searchQuery.value.toLowerCase()
        result = result.filter(member =>
            member.name.toLowerCase().includes(query) ||
            member.email.toLowerCase().includes(query) ||
            member.position.toLowerCase().includes(query)
        )
    }

    return result
})

const totalPages = computed(() => Math.ceil(filteredMembers.value.length / itemsPerPage.value))
const paginatedMembers = computed(() => {
    const start = (currentPage.value - 1) * itemsPerPage.value
    const end = start + itemsPerPage.value
    return filteredMembers.value.slice(start, end)
})

const goToPage = (pageNumber: number) => {
    currentPage.value = pageNumber
    window.scrollTo({ top: 0, behavior: 'smooth' })
}

const getDivisionTitle = (code: string) => {
    const division = divisions.find(d => d.name === code)
    return division ? division.title : code
}

const openModal = (member: Member) => {
    selectedMember.value = member
    isModalOpen.value = true
}

const closeModal = () => {
    isModalOpen.value = false
    selectedMember.value = null
}

onMounted(() => {
    setTimeout(() => {
        allMembers.value = generateMembers()
        isLoading.value = false
    }, 800)
})

// Watch for changes in the route query
watch(
    () => route.query.division,
    (newDivision) => {
        if (newDivision) {
            selectedDivision.value = newDivision as string
        } else {
            selectedDivision.value = 'all'
        }
    },
    { immediate: true }
)
</script>

<template>
    <Navbar />
    <div class="min-h-screen pt-20 bg-gray-50">
        <section class="py-6 bg-white border-b border-gray-200">
            <div class="container px-4 mx-auto">
                <div class="flex flex-col space-y-4 md:space-y-0 md:flex-row md:space-x-6">
                    <div class="flex-1">
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <svg class="w-4 h-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                </svg>
                            </span>
                            <input type="text" v-model="searchQuery" placeholder="Search by name, email, position..."
                                class="w-full py-3 pl-10 pr-4 text-sm transition-all bg-gray-100 border-0 rounded-lg focus:ring-2 focus:ring-black focus:outline-none" />
                        </div>
                    </div>

                    <div class="md:w-64">
                        <div class="relative">
                            <select v-model="selectedDivision"
                                class="w-full py-3 pl-4 pr-10 text-sm transition-all bg-gray-100 border-0 rounded-lg appearance-none focus:ring-2 focus:ring-black focus:outline-none">
                                <option value="all">All Divisions</option>
                                <option v-for="division in divisions" :key="division.name" :value="division.name">
                                    {{ division.title }}
                                </option>
                            </select>
                            <div class="absolute inset-y-0 right-0 flex items-center px-3 pointer-events-none">
                                <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <div class="md:w-64">
                        <div class="relative">
                            <select v-model="selectedCabinet"
                                class="w-full py-3 pl-4 pr-10 text-sm transition-all bg-gray-100 border-0 rounded-lg appearance-none focus:ring-2 focus:ring-black focus:outline-none">
                                <option value="all">All Cabinets</option>
                                <option v-for="cabinet in cabinets" :key="cabinet" :value="cabinet">
                                    {{ cabinet }}
                                </option>
                            </select>
                            <div class="absolute inset-y-0 right-0 flex items-center px-3 pointer-events-none">
                                <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-12">
            <div class="container px-4 mx-auto">
                <div class="flex items-center justify-between mb-8">
                    <h2 class="text-xl font-bold text-gray-900">
                        <span class="mr-2">Members</span>
                        <span class="px-2 py-1 text-xs text-gray-600 bg-gray-100 border border-gray-200 rounded-full">
                            {{ isLoading ? '...' : filteredMembers.length }} results
                        </span>
                    </h2>
                    <div v-if="!isLoading" class="text-sm text-gray-600">
                        Showing page {{ currentPage }} of {{ totalPages || 1 }}
                    </div>
                </div>

                <div v-if="isLoading" class="flex items-center justify-center py-20">
                    <div class="w-12 h-12 border-t-2 border-b-2 border-black rounded-full animate-spin"></div>
                </div>

                <div v-else>
                    <div v-if="filteredMembers.length === 0"
                        class="py-20 text-center bg-gray-100 border border-gray-200 border-dashed rounded-lg">
                        <svg class="w-16 h-16 mx-auto text-gray-400" fill="none" stroke="currentColor"
                            viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M12 21a9 9 0 110-18 9 9 0 010 18z">
                            </path>
                        </svg>
                        <h3 class="mt-4 text-lg font-semibold text-gray-700">No members found</h3>
                        <p class="mt-2 text-sm text-gray-500">Try adjusting your filters</p>
                    </div>

                    <div v-else class="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                        <div v-for="member in paginatedMembers" :key="member.id"
                            class="bg-white rounded-lg overflow-hidden border border-gray-200 transition-all duration-200 hover:translate-y-[-4px] hover:shadow-lg"
                            @click="openModal(member)">

                            <div class="flex items-start p-4 border-b border-gray-100">
                                <div class="relative w-16 h-16 mr-4">
                                    <img :src="member.avatar" :alt="member.name"
                                        class="object-cover w-16 h-16 border-2 border-gray-200 rounded-full"
                                        loading="lazy" />
                                </div>

                                <div class="flex-1">
                                    <h3 class="text-lg font-semibold leading-tight text-gray-900">{{ member.name }}</h3>
                                    <p class="text-sm text-gray-600 mt-0.5">{{ member.position }}</p>
                                    <div class="flex gap-1 mt-1">
                                        <span
                                            class="inline-flex items-center px-2 py-0.5 text-xs font-medium bg-gray-100 text-gray-800 rounded">
                                            {{ member.division }}
                                        </span>
                                        <span
                                            class="inline-flex items-center px-2 py-0.5 text-xs font-medium bg-gray-100 text-gray-800 rounded">
                                            {{ member.cabinet }}
                                        </span>
                                    </div>
                                </div>

                                <div class="transition-opacity opacity-0 group-hover:opacity-100">
                                    <button class="p-2 rounded-full hover:bg-gray-100">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-500"
                                            viewBox="0 0 20 20" fill="currentColor">
                                            <path
                                                d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z" />
                                            <path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z" />
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <div class="p-4 bg-gray-50">
                                <p class="mb-2 text-sm text-gray-600 truncate">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="inline w-4 h-4 mr-1 text-gray-500"
                                        fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                    </svg>
                                    {{ member.email }}
                                </p>
                                <button
                                    class="w-full py-2 text-sm font-medium text-center text-gray-800 transition-colors bg-gray-100 rounded-md hover:bg-gray-200">
                                    View Profile
                                </button>
                            </div>
                        </div>
                    </div>

                    <div v-if="totalPages > 1" class="flex justify-center mt-10">
                        <div class="flex space-x-1">
                            <button @click="goToPage(currentPage - 1)" :disabled="currentPage === 1"
                                class="px-4 py-2 text-sm text-gray-700 transition-colors border border-gray-200 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-100">
                                Previous
                            </button>

                            <template v-if="totalPages <= 7">
                                <button v-for="page in totalPages" :key="page" @click="goToPage(page)" :class="[
                                    'px-4 py-2 text-sm border rounded-lg transition-colors',
                                    currentPage === page
                                        ? 'bg-black text-white border-black'
                                        : 'border-gray-200 hover:bg-gray-100 text-gray-700'
                                ]">
                                    {{ page }}
                                </button>
                            </template>

                            <template v-else>
                                <button @click="goToPage(1)" :class="[
                                    'px-4 py-2 text-sm border rounded-lg transition-colors',
                                    currentPage === 1
                                        ? 'bg-black text-white border-black'
                                        : 'border-gray-200 hover:bg-gray-100 text-gray-700'
                                ]">
                                    1
                                </button>

                                <span v-if="currentPage > 3" class="px-4 py-2 text-sm text-gray-400">...</span>

                                <template v-for="pageNum in totalPages" :key="pageNum">
                                    <button
                                        v-if="pageNum !== 1 && pageNum !== totalPages && Math.abs(currentPage - pageNum) <= 1"
                                        @click="goToPage(pageNum)" :class="[
                                            'px-4 py-2 text-sm border rounded-lg transition-colors',
                                            currentPage === pageNum
                                                ? 'bg-black text-white border-black'
                                                : 'border-gray-200 hover:bg-gray-100 text-gray-700'
                                        ]">
                                        {{ pageNum }}
                                    </button>
                                </template>

                                <span v-if="currentPage < totalPages - 2"
                                    class="px-4 py-2 text-sm text-gray-400">...</span>

                                <button @click="goToPage(totalPages)" :class="[
                                    'px-4 py-2 text-sm border rounded-lg transition-colors',
                                    currentPage === totalPages
                                        ? 'bg-black text-white border-black'
                                        : 'border-gray-200 hover:bg-gray-100 text-gray-700'
                                ]">
                                    {{ totalPages }}
                                </button>
                            </template>

                            <button @click="goToPage(currentPage + 1)" :disabled="currentPage === totalPages"
                                class="px-4 py-2 text-sm text-gray-700 transition-colors border border-gray-200 rounded-lg disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-100">
                                Next
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <Footer />

    <div v-if="isModalOpen"
        class="fixed inset-0 z-50 flex items-center justify-center transition-all duration-300 bg-black/30 backdrop-blur-sm"
        @click.self="closeModal">
        <div class="relative w-full max-w-4xl mx-4 overflow-hidden transition-all duration-500 transform bg-white shadow-2xl rounded-xl"
            :class="{ 'scale-100 opacity-100': isModalOpen, 'scale-95 opacity-0': !isModalOpen }"
            :style="{ boxShadow: '0 10px 40px rgba(0, 0, 0, 0.2), 0 0 0 1px rgba(0, 0, 0, 0.05)' }">

            <div class="absolute top-0 left-0 right-0 h-1 bg-black"></div>

            <button @click="closeModal"
                class="absolute z-10 flex items-center justify-center w-10 h-10 transition-all duration-300 bg-gray-100 rounded-full hover:bg-gray-200 top-4 right-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-700" viewBox="0 0 24 24" fill="none"
                    stroke="currentColor" stroke-width="2">
                    <line x1="18" y1="6" x2="6" y2="18"></line>
                    <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
            </button>

            <div class="p-6 sm:p-8">
                <div v-if="selectedMember" class="space-y-6">
                    <div class="flex flex-col items-center space-y-4 sm:flex-row sm:space-y-0 sm:space-x-6">
                        <img :src="selectedMember.avatar" :alt="selectedMember.name"
                            class="object-cover w-32 h-32 rounded-lg shadow-md sm:w-40 sm:h-40" />

                        <div class="text-center sm:text-left">
                            <h3 class="text-2xl font-bold text-gray-900">{{ selectedMember.name }}</h3>
                            <p class="text-gray-600">{{ selectedMember.email }}</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                        <div>
                            <p class="text-sm text-gray-500">Position</p>
                            <p class="font-semibold text-gray-700">{{ selectedMember.position }}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Cabinet</p>
                            <p class="font-semibold text-gray-700">{{ selectedMember.cabinet }}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Batch</p>
                            <p class="font-semibold text-gray-700">{{ selectedMember.batch }}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Division</p>
                            <p class="font-semibold text-gray-700">{{ getDivisionTitle(selectedMember.division) }}</p>
                        </div>
                    </div>

                    <div>
                        <p class="text-sm text-gray-500">Personal Description</p>
                        <p class="text-gray-700">{{ selectedMember.personalDescription }}</p>
                    </div>

                    <div class="flex justify-center space-x-4 sm:justify-start">
                        <a :href="selectedMember.instagram" target="_blank" class="text-gray-500 hover:text-gray-700">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="currentColor"
                                viewBox="0 0 24 24">
                                <path
                                    d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
                            </svg>
                        </a>
                        <a :href="selectedMember.linkedin" target="_blank" class="text-gray-500 hover:text-gray-700">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="currentColor"
                                viewBox="0 0 24 24">
                                <path
                                    d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" />
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.grid-lines {
    background-image:
        linear-gradient(to right, rgba(0, 0, 0, 0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(0, 0, 0, 0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}

footer {
    box-shadow: 0 -10px 30px rgba(0, 0, 0, 0.05);
}
</style>