import { createRouter, createWebHashHistory } from 'vue-router';
import Home from '../views/Home.vue';
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
  history: createWebHashHistory(import.meta.env.BASE_URL), 
  routes,
});

export default router;
