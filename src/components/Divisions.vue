  <script setup lang="ts">
  import { ref, computed } from 'vue'

  const divisions = [
    {
      name: 'BOD',
      title: 'Board of Directors',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    },
    {
      name: 'RNT',
      title: 'Research and Technology',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    },
    {
      name: 'HRD',
      title: 'Human Resources',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    },
    {
      name: 'ICM',
      title: 'Internal Communications',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    },
    {
      name: 'IR',
      title: 'Internal Relations',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    },
    {
      name: 'ER',
      title: 'External Relations',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    },
    {
      name: ' SAC',
      title: 'Student ACADEMIC & COMPETITION',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    },
    {
      name: 'SPT',
      title: 'Student PASSIONs & TALENTS',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    },
    {
      name: 'TECHNOPRENEUR',
      title: 'TECHNOPRENEUR',
      image: '../public/puma-bag.JPG',
      description: 'lorem'
    }
  ]

  const activeIndex = ref(2) 
  let animating = false

  const wrapIndex = (index: number) => {
    const len = divisions.length
    return ((index % len) + len) % len
  }

  const changeIndexSmoothly = (direction: number) => {
    if (animating) return
    animating = true

    const targetIndex = wrapIndex(activeIndex.value + direction)
    const step = direction > 0 ? 1 : -1
    let progress = 0

    const animate = () => {
      if (progress >= Math.abs(direction)) {
        activeIndex.value = targetIndex
        animating = false
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
        translateY: (i - 2) * 60
      }
    })
  })
</script>

  <template>
    <section id="divisions" class="relative py-20 bg-gray-50">
      <div class="container relative px-4 mx-auto">
        <h2 class="mb-4 text-4xl font-bold text-center">Our Divisions</h2>
        <p class="max-w-2xl mx-auto mb-12 font-light text-center text-gray-600">
          Meet our specialized divisions working together to achieve excellence
        </p>

        <div class="flex max-w-6xl mx-auto">
          <div class="relative w-1/3 overflow-hidden h-[400px] flex flex-col items-center space-y-3">
            <div v-for="(division, i) in visibleDivisions" :key="division.name"
              class="absolute w-3/4 px-4 py-2 text-center transition-transform duration-500 ease-out rounded-lg cursor-pointer"
              :style="{
                top: `calc(50% + ${division.translateY}px)`,
                opacity: division.opacity,
                transform: `scale(${division.scale})`,
                zIndex: division.zIndex
              }" @click="changeIndexSmoothly(i - 2)">
              <span
                class="block p-3 text-lg font-semibold transition-all duration-300 bg-white border-2 border-transparent shadow-lg rounded-xl hover:border-gray-400">
                {{ division.name }}
              </span>

            </div>
          </div>

          <div class="relative w-2/3 h-[400px] overflow-hidden bg-white shadow-lg rounded-xl">
            <div class="relative h-3/5">
              <img :src="visibleDivisions[2].image" :alt="visibleDivisions[2].name"
                class="object-cover w-full h-full transition-transform duration-500 ease-out" />
              <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
              <div class="absolute bottom-0 left-0 right-0 p-8 text-white">
                <h3 class="mb-2 text-3xl font-bold">{{ visibleDivisions[2].name }}</h3>
                <p class="text-xl text-white/90">{{ visibleDivisions[2].title }}</p>
              </div>
            </div>
            <div class="p-8">
              <p class="text-lg leading-relaxed text-gray-600">
                {{ visibleDivisions[2].description }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
  </template>
