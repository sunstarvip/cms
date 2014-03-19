<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>

<xqlc:extends name="content">
    <form:form action="${ctx}/cms/advertise/save" method="post" modelAttribute="advertise">
        <form:hidden path="id"/>
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.base.detail"/></span>
            </h3>
        </div>
        <div class="toolbar">
            <ul>
                <li>
                    <a href="${ctx}/cms/advertise/create" class="btn btn-small btn-success"><fmt:message key="ui.base.create"/></a>
                </li>
                <li>
                    <a href="${ctx}/cms/advertise/update/${advertise.id}" class="btn btn-small btn-primary"><fmt:message key="ui.base.edit"/></a>
                </li>
                <%-- <li>
                    <a href="${ctx}/cms/advertise/bindAdCategory/${advertise.id}/${adCategory.id}" class="btn btn-small">
                        <fmt:message key="ui.cms.bindAdPosition"/>
                    </a>
                </li> --%>
                <li>
                    <a href="${ctx}/cms/advertise/advertiseList" class="btn btn-small btn-warning"><fmt:message key="ui.base.cancel"/></a>
                </li>
            </ul>
        </div>
        <div class="detailedinfo">
            <div class="row-fluid">
                <div class="span5 offset4">
                    <table>
                        <tbody>
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.advertiseName"/></h5>
                            </td>
                            <td>
                                ${advertise.name}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.showPattern"/></h5>
                            </td>
                            <td>
                                <c:if test="${advertise.showPattern == '1' }"><fmt:message key="ui.cms.fix"/></c:if>
                                <c:if test="${advertise.showPattern == '2' }"><fmt:message key="ui.cms.float"/></c:if>
                                <c:if test="${advertise.showPattern == '3' }"><fmt:message key="ui.cms.cmp"/></c:if>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.type"/></h5>
                            </td>
                            <td>
                                <c:if test="${advertise.type == '1' }"><fmt:message key="ui.cms.flash"/></c:if>
	                            <c:if test="${advertise.type == '2' }"><fmt:message key="ui.cms.image"/></c:if>
	                            <c:if test="${advertise.type == '3' }"><fmt:message key="ui.cms.text"/></c:if>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.linkAddress"/></h5>
                            </td>
                            <td>
                                ${advertise.linkAddress}
                            </td>
                        </tr>
                        <c:if test="${not empty advertise.adCategoryList }">
                        	<c:forEach items="${advertise.adCategoryList }" var="adCategory">
	                        <tr>
	                            <td>
	                                <h5><fmt:message key="ui.cms.ownAdCategoryList"/></h5>
	                            </td>
	                            <td>
	                                ${adCategory.name}
	                            </td>
	                        </tr>
                        	</c:forEach>
                        </c:if>
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.weight"/></h5>
                            </td>
                            <td>
                                ${advertise.weight}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.startTime"/></h5>
                            </td>
                            <td>
                                ${advertise.startTime}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.endTime"/></h5>
                            </td>
                            <td>
                                ${advertise.endTime}
                            </td>
                        </tr>
                        <tr>
                            <c:if test="${not empty advertise.versions}">
                            <div class="row-fluid">
	                            <xqlc:table id="queryTable" items="${advertise.versions}">
		                            <xqlc:row var="version">
			                            <xqlc:column title="${xqlc:i18n('ui.cms.fileName', locale)}" style="text-align: center" propertyName="name"/>
			                            <xqlc:column title="${xqlc:i18n('ui.cms.fileSize', locale)}" style="text-align: center" propertyName="sizes"/>
			                            <xqlc:column title="${xqlc:i18n('ui.cms.uploadTime', locale)}" style="text-align: center" propertyName="createTime"/>
		                            </xqlc:row>
	                            </xqlc:table>
	                        </div>
	                        </c:if>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </form:form>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseAddvertisePage.jsp" />