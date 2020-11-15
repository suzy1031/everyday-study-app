<template>
  <div>
    <Title :title="title"></Title>
    <!-- todo vuex使ってログアウトする処理 -->
    <router-link to="/login">
      <button type="submit" class="study-time-button logout">Logout</button>
    </router-link>
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
      title: "Settings"
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