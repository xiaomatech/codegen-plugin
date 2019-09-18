package ${package};

<#if ormType==1>
import org.mybatis.spring.annotation.MapperScan;
</#if>
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
@EnableConfigurationProperties
<#if ormType==1>
@MapperScan("${package}.entity")
</#if>
@EnableJpaRepositories("${package}.repository")
@Slf4j
@EnableTransactionManagement
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
