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
        var rid;

        /**
         * 修改角色的权限
         * @param roleid
         */
        function updateResc(rid_ele) {
            rid = rid_ele;
            // 通过ajax查询出所有的权限树
            $.get("resc/listajax2", {rid: rid}, function (data) {

                //生成Ztree
                createZtree("ztree_div", data, {
                    name: "resname",
                    pid: "pid",
                    icon: false,
                    expand: true,
                    check: true,
                    checkType: {"Y": "ps", "N": "s"}
                });

                //弹出dialog
                openDialog("tree_dialog", "设置角色权限", 300, 350);
            }, "json");
        }

        /**
         * 提交修改的角色权限关联
         */
        function updateRescAjax() {
            // 获得勾选的权限
            var reids = [];
            var treeObj = $.fn.zTree.getZTreeObj("ztree_div");
            var nodes = treeObj.getCheckedNodes(true);
            for (var i = 0; i < nodes.length; i++) {
                reids.push(nodes[i].id);
            }

            // ajax提交请求
            $.ajax({
                type: "POST",
                url: "/role/updateresc",
                traditional: true,
                data: {rid: rid, reids: reids},
                success: function (data) {
                    if (data == 1) {
                        alert("权限修改成功!");
                        closeDialog("tree_dialog");
                    } else {
                        alert("权限修改失败，清联系管理员");
                    }
                }
            });
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
                        <th>角色名称</th>
                        <th>角色描述</th>
                        <th>角色状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${roles}" var="role">
                        <tr>
                            <td><input type="checkbox"/></td>
                            <td>${role.id}</td>
                            <td>${role.rolename}</td>
                            <td>${role.roledesc}</td>
                            <td>${role.rolestate}</td>
                            <td>
                                <!-- Icons -->
                                <shiro:hasPermission name="/role/saveorupdate">
                                    <a href="javascript:updateRole(${role.id},'${role.rolename}','${role.roledesc}',
                                '${role.rolestate}')" title="Edit">
                                        <img src="resources/images/icons/pencil.png" alt="Edit"/>
                                    </a>
                                </shiro:hasPermission>

                                <shiro:hasPermission name="/role/delete">
                                    <a href="role/delete/${role.id}" title="Delete">
                                        <img src="resources/images/icons/cross.png" alt="Delete"/>
                                    </a>
                                </shiro:hasPermission>

                                <shiro:hasPermission name="/role/saveorupdate">
                                    <a href="javascript:updateResc(${role.id})" title="Edit Meta">
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
                            <shiro:hasPermission name="/role/saveorupdate">
                                <div class="bulk-actions align-left">
                                    <a class="mybutton" href="javascript:addRole()">添加角色</a>
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
     * 添加角色
     */
    function addRole() {

        // 清空表单
        $("#did").val("");

        $("#rolename_id").val("");

        $("#roledesc_id").val("");

        $("#rolestate_id").val("");

        // 弹出dialog
        openDialog('dep_dialog', '角色添加')
    }


    /**
     * 修改角色
     */
    function updateRole(roleid, rolename, roledesc, rolestate) {

        // 填充信息
        $("#did").val(roleid);

        $("#rolename_id").val(rolename);

        $("#roledesc_id").val(roledesc);

        $("#rolestate_id").val(rolestate);

        // 弹出dialog
        openDialog('dep_dialog', '角色修改');
    }
</script>

<!-- 弹出框-->
<div id="dep_dialog" style="display: none">
    <form action="${pageContext.request.contextPath}/role/saveorupdate" method="post">
        <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <input type="hidden" id="did" name="id" value=""/>
            <p>
                <label>角色名称</label>
                <input class="text-input input" type="text" id="rolename_id" name="rolename"/>
            </p>
            <p>
                <label>角色描述</label>
                <input class="text-input input" type="text" id="roledesc_id" name="roledesc"/>
            </p>
            <p>
                <label>角色状态</label>
                <input class="text-input input" type="text" id="rolestate_id" name="rolestate"/>
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

    <button type="button" class="mybutton" onclick="updateRescAjax()">提交</button>

</div>

</body>
</html>
