<script setup lang="ts">
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Navigation } from 'vue3-carousel'
import { ref } from 'vue'

const events = [
  {
    title: 'Regenetics',
    date: 'lorem',
    description: 'The PUMA Informatics Regeneration is an event to recruit new members who are enthusiastic and committed to joining the organization.',
    image: '../public/puma-bag.JPG'
  },
  {
    title: 'UNITICS',
    date: 'lorem',
    description: 'Unitics (Unity of Informatics) is organized to welcome new members to PUMA IT. The primary focus is to create an inclusive environment.',
    image: '../public/puma-bag.JPG'
  },
  {
    title: 'INFORUUM',
    date: 'lorem',
    description: 'Inforuum (Informatics Continuum) is a farewell event for PUMA IT members, allowing them to bid farewell and reminisce about shared moments.',
    image: '../public/puma-bag.JPG'
  },
  {
    title: 'TEMU ALUMNI',
    date: 'lorem',
    description: 'Temu Alumni is an event aimed at enhancing the relationship between students and alumni in the field of informatics through sharing sessions.',
    image: '../public/puma-bag.JPG'
  }
]

const currentSlide = ref(0)

const handleSlideChange = (index: number) => {
  currentSlide.value = index
}
</script>

<template>
  <section id="events" class="relative py-20 overflow-hidden bg-white">
    <div class="container relative px-4 mx-auto">
      <h2 class="mb-4 text-4xl font-bold text-center">Upcoming Events</h2>
      <p class="max-w-2xl mx-auto mb-12 font-light text-center text-gray-600">
        Join us in our upcoming events and be part of the technology revolution
      </p>
      <div class="mx-auto max-w-7xl">
        <Carousel 
          :items-to-show="2.5" 
          :wrap-around="true" 
          :transition="500" 
          @slideChange="handleSlideChange"
          class="event-carousel"
        >
          <Slide v-for="(event, index) in events" :key="index" class="carousel__item">
            <div class="h-full mx-4">
              <div 
                class="overflow-hidden transition-all duration-300 transform bg-white shadow-xl rounded-xl"
                :class="{ 
                  'scale-125 shadow-2xl': currentSlide === index, 
                  'scale-90 opacity-75': currentSlide !== index 
                }"
              >
                <div class="relative">
                  <img :src="event.image" :alt="event.title" class="object-cover w-full h-48" />
                  <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                  <div class="absolute bottom-0 left-0 right-0 p-6 text-white">
                    <h3 class="mb-2 text-xl font-bold">{{ event.title }}</h3>
                    <p class="text-sm text-white/90">{{ event.date }}</p>
                  </div>
                </div>
                <div class="p-6">
                  <p class="mb-4 text-sm text-gray-600">{{ event.description }}</p>
                  <button class="w-full px-6 py-2 text-sm text-white transition-colors bg-blue-600 rounded-full hover:bg-blue-700">
                    Learn More
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
  </section>
</template>

<style scoped>
.event-carousel :deep(.carousel__slide) {
  padding: 1rem;
}

.event-carousel :deep(.carousel__prev),
.event-carousel :deep(.carousel__next) {
  background-color: rgba(255, 255, 255, 0.9);
  border-radius: 50%;
  width: 48px;
  height: 48px;
  color: #1d4ed8;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.event-carousel :deep(.carousel__prev:hover),
.event-carousel :deep(.carousel__next:hover) {
  background-color: white;
  color: #1e40af;
}
</style>
