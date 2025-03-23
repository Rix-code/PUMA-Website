import { createRouter, createWebHashHistory } from "vue-router";
import Home from "../views/Home.vue";
import Contact from "../views/Contact.vue";
import Timeline from "../views/Timeline.vue";
import Cabinet from "../views/Cabinet.vue";
import Login from "../views/Login.vue";
import NotFound from "../views/404.vue"; 
import profile from "../views/profile.vue";
import puma from "../views/Puma.vue";
import photo from "../views/PhotoboxApp.vue";
import News from "../views/admin/news.vue";
import Event from "../views/admin/event.vue";
import Member from "../views/admin/Member.vue"
import Dashboard from "../views/admin/Dashboard.vue";
import Organizations from "../views/admin/Organizations.vue";
import Users from "../views/admin/Users.vue";

const routes = [
  { path: "/", name: "Home", component: Home },
  { path: "/contact", name: "Contact", component: Contact },
  { path: "/timeline", name: "Timeline", component: Timeline },
  { path: "/cabinet", name: "Cabinet", component: Cabinet },
  { path: "/login", name: "Login", component: Login },
  { path: "/profile", name: "profile", component: profile },
  { path: "/puma", name: "puma", component: puma },
  { path: "/photo", name: "photo", component: photo },
  { path: "/admin/news", name: "newsad", component: News },
  { path: "/admin/dashboard", name: "dashboard", component: Dashboard },
  { path: "/admin/event", name: "event", component: Event },
  { path: "/admin/Organizations", name: "Organization", component: Organizations },
  { path: "/admin/Users", name: "Users", component: Users },
  { path: "/admin/Member", name: "Member", component: Member },
  { path: "/:pathMatch(.*)*", name: "NotFound", component: NotFound }, 
];

const router = createRouter({
  history: createWebHashHistory(import.meta.env.BASE_URL),
  routes,
});

export default router;
