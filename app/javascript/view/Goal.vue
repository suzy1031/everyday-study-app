<template>
<div>
  <div class="title-position">
    <h1>Goal</h1>
  </div>
  <div class="goal-header-position">
    <h3>Please Set Weekly Study Time Goal</h3>
    <div class="common-error-message" v-if="error">{{ error }}</div>
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
      error: ''
    }
  },
  created () {
    // ログインしていない場合ログイン画面へリダイレクト
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    }
    // 既にgoalを登録している場合'/record'画面へリダイレクト
    this.$http.secured.get('/api/v1/goals')
    .then(response => {
      this.goals = response.data
    })
    if(this.goals) {
      this.$router.replace('/record')
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    // 目標時間の登録
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