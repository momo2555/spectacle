<template>
  <router-view/>
</template>

<script>
export default {

  name: 'HomeView',
  components: {
    
  },
  mounted () {
    this.$filarmonic.onStartGame(()=>{
      this.$router.push("/monitor");
    });
    this.$filarmonic.onCloseGame(()=>{
      this.$router.push("/");
    });
  }
}
</script>

<style lang="less">

@import 'style/colors.less';
* {
  box-sizing: border-box;
}
html {
  height: 100%;
}
body {
  margin: 0;
  background-color: @primary-color;
  height: 100%;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100%;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: @secondary-color;
}
</style>
