<template>
  <form @submit.prevent="$emit('submit')">
    <div class="login-section">
      <label for="target-time" class="form-label">Target Time</label>
      <input v-model="goal.target_time"
              id="target-time"
              class="goal-input-section"
              type="number"
              step="0.1"
              min="0.1"
              max="168"
              required="required"
              autocomplete="off"
            >
      <h3 class="goal-h3-text">Hour / Week</h3>
    </div>
    <button type="submit" class="study-time-button">register</button>
  </form>
</template>
<script>
export default {
  props: {
    goal: {},
    error: ''
  }
}
</script>
<style>
.login-section {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 2em;
  margin-bottom: 1.5em;
  height: 20em;
}
.goal-h3-text {
  color: white;
}
.goal-input-section {
  height: 1.5em;
}
</style>