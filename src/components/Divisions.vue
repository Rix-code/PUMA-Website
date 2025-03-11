<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'

const divisions = [
  {
    name: 'BOD',
    title: 'Board of Directors',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#3B82F6' // blue
  },
  {
    name: 'RNT',
    title: 'Research and Technology',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#0EA5E9' // sky
  },
  {
    name: 'HRD',
    title: 'Human Resources',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#0284C7' // blue
  },
  {
    name: 'ICM',
    title: 'Internal Communications',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#2563EB' // blue
  },
  {
    name: 'IR',
    title: 'Internal Relations',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#60A5FA' // blue
  },
  {
    name: 'ER',
    title: 'External Relations',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#38BDF8' // sky
  },
  {
    name: 'SAC',
    title: 'Student Academic & Competition',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#0369A1' // blue
  },
  {
    name: 'SPT',
    title: 'Student Passions & Talents',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#7DD3FC' // sky
  },
  {
    name: 'TECHNOPRENEUR',
    title: 'Technopreneur',
    image: '../public/puma-bag.JPG',
    description: 'lorem',
    color: '#1D4ED8' // blue
  }
]

const activeIndex = ref(2) 
let animating = ref(false)

const patterns = ref([])
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

onMounted(() => {
  generatePatterns()
})

const wrapIndex = (index: number) => {
  const len = divisions.length
  return ((index % len) + len) % len
}

const changeIndexSmoothly = (direction: number) => {
  if (animating.value) return
  animating.value = true

  const targetIndex = wrapIndex(activeIndex.value + direction)
  const step = direction > 0 ? 1 : -1
  let progress = 0

  const animate = () => {
    if (progress >= Math.abs(direction)) {
      activeIndex.value = targetIndex
      animating.value = false
      return
    }

    activeIndex.value = wrapIndex(activeIndex.value + step)
    progress++
    setTimeout(animate, 150) 
  }

  animate()
}

const visibleDivisions = computed(() => {
  return divisions.map((_, i) => {
    const index = wrapIndex(activeIndex.value + i - 2)
    return {
      ...divisions[index],
      opacity: Math.max(0.4, 1 - Math.abs(i - 2) * 0.3),
      scale: Math.max(0.9, 1 - Math.abs(i - 2) * 0.1),
      zIndex: divisions.length - Math.abs(i - 2),
      translateY: (i - 2) * 60, 
      visible: Math.abs(i - 2) <= 2, 
      isActive: i === 2
    }
  })
})

const activeColor = computed(() => {
  return divisions[wrapIndex(activeIndex.value)].color || '#3B82F6'
})
</script>

<template>
  <section id="divisions" class="relative py-24 overflow-hidden bg-gradient-to-b from-white to-blue-50">
    <div class="absolute inset-0 overflow-hidden">
      <div v-for="(pattern, index) in patterns" :key="index"
        class="absolute transition-all duration-1000 ease-out border-2 border-blue-100 rounded-full"
        :style="{
          width: `${pattern.size}px`,
          height: `${pattern.size}px`,
          left: `${pattern.x}%`,
          top: `${pattern.y}%`,
          opacity: pattern.opacity,
          transform: `rotate(${pattern.rotation}deg)`
        }">
      </div>
    </div>

    <div class="absolute rounded-full w-96 h-96" 
      :style="{
        background: `radial-gradient(circle, ${activeColor}20 0%, rgba(255,255,255,0) 70%)`,
        top: '-120px',
        right: '-120px',
        filter: 'blur(40px)'
      }">
    </div>
    <div class="absolute w-64 h-64 rounded-full"
      :style="{
        background: `radial-gradient(circle, ${activeColor}10 0%, rgba(255,255,255,0) 70%)`,
        bottom: '-50px',
        left: '-50px',
        filter: 'blur(30px)'
      }">
    </div>

    <div class="container relative z-10 px-4 mx-auto">
      <div class="mb-16 text-center">
        <h2 class="mb-4 text-5xl font-bold text-gray-800">
          Our <span class="text-blue-500">Divisions</span>
        </h2>
        <div class="w-24 h-1 mx-auto mb-6 rounded-full bg-gradient-to-r from-blue-300 to-blue-500"></div>
        <p class="max-w-2xl mx-auto text-lg font-light text-gray-600">
          Meet our specialized divisions working together to achieve excellence
        </p>
      </div>

      <div class="flex flex-col max-w-6xl gap-8 mx-auto lg:flex-row">
        <div class="relative w-full lg:w-1/3 h-[400px] flex items-center">
          <div v-for="(division, i) in visibleDivisions" :key="`nav-${i}`"
              v-show="division.visible"
              class="absolute w-3/4 px-4 py-2 text-center transition-all duration-500 ease-out cursor-pointer"
              :style="{
                top: `calc(50% + ${division.translateY}px)`,
                left: '50%',
                transform: `translateX(-50%) scale(${division.scale})`,
                opacity: division.opacity,
                zIndex: division.zIndex
              }" 
              @click="changeIndexSmoothly(i - 2)">
            <div
              class="p-4 text-center transition-all duration-300 ease-out transform rounded-xl hover:scale-105"
              :style="{
                backgroundColor: division.isActive ? `${division.color}10` : 'white',
                boxShadow: division.isActive 
                  ? `0 10px 25px ${division.color}30, 0 0 0 2px ${division.color}` 
                  : '0 4px 15px rgba(0, 0, 0, 0.05)'
              }">
              <span class="font-semibold" 
                :class="division.isActive ? 'text-blue-600' : 'text-gray-700'">
                {{ division.name }}
              </span>
            </div>
          </div>
          
          <div class="absolute left-0 right-0 flex justify-center gap-4 -bottom-8">
            <button @click="changeIndexSmoothly(-1)" 
              class="flex items-center justify-center w-10 h-10 transition-colors bg-white border border-blue-100 rounded-full shadow-md hover:bg-blue-50">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
              </svg>
            </button>
            <button @click="changeIndexSmoothly(1)"
              class="flex items-center justify-center w-10 h-10 transition-colors bg-white border border-blue-100 rounded-full shadow-md hover:bg-blue-50">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
            </button>
          </div>
        </div>

        <div class="relative w-full lg:w-2/3 h-[450px] bg-white rounded-2xl overflow-hidden shadow-xl"
          :style="{
            boxShadow: `0 20px 40px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(59, 130, 246, 0.1), 0 0 30px ${activeColor}10`,
            transition: 'box-shadow 0.5s ease'
          }">
          <div class="absolute top-0 left-0 w-full h-1"
            :style="{
              background: `linear-gradient(to right, ${activeColor}50, ${activeColor})`
            }">
          </div>

          <div class="relative overflow-hidden h-3/5">
            <img :src="visibleDivisions[2].image" :alt="visibleDivisions[2].name"
              class="object-cover w-full h-full transition-transform duration-700 ease-out hover:scale-105" />
            <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
            
            <div class="absolute bottom-0 left-0 right-0 p-8 text-white backdrop-blur-sm bg-black/10">
              <div class="flex items-center mb-2">
                <div class="w-1 h-6 mr-3 rounded-full" :style="{ backgroundColor: visibleDivisions[2].color }"></div>
                <h3 class="text-3xl font-bold tracking-tight">{{ visibleDivisions[2].name }}</h3>
              </div>
              <p class="text-xl text-white/90">{{ visibleDivisions[2].title }}</p>
            </div>
          </div>
          
          <div class="p-8">
            <p class="text-lg leading-relaxed text-gray-700">
              {{ visibleDivisions[2].description }}
            </p>
            
            <button class="relative px-6 py-3 mt-6 overflow-hidden bg-white border rounded-full group"
              :style="{
                borderColor: visibleDivisions[2].color,
                transition: 'all 0.3s ease'
              }">
              <span class="absolute inset-0 w-0 transition-all duration-500 ease-out group-hover:w-full"
                :style="{
                  background: visibleDivisions[2].color
                }">
              </span>
              <span class="relative z-10 flex items-center justify-center gap-2 font-medium transition-colors group-hover:text-white"
                :style="{ color: visibleDivisions[2].color }">
                Learn More
                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 transition-transform duration-300 group-hover:translate-x-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
              </span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>