<template>
  <div>
    <Header :title="title"></Header>
    <h4>Please Sign Up And enjoy App!!</h4>
    <div class="common-error-message" v-if="error">{{ error }}</div>
    <form @submit.prevent="signup">
      <div class="login-section">
        <label for="email" class="form-label">Email</label>
        <input v-model="email"
                id="email"
                type="email"
                required="required"
                autocomplete="off"
              >
        <label for="password" class="form-label">Password</label>
        <input v-model="password"
                id="password"
                type="password"
                required="required"
                autocomplete="off"
                maxlength="20"
              >
        <label for="password" class="form-label">Password Confirmation</label>
        <input v-model="password_confirmation"
                id="password-confirmation"
                type="password"
                required="required"
                autocomplete="off"
                maxlength="20"
              >
        <router-link to="/" class="signup-path">Login</router-link>
      </div>
      <button class="study-time-button" type="submit">Signup</button>
    </form>
  </div>
</template>
<script>
import Header from '../components/Header';

export default {
  name: 'Signup',
  components: {
    Header
  },
  data() {
    return {
      title: "Sign Up",
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created() {
    this.checkSignedIn()
  },
  updated() {
    this.checkSignedIn()
  },
  methods: {
    signup() {
      this.$http.plain.post('/api/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
      .then(response => this.signupSuccessful(response))
      .catch(error => this.signupFailed(error))
    },
    signupSuccessful(response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.$store.dispatch('doFetchSignedIn')
      this.error = ''
      this.$router.replace('/goals/new')
    },
    signupFailed(error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn() {
      if (localStorage.signedIn) {
        this.$router.replace('/record')
      }
    }
  }
}
</script>
<style scoped>
.login-section {
  height: 32em;
}
</style>