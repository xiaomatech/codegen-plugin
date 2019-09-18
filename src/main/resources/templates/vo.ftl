package ${package}.vo;

import javax.persistence.Column;
import javax.persistence.Id;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.io.Serializable;

<#list imports as import>
    import ${import};
</#list>

/**
 * ${comment}
 *
 */
@Data
@ApiModel(value="${comment}参数", description = "${comment}参数描述")
public class ${simpleName}Vo implements Serializable{

    private static final long serialVersionUID = 1L;

<#list fields as field>
    /**
     * ${field.comment}
     */
    <#if field.id>
    @Id
    </#if>
    <#if field.typeSimpleName == "Date">
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    </#if>
    @ApiModelProperty(value="字段描述:${field.comment}")
    @Column(name = "${field.columnName}")
    private ${field.typeSimpleName} ${field.name};

</#list>
	
}
