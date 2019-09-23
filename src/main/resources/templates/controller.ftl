package ${package};
import ${parentPackage}.common.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
<#if ormType==1>
import com.github.pagehelper.PageInfo;
<#else>
import org.springframework.data.domain.Page;
</#if>
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

<#list imports as import>
import ${import};
</#list>

<#assign model=service.dao.model />
<#list model.fields as field>
    <#if field.id>
/**
 * ${comment}
 */
@RestController
@RequestMapping("/v1/${model.varName}")
@Api(tags = "${model.comment}")
@Slf4j
public class ${simpleName} {
    @Autowired
    private ${service.simpleName} ${service.varName};

    @GetMapping("/{id}")
    @ApiOperation("通过ID查询单个${model.comment}")
    public Result<?> findById(@ApiParam("ID") @PathVariable("id") ${field.typeSimpleName} id) {
        ${model.simpleName} result = ${service.varName}.findById(id);
	return Result.ok(result);
    }

    @GetMapping("/list")
    @ApiOperation("分页查询${model.comment}")
    public Result<?> findByPage(@ApiParam("页号") @RequestParam(defaultValue = "1") Integer pageNum,
                                                @ApiParam("每页大小") @RequestParam(defaultValue = "10") Integer pageSize) {
        Page<#if ormType==1>Info</#if><${model.simpleName}> result = ${service.varName}.findByPage(pageNum, pageSize);
	return Result.ok(result);
    }

    @PostMapping
    @ApiOperation("新增${model.comment}")
    public Result<?> insert(@RequestBody ${model.simpleName} ${model.varName}) {
        ${service.varName}.insert(${model.varName});
	return Result.ok("添加成功");
    }

    @PutMapping
    @ApiOperation("修改${model.comment}")
    public Result<?> update(@RequestBody ${model.simpleName} ${model.varName}) {
        ${service.varName}.update(${model.varName});
	return Result.ok("修改成功");
    }

    @DeleteMapping("/{id}")
    @ApiOperation("通过ID删除单个${model.comment}")
    public Result<?> deleteById(@ApiParam("ID") @PathVariable("id") ${field.typeSimpleName} id) {
        ${service.varName}.deleteById(id);
	return Result.ok("删除成功");
    }
}
    </#if>
</#list>
