import { createRouter, createWebHashHistory } from "vue-router";
import Home from "../views/Home.vue";
import Contact from "../views/Contact.vue";
import Timeline from "../views/Timeline.vue";
import Cabinet from "../views/Cabinet.vue";
import Login from "../views/Login.vue";
import NotFound from "../views/404.vue"; 

const routes = [
  { path: "/", name: "Home", component: Home },
  { path: "/contact", name: "Contact", component: Contact },
  { path: "/timeline", name: "Timeline", component: Timeline },
  { path: "/cabinet", name: "Cabinet", component: Cabinet },
  { path: "/login", name: "Login", component: Login },
  { path: "/:pathMatch(.*)*", name: "NotFound", component: NotFound }, 
];

const router = createRouter({
  history: createWebHashHistory(import.meta.env.BASE_URL),
  routes,
});

export default router;
