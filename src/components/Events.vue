<script setup lang="ts">
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Navigation } from 'vue3-carousel'
import { ref, onMounted } from 'vue'

const events = [
  {
    title: 'Regenetics',
    date: '2025',
    description: 'The PUMA Informatics Regeneration is an event to recruit new members who are enthusiastic and committed to joining the organization.',
    images: [
      '../public/puma-bag.JPG',
      '../public/sample1.jpg',
      '../public/sample2.jpg'
    ]
  },
  {
    title: 'UNITICS',
    date: '2025',
    description: 'Unitics (Unity of Informatics) is organized to welcome new members to PUMA IT. The primary focus is to create an inclusive environment.',
    images: [
      '../public/puma-bag.JPG',
      '../public/sample3.jpg',
      '../public/sample4.jpg'
    ]
  },
  {
    title: 'INFORUUM',
    date: '2025',
    description: 'Inforuum (Informatics Continuum) is a farewell event for PUMA IT members, allowing them to bid farewell and reminisce about shared moments.',
    images: [
      '../public/puma-bag.JPG',
      '../public/sample5.jpg',
      '../public/sample6.jpg'
    ]
  },
  {
    title: 'TEMU ALUMNI',
    date: '2025',
    description: 'Temu Alumni is an event aimed at enhancing the relationship between students and alumni in the field of informatics through sharing sessions.',
    images: [
      '../public/puma-bag.JPG',
      '../public/sample7.jpg',
      '../public/sample8.jpg'
    ]
  }
]

const currentSlide = ref(0)
const modalVisible = ref(false)
const selectedEvent = ref(events[0])
const isLoaded = ref(false)
const patterns = ref([])
const backgroundCircles = ref([])

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

onMounted(() => {
  setTimeout(() => {
    isLoaded.value = true
  }, 300)
  generatePatterns()
  generateBackgroundCircles()
})
</script>

<template>
  <section id="events" class="relative py-24 overflow-hidden bg-white">
    <!-- Black circle accents instead of blue -->
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

    <!-- Subtle background patterns -->
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
        <h2 class="mb-4 text-5xl font-bold text-gray-800">
          Event <span class="text-black">Recap</span>
        </h2>
        <div class="w-24 h-1 mx-auto mb-6 rounded-full bg-gradient-to-r from-gray-300 to-black"></div>
        <p class="max-w-2xl mx-auto text-lg font-light text-gray-600">
          Discover the innovative journey of our tech community through our signature events
        </p>
      </div>

      <div class="mx-auto max-w-8xl">
        <Carousel :items-to-show="2.5" :wrap-around="true" :transition="600" @slideChange="handleSlideChange"
          class="event-carousel">
          <Slide v-for="(event, index) in events" :key="index" class="carousel__item">
            <div class="h-full mx-4 perspective">
              <div
                class="overflow-hidden transition-all duration-500 transform bg-white shadow-lg rounded-xl backface-visibility-hidden"
                :class="{
                  'scale-110': currentSlide === index,
                  'scale-90 opacity-90 hover:opacity-100 hover:scale-95': currentSlide !== index
                }" :style="{
                  boxShadow: currentSlide === index ? '0 15px 30px rgba(0, 0, 0, 0.2), 0 0 0 1px rgba(0, 0, 0, 0.1)' : '0 10px 20px rgba(0, 0, 0, 0.05)',
                  transform: isLoaded ? 'translateY(0)' : 'translateY(40px)',
                  opacity: isLoaded ? '1' : '0',
                  transitionDelay: `${index * 0.1}s`
                }">
                <div class="relative group">
                  <img :src="event.images[0]" :alt="event.title"
                    class="object-cover w-full h-56 transition-transform duration-700 group-hover:scale-105" />

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

                <div class="p-6 bg-white">
                  <p class="mb-5 text-sm leading-relaxed text-gray-600">{{ event.description }}</p>
                  <button @click="openModal(event)"
                    class="relative w-full px-6 py-3 overflow-hidden text-sm font-medium tracking-wide text-white transition-all duration-300 bg-black rounded-full hover:bg-gray-800">
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
        class="relative w-full max-w-4xl overflow-hidden transition-all duration-500 transform bg-white shadow-2xl rounded-xl"
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

        <div class="p-8">
          <div class="mb-8">
            <div class="inline-flex items-center px-3 py-1 mb-3 text-xs font-medium text-black rounded-full bg-black/10">
              {{ selectedEvent.date }}
            </div>
            <h3 class="mb-3 text-3xl font-bold text-gray-800">{{ selectedEvent.title }}</h3>
            <p class="text-gray-600">{{ selectedEvent.description }}</p>
          </div>

          <div class="overflow-hidden shadow-md rounded-xl">
            <Carousel :items-to-show="1" :wrap-around="true" :transition="800" class="gallery-carousel">
              <Slide v-for="(image, i) in selectedEvent.images" :key="i" class="carousel__item">
                <div class="relative overflow-hidden rounded-xl">
                  <img :src="image" :alt="`${selectedEvent.title} Image ${i + 1}`"
                    class="object-cover w-full transition-transform duration-700 rounded-lg hover:scale-105 h-96" />

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
  padding: 1.5rem;
}

.event-carousel :deep(.carousel__prev),
.event-carousel :deep(.carousel__next),
.gallery-carousel :deep(.carousel__prev),
.gallery-carousel :deep(.carousel__next) {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid rgba(0, 0, 0, 0.2);
  border-radius: 50%;
  width: 48px;
  height: 48px;
  color: #000000;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
}

.event-carousel :deep(.carousel__prev:hover),
.event-carousel :deep(.carousel__next:hover),
.gallery-carousel :deep(.carousel__prev:hover),
.gallery-carousel :deep(.carousel__next:hover) {
  background: #000000;
  color: white;
  transform: scale(1.05);
}
</style>