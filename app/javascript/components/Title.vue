<template>
  <div>
    <header>
      <div v-if="signedIn">
        <BurgerMenu></BurgerMenu>
      </div>
      <div class="title-position">
      <h1>{{title}}</h1>
      </div>
    </header>
  </div>
</template>
<script>
import BurgerMenu from './BurgerMenu';
import { mapState } from 'vuex'

export default {
  components: {
    BurgerMenu
  },
  props: {
    title: String
  },
  computed: mapState([
    'signedIn'
  ]),
  mounted () {
    this.$store.dispatch('doFetchSignedIn')
  }
}
</script>
<style>
.title-position {
  margin-top: 1.8em;
}
</style>