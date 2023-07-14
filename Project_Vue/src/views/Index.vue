<template>
  <div>
    <router-view />
  </div>
</template>
<script>
const httpurl = "http://10.22.124.14:8081";
var isName = null;
var isNum = null;
export default {
  httpurl,
  isName,
  isNum,  
};
</script>