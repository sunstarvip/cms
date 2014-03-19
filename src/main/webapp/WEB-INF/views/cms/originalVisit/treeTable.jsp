<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>
<c:forEach var="category" items="${child1.categoryChild}" varStatus="vs">
    <c:set var="index" value="${index + 1}" scope="request" /><!-- 每一次循环，index+1 -->
    <%--<tr>
        <td align="center" nowrap="nowrap">${index}</td>
        <td align="center" nowrap="nowrap">${level}</td>
        <td align="center" nowrap="nowrap">${cur.name}</td>
    </tr>--%>
    <tr id = "${category.id}" class="child-of-${child1.id}">
        <td style="padding-left: 19px;">
                ${category.name}
        </td>
        <td>
            <c:forEach items="${contentList}" var="content">
                <c:if test="${category.id == content[0]}">${content[1]}</c:if>
            </c:forEach>
        </td>
        <td>
            <c:forEach items="${categoryVdList}" var="categoryVd">
                <c:if test="${category.id == categoryVd[0]}">${categoryVd[1]}</c:if>
            </c:forEach>
        </td>
    </tr>
    <%--<c:if test="${fn:length(category.category) > 0}"><!-- 如果有childen -->--%>
    <c:if test="${category.categoryChild.size > 0}"><!-- 如果有childen -->
        <c:set var="level" value="${level + 1}" scope="request" /><!-- 循环一次子列表，level+1 -->
        <c:set var="child" value="${category.categoryChild}" scope="request" /><!-- 注意此处，子列表覆盖treeList，在request作用域 -->
        <c:import url="treeTable.jsp" /><!-- 这就是递归了 -->
    </c:if>
</c:forEach>
<c:set var="level" value="${level - 1}" scope="request" /><!-- 退出时，level-1 -->