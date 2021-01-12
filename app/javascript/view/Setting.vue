<template>
  <div>
    <Header :title="title"></Header>
    <div class="target-time-section">
      <h2>Your Target Time</h2>
      <div v-for="e in goals" :key="e.id">
        <h3 class="margin-top_1">{{ e.target_time }} Hour / Week</h3>
        <router-link :to="{ name: 'EditGoal', params: { id: e.id} }">
          <button class="button-link margin-top_1">Edit</button>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
import Header from '../components/Header'

export default {
  components: {
    Header
  },
  data() {
    return {
      title: "Settings",
      goals: []
    }
  },
  created() {
    this.$http.secured.get('/api/v1/goals')
    .then(response => {
      this.goals = response.data
    })
  }
}
</script>
<style scoped>
.target-time-section {
  width: 30em;
  height: 15em;
  border-radius: .3em;
  margin: 0 auto;
  margin-top: 4em;
  border: .15em solid #0066FF;
}
.target-time-section > h2 {
  margin-top: .8em;
}
.button-link {
  background: #0066FF;
  border: .1em solid #0066FF;
  border-radius: .3em;
  padding: .2em;
  color: white;
  font-weight: bold;
  padding: .3em .5em;
}
</style>