<template>
  <div>
    <Title :title="title"></Title>
    <h4>Please Sign Up And enjoy App!!</h4>
    <!-- todo formに変更 -->
    <div class="login-section">
      <label for="email" class="form-label">Email</label>
      <input id="email" type="email">
      <label for="password" class="form-label">Password</label>
      <input id="password" type="password">
      <router-link to="/login" class="signup-path">Login</router-link>
    </div>
  </div>
</template>
<script>
import Title from '../components/Title';

export default {
  components: {
    Title
  },
  data() {
    return {
      title: "Sign Up"
    }
  }
}
</script>
<style>
.login-section {
  position: absolute;
  width: 300px;
  height: 250px;
  background: #0066FF;
  border-radius: 4px;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
  display:flex;
  flex-flow: column;
}
.signup-path {
  margin: 10px;
  font-weight: bold;
  text-decoration: underline;
}
</style>