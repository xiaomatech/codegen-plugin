<template>
  <a-card :bordered="false">

    <!-- 查询区域 -->
    <div class="table-page-search-wrapper">
      <a-form layout="inline">
        <a-row :gutter="24">

<#list fields as field>
<#if field.name !='id' && field_index<= 1>
          <a-col :md="6" :sm="8">
            <a-form-item label="${field.comment}">
              <a-input placeholder="请输入${field.comment}" v-model="queryParam.${field.name}"></a-input>
            </a-form-item>
          </a-col>
<#elseif field_index == 2>
        <template v-if="toggleSearchStatus">
        <a-col :md="6" :sm="8">
            <a-form-item label="${field.comment}">
              <a-input placeholder="请输入${field.comment}" v-model="queryParam.${field.name}"></a-input>
            </a-form-item>
          </a-col>
<#elseif field.name !='id' && field_index< 5>
          <a-col :md="6" :sm="8">
            <a-form-item label="${field.comment}">
              <a-input placeholder="请输入${field.comment}" v-model="queryParam.${field.name}"></a-input>
            </a-form-item>
<#else>
</#if>
</#list>
        </template>
          <a-col :md="6" :sm="8" >
            <span style="float: left;overflow: hidden;" class="table-page-search-submitButtons">
              <a-button type="primary" @click="searchQuery" icon="search">查询</a-button>
              <a-button type="primary" @click="searchReset" icon="reload" style="margin-left: 8px">重置</a-button>
              <a @click="handleToggleSearch" style="margin-left: 8px">
                {{ toggleSearchStatus ? '收起' : '展开' }}
                <a-icon  type="toggleSearchStatus ? 'up' : 'down'"/>
              </a>
            </span>
          </a-col>

        </a-row>
      </a-form>
    </div>

    <!-- 操作按钮区域 -->
    <div class="table-operator">
      <a-button @click="handleAdd" type="primary" icon="plus">新增</a-button>
      <a-button type="primary" icon="download" @click="handleExportXls('${tableName}')">导出</a-button>
      <a-upload name="file" :showUploadList="false" :multiple="false" :headers="tokenHeader" :action="importExcelUrl" @change="handleImportExcel">
        <a-button type="primary" icon="import">导入</a-button>
      </a-upload>
      <a-dropdown v-if="selectedRowKeys.length > 0">
        <a-menu slot="overlay">
          <a-menu-item key="1" @click="batchDel"><a-icon type="delete"/>删除</a-menu-item>
        </a-menu>
        <a-button style="margin-left: 8px"> 批量操作 <a-icon type="down" /></a-button>
      </a-dropdown>
    </div>

    <!-- table区域-begin -->
    <div>
      <div class="ant-alert ant-alert-info" style="margin-bottom: 16px;">
        <i class="anticon anticon-info-circle ant-alert-icon"></i> 已选择 <a style="font-weight: 600">{{ selectedRowKeys.length }}</a>项
        <a style="margin-left: 24px" @click="onClearSelected">清空</a>
      </div>

      <a-table
        ref="table"
        size="middle"
        bordered
        rowKey="id"
        :columns="columns"
        :dataSource="dataSource"
        :pagination="ipagination"
        :loading="loading"
        :rowSelection="{selectedRowKeys: selectedRowKeys, onChange: onSelectChange}"
        @change="handleTableChange">

        <span slot="action" slot-scope="text, record">
          <a @click="handleEdit(record)">编辑</a>

          <a-divider type="vertical" />
          <a-dropdown>
            <a class="ant-dropdown-link">更多 <a-icon type="down" /></a>
            <a-menu slot="overlay">
              <a-menu-item>
                <a-popconfirm title="确定删除吗?" @confirm="handleDelete(record.id)">
                  <a>删除</a>
                </a-popconfirm>
              </a-menu-item>
            </a-menu>
          </a-dropdown>
        </span>

      </a-table>
    </div>
    <!-- table区域-end -->

    <!-- 表单区域 -->
    <${simpleName?uncap_first}-modal ref="modalForm" @ok="modalFormOk"></${simpleName?uncap_first}-modal>
  </a-card>
</template>

<script>
  import ${simpleName}Modal from './modules/${simpleName}Modal'
  import { JantdListMixin } from '@/mixins/JantdListMixin'

  export default {
    name: "${simpleName}List",
    mixins:[JantdListMixin],
    components: {
      ${simpleName}Modal
    },
    data () {
      return {
        description: '${tableName}管理页面',
        // 表头
        columns: [
          {
            title: '#',
            dataIndex: '',
            key:'rowIndex',
            width:60,
            align:"center",
            customRender:function (t,r,index) {
              return parseInt(index)+1;
            }
           },
          <#list fields as field>
           <#if field.name !='id' && field.name !="createTime" && field.name != "createBy" && field.name !="updateTime" && field.name != "updateBy">
		   {
            title: '${field.comment}',
            align:"center",
            dataIndex: '${field.name}'
           },
	   </#if>
	  </#list>
          {
            title: '操作',
            dataIndex: 'action',
            align:"center",
            scopedSlots: { customRender: 'action' },
          }
        ],
		url: {
          list: "/v1/${simpleName?uncap_first}/list",
          delete: "/v1/${simpleName?uncap_first}/delete",
          deleteBatch: "/v1/${simpleName?uncap_first}/deleteBatch",
       },
    }
  },
  computed: {
    importExcelUrl: function(){
      <#noparse>return `${window._CONFIG['domianURL']}/${this.url.importExcelUrl}`;</#noparse>
    }
  },
    methods: {
     
    }
  }
</script>
<style scoped>
  @import '~@assets/less/common.less'
</style>
