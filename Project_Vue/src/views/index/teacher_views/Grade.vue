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
        <el-table-column prop="kno" label="课程号" width="200">
        </el-table-column>
        <el-table-column prop="kname" label="课程名" width="200">
        </el-table-column>
        <el-table-column prop="term" label="学期" width="180">
        </el-table-column>
        <el-table-column prop="sno" label="学号" width="200"> </el-table-column>
        <el-table-column prop="grade" label="成绩" width="180">
        </el-table-column>
        <el-table-column prop="update">
          <el-button>修改</el-button>
        </el-table-column>
        <el-table-column prop="delete">
          <el-popover placement="top" width="160" v-model="visible">
            <p>确定删除吗？</p>
            <div style="text-align: right; margin: 0">
              <el-button size="mini" type="text" @click="visible = false">
                取消
              </el-button>
              <el-button type="primary" size="mini" @click="visible = false">
                确定
              </el-button>
            </div>
            <el-button slot="reference">删除</el-button>
          </el-popover>
        </el-table-column>
      </el-table>
      <div
        class="block"
        @click="getData()"
        @change="getData()"
        style="margin-top: 20px"
      >
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page.sync="currentPage"
          :page-size="10"
          layout="prev, pager, next, jumper"
          :total="100"
        >
        </el-pagination>
      </div>
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
      currentPage: 1,
      loading: true,
      visible: false,
      httpurl: global.httpurl,
    };
  },
  methods: {
    getData() {
      this.loading = true;
      let self = this;
      this.axios
        .get(self.httpurl + "/grade_view/findAll/" + self.currentPage)
        .then(function (res) {
          self.tableData = res.data.content;
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