import { createApp } from 'vue'
import './style.css'
import 'animate.css';
import App from './App.vue'
import "flyonui/flyonui";
import router from '../src/components/router/index'; 

const app = createApp(App); // Create the Vue app instance

app.use(router); // Apply Vue Router
app.mount('#app'); // Mount the app
