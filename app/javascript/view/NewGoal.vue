<template>
<div>
  <div class="title-position">
    <h1>Goal</h1>
  </div>
  <div class="goal-header-position">
    <h3>Please Set Weekly Study Time Goal</h3>
  </div>
  <div class="common-error-message" v-if="error">{{ error }}</div>
  <form-pane-goal :error="error" :goal="goal" @submit="postGoal"></form-pane-goal>
</div>
</template>

<script>
import axios from 'axios';
import FormPaneGoal from '../components/FormPaneGoal.vue';

export default {
  components: { FormPaneGoal },
  name: 'NewGoal',
  data() {
    return {
      goals: [],
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
    // todo 既にgoalを登録している場合'/record'画面へリダイレクトさせる
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    // 目標時間の登録
    postGoal() {
      this.$http.secured.post('/api/v1/goals', this.goal)
      .then(response => {
        this.goals.push(response.data)
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
</style>