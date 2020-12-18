<template>
  <div>
    <Header :title="title"></Header>
    <ButtonComingSoon></ButtonComingSoon>
  </div>
</template>

<script>
import ButtonComingSoon from '../components/ButtonComingSoon';
import Header from '../components/Header';

export default {
  components: {
    ButtonComingSoon,
    Header
  },
  data() {
    return {
      title: "Last Week History"
    }
  }
}
</script>

<style>

</style>