<template>
  <section id="home" class="relative h-screen">
    <div class="absolute inset-0">
      <img
        src="https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"
        class="object-cover w-full h-full" alt="Background" />
      <div class="absolute inset-0 bg-gradient-to-b from-black/70 to-black/50"></div>
    </div>
    <div class="relative flex items-center justify-center h-full">
      <div class="text-center">
        <h1 class="mb-4 text-5xl font-bold text-white md:text-7xl animate-fadeInUp">
          Kaustav Cabinet
        </h1>
        <p class="text-xl text-white/90 animate-fadeInUp animate-delay-200">
          Leading the future of technology
        </p>
        <a href="/cabinet"
          class="inline-block px-8 py-3 mt-8 text-white transition-colors bg-blue-600 rounded-full hover:bg-blue-700 animate-fadeInUp animate-delay-300">
          Discover More
        </a>

      </div>
    </div>
    <div class="absolute -translate-x-1/2 bottom-10 left-1/2 animate-bounce">
      <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
      </svg>
    </div>
  </section>
</template>