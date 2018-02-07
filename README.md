### jfinal-admin 后台框架 
基于JFinal的后台管理系统，采用了简洁强大的JFinal作为web框架，模板引擎用的是beetl，数据库用mysql，前端bootstrap框架。

- 演示地址 http://jad.yxyun.win/jadmin
- 密码 123456

### 特性
1. 内置用户和权限系统
2. mysql、oracle等多数据库支持
3. 支持引入第三方前端库
4. 基于jfinal_cms深度精简
5. 集成spring(可选)
6. 菜单权限、功能权限双重保障

### 部署重要说明
需要jdk7及以上环境支撑，需要maven最好用idea部署，系统默认密码123456


### 最新更新
- 1.菜单栏xss漏洞修复
- 2.废弃dubbo注解的方式集成spring，提供spring集成开关配置默认关闭
- 3.角色授权bug修复
- 4.合并任务调度（QuickJob [QuickJob ](https://gitee.com/supyuan/QuickJob)）
- 5.新增 XSS 脚本处理功能，示例 : ${nameHtml,xss}
- 6.修复个别情况下，当前页数大于总页数时，分页的 bug
- 7.权限控制精准到功能按钮
- 8.全新登录界面

### 更新日志
![输入图片说明](https://gitee.com/uploads/images/2017/1215/094356_924f59cf_22738.png "1.png")
![输入图片说明](https://gitee.com/uploads/images/2017/1215/094408_27becaa2_22738.png "2.png")
![输入图片说明](https://gitee.com/uploads/images/2017/1215/094417_2dcf7299_22738.png "3.png")
![](https://git.oschina.net/uploads/images/2017/0516/223055_56ede065_22738.png "在这里输入图片标题")


### 其他
jfinal_cms深度精简，不再依赖jflyfox_base，jflyfox_jfinal。

### 代码质量分析
![输入图片说明](https://gitee.com/uploads/images/2017/1103/105801_c6f199f4_22738.png "fx3.png")

### 界面预览
![输入图片说明](https://gitee.com/uploads/images/2017/1103/110136_c846750a_22738.png "2017-11-03_110222.png")

### 配置说明
- 数据库连接配置 修改pom.xml
```
<profiles>

        <profile>

            <id>develop</id>

            <activation>

                <activeByDefault>true</activeByDefault>

            </activation>

            <properties>

                <jdbc-url>
                    <![CDATA[jdbc:mysql://127.0.0.1:3306/jfinal_job?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull]]></jdbc-url>

                <jdbc-username>root</jdbc-username>

                <jdbc-password>123456</jdbc-password>

            </properties>

        </profile>

    </profiles>
```
- 登录系统账号 admin/123456
- spring使用
第一步 CONSTANTS.SPRING=false 开启
第二步 继承 BaseProjectController 调用 getClassBeanByName("classname") 即可获取spring管理的bean对象


### 鸣谢
- [JFinal](http://www.oschina.net/p/jfinal)

- [beetl](http://ibeetl.com/)

- [flyfox](http://git.oschina.net/flyfox)

### 关于作者
- IT小香猪(qq:454979901)
