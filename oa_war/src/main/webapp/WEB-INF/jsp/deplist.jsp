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
                openDialog("tree_dialog", "选择父部门", 300, 300);
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
                        <th>部门名称</th>
                        <th>父部门</th>
                        <th>部门描述</th>
                        <th>成立时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${deps}" var="dep">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${dep.id}</td>
                            <td>${dep.dname}</td>
                            <td>${dep.pname}</td>
                            <td>${dep.dinfo}</td>
                            <td><fmt:formatDate value="${dep.createtime}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <!-- Icons -->
                                <shiro:hasPermission name="/dep/saveorupdate">
                                    <a href="javascript:updateDep(${dep.id},'${dep.dname}',${dep.pid},'${dep.pname}','${dep.dinfo}',
                                '${dep.createtime}')" title="Edit">
                                        <img src="resources/images/icons/pencil.png" alt="Edit"/>
                                    </a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="/dep/delete">
                                    <a href="dep/delete/${dep.id}" title="Delete">
                                        <img src="resources/images/icons/cross.png" alt="Delete"/>
                                    </a>
                                </shiro:hasPermission>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="6">
                            <shiro:hasPermission name="/dep/saveorupdate">
                                <div class="bulk-actions align-left">
                                    <a class="mybutton" href="javascript:addDep()">添加部门</a>
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
     * 添加部门
     */
    function addDep() {
        // 清空表单
        $("#did").val("");

        $("#dname_id").val("");

        $("#btn_id").html("无");
        $("#pid_id").val("-1");

        $("#dinfo_id").html("");

        $("#createtime_id").val("");

        // 弹出dialog
        openDialog('dep_dialog', '部门添加')
    }


    /**
     * 修改部门
     */
    function updateDep(did, dname, pid, pname, dinfo, createtime) {
        // 填充信息
        $("#did").val(did);

        $("#dname_id").val(dname);

        $("#btn_id").html(pname);
        $("#pid_id").val(pid);

        $("#dinfo_id").html(dinfo);

        var date = new Date(createtime);
        var dateStr = date.getFullYear() + "-" + date.getMonth() + "-" + date.getDate();

        $("#createtime_id").val(dateStr);

        // 弹出dialog
        openDialog('dep_dialog', '部门修改');
    }
</script>

<!-- 弹出框-->
<div id="dep_dialog" style="display: none">
    <form action="${pageContext.request.contextPath}/dep/saveorupdate" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <input type="hidden" id="did" name="id" value=""/>
            <p>
                <label>部门名称</label>
                <input class="text-input input" type="text" id="dname_id" name="dname"/>
            </p>
            <p>
                <label>父部门</label>
                <button id="btn_id" class="mybutton" type="button" onclick="showDepsTree()">无</button>
                <input id="pid_id" name="pid" type="hidden" value="-1">
            </p>
            <p>
                <label>成立时间</label>
                <input class="Wdate time-input" type="text" id="createtime_id"
                       name="createtime" onclick="WdatePicker()"/>
            </p>
            <p>
                <label>部门描述</label>
                <textarea class="text-input textarea " id="dinfo_id" name="dinfo" cols="50" rows="10"></textarea>
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

</body>
</html>
