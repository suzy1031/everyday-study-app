<template>
  <div>
    <Header :title="title"></Header>
    <form-pane-goal :error="error" :goal="goal" @submit="updateGoal"></form-pane-goal>
  </div>
</template>

<script>
import axios from 'axios';
import FormPaneGoal from '../components/FormPaneGoal.vue';
import Header from '../components/Header'

export default {
  components: {
    FormPaneGoal,
    Header
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