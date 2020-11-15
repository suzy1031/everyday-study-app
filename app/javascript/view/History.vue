<template>
  <div>
    <Title :title="title"></Title>
    <ButtonNotFunc></ButtonNotFunc>
  </div>
</template>

<script>
import ButtonNotFunc from '../components/ButtonNotFunc';
import Title from '../components/Title';

export default {
  components: {
    ButtonNotFunc,
    Title
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