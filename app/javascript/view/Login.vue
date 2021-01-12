<template>
  <div>
    <Header :title="title"></Header>
    <h4>Please Login And enjoy App!!</h4>
    <div class="common-error-message" v-if="error">{{ error }}</div>
    <form @submit.prevent="signin">
      <div class="login-section">
        <label for="email" class="form-label">Email</label>
        <input v-model="email" id="email" type="email" required="required" autocomplete="off">
        <label for="password" class="form-label">Password</label>
        <input v-model="password" id="password" type="password" required="required" autocomplete="off" maxlength="20">
        <router-link to="/signup" class="signup-path">Sign Up</router-link>
      </div>
      <button type="submit" class="study-time-button">Sign In</button>
    </form>
  </div>
</template>

<script>
import Header from '../components/Header';

export default {
  name: 'Signin',
  components: {
    Header
  },
  data() {
    return {
      title: "Login",
      email: '',
      password: '',
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
    signin() {
      this.$http.plain.post('/api/signin', { email: this.email, password: this.password })
      .then(response => this.signinSuccessful(response))
      .catch(error => this.signinFailed(error))
    },
    signinSuccessful(response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.$store.dispatch('doFetchSignedIn')
      this.error = ''
      this.$router.replace('/record')
    },
    signinFailed(error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn() {
      if (localStorage.signedIn) {
        this.$router.replace('/')
      }
    }
  }
}
</script>
<style>
.login-section {
  width: 30em;
  height: 22em;
  background: #0066FF;
  border-radius: .3em;
  display:flex;
  flex-flow: column;
  margin: 3em auto;
}
.form-label {
  color: white;
  font-size: 2.4em;
  font-weight: bold;
  margin: .2em 0;
}
.signup-path {
  margin: .4em;
  font-weight: bold;
  text-decoration: underline;
}
</style>