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
    <a href="#" @click.prevent="signOut">
      <span>Logout</span>
    </a>
  </slide>
</template>
<script>
export default {
  methods: {
    setError(error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signOut() {
      this.$http.secured.delete(`/api/signin`)
      .then(response => {
        delete localStorage.csrf
        delete localStorage.signedIn
        this.$router.replace('/')
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