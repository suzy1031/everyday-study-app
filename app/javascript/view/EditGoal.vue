<template>
  <div>
    <Header :title="title"></Header>
    <form-pane-goal :error="error" :goal="goal" @submit="updateGoal"></form-pane-goal>
    <div class="margin-top_1_half">
      <BackButton></BackButton>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import FormPaneGoal from '../components/FormPaneGoal.vue';
import Header from '../components/Header'
import BackButton from '../components/BackButton'

export default {
  components: {
    FormPaneGoal,
    Header,
    BackButton
  },
  data() {
    return {
      title: 'Edit Target Time',
      goal: {},
      error: ''
    }
  },
  created() {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get(`/api/v1/goals/${this.$route.params.id}.json`)
      .then(response => {
        this.goal = response.data
      })
      .catch(error => {
        this.setError(error, 'Something went wrong')
        delete localStorage.csrf
        delete localStorage.signedIn
        this.$router.replace('/')
        }
      );
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    updateGoal() {
      this.$http.secured.patch(`/api/v1/goals/${this.goal.id}`, this.goal)
      .then(response => {
        this.$router.replace('/setting')
      })
      .catch(error => this.setError(error, 'Can not edit'));
    }
  }
}
</script>