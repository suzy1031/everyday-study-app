<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'App',
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
  width: 13em;
  height: 5em;
  margin: .4em auto;
  border: none;
  outline: none;
  appearance: none;
  border-radius: .25em;
  padding: .3em;
  font-size: 1.8em;
}
input:focus {
  outline: none;
}
h1 {
  font-size: 2.8em;
}
h2 {
  font-size: 2.4em;
}
h3 {
  font-size: 1.8em;
}
.common-error-message {
  color: red;
  font-size: 1.6em;
  margin-top: .5em;
}
/* ここまで */
.margin-top_1 {
  margin-top: 1em !important;
}
.margin-top_1_half {
  margin-top: 1.5em !important;
}
.margin-top_2 {
  margin-top: 2em !important;
}
.margin-top_3 {
  margin-top: 3em !important;
}
.margin-top_5 {
  margin-top: 5em !important;
}
.margin-top_5_half {
  margin-top: 5.5em !important;
}
.position-left_0 {
  left: 0 !important;
}
.position-right_0 {
  right: 0 !important;
}
</style>
