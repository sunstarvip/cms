<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.List"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="title">
    <fmt:message key="ui.cms.CMSManagement"/>
</xqlc:extends>

<xqlc:extends name="header">
    <fmt:message key="ui.cms.CMSManagement"/>
</xqlc:extends>

<xqlc:extends name="nav">
    <h3>
        <span><fmt:message key="ui.base.powerManagement"/></span>
    </h3>
    <ul>
        <li><a href="${ctx}/cms/site/list" id="categoryManagement"><fmt:message key="ui.cms.siteManagement" /></a></li>
        <li><a href="${ctx}/cms/category/list" id="categoryManagement"><fmt:message key="ui.cms.categoryManagement" /></a></li>
        <li><a href="${ctx}/cms/category/categoryTree/content" id="contentManagement"><fmt:message key="ui.cms.contentManage" /></a></li>
        <li><a href="${ctx}/cms/template/list" id="templateManagement"><fmt:message key="ui.cms.templateManagement" /></a></li>
        <li><a href="${ctx}/cms/adGroup/treeList" id="adCategoryManagement"><fmt:message key="ui.cms.adPositionManagement" /></a></li>
        <li><a href="${ctx}/cms/advertise/advertiseList" id="advertiseManagement"> <fmt:message key="ui.cms.advertiseManagement" /></a></li>
    </ul>
</xqlc:extends>

<jsp:include page="/common/ContentPage.jsp" />
