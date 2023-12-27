import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import filarmonic from './services/socketClientService'
const app = createApp(App);
//app.config.compilerOptions.isCustomElement = (tag) =>  tag === 'webview'
app.use(router);
app.use(filarmonic)
app.mount('#app');
