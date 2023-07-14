<template>
  <div class="table">
    <el-card shadow="hover">
      <el-table
        v-loading="loading"
        :data="tableData"
        stripe
        border
        style="width: 100%"
      >
        <el-table-column prop="kno" label="课程号" width="280">
        </el-table-column>
        <el-table-column prop="kname" label="课程名" width="280">
        </el-table-column>
        <el-table-column prop="term" label="学期" width="150">
        </el-table-column>
        <el-table-column prop="sno" label="学号" width="250"> </el-table-column>
        <el-table-column prop="grade" label="成绩" width="249">
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>
<script>
import global from "../../Index.vue";
export default {
  data() {
    return {
      tableData: [],
      pageNo: 1,
      loading: true,
      httpurl: global.httpurl,
    };
  },
  methods: {
    getData() {
      this.loading = true;
      let self = this;
      this.axios
        .get(self.httpurl + "/grade_view/findById/" + global.isNum)
        .then(function (res) {
          self.tableData = res.data;
          self.loading = false;
        })
        .catch(function (err) {
          console.log(err);
          self.tableData = [];
        });
      console.log("ok");
    },
  },
  mounted() {
    this.getData();
  },
};
</script>