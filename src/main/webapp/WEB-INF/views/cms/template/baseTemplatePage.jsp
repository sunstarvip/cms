<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>

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
        <li><a href="${ctx}/cms/site/list" id="siteManagement"><fmt:message key="ui.cms.siteManagement" /></a></li>
        <li><a href="${ctx}/cms/category/categoryTree/content" id="contentManagement"><fmt:message key="ui.cms.contentManage" /></a></li>
        <li class="active">
            <a href="${ctx}/cms/template/list">
                <i class="icon-user"></i>
                <fmt:message key="ui.cms.templateManagement" />
                <i class="icon-chevron-right pull-right"></i>
            </a>
        </li>
        <li><a href="${ctx}/cms/adGroup/treeList" id="adCategoryManagement"><fmt:message key="ui.cms.adPositionManagement" /></a></li>
        <li><a href="${ctx}/cms/advertise/advertiseList" id="advertiseManagement"> <fmt:message key="ui.cms.advertiseManagement" /></a></li>
    </ul>
</xqlc:extends>
<jsp:include page="/common/ContentPage.jsp" />