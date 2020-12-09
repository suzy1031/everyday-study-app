<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue';
import VueRouter from 'vue-router';
import Record from './view/Record';
import History from './view/History';
import Setting from './view/Setting';
import Login from './view/Login';
import Signup from './view/Signup';

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
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
      path: '/login',
      component: Login
    },
    {
      path: '/signup',
      component: Signup
    }
  ]
})

Vue.use(VueRouter)

export default {
  router,
  data() {
    return {
    }
  }
}
</script>
<style>
/* 全体のレイアウト */
* {
  margin: 0;
  padding: 0;
}
html {
  /* html全体のフォントサイズを10pxに指定 */
  font-size: 62.5%;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}
a {
  text-decoration: none;
  color: white;
}
button {
  border: none;
  outline: none;
  appearance: none;
}
input {
  width: 250px;
  height: 35px;
  margin: 5px auto;
  border: none;
  outline: none;
  appearance: none;
  border-radius: .25em;
  padding: 3px;
  font-size: 18px;
}
input:focus {
  outline: none;
}
h1 {
  font-size: 2.8em;
}
h3 {
  font-size: 1.8em;
}
/* ここまで */
</style>
