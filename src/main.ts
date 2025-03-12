import { createApp } from 'vue'
import './style.css'
import 'animate.css';
import App from './App.vue'
import "flyonui/flyonui";
import router from '../src/components/router/index'; 

const app = createApp(App); 

app.use(router); 
app.mount('#app'); 
