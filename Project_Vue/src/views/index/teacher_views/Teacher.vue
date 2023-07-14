<template>
  <el-container
    style="height: 1000px; border: 1px solid #eee; background-color: #f7f7fc"
  >
    <el-aside width="250px">
      <h4
        font-size
        style="
          padding-left: 30px;
          color: rgb(255, 255, 255);
          height: 38.72px;
          margin-top: 21.28px;
          margin-bottom: 0px;
        "
      >
        教师
      </h4>
      <el-menu
        background-color="#222e3c"
        text-color="#fff"
        active-text-color="#fff"
        style="border: 0px"
        default-active="1"
      >
        <router-link to="/teacher/student">
          <el-menu-item index="1"
            ><i class="el-icon-data-line"></i>学生管理</el-menu-item
          >
        </router-link>
        <router-link to="/teacher/class">
          <el-menu-item index="2"
            ><i class="el-icon-s-operation"></i>班级管理</el-menu-item
          >
        </router-link>
        <router-link to="/teacher/course">
          <el-menu-item index="3"
            ><i class="el-icon-s-grid"></i>课程管理</el-menu-item
          >
        </router-link>
        <router-link to="/teacher/grade">
          <el-menu-item index="4">
            <template slot="title"
              ><i class="el-icon-setting"></i>成绩管理</template
            >
          </el-menu-item>
        </router-link>
        <router-link to="/teacher/system">
          <el-menu-item index="5">
            <template slot="title"
              ><i class="el-icon-info"></i>系统管理</template
            >
          </el-menu-item>
        </router-link>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header style="font-size: 12px; text-align: right">
        <el-col :span="6">
          <el-input
            size="small"
            placeholder="搜索..."
            suffix-icon="el-icon-search"
            v-model="input1"
            style="width: 400px; height: 10px"
          >
          </el-input>
        </el-col>
        <el-col :span="6" :offset="12">
          <el-dropdown>
            <i class="el-icon-setting" style="margin-right: 15px"></i>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item>让我康康</el-dropdown-item>
              <router-link to="/login">
                <el-dropdown-item> 退出登录 </el-dropdown-item>
              </router-link>
            </el-dropdown-menu>
          </el-dropdown>
          <span>{{ global.isName }}({{ global.isNum }})</span>
        </el-col>
      </el-header>
      <router-view />
    </el-container>
  </el-container>
</template>

<style>
.el-header {
  background-color: white;
  color: #333;
  line-height: 60px;
}

.el-aside {
  background-color: #222e3c;
}

.el-menu-item.is-active {
  background-color: #51e0b4 !important;
}

.el-input__inner:focus {
  border-color: teal !important;
}

a {
  text-decoration: none;
}
</style>

<script>
import global from "../../Index.vue";
export default {
  data() {
    return {
      input1: "",
      global,
    };
  },
  methods: {
    toLogin() {
      console.log(global.isNum);
      if (global.isNum == null) {
        this.$router.push({ path: "/login" });
        alert("请重新登录");
      }
    },
  },
  mounted() {
    this.toLogin();
  },
};
</script>