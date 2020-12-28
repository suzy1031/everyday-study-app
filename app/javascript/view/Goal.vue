<template>
<div>
  <div class="title-position">
    <h1>Goal</h1>
  </div>
  <div class="goal-header-position">
    <h3>Please Set Weekly Study Time Goal</h3>
  </div>
  <!-- todo エラーメッセージ表示 -->
  <!-- todo formにする -->
  <div class="login-section">
    <label for="target-time" class="form-label">Target Time</label>
    <!-- todo required="required" autocomplete="off"の設定をする -->
    <!-- todo v-model="target-model"の設定をする -->
    <input id="target-time" class="goal-input-section" type="target-time">
    <h3 class="goal-h3-text">Hour / per-week</h3>
  </div>
  <button type="submit" class="study-time-button">register</button>
  <!-- todo formここまで -->
</div>
</template>

<script>
export default {
  name: 'Goal',
  data() {
    return {

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