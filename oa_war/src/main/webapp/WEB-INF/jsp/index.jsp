<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/1
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Simpla Admin</title>
    <!--                       CSS                       -->
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
            src="resources/scripts/jquery-1.3.2.min.js"></script>
    <!-- jQuery Configuration -->
    <script type="text/javascript"
            src="resources/scripts/simpla.jquery.configuration.js"></script>
    <!-- Facebox jQuery Plugin -->
    <script type="text/javascript" src="resources/scripts/facebox.js"></script>
    <!-- jQuery WYSIWYG Plugin -->
    <script type="text/javascript" src="resources/scripts/jquery.wysiwyg.js"></script>
    <style>
        body {
            overflow-x: hidden;
            overflow-y: hidden;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#homeframe").css("height", $(window).height());
        });

        function itemclick(ele) {
            $("#homeframe").attr("src", ele.name);
            $(".current").removeClass("current");
            $(ele).addClass("current");
        }
    </script>
</head>
<body id="main_body">
<div id="body-wrapper">
    <!-- Wrapper for the radial gradient background -->
    <div id="sidebar">
        <div id="sidebar-wrapper">
            <!-- Sidebar with logo and menu -->
            <h1 id="sidebar-title">
                <a href="#">Simpla Admin</a>
            </h1>
            <!-- Logo (221px wide) -->
            <a href="#"><img id="logo" src="resources/images/logo.png"
                             alt="Simpla Admin logo"/></a>
            <!-- Sidebar Profile links -->
            <div id="profile-links">
                你好, <a title="Edit your profile">${loginuser.name}</a>, 你有 <a>0 条消息</a><br/>
                <br/> <a title="个人中心">个人中心</a> | <a href="/logout"
                                                    title="Sign Out">注销</a>
            </div>

            <!-- 引入菜单 -->
            <ul id="main-nav">
                <li><a onclick="itemclick(this);" name="topage/home"
                       class="nav-top-item no-submenu"> 主页 </a></li>
                <!-- 循环一级权限 -->
                <c:forEach items="${loginuser.rescs}" var="resc">
                    <c:if test="${resc.resstate == 1}">
                        <li><a class="nav-top-item">${resc.resname}</a>
                            <ul>
                                <!-- 循环二级权限 -->
                                <c:forEach items="${loginuser.rescs}" var="resc2">
                                    <c:if test="${resc.id == resc2.pid}">
                                        <li><a onclick="itemclick(this);" name="${resc2.respath}">
                                                ${resc2.resname}</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div style="margin: 0 0 0 230px;">
        <!-- End #sidebar -->
        <iframe id="homeframe" name="homeframe" src="topage/home"
                width="100%" scrolling="auto"/>
    </div>
</div>
</body>
<!-- Download From www.exet.tk-->
</html>


