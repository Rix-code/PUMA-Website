<script setup lang="ts">
import { ref, onMounted, computed, onBeforeUnmount } from 'vue'
import Navbar from '../Navbar.vue'; 
import Footer from '../Footer.vue'; 

const isScrolled = ref(false);
const activeEvent = ref<number | null>(null);
const isHoveringTimeline = ref(false);
const showModal = ref(false);
const selectedEvent = ref<any>(null);
const currentImageIndex = ref(0);

const selectedFilter = ref<'all' | 'upcoming' | 'completed'>('all');

const events = [
    {
        title: 'Regenetics 2024/2025', date: '1 September 2024',
        description: 'The PUMA Informatics Regeneration is an event to recruit new members who are enthusiastic and committed to joining the organization.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample1.jpg', '../public/sample2.jpg'], status: 'completed'
    },
    {
        title: 'Unitics', date: '1 December 2024',
        description: 'Unitics (Unity of Informatics) is organized to welcome new members to PUMA IT. The primary focus is to create an inclusive environment.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample3.jpg', '../public/sample4.jpg'], status: 'completed'
    },
    {
        title: '1st Aformation Midterm', date: '1 October 2024',
        description: 'First midterm evaluation for new members focusing on organizational knowledge and technical skills development.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample5.jpg', '../public/sample6.jpg'], status: 'completed'
    },
    {
        title: 'PUMA Training', date: '1 October 2024',
        description: 'Comprehensive training program for members covering technical skills and organizational knowledge.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample7.jpg', '../public/sample8.jpg'], status: 'completed'
    },
    {
        title: 'Brainstormics', date: '1 November 2024',
        description: 'Collaborative brainstorming session to generate innovative ideas for upcoming projects and events.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample10.jpg'], status: 'completed'
    },
    {
        title: 'Guest Lecture', date: '1 December 2024',
        description: 'Industry professionals sharing insights and expertise on current trends in information technology.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample12.jpg'], status: 'completed'
    },
    {
        title: '2nd Aformation Final Exam', date: '1 December 2024',
        description: 'End-of-semester evaluation assessing progress and knowledge acquisition of new members.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample14.jpg'], status: 'completed'
    },
    {
        title: 'Temu Alumni', date: '1 February 2025',
        description: 'Networking event connecting current members with alumni to share experiences and career insights.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample16.jpg'], status: 'completed'
    },
    {
        title: '3rd Aformation Midterm', date: '1 February 2025',
        description: 'Midterm evaluation focusing on project development and leadership skills assessment.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample18.jpg'], status: 'completed'
    },
    {
        title: 'Informatics Connect', date: '1 March 2025',
        description: 'Industry networking event connecting students with potential employers and industry partners.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample20.jpg'], status: 'completed'
    },
    {
        title: '4th Aformation Final Exam', date: '1 May 2025',
        description: 'Final comprehensive evaluation of member progress throughout the academic year.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample22.jpg'], status: 'completed'
    },
    {
        title: 'Preschotics Beasiswa', date: '1 May 2025',
        description: 'Scholarship preparation program helping students apply for prestigious educational opportunities.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample22.jpg'], status: 'completed'
    },
    {
        title: 'Company Visit', date: '1 June 2025',
        description: 'Organized visits to leading tech companies to observe professional work environments.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample22.jpg'], status: 'upcoming'
    },
    {
        title: 'Elevate Informatics Festival', date: '1 July 2025',
        description: 'Annual celebration showcasing student projects and achievements in information technology.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample22.jpg'], status: 'upcoming'
    },
    {
        title: 'Regenetics', date: '1 August 2025',
        description: 'Recruitment event for the next academic year welcoming new potential organization members.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample22.jpg'], status: 'upcoming'
    },
    {
        title: 'Inforuum', date: '1 August 2025',
        description: 'Open forum discussion addressing current challenges and future directions in informatics.',
        images: ['https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg', '../public/sample22.jpg'], status: 'upcoming'
    }
];

const timelineEvents = computed(() => {
    let filteredEvents = events;
    if (selectedFilter.value === 'completed') {
        filteredEvents = events.filter(event => event.status === 'completed');
    } else if (selectedFilter.value === 'upcoming') {
        filteredEvents = events.filter(event => event.status === 'upcoming');
    }
    filteredEvents.sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());
    return filteredEvents.map((event, index) => ({
        ...event,
        id: index + 1,
        month: new Date(event.date).toLocaleDateString('en-US', { month: 'short', year: 'numeric' })
    }));
});

const lastCompletedEventDetails = computed(() => {
    const completedInCurrentView = timelineEvents.value
        .filter(e => e.status === 'completed')
        .pop(); // Gets the last one because timelineEvents is already sorted by date

    if (!completedInCurrentView) return null;

    const globalIndexInCurrentView = timelineEvents.value.findIndex(event => event.id === completedInCurrentView.id);

    return {
        id: completedInCurrentView.id,
        globalIndex: globalIndexInCurrentView,
    };
});


const setFilter = (filter: 'all' | 'upcoming' | 'completed') => {
    selectedFilter.value = filter;
    activeEvent.value = null; 
};

const handleScroll = () => { isScrolled.value = window.scrollY > 50; };

const numCols = ref(4);

const updateNumCols = () => {
    const width = window.innerWidth;
    if (width >= 1280) { numCols.value = 4; }
    else if (width >= 1024) { numCols.value = 3; }
    else if (width >= 768) { numCols.value = 2; }
    else { numCols.value = 1; }
};

onMounted(() => {
    window.addEventListener('scroll', handleScroll);
    updateNumCols();
    window.addEventListener('resize', updateNumCols);
});

onBeforeUnmount(() => {
    window.removeEventListener('scroll', handleScroll);
    window.removeEventListener('resize', updateNumCols);
});

const eventRows = computed(() => {
    const eventsArray = timelineEvents.value;
    // Only create rows if numCols > 1, otherwise it's a vertical list
    if (!eventsArray.length || numCols.value <= 1) return [];
    const rows: typeof eventsArray[] = [];
    for (let i = 0; i < eventsArray.length; i += numCols.value) {
        rows.push(eventsArray.slice(i, i + numCols.value));
    }
    return rows;
});

const getRowProgressWidth = (rowIndex: number, currentRowEvents: any[]) => {
    if (!lastCompletedEventDetails.value || timelineEvents.value.length === 0 || numCols.value <= 1) {
        return 0;
    }

    const { globalIndex: globalLastCompletedEventIndexInView } = lastCompletedEventDetails.value;
    const lastCompletedEventRowIndex = Math.floor(globalLastCompletedEventIndexInView / numCols.value);

    if (rowIndex < lastCompletedEventRowIndex) {
        return 100;
    } else if (rowIndex === lastCompletedEventRowIndex) {
        let completedCountInThisRow = 0;
        for (const eventInRow of currentRowEvents) {
            const eventInRowGlobalIndex = timelineEvents.value.findIndex(e => e.id === eventInRow.id);
            if (eventInRowGlobalIndex !== -1 && eventInRowGlobalIndex <= globalLastCompletedEventIndexInView) {
                completedCountInThisRow++;
            }
        }
        return (completedCountInThisRow / currentRowEvents.length) * 100; 
    } else {
        return 0;
    }
};

const verticalTimelineProgressHeight = computed(() => {
    if (!lastCompletedEventDetails.value || timelineEvents.value.length === 0 || numCols.value !== 1) {
        return 0;
    }
    const { globalIndex: globalLastCompletedEventIndexInView } = lastCompletedEventDetails.value;
    if (timelineEvents.value.length === 0) return 0;
    return ((globalLastCompletedEventIndexInView + 1) / timelineEvents.value.length) * 100;
});

const setActiveEvent = (id: number) => { activeEvent.value = id; };

const openModal = (event: any) => {
    selectedEvent.value = event;
    currentImageIndex.value = 0;
    showModal.value = true;
    document.body.style.overflow = 'hidden';
};

const closeModal = () => {
    showModal.value = false;
    selectedEvent.value = null;
    document.body.style.overflow = 'auto';
};

const nextImage = () => {
    if (selectedEvent.value && selectedEvent.value.images.length > 1) {
        currentImageIndex.value = (currentImageIndex.value + 1) % selectedEvent.value.images.length;
    }
};

const prevImage = () => {
    if (selectedEvent.value && selectedEvent.value.images.length > 1) {
        currentImageIndex.value = (currentImageIndex.value === 0)
            ? selectedEvent.value.images.length - 1
            : currentImageIndex.value - 1;
    }
};
const goToImage = (index: number) => { currentImageIndex.value = index; };

const allEventsCount = computed(() => events.length);
const overallCompletedEventsCount = computed(() => events.filter(e => e.status === 'completed').length);
const overallUpcomingEventsCount = computed(() => events.filter(e => e.status === 'upcoming').length);

const getStatusIcon = (status: string) => status === 'completed' ? `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />` : `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />`;
const getStatusColor = (status: string) => status === 'completed' ? 'text-gray-700' : 'text-gray-500';
const getStatusBg = (status: string) => status === 'completed' ? 'bg-gray-200 border-gray-400' : 'bg-slate-100 border-gray-300';
const getStatusText = (status: string) => status === 'completed' ? 'Closed' : 'Pending';
const getDotPinColor = (status: string, isActive: boolean) => isActive ? (status === 'completed' ? 'bg-gray-800 border-black' : 'bg-gray-700 border-gray-800') : (status === 'completed' ? 'bg-gray-500 border-gray-600' : 'bg-slate-400 border-slate-500');
const getCardGradient = (status: string) => status === 'completed' ? 'from-gray-100 to-slate-200' : 'from-slate-50 to-gray-100';
const getActiveCardBorder = (status: string) => status === 'completed' ? 'border-gray-500 shadow-gray-300/50' : 'border-gray-400 shadow-slate-300/50';

</script>

<template>
    <Navbar />
    <div class="relative min-h-screen pt-16 font-mono bg-gradient-to-br from-white via-gray-50 to-slate-100">
        <div class="absolute inset-0 dot-background"></div>
        <div class="absolute inset-0 opacity-10"
             style="background-image: radial-gradient(circle at 1px 1px, rgba(100,116,139,0.15) 1px, transparent 0); background-size: 32px 32px;"></div>

        <div class="relative z-10 overflow-hidden bg-transparent border-b border-gray-200/50">
            <div class="container relative max-w-6xl px-6 py-20 mx-auto">
                <div class="text-center">
                    <div class="inline-flex items-center px-3 py-1 mb-6 font-mono text-xs font-semibold tracking-wider text-gray-700 uppercase transform bg-gray-200 border border-gray-400 rounded-sm shadow-sm -rotate-2">
                        <svg class="w-3 h-3 mr-2 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
                        Case File: Kaustav Cabinet
                    </div>
                    <h1 class="mb-6 text-5xl font-bold tracking-wider text-black uppercase sm:text-6xl">
                        PUMA TIMELINE
                        <span class="block text-3xl font-medium tracking-normal text-transparent normal-case bg-gradient-to-r from-gray-700 to-black bg-clip-text">2024/2025</span>
                    </h1>
                    <p class="max-w-3xl mx-auto text-lg leading-relaxed tracking-wide text-gray-600 uppercase">
                        Chronological log of operations and milestones throughout the term.
                    </p>
                    <div class="flex items-center justify-center mt-10 space-x-6">
                        <div class="text-center">
                            <div class="text-2xl font-bold text-gray-800">{{ overallCompletedEventsCount }}</div>
                            <div class="text-xs tracking-wider text-gray-500 uppercase">Cases Closed</div>
                        </div>
                        <div class="w-px h-10 bg-gray-300"></div>
                        <div class="text-center">
                            <div class="text-2xl font-bold text-gray-600">{{ overallUpcomingEventsCount }}</div>
                            <div class="text-xs tracking-wider text-gray-500 uppercase">Leads Pending</div>
                        </div>
                        <div class="w-px h-10 bg-gray-300"></div>
                        <div class="text-center">
                            <div class="text-2xl font-bold text-black">{{ allEventsCount }}</div>
                            <div class="text-xs tracking-wider text-gray-500 uppercase">Total Entries</div>
                        </div>
                    </div>
                    <div class="flex justify-center mt-12 space-x-3">
                        <button
                            @click="setFilter('all')"
                            :class="['px-4 py-2 text-sm font-semibold uppercase border rounded-md shadow-sm transition-all duration-200',
                                     selectedFilter === 'all' ? 'bg-gray-700 text-white border-gray-700 ring-2 ring-gray-500 ring-offset-1' : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-100 hover:border-gray-400']">
                            All Cases
                        </button>
                        <button
                            @click="setFilter('upcoming')"
                            :class="['px-4 py-2 text-sm font-semibold uppercase border rounded-md shadow-sm transition-all duration-200',
                                     selectedFilter === 'upcoming' ? 'bg-gray-700 text-white border-gray-700 ring-2 ring-gray-500 ring-offset-1' : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-100 hover:border-gray-400']">
                            Pending Leads ({{ overallUpcomingEventsCount }})
                        </button>
                        <button
                            @click="setFilter('completed')"
                            :class="['px-4 py-2 text-sm font-semibold uppercase border rounded-md shadow-sm transition-all duration-200',
                                     selectedFilter === 'completed' ? 'bg-gray-700 text-white border-gray-700 ring-2 ring-gray-500 ring-offset-1' : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-100 hover:border-gray-400']">
                            Closed Cases ({{ overallCompletedEventsCount }})
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="container relative z-10 px-6 py-12 mx-auto max-w-7xl">
            <div v-if="timelineEvents.length === 0" class="py-12 text-center">
                <svg class="w-16 h-16 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                <p class="text-xl font-semibold text-gray-600">No cases match the current filter.</p>
                <p class="text-gray-500">Try selecting a different filter option above.</p>
            </div>

            <div v-if="numCols > 1 && timelineEvents.length > 0" class="space-y-16">
                <div v-for="(rowEvents, rowIndex) in eventRows" :key="`h-row-${rowIndex}`"
                     class="relative row-container"
                     @mouseenter="isHoveringTimeline = true"
                     @mouseleave="isHoveringTimeline = false">

                    <div class="absolute left-0 right-0 h-0.5 bg-gray-300 top-3"></div>
                    <div class="absolute left-0 h-0.5 transition-all duration-1000 ease-out bg-gray-700 top-3"
                         :style="{ width: getRowProgressWidth(rowIndex, rowEvents) + '%' }"></div>

                    <div class="grid gap-x-8"
                         :class="{
                             'grid-cols-2': numCols === 2,
                             'grid-cols-3': numCols === 3,
                             'grid-cols-4': numCols >= 4,
                         }">
                        <div v-for="event in rowEvents" :key="event.id"
                             class="relative pt-8 group" @mouseenter="setActiveEvent(event.id)">

                            <div class="absolute left-0 w-3.5 h-3.5 transition-all duration-300 transform -translate-x-1/2 bg-white border-2 rounded-full shadow-md top-[10px] group-hover:scale-125"
                                 :class="getDotPinColor(event.status, activeEvent === event.id)">
                                <div class="absolute bg-white rounded-full inset-0.5 opacity-30 group-hover:opacity-50"></div>
                            </div>

                            <div class="pl-6 transition-all duration-300 cursor-pointer group-hover:transform group-hover:scale-105 group-hover:-translate-y-1"
                                 @click="openModal(event)">
                                <div class="relative overflow-hidden transition-all duration-300 bg-white border rounded-md shadow-lg hover:shadow-xl"
                                     :class="{ [getActiveCardBorder(event.status)]: activeEvent === event.id, 'border-gray-200/70': activeEvent !== event.id }"
                                     style="clip-path: polygon(0 0, 100% 0, 100% calc(100% - 12px), calc(100% - 12px) 100%, 0 100%);">
                                    <div class="absolute inset-0 transition-opacity duration-300 opacity-0 group-hover:opacity-100"
                                         :class="`bg-gradient-to-br ${getCardGradient(event.status)}`"></div>
                                    <div class="relative p-5">
                                        <div class="flex items-center justify-between mb-3">
                                            <div class="inline-flex items-center px-2 py-0.5 text-xs font-bold tracking-wider uppercase border rounded-sm" :class="getStatusBg(event.status)">
                                                <svg class="w-2.5 h-2.5 mr-1.5" :class="getStatusColor(event.status)" fill="none" stroke="currentColor" viewBox="0 0 24 24" v-html="getStatusIcon(event.status)"></svg>
                                                <span :class="getStatusColor(event.status)">{{ getStatusText(event.status) }}</span>
                                            </div>
                                            <div class="text-xs font-medium text-gray-500 uppercase">{{ event.month }}</div>
                                        </div>
                                        <div class="flex items-center justify-center w-10 h-10 mb-4 transition-all duration-300 border border-gray-200 rounded-lg bg-slate-100 group-hover:bg-gray-600 group-hover:border-gray-700">
                                            <svg class="w-5 h-5 text-gray-500 transition-colors duration-300 group-hover:text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg>
                                        </div>
                                        <h3 class="mb-2 text-lg font-bold leading-tight text-black normal-case group-hover:text-gray-800">{{ event.title }}</h3>
                                        <div class="mb-3 text-xs font-medium text-gray-500 uppercase">{{ event.date }}</div>
                                        <div class="pt-3 mt-3 border-t border-gray-200/80">
                                            <div class="inline-flex items-center text-xs font-semibold tracking-wider text-gray-600 uppercase transition-colors duration-300 group-hover:text-black">
                                                Access File
                                                <svg class="w-3 h-3 ml-1 transition-transform duration-300 group-hover:translate-x-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" /></svg>
                                            </div>
                                        </div>
                                        <div class="absolute bottom-0 right-0 w-3 h-3 transition-colors duration-300 bg-gray-300/70 group-hover:bg-gray-400/70" style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div v-else-if="numCols === 1 && timelineEvents.length > 0" class="relative pt-4 vertical-timeline-container">
                <div class="absolute w-0.5 bg-gray-300 top-2 bottom-0 left-[calc(0.875rem-1px)]"></div> <div class="absolute w-0.5 transition-all duration-1000 ease-out bg-gray-700 top-2 left-[calc(0.875rem-1px)]"
                     :style="{ height: verticalTimelineProgressHeight + '%' }"></div>

                <div v-for="(event) in timelineEvents" :key="`v-event-${event.id}`"
                     class="relative pl-8 mb-8 group vertical-event-item"
                     @mouseenter="setActiveEvent(event.id)">

                    <div class="absolute w-3.5 h-3.5 transition-all duration-300 transform -translate-x-1/2 bg-white border-2 rounded-full shadow-md left-[0.875rem] top-1 group-hover:scale-125"
                         :class="getDotPinColor(event.status, activeEvent === event.id)">
                        <div class="absolute bg-white rounded-full inset-0.5 opacity-30 group-hover:opacity-50"></div>
                    </div>

                    <div class="transition-all duration-300 cursor-pointer group-hover:transform group-hover:scale-105 group-hover:-translate-y-1"
                         @click="openModal(event)">
                         <div class="relative overflow-hidden transition-all duration-300 bg-white border rounded-md shadow-lg hover:shadow-xl"
                                     :class="{ [getActiveCardBorder(event.status)]: activeEvent === event.id, 'border-gray-200/70': activeEvent !== event.id }"
                                     style="clip-path: polygon(0 0, 100% 0, 100% calc(100% - 12px), calc(100% - 12px) 100%, 0 100%);">
                            <div class="absolute inset-0 transition-opacity duration-300 opacity-0 group-hover:opacity-100"
                                 :class="`bg-gradient-to-br ${getCardGradient(event.status)}`"></div>
                            <div class="relative p-5">
                                <div class="flex items-center justify-between mb-3">
                                    <div class="inline-flex items-center px-2 py-0.5 text-xs font-bold tracking-wider uppercase border rounded-sm" :class="getStatusBg(event.status)">
                                        <svg class="w-2.5 h-2.5 mr-1.5" :class="getStatusColor(event.status)" fill="none" stroke="currentColor" viewBox="0 0 24 24" v-html="getStatusIcon(event.status)"></svg>
                                        <span :class="getStatusColor(event.status)">{{ getStatusText(event.status) }}</span>
                                    </div>
                                    <div class="text-xs font-medium text-gray-500 uppercase">{{ event.month }}</div>
                                </div>
                                <div class="flex items-center justify-center w-10 h-10 mb-4 transition-all duration-300 border border-gray-200 rounded-lg bg-slate-100 group-hover:bg-gray-600 group-hover:border-gray-700">
                                    <svg class="w-5 h-5 text-gray-500 transition-colors duration-300 group-hover:text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg>
                                </div>
                                <h3 class="mb-2 text-lg font-bold leading-tight text-black normal-case group-hover:text-gray-800">{{ event.title }}</h3>
                                <div class="mb-3 text-xs font-medium text-gray-500 uppercase">{{ event.date }}</div>
                                <div class="pt-3 mt-3 border-t border-gray-200/80">
                                    <div class="inline-flex items-center text-xs font-semibold tracking-wider text-gray-600 uppercase transition-colors duration-300 group-hover:text-black">
                                        Access File
                                        <svg class="w-3 h-3 ml-1 transition-transform duration-300 group-hover:translate-x-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" /></svg>
                                    </div>
                                </div>
                                <div class="absolute bottom-0 right-0 w-3 h-3 transition-colors duration-300 bg-gray-300/70 group-hover:bg-gray-400/70" style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 gap-6 mt-20 md:grid-cols-2 lg:grid-cols-4">
                <div class="p-6 text-center transition-all duration-300 border border-gray-200 rounded-lg shadow-md bg-gradient-to-br from-slate-50 to-gray-100 hover:shadow-lg hover:scale-105">
                    <div class="flex items-center justify-center w-12 h-12 mx-auto mb-3 bg-gray-200 border border-gray-300 rounded-md"><svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg></div>
                    <div class="text-3xl font-bold text-gray-900">12</div>
                    <div class="text-xs font-semibold tracking-wider text-gray-500 uppercase">Months Span</div>
                </div>
                <div class="p-6 text-center transition-all duration-300 border border-gray-200 rounded-lg shadow-md bg-gradient-to-br from-slate-50 to-gray-100 hover:shadow-lg hover:scale-105">
                    <div class="flex items-center justify-center w-12 h-12 mx-auto mb-3 bg-gray-200 border border-gray-300 rounded-md"><svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" /></svg></div>
                    <div class="text-3xl font-bold text-gray-900">{{ allEventsCount }}</div>
                    <div class="text-xs font-semibold tracking-wider text-gray-500 uppercase">Total Entries</div>
                </div>
                <div class="p-6 text-center transition-all duration-300 border border-gray-200 rounded-lg shadow-md bg-gradient-to-br from-slate-50 to-gray-100 hover:shadow-lg hover:scale-105">
                    <div class="flex items-center justify-center w-12 h-12 mx-auto mb-3 bg-gray-700 border border-gray-800 rounded-md"><svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" /></svg></div>
                    <div class="text-3xl font-bold text-gray-800">{{ overallCompletedEventsCount }}</div>
                    <div class="text-xs font-semibold tracking-wider text-gray-500 uppercase">Cases Closed</div>
                </div>
                <div class="p-6 text-center transition-all duration-300 border border-gray-200 rounded-lg shadow-md bg-gradient-to-br from-slate-50 to-gray-100 hover:shadow-lg hover:scale-105">
                    <div class="flex items-center justify-center w-12 h-12 mx-auto mb-3 bg-gray-200 border border-gray-300 rounded-md"><svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg></div>
                    <div class="text-3xl font-bold text-transparent bg-gradient-to-r from-gray-700 to-black bg-clip-text">{{ allEventsCount > 0 ? Math.round((overallCompletedEventsCount / allEventsCount) * 100) : 0 }}%</div>
                    <div class="text-xs font-semibold tracking-wider text-gray-500 uppercase">Case Progress</div>
                </div>
            </div>
        </div>

        <div v-if="showModal"
             class="fixed inset-0 z-50 flex items-center justify-center px-4 py-8 modal-enter"
             @click.self="closeModal">
            <div class="absolute inset-0 bg-black/70 backdrop-blur-sm"></div>
            <div class="relative w-full max-w-3xl max-h-[90vh] overflow-hidden bg-gradient-to-br from-slate-100 to-gray-200 border border-gray-300 rounded-lg shadow-2xl">
                <button @click="closeModal" class="absolute z-20 p-1.5 text-gray-500 transition-colors duration-200 bg-white border border-gray-300 rounded-full shadow-lg top-3 right-3 hover:text-gray-700 hover:bg-gray-100">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
                </button>
                <div class="overflow-y-auto max-h-[90vh] styled-scrollbar">
                    <div class="relative p-6 pb-4 border-b border-gray-300/70" :class="`bg-gradient-to-br ${getCardGradient(selectedEvent?.status)}`">
                        <div class="flex items-start justify-between">
                            <div>
                                <div class="inline-flex items-center px-3 py-1 mb-3 text-sm font-bold tracking-wider uppercase border rounded-sm" :class="getStatusBg(selectedEvent?.status)">
                                    <svg class="w-3 h-3 mr-2" :class="getStatusColor(selectedEvent?.status)" fill="none" stroke="currentColor" viewBox="0 0 24 24" v-html="getStatusIcon(selectedEvent?.status)"></svg>
                                    <span :class="getStatusColor(selectedEvent?.status)">{{ getStatusText(selectedEvent?.status) }}</span>
                                </div>
                                <h2 class="mb-1 text-2xl font-bold text-black normal-case">{{ selectedEvent?.title }}</h2>
                                <div class="flex items-center text-sm text-gray-600 uppercase">
                                    <svg class="w-4 h-4 mr-1.5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg>
                                    {{ selectedEvent?.date }}
                                </div>
                            </div>
                        </div>
                        <div class="absolute w-16 h-5 transform bg-gray-50/50 border border-gray-200/50 shadow-sm top-4 right-16 opacity-60 rotate-[20deg]"></div>
                    </div>
                    <div class="p-6 normal-case">
                        <div class="mb-6">
                            <h3 class="mb-2 text-sm font-semibold tracking-wider text-gray-500 uppercase">Case Description:</h3>
                            <p class="text-base leading-relaxed text-gray-700">{{ selectedEvent?.description }}</p>
                        </div>
                        <div v-if="selectedEvent?.images && selectedEvent.images.length > 0" class="mb-6">
                            <h3 class="mb-3 text-sm font-semibold tracking-wider text-gray-500 uppercase">Exhibits:</h3>
                            <div class="relative mb-3 overflow-hidden bg-gray-300 border border-gray-400 rounded shadow-md">
                                <img :src="selectedEvent.images[currentImageIndex]" :alt="`${selectedEvent.title} - Image ${currentImageIndex + 1}`" class="object-contain w-full h-80 image-transition">
                                <div v-if="selectedEvent.images.length > 1" class="absolute inset-y-0 left-0 right-0 flex items-center justify-between p-2">
                                    <button @click="prevImage" class="p-1.5 text-white transition-colors duration-200 rounded-full bg-black/40 backdrop-blur-sm hover:bg-black/60"><svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" /></svg></button>
                                    <button @click="nextImage" class="p-1.5 text-white transition-colors duration-200 rounded-full bg-black/40 backdrop-blur-sm hover:bg-black/60"><svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" /></svg></button>
                                </div>
                                <div v-if="selectedEvent.images.length > 1" class="absolute px-2 py-0.5 text-xs font-medium text-white rounded-full top-2 right-2 bg-black/40 backdrop-blur-sm">{{ currentImageIndex + 1 }} / {{ selectedEvent.images.length }}</div>
                            </div>
                            <div v-if="selectedEvent.images.length > 1" class="flex pb-1 space-x-2 overflow-x-auto styled-scrollbar-thin">
                                <button v-for="(image, index) in selectedEvent.images" :key="index" @click="goToImage(index)" class="flex-shrink-0 w-16 h-16 overflow-hidden transition-all duration-200 border-2 rounded shadow-sm hover:opacity-80" :class="{ 'border-gray-700 ring-1 ring-gray-500': currentImageIndex === index, 'border-gray-300 hover:border-gray-400': currentImageIndex !== index }">
                                    <img :src="image" :alt="`Thumbnail ${index + 1}`" class="object-cover w-full h-full">
                                </button>
                            </div>
                        </div>
                        <div class="grid grid-cols-1 gap-4 pt-4 border-t border-gray-300/70 md:grid-cols-3">
                            <div class="p-3 border rounded bg-slate-200/60 border-gray-300/80">
                                <h4 class="mb-1 text-xs font-semibold tracking-wider text-gray-500 uppercase">File Status</h4>
                                <div class="inline-flex items-center px-2 py-0.5 text-xs font-medium rounded-sm" :class="getStatusBg(selectedEvent?.status)">
                                    <svg class="w-2.5 h-2.5 mr-1" :class="getStatusColor(selectedEvent?.status)" fill="none" stroke="currentColor" viewBox="0 0 24 24" v-html="getStatusIcon(selectedEvent?.status)"></svg>
                                    <span :class="getStatusColor(selectedEvent?.status)">{{ getStatusText(selectedEvent?.status) }}</span>
                                </div>
                            </div>
                            <div class="p-3 border rounded bg-slate-200/60 border-gray-300/80">
                                <h4 class="mb-1 text-xs font-semibold tracking-wider text-gray-500 uppercase">Log Date</h4>
                                <p class="text-sm text-gray-700">{{ selectedEvent?.date }}</p>
                            </div>
                            <div class="p-3 border rounded bg-slate-200/60 border-gray-300/80">
                                <h4 class="mb-1 text-xs font-semibold tracking-wider text-gray-500 uppercase">Exhibit Count</h4>
                                <p class="text-sm text-gray-700">{{ selectedEvent?.images?.length || 0 }} items</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <Footer />
</template>

<style scoped>
.dot-background {
    background-image: radial-gradient(circle at 1px 1px, rgba(107, 114, 128, 0.1) 1px, transparent 0);
    background-size: 20px 20px;
    animation: dot-drift 25s linear infinite;
}
@keyframes dot-drift {
    0% { background-position: 0 0; }
    100% { background-position: 20px 20px; }
}
.line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.container :deep(*),
.modal-enter :deep(*),
.group,
.group > div, 
.group svg,
button, 
.absolute.bg-gray-700, 
.absolute.left-0.w-3\.5, 
.relative.overflow-hidden 
{
    transition-property: color, background-color, border-color, transform, box-shadow, opacity, scale, width, height;
    transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
    transition-duration: 300ms;
}


.absolute.bg-gray-700.transition-all {
    transition-duration: 1000ms !important;
}


::-webkit-scrollbar { width: 6px; height: 6px; }
::-webkit-scrollbar-track { background: #e5e7eb; border-radius: 3px; }
::-webkit-scrollbar-thumb { background: #9ca3af; border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: #6b7280; }
.styled-scrollbar::-webkit-scrollbar { width: 6px; height: 6px; }
.styled-scrollbar::-webkit-scrollbar-track { background: #e5e7eb; border-radius: 3px; }
.styled-scrollbar::-webkit-scrollbar-thumb { background: #9ca3af; border-radius: 3px; }
.styled-scrollbar::-webkit-scrollbar-thumb:hover { background: #6b7280; }
.styled-scrollbar-thin::-webkit-scrollbar { height: 4px; }

@keyframes modalFadeIn {
    from { opacity: 0; transform: scale(0.97); }
    to { opacity: 1; transform: scale(1); }
}
.modal-enter { animation: modalFadeIn 0.25s ease-out; }
.image-transition { transition: opacity 0.3s ease-in-out; }

.group:hover .shadow-lg { box-shadow: 0 8px 16px -4px rgba(0,0,0,0.1), 0 3px 6px -3px rgba(0,0,0,0.07); }
.group:hover .shadow-xl { box-shadow: 0 12px 25px -5px rgba(0,0,0,0.1), 0 5px 10px -6px rgba(0,0,0,0.08); }
</style>