<template>
  <slide noOverlay>
    <router-link to="/Record">
      <span>Record</span>
    </router-link>
    <router-link to="/history">
      <span>History</span>
    </router-link>
    <router-link to="/setting">
      <span>Setting</span>
    </router-link>
    <a href="/" v-if="signedIn" @click="signOut">
      <span>Logout</span>
    </a>
  </slide>
</template>
<script>
import { mapState } from 'vuex'
export default {
  computed: mapState([
    'signedIn'
  ]),
  mounted () {
    this.$store.dispatch('doFetchSignedIn')
  },
  methods: {
    setError(error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signOut() {
      this.$http.secured.delete(`/api/signin`)
      .then(response => {
        delete localStorage.csrf
        delete localStorage.signedIn
      })
      .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
<style>
.bm-burger-button {
  top: 3% !important;
  left: 3% !important;
}
</style>