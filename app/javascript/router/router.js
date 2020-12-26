import Vue from 'vue';
import VueRouter from 'vue-router';
import Record from '../view/Record';
import History from '../view/History';
import Setting from '../view/Setting';
import Login from '../view/Login';
import Signup from '../view/Signup';

Vue.use(VueRouter)

export default new VueRouter({
  routes: [
    {
      path: '/record',
      component: Record
    },
    {
      path: '/history',
      component: History
    },
    {
      path: '/setting',
      component: Setting
    },
    {
      path: '/',
      name: 'Signin',
      component: Login
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
  ]
})

