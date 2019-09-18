<template>
  <div class="app-container calendar-list-container">
    <div class="filter-container">
      <el-input @keyup.enter.native="handleFilter" style="width: 200px;" class="filter-item" placeholder="内容" v-model="listQuery.name"> </el-input>
      <el-button class="filter-item" type="primary" v-waves icon="el-icon-search" @click="handleFilter">搜索</el-button>
      <el-button class="filter-item" v-if="${simpleName}Manager_btn_add" style="margin-left: 10px;" @click="handleCreate" type="primary" icon="el-icon-plus">添加</el-button>
    </div>
    <el-table :key='tableKey' :data="list" v-loading.body="listLoading" border fit highlight-current-row style="width: 100%">

<#list fields as field>
<#if field.id>
    <el-table-column align="center" label="${field.columnName}" width="65">
       <template scope="scope">
         <span>{{scope.row.${field.name}}}</span>
       </template>
    </el-table-column>
<#else>
    <el-table-column width="200px" align="center" label="${field.comment}">
      <template scope="scope">
        <span>{{scope.row.${field.name}}}</span>
      </template>
    </el-table-column>
</#if>

</#list>
      <el-table-column fixed="right" align="center" label="操作" width="150"> <template scope="scope">
        <el-button v-if="${simpleName}Manager_btn_edit" size="small" type="success" @click="handleUpdate(scope.row)">编辑
        </el-button>
        <el-button v-if="${simpleName}Manager_btn_del" size="small" type="danger" @click="handleDelete(scope.row)">删除
        </el-button>
      </template> </el-table-column>
    </el-table>
    <div v-show="!listLoading" class="pagination-container">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page.sync="listQuery.page" :page-sizes="[10,20,30, 50]" :page-size="listQuery.limit" layout="total, sizes, prev, pager, next, jumper" :total="total"> </el-pagination>
    </div>
    <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
      <el-form :model="form" :rules="rules" ref="form" label-width="100px">

<#list fields as field>
<#if field.id>
<#else>
    <el-form-item label="${field.comment}" prop="${field.name}">
      <el-input v-model="form.${field.name}" placeholder="请输入${field.comment}"></el-input>
    </el-form-item>
</#if>
</#list>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel('form')">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="primary" @click="create('form')">确 定</el-button>
        <el-button v-else type="primary" @click="update('form')">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  const axios = require('axios');

  function page(query) {
	return axios({
		url: '/v1/${simpleName}/list',
		method: 'get',
		data: query
	});
  }

  function addObj(obj) {
	return axios({
		url: '/v1/${simpleName}',
		method: 'post',
		data: obj
	});
  }

  function getObj(id) {
	return axios({
		url: '/v1/${simpleName}/' + id,
		method: 'get'
	})
  }

  function delObj(id) {
	return axios({
		url: '/v1/${simpleName}/' + id,
		method: 'delete'
	})
  }
  function putObj(obj) {
	return axios({
		url: '/v1/${simpleName}',
		method: 'put',
		data: obj
	})
  }

  import { mapGetters } from 'vuex';
  export default {
    name: '${simpleName}',
    data() {
      return {
        list: null,
        total: null,
        listLoading: true,
        listQuery: {
          page: 1,
          limit: 20,
          name: undefined
        },
        dialogFormVisible: false,
        dialogStatus: '',
        ${simpleName}Manager_btn_edit: false,
        ${simpleName}Manager_btn_del: false,
        ${simpleName}Manager_btn_add: false,
        textMap: {
          update: '编辑',
          create: '创建'
        },
        tableKey: 0
      }
    },
    created() {
      this.getList();
      this.${simpleName}Manager_btn_edit = this.elements['${simpleName}Manager:btn_edit'];
      this.${simpleName}Manager_btn_del = this.elements['${simpleName}Manager:btn_del'];
      this.${simpleName}Manager_btn_add = this.elements['${simpleName}Manager:btn_add'];
    },
    computed: {
      ...mapGetters([
        'elements'
      ])
    },
    methods: {
      getList() {
        this.listLoading = true;
        page(this.listQuery)
            .then(response => {
          this.list = response.data.rows;
        this.total = response.data.total;
        this.listLoading = false;
      })
      },
      handleFilter() {
        this.getList();
      },
      handleSizeChange(val) {
        this.listQuery.limit = val;
        this.getList();
      },
      handleCurrentChange(val) {
        this.listQuery.page = val;
        this.getList();
      },
      handleCreate() {
        this.resetTemp();
        this.dialogStatus = 'create';
        this.dialogFormVisible = true;
      },
      handleUpdate(row) {
        getObj(row.id)
            .then(response => {
          this.form = response.data;
        this.dialogFormVisible = true;
        this.dialogStatus = 'update';
      });
      },
      handleDelete(row) {
        this.$confirm('此操作将永久删除, 是否继续?', '提示', {
              confirmButtonText: '确定',
              cancelButtonText: '取消',
              type: 'warning'
            })
            .then(() => {
          delObj(row.id)
      .then(() => {
          this.$notify({
          title: '成功',
          message: '删除成功',
          type: 'success',
          duration: 2000
        });
        const index = this.list.indexOf(row);
        this.list.splice(index, 1);
      });
      });
      },
      create(formName) {
        const set = this.$refs;
        set[formName].validate(valid => {
        if (valid) {
        addObj(this.form)
        .then(() => {
        this.dialogFormVisible = false;
        this.getList();
        this.$notify({
        title: '成功',
        message: '创建成功',
        type: 'success',
        duration: 2000
        });
        })
        } else {
        return false;
        }
        });
      },
      cancel(formName) {
        this.dialogFormVisible = false;
        const set = this.$refs;
        set[formName].resetFields();
      },
      update(formName) {
        const set = this.$refs;
        set[formName].validate(valid => {
        if (valid) {
        this.dialogFormVisible = false;
        this.form.password = undefined;
        putObj(this.form).then(() => {
        this.dialogFormVisible = false;
        this.getList();
        this.$notify({
        title: '成功',
        message: '创建成功',
        type: 'success',
        duration: 2000
        });
        });
        } else {
        return false;
        }
        });
      },
      resetTemp() {
        this.form = {
          username: undefined,
          name: undefined,
          sex: '男',
          password: undefined,
          description: undefined
        };
      }
    }
  }
</script>
