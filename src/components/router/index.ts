import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/home.vue';
import Contact from '../views/Contact.vue';
import Timeline from '../views/Timeline.vue';
import Cabinet from '../views/Cabinet.vue';

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/contact', name: 'Contact', component: Contact }, 
  { path: '/timeline', name: 'Timeline', component: Timeline }, 
  { path: '/cabinet', name: 'Cabinet', component: Cabinet }, 
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
