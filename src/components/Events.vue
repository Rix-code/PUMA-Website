<script setup lang="ts">
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Navigation } from 'vue3-carousel'
import { ref, onMounted, computed } from 'vue'
import 'aos/dist/aos.css'
import AOS from 'aos'

const windowWidth = ref(0)

const events = [
  {
    title: 'Regenetics 2024/2025',
    date: '1 September 2024',
    description: 'The PUMA Informatics Regeneration is an event to recruit new members who are enthusiastic and committed to joining the organization.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample1.jpg',
      '../public/sample2.jpg'
    ]
  },
  {
    title: 'Unitics',
    date: '1 December 2024',
    description: 'Unitics (Unity of Informatics) is organized to welcome new members to PUMA IT. The primary focus is to create an inclusive environment.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample3.jpg',
      '../public/sample4.jpg'
    ]
  },
  {
    title: '1st Aformation Midterm',
    date: '1 October 2024',
    description: 'First midterm evaluation for new members focusing on organizational knowledge and technical skills development.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample5.jpg',
      '../public/sample6.jpg'
    ]
  },
  {
    title: 'PUMA Training',
    date: '1 October 2024',
    description: 'Comprehensive training program for members covering technical skills and organizational knowledge.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample7.jpg',
      '../public/sample8.jpg'
    ]
  },
  {
    title: 'Brainstormics',
    date: '1 November 2024',
    description: 'Collaborative brainstorming session to generate innovative ideas for upcoming projects and events.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample10.jpg'
    ]
  },
  {
    title: 'Guest Lecture',
    date: '1 December 2024',
    description: 'Industry professionals sharing insights and expertise on current trends in information technology.',
    images: [
      '.https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample12.jpg'
    ]
  },
  {
    title: '2nd Aformation Final Exam',
    date: '1 December 2024',
    description: 'End-of-semester evaluation assessing progress and knowledge acquisition of new members.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample14.jpg'
    ]
  },
  {
    title: 'Temu Alumni',
    date: '1 February 2025',
    description: 'Networking event connecting current members with alumni to share experiences and career insights.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample16.jpg'
    ]
  },
  {
    title: '3rd Aformation Midterm',
    date: '1 February 2025',
    description: 'Midterm evaluation focusing on project development and leadership skills assessment.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample18.jpg'
    ]
  },
  {
    title: 'Informatics Connect',
    date: '1 March 2025',
    description: 'Industry networking event connecting students with potential employers and industry partners.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample20.jpg'
    ]
  },
  {
    title: '4th Aformation Final Exam',
    date: '1 May 2025',
    description: 'Final comprehensive evaluation of member progress throughout the academic year.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample22.jpg'
    ]
  },
  {
    title: 'Preschotics Beasiswa',
    date: '1 May 2025',
    description: 'Scholarship preparation program helping students apply for prestigious educational opportunities.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample22.jpg'
    ]
  },
  {
    title: 'Company Visit',
    date: '1 June 2025',
    description: 'Organized visits to leading tech companies to observe professional work environments.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample22.jpg'
    ]
  },
  {
    title: 'Elevate Informatics Festival',
    date: '1 July 2025',
    description: 'Annual celebration showcasing student projects and achievements in information technology.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample22.jpg'
    ]
  },
  {
    title: 'Regenetics',
    date: '1 August 2025',
    description: 'Recruitment event for the next academic year welcoming new potential organization members.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample22.jpg'
    ]
  },
  {
    title: 'Inforuum',
    date: '1 August 2025',
    description: 'Open forum discussion addressing current challenges and future directions in informatics.',
    images: [
      'https://i.pinimg.com/736x/ff/e1/6c/ffe16ca3153ef85b42f5cfebbd69c758.jpg',
      '../public/sample22.jpg'
    ]
  }
]

const itemsToShow = computed(() => {
  if (windowWidth.value < 640) {
    return 1 
  } else if (windowWidth.value < 1024) {
    return 2 
  } else {
    return 2.5 
  }
})

const currentSlide = ref(0)
const modalVisible = ref(false)
const selectedEvent = ref(events[0])
const isLoaded = ref(false)
const patterns = ref<{ x: number; y: number; size: number; rotation: number; opacity: number; }[]>([])
const backgroundCircles = ref<{ x: number; y: number; size: number; color: string; opacity: number; blur: number; }[]>([])

const handleSlideChange = (index: number) => {
  currentSlide.value = index
}

const openModal = (event: any) => {
  selectedEvent.value = event
  modalVisible.value = true
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  modalVisible.value = false
  document.body.style.overflow = 'auto'
}

const generatePatterns = () => {
  const newPatterns = []
  for (let i = 0; i < 12; i++) {
    newPatterns.push({
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: Math.random() * 30 + 10,
      rotation: Math.random() * 360,
      opacity: Math.random() * 0.05 + 0.02
    })
  }
  patterns.value = newPatterns
}

const generateBackgroundCircles = () => {
  const circles = []
  for (let i = 0; i < 6; i++) {
    circles.push({
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: Math.random() * 200 + 100,
      color: [
        '#000000', '#1A1A1A', '#333333',
        '#4D4D4D', '#666666', '#808080'
      ][i],
      opacity: Math.random() * 0.08 + 0.02,
      blur: Math.random() * 50 + 30
    })
  }
  backgroundCircles.value = circles
}

const updateWindowWidth = () => {
  windowWidth.value = window.innerWidth
}

onMounted(() => {
  windowWidth.value = window.innerWidth
  
  window.addEventListener('resize', updateWindowWidth)
  
  setTimeout(() => {
    isLoaded.value = true
  }, 300)
  
  generatePatterns()
  generateBackgroundCircles()
  
  AOS.init({
    duration: 800,
    easing: 'ease-in-out',
    once: true,
  })
})
</script>

<template>
  <section id="events" class="relative py-24 overflow-hidden bg-white">
    <div class="absolute inset-0 overflow-hidden">
      <div v-for="(circle, index) in backgroundCircles" :key="`circle-${index}`" class="absolute rounded-full" :style="{
        width: `${circle.size}px`,
        height: `${circle.size}px`,
        left: `${circle.x}%`,
        top: `${circle.y}%`,
        backgroundColor: circle.color,
        opacity: circle.opacity,
        filter: `blur(${circle.blur}px)`,
        transform: 'translate(-50%, -50%)'
      }">
      </div>
    </div>

    <div class="absolute inset-0 overflow-hidden">
      <div v-for="(pattern, index) in patterns" :key="index"
        class="absolute transition-all duration-1000 ease-out border-2 border-gray-100 rounded-full" :style="{
          width: `${pattern.size}px`,
          height: `${pattern.size}px`,
          left: `${pattern.x}%`,
          top: `${pattern.y}%`,
          opacity: pattern.opacity,
          transform: `rotate(${pattern.rotation}deg)`
        }">
      </div>
    </div>

    <div class="container relative z-10 px-4 mx-auto">
      <div class="mb-16 text-center">
        <h2 data-aos="fade-up" class="mb-4 text-3xl text-5xl font-bold text-gray-800 sm:text-5xl">
          Event <span class="text-black">Recap</span>
        </h2>
        <div class="w-24 h-1 mx-auto mb-6 rounded-full bg-gradient-to-r from-gray-300 to-black"></div>
        <p class="max-w-2xl px-4 mx-auto text-lg font-light text-gray-600">
          Discover the innovative journey of our tech community through our signature events
        </p>
      </div>

      <div data-aos="fade-up" class="mx-auto max-w-8xl">
        <Carousel :items-to-show="itemsToShow" :wrap-around="true" :transition="600" @slideChange="handleSlideChange"
          class="event-carousel">
          <Slide v-for="(event, index) in events" :key="index" class="carousel__item">
            <div class="h-full mx-4 perspective">
              <div
                class="overflow-hidden transition-all duration-500 transform bg-white shadow-lg rounded-xl backface-visibility-hidden event-card"
                :class="{
                  'scale-105': currentSlide === index,
                  'scale-95 opacity-90 hover:opacity-100 hover:scale-98': currentSlide !== index
                }" :style="{
                  boxShadow: currentSlide === index ? '0 15px 30px rgba(0, 0, 0, 0.2), 0 0 0 1px rgba(0, 0, 0, 0.1)' : '0 10px 20px rgba(0, 0, 0, 0.05)',
                  transform: isLoaded ? 'translateY(0)' : 'translateY(40px)',
                  opacity: isLoaded ? '1' : '0',
                  transitionDelay: `${index * 0.1}s`
                }">
                <div class="relative group">
                  <div class="image-container">
                    <img :src="event.images[0]" :alt="event.title"
                      class="object-cover w-full transition-transform duration-700 group-hover:scale-105" />
                  </div>

                  <div
                    class="absolute inset-0 transition-opacity duration-500 bg-gradient-to-t from-black/40 to-transparent">
                  </div>

                  <div class="absolute bottom-0 left-0 w-full h-1 bg-black"></div>

                  <div class="absolute bottom-0 left-0 right-0 p-6 text-white">
                    <div class="flex items-end justify-between">
                      <div>
                        <h3 class="mb-1 text-2xl font-bold tracking-tight">{{ event.title }}</h3>
                        <div class="flex items-center">
                          <div class="w-2 h-2 mr-2 bg-black rounded-full"></div>
                          <p class="text-sm font-medium text-white/90">{{ event.date }}</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="p-4 bg-white content-container">
                  <p class="text-xs leading-relaxed text-gray-600 description">{{ event.description }}</p>
                  <button @click="openModal(event)"
                    class="relative w-full px-4 py-2 overflow-hidden text-xs font-medium tracking-wide text-white transition-all duration-300 bg-black rounded-full hover:bg-gray-800">
                    <span class="relative z-10">Explore Event</span>
                    <div class="absolute inset-0 transition-opacity duration-300 bg-white opacity-0 hover:opacity-30">
                    </div>
                  </button>
                </div>
              </div>
            </div>
          </Slide>

          <template #addons>
            <Navigation />
          </template>
        </Carousel>
      </div>
    </div>

    <div v-if="modalVisible"
      class="fixed inset-0 z-50 flex items-center justify-center transition-all duration-300 bg-black/30 backdrop-blur-sm"
      @click.self="closeModal">
      <div
        class="relative w-full max-w-4xl mx-4 overflow-hidden transition-all duration-500 transform bg-white shadow-2xl rounded-xl"
        :class="{ 'scale-100 opacity-100': modalVisible, 'scale-95 opacity-0': !modalVisible }"
        :style="{ boxShadow: '0 10px 40px rgba(0, 0, 0, 0.2), 0 0 0 1px rgba(0, 0, 0, 0.05)' }">

        <div class="absolute top-0 left-0 right-0 h-1 bg-black"></div>

        <button @click="closeModal"
          class="absolute z-10 flex items-center justify-center w-10 h-10 transition-all duration-300 rounded-full bg-gray-200/80 hover:bg-gray-300/90 top-4 right-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-700" viewBox="0 0 24 24" fill="none"
            stroke="currentColor" stroke-width="2">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>

        <div class="p-4 sm:p-8">
          <div class="mb-6 sm:mb-8">
            <div class="inline-flex items-center px-3 py-1 mb-3 text-xs font-medium text-black rounded-full bg-black/10">
              {{ selectedEvent.date }}
            </div>
            <h3 class="mb-3 text-2xl font-bold text-gray-800 sm:text-3xl">{{ selectedEvent.title }}</h3>
            <p class="text-gray-600">{{ selectedEvent.description }}</p>
          </div>

          <div class="overflow-hidden shadow-md rounded-xl">
            <Carousel :items-to-show="1" :wrap-around="true" :transition="800" class="gallery-carousel">
              <Slide v-for="(image, i) in selectedEvent.images" :key="i" class="carousel__item">
                <div class="relative overflow-hidden rounded-xl">
                  <img :src="image" :alt="`${selectedEvent.title} Image ${i + 1}`"
                    class="object-cover w-full transition-transform duration-700 rounded-lg hover:scale-105 modal-image" />

                  <div class="absolute bottom-0 left-0 right-0 h-1/4 bg-gradient-to-t from-black/40 to-transparent">
                  </div>

                  <div
                    class="absolute px-3 py-1 text-xs font-medium text-gray-800 rounded-full bottom-4 right-4 bg-white/70 backdrop-blur-sm">
                    {{ i + 1 }}/{{ selectedEvent.images.length }}
                  </div>
                </div>
              </Slide>
              <template #addons>
                <Navigation />
              </template>
            </Carousel>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.perspective {
  perspective: 1000px;
}

.backface-visibility-hidden {
  backface-visibility: hidden;
}

.event-carousel :deep(.carousel__slide) {
  padding: 1rem;
}

.event-carousel :deep(.carousel__prev),
.event-carousel :deep(.carousel__next),
.gallery-carousel :deep(.carousel__prev),
.gallery-carousel :deep(.carousel__next) {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 50%;
  width: 40px;
  height: 40px;
  color: #000000;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
}

.event-card {
  height: 450px;
  display: flex;
  flex-direction: column;
}

.image-container {
  height: 340px; 
  overflow: hidden;
}

.image-container img {
  height: 100%;
  width: 100%;
  object-fit: cover;
}

.content-container {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.description {
  flex: 1;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  margin-bottom: 8px;
}

.modal-image {
  height: 400px;
  width: 100%;
  object-fit: cover;
}

@media (min-width: 640px) {
  .event-carousel :deep(.carousel__prev),
  .event-carousel :deep(.carousel__next),
  .gallery-carousel :deep(.carousel__prev),
  .gallery-carousel :deep(.carousel__next) {
    width: 48px;
    height: 48px;
  }

  .event-carousel :deep(.carousel__slide) {
    padding: 1.5rem;
  }
}

.event-carousel :deep(.carousel__prev:hover),
.event-carousel :deep(.carousel__next:hover),
.gallery-carousel :deep(.carousel__prev:hover),
.gallery-carousel :deep(.carousel__next:hover) {
  background: #000000;
  color: white;
}

.hover\:scale-98:hover {
  transform: scale(0.98);
}
</style>