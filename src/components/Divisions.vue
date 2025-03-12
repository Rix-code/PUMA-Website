<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'

// Define the interface for division objects
interface Division {
  name: string
  title: string
  image: string
  description: string
}

// Define the interface for pattern objects
interface Pattern {
  x: number
  y: number
  size: number
  rotation: number
  opacity: number
}

// Define the interface for background gradient circles
interface GradientCircle {
  size: number
  x: number
  y: number
  opacity: number
}

const divisions: Division[] = [
  {
    name: 'BOD',
    title: 'Board of Directors',
    image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
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
    title: 'Human Resources',
    image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
    description: 'lorem'
  },
  {
    name: 'ICM',
    title: 'Internal Communications',
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

const activeIndex = ref(2)
let animating = ref(false)

const bgGradientCircles = ref<GradientCircle[]>([
  { size: 500, x: -10, y: -10, opacity: 0.07 },
  { size: 400, x: 75, y: 20, opacity: 0.05 },
  { size: 350, x: 20, y: 70, opacity: 0.06 },
  { size: 300, x: 60, y: 80, opacity: 0.04 },
  { size: 450, x: 90, y: 40, opacity: 0.03 }
])

const patterns = ref<Pattern[]>([])
const generatePatterns = () => {
  const newPatterns: Pattern[] = []
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

const isMobile = ref(false)

const checkMobile = () => {
  isMobile.value = window.innerWidth < 768
}

onMounted(() => {
  checkMobile()
  window.addEventListener('resize', checkMobile)
})
</script>

<template>
  <section id="divisions" class="relative py-24 overflow-hidden bg-gradient-to-b from-white to-gray-50">
    <div class="absolute inset-0 overflow-hidden">
      <div v-for="(circle, index) in bgGradientCircles" :key="`gradient-circle-${index}`"
        class="absolute rounded-full" 
        :style="{
          width: `${circle.size}px`,
          height: `${circle.size}px`,
          left: `${circle.x}%`,
          top: `${circle.y}%`,
          background: 'radial-gradient(circle, rgba(0,0,0,0.4) 0%, rgba(255,255,255,0) 70%)',
          opacity: circle.opacity,
          filter: 'blur(50px)'
        }">
      </div>

      <div v-for="(pattern, index) in patterns" :key="`pattern-${index}`"
        class="absolute transition-all duration-1000 ease-out border-2 border-gray-200 rounded-full" 
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

    <div class="container relative z-10 px-4 mx-auto">
      <div class="mb-16 text-center">
        <h2 class="mb-4 text-5xl font-bold text-gray-800">
          Our <span class="text-black">Divisions</span>
        </h2>
        <div class="w-24 h-1 mx-auto mb-6 rounded-full bg-gradient-to-r from-gray-300 to-black"></div>
        <p class="max-w-2xl mx-auto text-lg font-light text-gray-600">
          Meet our specialized divisions working together to achieve excellence
        </p>
      </div>

      <div class="flex flex-col max-w-6xl gap-8 mx-auto lg:flex-row">
        <div class="relative w-full lg:w-1/3 h-[400px] hidden md:flex items-center">
          <div v-for="(division, i) in visibleDivisions" :key="`nav-${i}`" v-show="division.visible"
            class="absolute w-3/4 px-4 py-2 text-center transition-all duration-500 ease-out cursor-pointer" 
            :style="{
              top: `calc(50% + ${division.translateY}px)`,
              left: '50%',
              transform: `translateX(-50%) scale(${division.scale})`,
              opacity: division.opacity,
              zIndex: division.zIndex
            }" 
            @click="changeIndexSmoothly(i - 2)">
            <div class="p-4 text-center transition-all duration-300 ease-out transform rounded-xl hover:scale-105"
              :style="{
                backgroundColor: division.isActive ? 'rgba(0,0,0,0.05)' : 'white',
                boxShadow: division.isActive
                  ? '0 10px 25px rgba(0,0,0,0.1), 0 0 0 2px rgba(0,0,0,0.8)'
                  : '0 4px 15px rgba(0, 0, 0, 0.05)'
              }">
              <span class="font-semibold" :class="division.isActive ? 'text-black' : 'text-gray-700'">
                {{ division.name }}
              </span>
            </div>
          </div>

          <div class="absolute left-0 right-0 flex justify-center gap-4 -bottom-8 md:flex">
            <button @click="changeIndexSmoothly(-1)"
              class="flex items-center justify-center w-10 h-10 transition-colors bg-white border border-gray-200 rounded-full shadow-md hover:bg-gray-50">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-black" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
              </svg>
            </button>
            <button @click="changeIndexSmoothly(1)"
              class="flex items-center justify-center w-10 h-10 transition-colors bg-white border border-gray-200 rounded-full shadow-md hover:bg-gray-50">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-black" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
            </button>
          </div>
        </div>

        <div class="relative w-full lg:w-2/3 h-[450px] bg-white rounded-2xl overflow-hidden shadow-xl" 
          style="box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(0, 0, 0, 0.1), 0 0 30px rgba(0, 0, 0, 0.05)">
          <div class="absolute top-0 left-0 w-full h-1 bg-black"></div>

          <div class="flex items-center justify-center p-2 md:hidden bg-black/5">
            <span class="font-semibold text-black">
              {{ visibleDivisions[2].name }} - {{ visibleDivisions[2].title }}
            </span>
          </div>

          <div class="relative overflow-hidden h-3/5">
            <img :src="visibleDivisions[2].image" :alt="visibleDivisions[2].name"
              class="object-cover w-full h-full transition-transform duration-700 ease-out hover:scale-105" />
            <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>

            <div class="absolute bottom-0 left-0 right-0 p-8 text-white bg-gradient-to-t from-black/80 via-black/40 to-transparent">
              <div class="flex items-center mb-2">
                <div class="w-1 h-6 mr-3 bg-white rounded-full"></div>
                <h3 class="text-3xl font-bold tracking-tight">{{ visibleDivisions[2].name }}</h3>
              </div>
              <p class="text-xl text-white/90">{{ visibleDivisions[2].title }}</p>
            </div>
          </div>

          <div class="p-8">
            <p class="text-lg leading-relaxed text-gray-700">
              {{ visibleDivisions[2].description }}
            </p>

            <div class="flex items-center justify-between mt-6">
              <button class="relative px-6 py-3 overflow-hidden bg-white border border-black rounded-full group">
                <span class="absolute inset-0 w-0 transition-all duration-500 ease-out bg-black group-hover:w-full"></span>
                <span class="relative z-10 flex items-center justify-center gap-2 font-medium text-black transition-colors group-hover:text-white">
                  See Member
                  <svg xmlns="http://www.w3.org/2000/svg"
                    class="w-4 h-4 transition-transform duration-300 group-hover:translate-x-1" fill="none"
                    viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                  </svg>
                </span>
              </button>

              <div class="flex justify-center gap-4 md:hidden">
                <button @click="changeIndexSmoothly(-1)"
                  class="flex items-center justify-center w-10 h-10 transition-colors bg-white border border-gray-200 rounded-full shadow-md hover:bg-gray-50">
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-black" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
                <button @click="changeIndexSmoothly(1)"
                  class="flex items-center justify-center w-10 h-10 transition-colors bg-white border border-gray-200 rounded-full shadow-md hover:bg-gray-50">
                  <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-black" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>