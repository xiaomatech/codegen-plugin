package ${package}.impl;

import ${package}.DomainUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Assert;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

<#list imports as import>
    import ${import};
</#list>

import lombok.extern.slf4j.Slf4j;

<#assign model=dao.model />
<#list model.fields as field>
    <#if field.id>

@RunWith(SpringRunner.class)
@SpringBootTest
@FixMethodOrder(MethodSorters.DEFAULT)
@Slf4j
public class ${model.simpleName}ServiceTest {

	@Autowired
	private ${model.simpleName}Service ${model.varName}Service;	
	
	public ${model.simpleName} model(){
	    return DomainUtils.newRandomInstance(${model.simpleName}.class);
	}
	
	@Test
	public void saveManyToOne() {
	    try{
		    ${model.simpleName} domainInstance = DomainUtils.newRandomInstance(${model.simpleName}.class,true);
		    ObjectMapper objectMapper = new ObjectMapper();
		    String json = objectMapper.writeValueAsString(domainInstance);
		    System.out.println(json);
		    ${model.varName}Service.insert(domainInstance);
	    }catch(Exception e){

	    }
	}

	@Test
        public void findById() {
            Assert.assertNotNull(${model.varName}Service.findById(1));
        }
}

  </#if>
</#list>

