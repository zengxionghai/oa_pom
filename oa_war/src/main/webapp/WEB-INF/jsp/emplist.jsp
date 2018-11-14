<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/1
  Time: 18:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html >
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css"
          media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css"
          media="screen"/>
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css"
          media="screen"/>

    <!--                       Javascripts                       -->
    <!-- jQuery -->
    <script type="text/javascript"
            src="resources/scripts/jquery-1.8.3.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>

    <!-- dialog弹出框的导入 -->
    <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css"/>
    <script type="text/javascript" src="resources/widget/dialog/jquery-ui-1.9.2.custom.min.js"></script>
    <script type="text/javascript" src="resources/js/plugin.js"></script>

    <!-- 时间日期插件 -->
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/widget/My97DatePicker/WdatePicker.js"></script>

    <!-- Ztree树形结构 -->
    <link rel="stylesheet" href="resources/widget/zTree/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="resources/widget/zTree/jquery.ztree.all.min.js"></script>

    <!-- 图片上传插件 -->
    <link rel="stylesheet" href="resources/widget/webuploader/webuploader.css"/>
    <script type="text/javascript" src="resources/widget/webuploader/webuploader.min.js"></script>


    <style>
        .time-input {
            padding: 6px;
            font-size: 13px;
            border: 1px solid #d5d5d5;
            color: #333;
        }
    </style>

    <script type="text/javascript">
        /**
         * 显示父部门的树形机构
         */
        function showDepsTree() {
            $.get("dep/listAjax", function (data) {
                //生成Ztree
                createZtree("ztree_div", data, {
                    name: "dname",
                    pid: "pid",
                    icon: false,
                    expand: true,
                    onclick: function (event, treeId, treeNode) {
                        //将选中的父部门名称设置给button按钮
                        $("#btn_id").html(treeNode.dname);
                        $("#pid_id").val(treeNode.id);
                        // 关闭弹窗
                        closeDialog("tree_dialog");
                    }
                }, $("#pid_id").val())

                //弹出dialog
                openDialog("tree_dialog", "选择部门", 300, 300);
            }, "json");
        }

    </script>


</head>
<body>
<div id="main-content">
    <div class="content-box">
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <div class="tab-content default-tab" id="tab1">
                <table>
                    <thead>
                    <tr>
                        <th><input class="check-all" type="checkbox"/></th>
                        <th>编号</th>
                        <th>头像</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>出生日期</th>
                        <th>所属部门</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${emps}" var="emp">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${emp.id}</td>
                            <c:if test="${emp.image == null || emp.image == ''}">
                                <td><img width="50" height="50" src="resources/images/icons/header.jpg"></td>
                            </c:if>
                            <c:if test="${emp.image != null && emp.image != ''}">
                                <td><img width="50" height="50" src="img/getImg?path=${emp.image}"></td>
                            </c:if>
                            <td>${emp.name}</td>
                            <td>${emp.sex eq 1?"男":"女"}</td>
                            <td>${emp.email}</td>
                            <td><fmt:formatDate value="${emp.birthday}" pattern="yyyy-MM-dd"/></td>
                            <td>${emp.dname eq null?"无":emp.dname}</td>
                            <td>
                                <!-- Icons -->
                                <shiro:hasPermission name="/emp/saveorupdate">
                                    <a href="javascript:updateEmp(${emp.id},'${emp.image}','${emp.name}','${emp.password}',
                                ${emp.sex},${emp.did},'${emp.dname}','${emp.email}','${emp.birthday}')" title="Edit">
                                        <img src="resources/images/icons/pencil.png" alt="Edit"/>
                                    </a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/emp/delete">
                                    <a href="emp/delete/${emp.id}" title="Delete">
                                        <img src="resources/images/icons/cross.png" alt="Delete"/>
                                    </a>
                                </shiro:hasPermission>

                                <!-- 选择员工角色 -->
                                <shiro:hasPermission name="/emp/saveorupdate">
                                    <a href="javascript:updateRole(${emp.id})" title="Edit Meta">
                                        <img src="resources/images/icons/hammer_screwdriver.png" alt="Edit Meta"/>
                                    </a>
                                </shiro:hasPermission>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <shiro:hasPermission name="/emp/saveorupdate">
                                <div class="bulk-actions align-left">
                                    <a class="mybutton" href="javascript:addEmp()">添加员工</a>
                                </div>
                            </shiro:hasPermission>

                            <%-- 分页导航 --%>
                            <%@include file="page.jsp" %>
                            <div class="clear"></div>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <!-- End .content-box-content -->
    </div>
</div>
<!-- End #main-content -->

<script type="text/javascript">

    /**
     * 添加角色(方案一)
     *
     * 1.ajax -> 角色信息
     * 2.ajax ->eid ->该职工拥有的角色
     * 3.找到对应的checkbox，设置为checked
     */
    /*function updateRole(eid) {
        // 设置添加角色的员工id
        $("#eid_id").val(eid);

        //查询所有角色信息（ajax）
        $.get("/role/listAjax", function (data) {
            // 将角色的信息填充到弹出框中
            var html = "";
            for (var i = 0; i < data.length; i++) {
                html += "<input type='checkbox' name='rid' value='" + data[i].id + "'/>" + data[i].rolename + "<br/>";
            }
            $("#role_id").html(html);

            // 通过ajax查询当前职工所选择的角色
            $.get("/emp/queryrole", {eid: eid}, function (data) {
                // 当前职工所拥有的角色
                for (var i = 0; i < data.length; i++) {
                    $("input[type='checkbox'][name='rid'][value='" + data[i].id + "']").attr("checked", "checked")
                }
            }, "json")
            // 弹出框
            openDialog("role_dialog", "角色添加", 240, 220);
        }, "json")
    }*/

    /**
     * 添加角色(方案二)
     *
     * 1.ajax -> eid -> 所有角色信息（check）
     * 2.生成checkbox
     */
    function updateRole(eid) {
        // 设置添加角色的员工id
        $("#eid_id").val(eid);

        //查询所有角色信息（ajax）
        $.get("/role/listAjax2", {eid: eid}, function (data) {
            // 将角色的信息填充到弹出框中
            var html = "";
            for (var i = 0; i < data.length; i++) {
                if (data[i].checked) {
                    html += "<input type='checkbox' name='rid' value='" + data[i].id + "' checked/>"
                        + data[i].rolename + "<br/>";
                } else {
                    html += "<input type='checkbox' name='rid' value='" + data[i].id + "'/>"
                        + data[i].rolename + "<br/>";
                }
            }
            $("#role_id").html(html);

            // 弹出框
            openDialog("role_dialog", "角色添加", 240, 220);
        }, "json")
    }

    /**
     *添加员工
     */
    function addEmp() {
        // 清空表单
        $("#eid").val("");

        $("#header_id").attr("src", "resources/images/icons/header.jpg");
        $("#img_id").val("");

        $("#name_id").val("");

        $("#password_id").val("");

        $("input[type='radio'][value='1']").attr("checked", "checked");

        $("#email_id").val("");

        $("#birthday_id").val("");


        $("#btn_id").html("无");
        $("#pid_id").val("-1");

        openDialog('dep_dialog', '员工添加');
    }

    /**
     * 修改员工
     */
    function updateEmp(eid, image, name, password, sex, did, dname, email, birthday) {
        // 获得需要修改的员工所有信息
        // alert(eid + "/" + image + "/" + name + "/" + password + "/" + sex + "/" + did + "/" + email + "/" + birthday);

        // 填充到dialog的表单上
        $("#eid").val(eid);

        // 填充头像
        if (image != null && image != "") {
            $("#header_id").attr("src", "img/getImg?path=" + image);
            $("#img_id").val(image);
        }
        $("#name_id").val(name);
        $("#password_id").val(password);
        $("input[type='radio'][value='" + sex + "']").attr("checked", "checked");
        $("#email_id").val(email);

        // 填充出生日期
        var date = new Date(birthday);
        var dateStr = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
        $("#birthday_id").val(dateStr);

        //填充部门
        $("#btn_id").html(dname);
        $("#pid_id").val(did);

        // 弹出dialog
        openDialog('dep_dialog', '员工修改');
    }
</script>

<!-- 弹出框-->
<div id="dep_dialog" style="display: none">
    <form action="${pageContext.request.contextPath}/emp/saveorupdate" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <input type="hidden" id="eid" name="id" value=""/>
            <p>
                <label>头像</label>
                <input type="hidden" name="image" id="img_id" value=""/>
                <img id="header_id" width="120" height="120" src="resources/images/icons/header.jpg">
            <div id="filePicker">选择头像</div>
            </p>
            <p>
                <label>姓名</label>
                <input class="text-input input" type="text" id="name_id" name="name"/>
            </p>
            <p>
                <label>密码</label>
                <input class="text-input input" type="password" id="password_id" name="password"/>
            </p>
            <p>
                <label>性别</label>
                <input type="radio" name="sex" value="1" checked/>男
                <input type="radio" name="sex" value="0"/>女
            </p>
            <p>
                <label>所属部门</label>
                <button id="btn_id" class="mybutton" type="button" onclick="showDepsTree()">无</button>
                <input id="pid_id" name="did" type="hidden" value="-1">
            </p>
            <p>
                <label>邮箱</label>
                <input class="text-input input" type="text" id="email_id" name="email"/>
            </p>
            <p>
                <label>出生日期</label>
                <input class="Wdate time-input" type="text" id="birthday_id"
                       name="birthday" onclick="WdatePicker()"/>
            </p>
            <p>
                <input class="mybutton" type="submit" value="提交"/>
            </p>
        </fieldset>
        <div class="clear"></div>
        <!-- End .clear -->
    </form>
</div>

<!-- 树形弹出框 -->
<div id="tree_dialog" style="display: none">
    <div id="ztree_div" class="ztree"></div>
</div>

<div id="role_dialog" style="display: none">
    <form action="emp/updaterole" method="post">
        <input type="hidden" name="eid" id="eid_id" value=""/>
        <!-- 显示角色信息 -->
        <div id="role_id"></div>

        <button type="submit" class="mybutton">提交</button>
    </form>
</div>

<!-- 头像上传 -->
<script type="text/javascript">
    // 初始化Web Uploader
    var uploader = WebUploader.create({

        // 选完文件后，是否自动上传。
        auto: true,

        // swf文件路径
        swf: ${pageContext.request.contextPath}+'/resources/widget/webuploader/Uploader.swf',

        // 文件接收服务端。
        server: '/img/upload',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker'
    });

    // 设置一个队列监听事件，当有一个图片添加进队列中时，触发该方法
    uploader.on("fileQueued", function (file) {
        // 找到头像的img标签
        var $img = $("#header_id");

        // 创建缩略图
        uploader.makeThumb(file, function (error, src) {
            if (error) {
                $img.replaceWith('<span>不能预览</span>');
                return;
            }
            $img.attr('src', src);
        }, 120, 120);

        uploader.on("uploadSuccess", function (file, response) {
            $("#img_id").val(response.uploadpath)
        });

    });

</script>

</body>
</html>
