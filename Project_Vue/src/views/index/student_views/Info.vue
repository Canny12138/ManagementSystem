<template>
  <div class="table">
    <!-- <el-card shadow="hover" style="margin: 10px">
      <el-table
        v-loading="loading"
        :data="tableData"
        stripe
        border
        style="width: 100%"
      >
        <el-table-column prop="sno" label="学号" width="250"> </el-table-column>
        <el-table-column prop="sname" label="姓名" width="250">
        </el-table-column>
        <el-table-column prop="cno" label="班级" width="150"> </el-table-column>
        <el-table-column prop="zhuanye" label="专业" width="250">
        </el-table-column>
        <el-table-column prop="sdept" label="系部" width="288">
        </el-table-column>
      </el-table>
    </el-card> -->
    <el-card shadow="hover" style="margin: 10px">
      <h1>学生信息</h1>
      <br />
      <p>学号： {{ tableData[0].sno }}</p>
      <p>姓名： {{ tableData[0].sname }}</p>
      <p>班级： {{ tableData[0].cno }}</p>
      <p>专业： {{ tableData[0].zhuanye }}</p>
      <p>系部： {{ tableData[0].sdept }}</p>
    </el-card>
  </div>
</template>
<script>
import global from "../../Index.vue";
export default {
  data() {
    return {
      tableData: [
        {
          sname: null,
          cno: null,
          zhuanye: null,
          sdept: null,
        },
      ],
      loading: true,
      in_sno: null,
      in_sname: null,
      in_cno: null,
      httpurl: global.httpurl,
      isNum: global.isNum,
    };
  },
  methods: {
    getData() {
      this.loading = true;
      let self = this;
      this.axios
        .get(self.httpurl + "/student_view/findById/" + self.isNum)
        .then(function (res) {
          self.tableData = res.data;
          self.loading = false;
        })
        .catch(function (err) {
          console.log(err);
          self.tableData = [];
        });
    },
    handleSizeChange(val) {
      console.log(`每页 ${val} 条`);
    },
    handleCurrentChange(val) {
      console.log(`当前页: ${val}`);
    },
  },
  mounted() {
    this.getData();
  },
};
</script>