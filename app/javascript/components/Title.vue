<template>
  <div>
    <header>
      <BurgerMenu></BurgerMenu>
      <div class="title-position">
      <h1>{{title}}</h1>
      </div>
    </header>
  </div>
</template>
<script>
import BurgerMenu from './BurgerMenu';

export default {
  components: {
    BurgerMenu
  },
  props: {
    title: String
  }
}
</script>
<style>
.title-position {
  margin-top: 1.8em;
}
</style>