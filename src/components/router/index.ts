import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router"
import Home from "../views/Home.vue"
import Contact from "../views/Contact.vue"
import Timeline from "../views/Timeline.vue"
import Login from "../views/Login.vue"
import Puma from "../views/Puma.vue"
import NotFound from "../views/404.vue"
import profile from "../views/profile.vue"
import photo from "../views/PhotoboxApp.vue"
import News from "../views/admin/news.vue"
import Event from "../views/admin/event.vue"
import Member from "../views/admin/Member.vue"
import Dashboard from "../views/admin/Dashboard.vue"
import Organizations from "../views/admin/Organizations.vue"
import Users from "../views/admin/Users.vue"
import DivisionMembersPage from "../views/DivisionMember.vue"
import About from "../views/About.vue"
import Aspirations from "../views/Aspirations.vue"
import Merch from "../views/Merch.vue"

const routes: Array<RouteRecordRaw> = [
  { path: "/", name: "Home", component: Home },
  { path: "/contact", name: "Contact", component: Contact },
  { path: "/about", name: "About", component: About },
  { path: "/timeline", name: "Timeline", component: Timeline },
  { path: "/puma", name: "DivisionsList", component: Puma },
  { path: "/division/:divisionName", name: "DivisionMembers", component: DivisionMembersPage },
  { path: "/login", name: "Login", component: Login },
  { path: "/profile", name: "profile", component: profile },
  { path: "/photo", name: "photo", component: photo },
  { path: "/aspirations", name: "aspirations", component: Aspirations },
  { path: "/merch", name: "merch", component: Merch },
  { path: "/admin/news", name: "newsad", component: News },
  { path: "/admin/dashboard", name: "dashboard", component: Dashboard },
  { path: "/admin/event", name: "event", component: Event },
  { path: "/admin/Organizations", name: "Organization", component: Organizations },
  { path: "/admin/Users", name: "Users", component: Users },
  { path: "/admin/Member", name: "Member", component: Member },
  { path: "/:pathMatch(.*)*", name: "NotFound", component: NotFound },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL), // ✅ Switch from hash to history mode
  routes,
  scrollBehavior(to, from, savedPosition) {
    return savedPosition || { top: 0 }
  },
})

export default router
