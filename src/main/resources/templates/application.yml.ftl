spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    driver-class-name: com.mysql.jdbc.Driver
    url: jdbc:mysql://${conn.host}:${conn.port?c}/${db}?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull&useSSL=false&serverTimezone=GMT%2B8
    username: ${conn.username}
    password: ${conn.password}
    hikari:
      minimum-idle: 5
      maximum-pool-size: 100
      idle-timeout: 30000
      validation-timeout: 250
      max-lifetime: 1800000
      connection-timeout: 30000
      connection-test-query: SELECT 1
  jackson:
    date-format: yyyy-MM-dd HH:mm:ss
    time-zone: GMT+8

  jpa:
    generate-ddl: true
    show-sql: true
    database: mysql
#    properties.hibernate.dialect: org.hibernate.dialect.MySQL8Dialect
#    database-platform: org.hibernate.dialect.MySQL8Dialect
#  session:
#    store-type: REDIS
#  redis:
#    database: 0
#    host: 127.0.0.1
#    port: 6379
#    password:
#    pool:
#      max-active: 10
#      max-wait: -1
#      max-idle: 8
#      min-idle: 0
#    timeout: 0
## Elasticsearch
#  data:
#    elasticsearch:
#      cluster-nodes: 127.0.0.1:9300
#      # 未使用到ES 关闭其持久化存储
#      repositories:
#        enabled: false
#  # 定时任务
#  quartz:
#    # 任务信息存储至数据库
#    job-store-type: jdbc
#    properties:
#      org:
#        quartz:
#          jobStore:
#            misfireThreshold: 100
#  # 文件大小上传配置
#  servlet:
#    multipart:
#      max-file-size: 5MB
#      max-request-size: 5MB

#spring:
#   activiti:
#      #启用activiti的身份关系
#      check-process-definitions: true
#      #保存所有的历史信息
#      history-level: full
#      #数据库自动建表，在启动后改为false
#      database-schema-update: true
#      #启用activiti的身份关系
#      check-process-definitions: true
#      #bpmn文件所在位置
#      process-definition-location-prefix: classpath:/processes/


<#if ormType==1>
mybatis:
  mapper-locations: classpath:/mapper/**/*.xml
</#if>
