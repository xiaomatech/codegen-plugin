<template>
  <a-modal
    :title="title"
    :width="800"
    :visible="visible"
    :confirmLoading="confirmLoading"
    @ok="handleOk"
    @cancel="handleCancel"
    cancelText="关闭">
    
    <a-spin :spinning="confirmLoading">
      <a-form :form="form">
      
<#list fields as field><#rt/>
<#if field.name !='id' && field.name !="createTime" && field.name != "createBy" && field.name !="updateTime" && field.name != "updateBy" ><#rt/>
        <a-form-item
          :labelCol="labelCol"
          :wrapperCol="wrapperCol"
          label="${field.comment}">
          <#if field.typeName =='date'>
          <a-date-picker v-decorator="[ '${field.name}', {}]" />
          <#elseif field.typeName =='datetime'>
          <a-date-picker showTime format='YYYY-MM-DD HH:mm:ss' v-decorator="[ '${field.name}', {}]" />
          <#elseif "int,decimal,double,"?contains(field.typeName)>
          <a-input-number v-decorator="[ '${field.name}', {}]" />
          <#else>
          <a-input placeholder="请输入${field.comment}" v-decorator="['${field.name}', {}]" />
          </#if>
        </a-form-item>
</#if>
</#list>
		
      </a-form>
    </a-spin>
  </a-modal>
</template>

<script>
  import { httpAction } from '@/api/manage'
  import pick from 'lodash.pick'
  import moment from "moment"

  export default {
    name: "${simpleName}Modal",
    data () {
      return {
        title:"操作",
        visible: false,
        model: {},
        labelCol: {
          xs: { span: 24 },
          sm: { span: 5 },
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 16 },
        },

        confirmLoading: false,
        form: this.$form.createForm(this),
        validatorRules:{
        <#list fields as field>
        <#if field.name !='id'>
        ${field.name}:{rules: [{ required: true, message: '请输入${field.comment}!' }]},
        </#if>
	</#list>
        },
        url: {
          add: "/v1/${simpleName?uncap_first}/add",
          edit: "/v1/${simpleName?uncap_first}/edit",
        },
      }
    },
    created () {
    },
    methods: {
      add () {
        this.edit({});
      },
      edit (record) {
        this.form.resetFields();
        this.model = Object.assign({}, record);
        this.visible = true;
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model<#list fields as field><#if field.name !='id' && field.typeName?index_of("date")==-1 && field.name !="createTime" && field.name != "createBy" && field.name !="updateTime" && field.name != "updateBy" >,'${field.name}'</#if></#list>))
	  //时间格式化
          <#list fields as field>
          <#if field.name !='id' && field.typeName?index_of("date")!=-1 && !"createTime,updateTime"?contains(field.name)>
          this.form.setFieldsValue({${field.name}:this.model.${field.name}?moment(this.model.${field.name}):null})
          </#if>
          </#list>
        });

      },
      close () {
        this.$emit('close');
        this.visible = false;
      },
      handleOk () {
        const that = this;
        // 触发表单验证
        this.form.validateFields((err, values) => {
          if (!err) {
            that.confirmLoading = true;
            let httpurl = '';
            let method = '';
            if(!this.model.id){
              httpurl+=this.url.add;
              method = 'post';
            }else{
              httpurl+=this.url.edit;
               method = 'put';
            }
            let formData = Object.assign(this.model, values);
            //时间格式化
            <#list fields as field>
            <#if field.name !='id' && field.typeName =='date'>
            formData.${field.name} = formData.${field.name}?formData.${field.name}.format():null;
            <#elseif field.name !='id' && field.typeName =='datetime' && !"createTime,updateTime"?contains(field.name) >
            formData.${field.name} = formData.${field.name}?formData.${field.name}.format('YYYY-MM-DD HH:mm:ss'):null;
            </#if>
            </#list>
            
            console.log(formData)
            httpAction(httpurl,formData,method).then((res)=>{
              if(res.success){
                that.$message.success(res.message);
                that.$emit('ok');
              }else{
                that.$message.warning(res.message);
              }
            }).finally(() => {
              that.confirmLoading = false;
              that.close();
            })
          }
        })
      },
      handleCancel () {
        this.close()
      },
    }
  }
</script>

<style lang="less" scoped>

</style>
