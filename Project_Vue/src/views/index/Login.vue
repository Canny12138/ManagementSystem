<template>
  <div>
    <!--flex弹性盒子模型，justify-content：主抽 -->
    <div style="display: flex; justify-content: center; margin-top: 150px">
      <el-card style="width: 400px">
        <div slot="header" class="clearfix">
          <span>登录</span>
        </div>
        <table>
          <tr>
            <td>用户名</td>
            <td>
              <el-input
                v-model="user.num"
                placeholder="请输入用户名"
              ></el-input>
            </td>
          </tr>
          <tr>
            <td>密码</td>
            <td>
              <el-input
                type="password"
                v-model="user.password"
                placeholder="请输入密码"
                @keydown.enter.native="doLogin"
              ></el-input>
              <!-- @keydown.enter.native="doLogin"当按下enter键的时候也会执行doLogin方法-->
            </td>
          </tr>
          <tr>
            <!-- 占两行-->
            <td colspan="2">
              <!-- 点击事件的两种不同的写法v-on:click和 @click-->
              <!--<el-button style="width: 300px" type="primary" v-on:click="doLogin">登录</el-button>-->
              <el-button style="width: 300px" type="primary" @click="doLogin">
                登录
              </el-button>
            </td>
          </tr>
        </table>
      </el-card>
    </div>
  </div>
</template>
<script>
import global from "../Index.vue";
export default {
  data() {
    return {
      user: {
        num: "20002",
        password: "20002",
      },
      httpurl: global.httpurl,
    };
  },
  methods: {
    toTeacher() {
      this.$router.push({ path: "/teacher/student" });
      alert("登录成功！");
    },
    toStudnet() {
      this.$router.push({ path: "/student/info" });
      alert("登录成功！");
    },
    doLogin() {
      let self = this;
      axios({
        // header: {
        //   "Content-Type": "applicationx/json", //如果写成contentType会报错,如果不写这条也报错
        // },
        url: self.httpurl + "/power/login",
        method: "post",
        data: this.user,
        //     transformRequest: [function(data) {
        //     data = JSON.stringify(data)
        //      return data
        // }
      }).then(function (res) {
        if (res.data[0].type == "教师") {
          console.log("is 教师");
          global.isName = res.data[0].name;
          global.isNum = res.data[0].num;
          self.toTeacher();
        } else if (res.data[0].type == "学生") {
          console.log("is 学生");
          global.isName = res.data[0].name;
          global.isNum = res.data[0].num;
          self.toStudnet();
        } else {
          alert("登录失败！");
        }
      });
    },
  },
};
</script>