<template>
  <div>
    <Header :title="title"></Header>
    <a href="/" v-if="signedIn" @click="signOut" class="study-time-button logout">Logout</a>
  </div>
</template>

<script>
import Header from '../components/Header'
import { mapState } from 'vuex'

export default {
  components: {
    Header
  },
  data() {
    return {
      title: "Settings"
    }
  },
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
.logout {
  position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>