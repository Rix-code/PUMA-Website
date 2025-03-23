import { createApp } from 'vue'
import './style.css'
import 'animate.css';
import App from './App.vue'
import router from '../src/components/router/index'; 
import AdminLayout from '../src/components/views/admin/Layout.vue'

const app = createApp(App); 

app.use(router); 
app.mount('#app'); 
app.component('AdminLayout', AdminLayout)
