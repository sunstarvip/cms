<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
    <form id="queryForm" action="${ctx}/cms/site/list">
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.siteList" /></span>
            </h3>
        </div>
        <div class="toolbar">
            <ul>
                <li>
                    <!-- 新增按钮 -->
                    <a class="btn btn-small btn-info" href="${ctx}/cms/site/create">
                        <fmt:message key="ui.base.create"/>
                    </a>
                </li>
                <li class="divider"></li>
                <li> <a id="batch_blockUp" class="btn btn-small btn-danger">
                        <fmt:message key="ui.cms.batchBlockUp"/>
                    </a>
                </li>
                <li class="divider"></li>
                <li> <a id="batch_start" class="btn btn-small btn-success">
                        <fmt:message key="ui.cms.batchStart"/>
                     </a>
                </li>
                <li class="divider"></li>
                <!-- 高级搜索 -->
                <li class="btn-group">
                	 <input type="text" id="name" name="queryParameter.name_li" value="${name_li}"
                	 placeholder="<fmt:message key="ui.cms.siteName"/>">
                </li>
                <li class="divider"></li>
                <li>
                <button class="btn btn-small btn-primary" type="button" id="searchBtn">
                	 <fmt:message key="ui.cms.search"/></button>
                </li>
            </ul>
        </div>
        <%--<xqlc:table id="queryTable" items="${pageInfo}">--%>
            <%--<xqlc:row var="site">--%>
                <%--<xqlc:column title='<input id="chk_all" type="checkbox">'>--%>
                <%--<input type="checkbox" name="chk" value="${site.id}">--%>
                <%--</xqlc:column>--%>
                <%--<xqlc:column title="${xqlc:i18n('ui.cms.siteName',locale)}">--%>
                     <%--<c:choose>--%>
                 	<%--<c:when test="${site.mainSite == 'yes'}">--%>
                 		<%--<div class="tip-top" data-original-title="${xqlc:i18n('ui.cms.path',locale)}：${site.path }">--%>
                 		<%--<span style="color:orange"><fmt:message key="ui.cms.mainSite"/>/</span>${site.name }--%>
                 		<%--</div>--%>
                 	<%--</c:when>--%>
                 	<%--<c:when test="${site.mainSite == 'no'}">--%>
                 	    <%--<div class="tip-top" data-original-title="${xqlc:i18n('ui.cms.path',locale)}：${site.path }">--%>
                 		<%--<span style="color:gray"><fmt:message key="ui.cms.nomainSite"/>/</span>${site.name }--%>
                 		<%--</div>--%>
                 	<%--</c:when>--%>
                 	<%--<c:otherwise>--%>
                 	    <%--<div class="tip-top" data-original-title="${xqlc:i18n('ui.cms.path',locale)}：${site.path }">--%>
                 		<%--${site.name }--%>
                 		<%--</div>--%>
                 	<%--</c:otherwise>--%>
                 <%--</c:choose>--%>
                <%--</xqlc:column>--%>
                <%----%>
                <%--<!-- 创建时间 -->--%>
                <%--<xqlc:column title="${xqlc:i18n('ui.base.createTime', locale)}">--%>
                <%--<fmt:formatDate value="${site.createTime}" type="date"/>--%>
                <%--</xqlc:column>--%>
                <%--<xqlc:column title="${xqlc:i18n('ui.cms.parkedDomains', locale)}" propertyName="webDomain" />--%>
                <%--<xqlc:column title="${xqlc:i18n('ui.cms.siteAbbreviation',locale)}" propertyName="simpleName" />--%>
                <%--<xqlc:column title="${xqlc:i18n('ui.cms.whetherUseSite', locale)}" >--%>
                	<%--<c:choose>--%>
                		<%--<c:when test="${site.startFlag == 'yes'}">--%>
                			<%--<fmt:message key="ui.cms.yes"/>--%>
                		<%--</c:when>--%>
                		<%--<c:when test="${site.startFlag == 'no'}">--%>
                			<%--<fmt:message key="ui.cms.no"/>--%>
                		<%--</c:when>--%>
                		<%--<c:otherwise>--%>
                		<%--</c:otherwise>--%>
                	<%--</c:choose>--%>
                <%--</xqlc:column>--%>
            <%--</xqlc:row>--%>
        <%--</xqlc:table>--%>
        <div class="pagination pagination-centered">
            <xqlc:page page="${pageInfo}" formId="queryForm" />
        </div>
    </form>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/base/baseSitePage.jsp" />
