<template>
<div>
  <div class="title-position">
    <h1>Goal</h1>
  </div>
  <div class="goal-header-position">
    <h3>Please Set Weekly Study Time Goal</h3>
  </div>
  <!-- todo エラーメッセージ表示 -->
  <div class="login-section">
    <form @submit.prevent="postGoal">
      <label for="target-time" class="form-label">Target Time</label>
      <input v-model="goal.target_time" id="target-time" class="goal-input-section" type="number" required="required" autocomplete="off">
      <h3 class="goal-h3-text">Hour / per-week</h3>
      <button type="submit" class="study-time-button">register</button>
    </form>
  </div>
</div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Goal',
  data() {
    return {
      goal: {
        target_time: ''
      },
      errors: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    postGoal() {
      this.$http.secured.post('/api/v1/goals', this.goal)
      .then(response => {
        let e = response.data
        this.$router.replace('/record')
      })
      .catch(error => this.setError(error, 'Can not create'));
    }
  }

}
</script>

<style>
.goal-header-position {
  height: 5em;
  display: flex;
  justify-content: center;
  align-items: center;
}
.login-section {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 2em;
  margin-bottom: 1.5em;
  height: 20em;
}
.goal-input-section {
  height: 1.5em;
}
.goal-h3-text {
  color: white;
}
</style>