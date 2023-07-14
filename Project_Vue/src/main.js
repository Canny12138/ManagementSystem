import Vue from 'vue'
import './plugins/axios'
import Index from './views/Index.vue'
import router from './router'
import './plugins/element.js'
import ElementUI from 'element-ui'
Vue.use(ElementUI);
Vue.config.productionTip = false

// new Vue({
//   router,
//   render: h => h(App)
// }).$mount('#app')
new Vue({
  router,
  render: h => h(Index)
}).$mount('#app')
// export default new router(
//   {
//     routes: [
//       {
//         path: '/login',
//         name: 'login',
//         component: Login
//       }
//     ]
//   }
// )