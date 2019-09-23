package ${package};

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

<#list imports as import>
import ${import};
</#list>

/**
 * ${comment}
 */
<#list model.fields as field>
    <#if field.id>
@Repository
public interface ${model.simpleName}Repository extends JpaRepository<${model.simpleName}, ${field.typeSimpleName}>, JpaSpecificationExecutor<${model.simpleName}> {

}
    </#if>
</#list>
