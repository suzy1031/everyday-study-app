import Vue from 'vue'
import App from '../app.vue'

import { library } from '@fortawesome/fontawesome-svg-core'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { Slide } from 'vue-burger-menu'
import Store from '../store/store.js'
import Router from '../router/router.js'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from '../axios/axios.js'

library.add(fas, far, fab);
Vue.component('font-awesome-icon', FontAwesomeIcon);
Vue.component('slide', Slide);

Vue.config.productionTip = false;

Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

new Vue({
  el: '#app',
  store: Store,
  router: Router,
  securedAxiosInstance,
  plainAxiosInstance,
  render: h => h(App)
})
