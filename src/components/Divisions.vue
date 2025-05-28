<script setup lang="ts">
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const seeMembers = (divisionName: string) => {
  router.push({ path: '/puma', query: { division: divisionName } })
}

interface Division {
  name: string
  title: string
  image: string
  description: string
}

interface Pattern {
  x: number
  y: number
  size: number
  rotation: number
  opacity: number
}

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
    image: '/division/bod.JPG',
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
    image: '/division/hrd.JPG',
    description: 'lorem'
  },
  {
    name: 'ICM',
    title: 'Information and Creative Media',
    image: '/division/icm.JPG',
    description: 'lorem'
  },
  {
    name: 'IR',
    title: 'Internal Relations',
    image: '/division/internal.JPG',
    description: 'lorem'
  },
  {
    name: 'ER',
    title: 'External Relations',
    image: '/division/EXT.JPG',
    description: 'lorem'
  },
  {
    name: 'SAC',
    title: 'Student Academic & Competition',
    image: '/division/sac.JPG',
    description: 'lorem'
  },
  {
    name: 'SPT',
    title: 'Student Passions & Talents',
    image: '/division/spt.JPG',
    description: 'lorem'
  },
  {
    name: 'TECHNOPRENEUR',
    title: 'Technopreneur',
    image: '/division/Technoprenet.JPG',
    description: 'lorem'
  }
]

const activeIndex = ref(0)
const animating = ref(false)
const transitionDirection = ref<'left' | 'right' | 'none'>('none') 

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

const wrapIndex = (index: number) => {
  const len = divisions.length
  return ((index % len) + len) % len
}

const changeIndexSmoothly = (direction: number) => {
  if (animating.value) return
  if (direction === 0) return

  if (direction > 0) {
    transitionDirection.value = 'right' 
  } else {
    transitionDirection.value = 'left' 
  }

  animating.value = true
  activeIndex.value = wrapIndex(activeIndex.value + direction)
}

const onAfterCardEnter = () => {
  animating.value = false
  transitionDirection.value = 'none'; 
}

const visibleDivisions = computed(() => {
  if (divisions.length === 0) return [];
  return Array.from({ length: Math.min(5, divisions.length) }).map((_, i) => {
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
const isSmallMobile = ref(false)

const checkMobile = () => {
  isMobile.value = window.innerWidth < 768
  isSmallMobile.value = window.innerWidth < 480
}

let autoSlideIntervalId: number | null = null;

onMounted(() => {
  generatePatterns()
  checkMobile()
  window.addEventListener('resize', checkMobile)
  autoSlideIntervalId = window.setInterval(() => {
    changeIndexSmoothly(1); 
  }, 5000);
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', checkMobile)
  if (autoSlideIntervalId !== null) {
    clearInterval(autoSlideIntervalId);
  }
})

</script>

<template>
  <section id="divisions" class="relative py-12 overflow-hidden sm:py-16 md:py-24 bg-gradient-to-b from-white to-gray-50">
    <div class="absolute inset-0 overflow-hidden">
      <div v-for="(circle, index) in bgGradientCircles" :key="`gradient-circle-${index}`" class="absolute rounded-full"
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
        class="absolute transition-all duration-1000 ease-out border-2 border-gray-200 rounded-full" :style="{
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
      <div class="mb-8 text-center transition-opacity duration-700 ease-in-out md:mb-16">
        <h2 class="mb-4 text-3xl font-bold text-gray-800 md:text-5xl">
          Our <span class="text-black">Divisions</span>
        </h2>
        <div class="w-16 h-1 mx-auto mb-4 rounded-full md:w-24 md:mb-6 bg-gradient-to-r from-gray-300 to-black"></div>
        <p class="max-w-2xl mx-auto text-base font-light text-gray-600 md:text-lg">
          Meet our specialized divisions working together to achieve excellence
        </p>
      </div>

      <div class="flex flex-col max-w-6xl gap-4 mx-auto md:gap-8 lg:flex-row">
        <div class="relative w-full lg:w-1/3 h-[200px] sm:h-[250px] md:h-[400px] hidden md:flex items-center">
          <template v-if="visibleDivisions.length > 0">
            <div v-for="(division, i) in visibleDivisions" :key="`nav-${division.name}-${i}`" v-show="division.visible"
              class="absolute w-3/4 px-4 py-2 text-center transition-all duration-500 ease-out cursor-pointer group"
              :style="{
                top: `calc(50% + ${division.translateY}px)`,
                left: '50%',
                transform: `translateX(-50%) scale(${division.scale})`,
                opacity: division.opacity,
                zIndex: division.zIndex
              }" @click="changeIndexSmoothly(i - 2)">
              <div
                class="p-3 text-center transition-all duration-300 ease-out transform sm:p-4 rounded-xl hover:bg-black/5"
                :class="{
                  'bg-black/5 border-2 border-black': division.isActive,
                  'bg-white shadow-md hover:shadow-lg': !division.isActive
                }">
                <span class="font-semibold transition-all duration-300"
                  :class="division.isActive ? 'text-black' : 'text-gray-700 group-hover:text-black'">
                  {{ division.name }}
                </span>
              </div>
            </div>
          </template>
          <div class="absolute left-0 right-0 flex justify-center gap-4 -bottom-8 md:flex">
            <button @click="changeIndexSmoothly(-1)"
              class="flex items-center justify-center w-10 h-10 transition-all duration-300 bg-white rounded-full shadow-md hover:bg-black hover:text-white group">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-black transition-colors group-hover:text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
              </svg>
            </button>
            <button @click="changeIndexSmoothly(1)"
              class="flex items-center justify-center w-10 h-10 transition-all duration-300 bg-white rounded-full shadow-md hover:bg-black hover:text-white group">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-black transition-colors group-hover:text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
              </svg>
            </button>
          </div>
        </div>

        <div class="relative lg:w-2/3 card-transition-wrapper h-[400px] sm:h-[450px] md:h-[500px] lg:h-[550px]">
          <transition
            name="card-transition"
            mode="out-in"
            @after-enter="onAfterCardEnter"
          >
            <div v-if="visibleDivisions.length > 2 && visibleDivisions[2]"
              :key="visibleDivisions[2].name"
              class="w-full h-full overflow-hidden bg-white shadow-xl rounded-2xl main-card-inner hover:shadow-2xl"
            >
              <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-black to-transparent"></div>
              <div class="relative overflow-hidden h-4/5 sm:h-4/5 md:h-4/5">
                <div class="relative w-full h-full overflow-hidden">
                  <img :src="visibleDivisions[2].image" :alt="visibleDivisions[2].name"
                    class="absolute inset-0 object-cover w-full h-full" />
                  <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent"></div>
                  <div class="absolute bottom-0 left-0 right-0 p-4 text-white sm:p-6 md:p-8">
                    <div class="flex items-center mb-1 md:mb-2">
                      <div class="w-1 h-6 mr-3 bg-white rounded-full"></div>
                      <h3 class="text-lg font-bold tracking-tight sm:text-xl md:text-3xl">
                        {{ visibleDivisions[2].name }}
                      </h3>
                    </div>
                    <p class="text-xs sm:text-sm md:text-xl text-white/90">
                      {{ visibleDivisions[2].title }}
                    </p>
                  </div>
                </div>
              </div>
              <div class="flex items-center justify-between px-4 py-3 sm:p-4 md:p-6">
                <button
                  class="relative px-3 sm:px-4 md:px-6 py-1.5 sm:py-2 md:py-3 overflow-hidden bg-white rounded-full group text-xs sm:text-sm md:text-base transition-all duration-300 hover:scale-[1.02] active:scale-95"
                  @click="seeMembers(visibleDivisions[2].name)">
                  <span class="absolute inset-0 w-0 transition-all duration-500 ease-out bg-black group-hover:w-full"></span>
                  <span class="relative z-10 flex items-center justify-center gap-1 font-medium transition-all duration-300 sm:gap-2 group-hover:text-white">
                    See Members
                    <svg xmlns="http://www.w3.org/2000/svg"
                      class="w-3 h-3 transition-all duration-300 sm:w-4 sm:h-4 group-hover:translate-x-1 group-hover:scale-110"
                      fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                    </svg>
                  </span>
                </button>
                <div class="flex justify-center gap-2 sm:gap-3 md:hidden">
                  <button @click="changeIndexSmoothly(-1)"
                    class="flex items-center justify-center w-8 h-8 transition-all duration-300 bg-white rounded-full shadow-md hover:bg-black hover:text-white group">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 text-black transition-colors group-hover:text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
                    </svg>
                  </button>
                  <button @click="changeIndexSmoothly(1)"
                    class="flex items-center justify-center w-8 h-8 transition-all duration-300 bg-white rounded-full shadow-md hover:bg-black hover:text-white group">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 text-black transition-colors group-hover:text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                    </svg>
                  </button>
                </div>
              </div>
            </div>
            <div v-else
              :key="'loading-card'"
              class="flex items-center justify-center w-full h-full bg-gray-200 rounded-2xl">
              <p>Loading divisions...</p>
            </div>
          </transition>
        </div>
      </div>
    </div>
  </section>
</template>

<style>

.button-underline::after {
  content: ''; position: absolute; bottom: 0; left: 0; width: 0; height: 2px;
  background-color: currentColor; transition: width 0.4s cubic-bezier(0.65, 0, 0.35, 1);
}
.button-underline:hover::after { width: 100%; }
.card-hover {
  transition: transform 0.5s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.5s cubic-bezier(0.16, 1, 0.3, 1);
}
.card-hover:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1); }
.image-zoom { transition: transform 1s cubic-bezier(0.16, 1, 0.3, 1); }
.image-zoom:hover { transform: scale(1.03); }
.ease-spring { transition-timing-function: cubic-bezier(0.16, 1, 0.3, 1); }
.ease-smooth { transition-timing-function: cubic-bezier(0.65, 0, 0.35, 1); }


.card-transition-wrapper {
  perspective: 1200px;
}

.card-transition-enter-active,
.card-transition-leave-active {
  transition-property: transform, opacity;
  transition-duration: 0.35s;
  transition-timing-function: cubic-bezier(0.4, 0.0, 0.2, 1);
}

.card-transition-enter-from {
  opacity: 0;
  transform: v-bind("transitionDirection === 'right' ? 'translateY(20px) scale(0.97)' : 'translateY(-20px) scale(0.97)'");
}
.card-transition-enter-to {
  opacity: 1;
  transform: translateY(0) scale(1);
}

.card-transition-leave-from {
  opacity: 1;
  transform: translateY(0) scale(1);
}
.card-transition-leave-to {
  opacity: 0;
  transform: v-bind("transitionDirection === 'right' ? 'translateY(-20px) scale(0.97)' : 'translateY(20px) scale(0.97)'");
}
</style>