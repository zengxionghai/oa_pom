<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/1
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination">
    <c:if test="${page.pageSum > 1}">
        <c:if test="${page.page == 1}">
            <a title="First Page">&laquo; First</a>
            <a title="Previous Page">&laquo; Previous</a>
        </c:if>
        <c:if test="${page.page > 1}">
            <a href="${page.url}&page=1" title="First Page">&laquo; First</a>
            <a href="${page.url}&page=${page.page-1}" title="Previous Page">&laquo; Previous</a>
        </c:if>

        <c:forEach items="${page.indexs}" var="index">
            <c:if test="${page.page==index}">
                <a class="number current" title="${index}">${index}</a>
            </c:if>
            <c:if test="${page.page!=index}">
                <a href="${page.url}&page=${index}" class="number" title="${index}">${index}</a>
            </c:if>
        </c:forEach>

        <c:if test="${page.page < page.pageSum}">
            <a href="${page.url}&page=${page.page+1}" title="Next Page">Next &raquo;</a>
            <a href="${page.url}&page=${page.pageSum}" title="Last Page">Last &raquo;</a>
        </c:if>
        <c:if test="${page.page == page.pageSum}">
            <a title="Next Page">Next &raquo;</a>
            <a title="Last Page">Last &raquo;</a>
        </c:if>
        当前第${page.page}页/共${page.pageSum}页
    </c:if>
</div>
<!-- End .pagination -->
