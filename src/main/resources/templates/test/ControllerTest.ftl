package ${package};

import ${package}.DomainUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.hamcrest.core.StringContains;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import lombok.extern.slf4j.Slf4j;
import java.util.Date;

<#list imports as import>
    import ${import};
</#list>

<#assign model=service.dao.model />
<#list model.fields as field>
    <#if field.id>

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@FixMethodOrder(MethodSorters.DEFAULT)
@Slf4j
public class ${model.simpleName}ControllerTest {
	@Autowired
	private MockMvc mockMvc;
	
	private ${model.simpleName} model(){
	    ${model.simpleName} model = DomainUtils.newRandomInstance(${model.simpleName}.class);
	    return model;
	}
	
	@Test
	public void create() throws Exception{
	    String json = new ObjectMapper().writeValueAsString(model());
	    mockMvc.perform(MockMvcRequestBuilders.post("/v1/${model.simpleName}")
	            .contentType(MediaType.APPLICATION_JSON).content(json)).andExpect(MockMvcResultMatchers.status().isOk())
	            .andDo(MockMvcResultHandlers.print());
	
	}
	
	@Test
	public void saveManyToOne() throws Exception{
	    ${model.simpleName} domainInstance = DomainUtils.newRandomInstance(${model.simpleName}.class,true);
	    ObjectMapper objectMapper = new ObjectMapper();
	    String json = objectMapper.writeValueAsString(domainInstance);
	    System.out.println(json);
	    mockMvc.perform(MockMvcRequestBuilders.post("/v1/${model.simpleName}")
	            .contentType(MediaType.APPLICATION_JSON).content(json)).andExpect(MockMvcResultMatchers.status().isOk())
	            .andDo(MockMvcResultHandlers.print());
	}
	
	@Test
	public void list() throws Exception{
	    mockMvc.perform(MockMvcRequestBuilders.post("/v1/${model.simpleName}/list")).andExpect(MockMvcResultMatchers.status().isOk());
	}
	
	@Test
	public void get() throws Exception{
	    mockMvc.perform(MockMvcRequestBuilders.get("/v1/${model.simpleName}/1")).andExpect(MockMvcResultMatchers.status().isOk());
	}
	
	
	@Test
	@Ignore
	public void delete() throws Exception{
	    mockMvc.perform(MockMvcRequestBuilders.delete("/v1/${model.simpleName}/1")).andExpect(MockMvcResultMatchers.status().isOk())
	            .andExpect(MockMvcResultMatchers.content().string(StringContains.containsString("Request Successful")))
	            .andDo(MockMvcResultHandlers.print());
	
	}
}
  </#if>
</#list>

