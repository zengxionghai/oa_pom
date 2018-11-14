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

    <!-- Ztree树形结构 -->
    <link rel="stylesheet" href="resources/widget/zTree/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="resources/widget/zTree/jquery.ztree.all.min.js"></script>


    <script type="text/javascript">
        /**
         * 显示父权限的树形机构
         */
        function showRescTree() {
            $.get("resc/listajax", function (data) {

                //生成Ztree
                createZtree("ztree_div", data, {
                    name: "resname",
                    pid: "pid",
                    icon: false,
                    expand: true,
                    onclick: function (event, treeId, treeNode) {
                        //将选中的父权限名称设置给button按钮
                        $("#btn_id").html(treeNode.resname);
                        $("#pid_id").val(treeNode.id);

                        if (treeNode.resstate == 1) {
                            $("#span_id").html("二级权限");
                            $("#resstate_id").val(2);
                        } else if (treeNode.resstate == 2) {
                            $("#span_id").html("三级权限");
                            $("#resstate_id").val(3);
                        } else {
                            alert("三级权限下不能再有子权限！");
                            return;
                        }

                        // 关闭弹窗
                        closeDialog("tree_dialog");
                    }
                }, $("#pid_id").val())

                //弹出dialog
                openDialog("tree_dialog", "选择父权限", 300, 300);
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
                        <th>权限名称</th>
                        <th>权限路径</th>
                        <th>权限类型</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${rescs}" var="resc">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${resc.id}</td>
                            <td>${resc.resname}</td>
                            <td>${resc.respath}</td>
                            <td>
                                <c:if test="${resc.resstate==1}">
                                    一级权限
                                </c:if>
                                <c:if test="${resc.resstate==2}">
                                    二级权限
                                </c:if>
                                <c:if test="${resc.resstate==3}">
                                    三级权限
                                </c:if>
                            </td>
                            <td>
                                <!-- Icons -->
                                <shiro:hasPermission name="/resc/saveorupdate">
                                    <a href="javascript:updateResc(${resc.id},${resc.pid},'${resc.resname}',
                                '${resc.respath}','${resc.resstate}')" title="Edit">
                                        <img src="resources/images/icons/pencil.png" alt="Edit"/>
                                    </a>
                                </shiro:hasPermission>

                                <shiro:hasPermission name="/resc/delete">
                                    <a href="resc/delete/${resc.id}" title="Delete">
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
                            <shiro:hasPermission name="/resc/saveorupdate">
                                <div class="bulk-actions align-left">
                                    <a class="mybutton" href="javascript:addResc()">添加权限</a>
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
     * 添加权限
     */
    function addResc() {

        // 清空表单
        $("#did").val("");

        $("#btn_id").html("无");
        $("#pid_id").val("-1");

        $("#resname_id").val("");

        $("#respath_id").val("");

        $("#resstate_id").val(1);

        $("#span_id").html("一级权限");

        // 弹出dialog
        openDialog('dep_dialog', '权限添加')
    }


    /**
     * 修改权限
     */
    function updateResc(rescid, pid, resname, respath,  resstate) {

        // 填充信息
        $("#did").val(rescid);

        $("#pid_id").val(pid);

        $("#resname_id").val(resname);

        $("#respath_id").val(respath);

        $("#resstate_id").val(resstate);

        // 弹出dialog
        openDialog('dep_dialog', '权限修改');
    }
</script>

<!-- 弹出框-->
<div id="dep_dialog" style="display: none">
    <form action="${pageContext.request.contextPath}/resc/saveorupdate" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <input type="hidden" id="did" name="id" value=""/>
            <p>
                <label>权限名称</label>
                <input class="text-input input" type="text" id="resname_id" name="resname"/>
            </p>
            <p>
                <label>权限路径</label>
                <input class="text-input input" type="text" id="respath_id" name="respath"/>
            </p>
            <p>
                <label>父权限</label>
                <button id="btn_id" class="mybutton" type="button" onclick="showRescTree()">无</button>
                <input id="pid_id" name="pid" type="hidden" value="-1">
            </p>
            <p>
                <label>权限类型</label>
                <span id="span_id">一级权限</span>
                <input type="hidden" name="resstate" id="resstate_id" value=""/>
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
