<template>
  <section id="contact" class="relative py-20 bg-gray-50">
    <div class="absolute inset-0 h-32 pointer-events-none bg-gradient-to-b from-white to-gray-50"></div>
    <div class="container relative px-4 mx-auto">
      <h2 class="mb-4 text-4xl font-bold text-center">Contact Us</h2>
      <p class="max-w-2xl mx-auto mb-12 text-center text-gray-600">
        Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.
      </p>
      <div class="max-w-3xl mx-auto">
        <div class="p-8 transition-all duration-300 transform bg-white shadow-xl rounded-xl hover:shadow-2xl">
          <form class="space-y-6">
            <div class="grid gap-6 md:grid-cols-2">
              <div>
                <label class="block mb-2 font-medium text-gray-700">Name</label>
                <input 
                  type="text" 
                  class="w-full px-4 py-3 transition-all border border-gray-200 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200" 
                />
              </div>
              <div>
                <label class="block mb-2 font-medium text-gray-700">Email</label>
                <input 
                  type="email" 
                  class="w-full px-4 py-3 transition-all border border-gray-200 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200" 
                />
              </div>
            </div>
            <div>
              <label class="block mb-2 font-medium text-gray-700">Subject</label>
              <input 
                type="text" 
                class="w-full px-4 py-3 transition-all border border-gray-200 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200" 
              />
            </div>
            <div>
              <label class="block mb-2 font-medium text-gray-700">Message</label>
              <textarea 
                rows="4" 
                class="w-full px-4 py-3 transition-all border border-gray-200 rounded-lg focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200"
              ></textarea>
            </div>
            <button 
              type="submit" 
              class="w-full bg-blue-600 text-white py-3 px-6 rounded-lg hover:bg-blue-700 transition-colors transform hover:-translate-y-0.5 duration-200"
            >
              Send Message
            </button>
          </form>
        </div>
      </div>
    </div>
    <div class="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(59,130,246,0.1),transparent)] pointer-events-none"></div>
  </section>
</template>