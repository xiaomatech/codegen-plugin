package ${package};

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

<#list imports as import>
    import ${import};
</#list>

/**
 * ${comment}
 */
@Data
@Entity
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@Table(name = "${tableName}")
public class ${simpleName} implements Serializable {
<#list fields as field>
    /**
     * ${field.comment}
     */
    <#if field.id>
    @Id
    </#if>
    @Column(name = "${field.columnName}")
    private ${field.typeSimpleName} ${field.name};
</#list>
}
