<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="title">
	<fmt:message key="ui.cms.categoryManage"/>
</xqlc:extends>

<xqlc:extends name="javascript">
    <xqlc:importjs prefix="http://111.4.117.119/xqlc-ui/static/js/" src="plugins/xqlc.table.popover, plugins/jquery.metadata,
                   plugins/jquery.validate, plugins/messages_cn" />
	<script type="text/javascript">
		$(function() { 
			$('[name="chk"]').click(function() {
				$('[name="chk"]').attr('checked', false);
				$(this).attr('checked', true);
			});
		});
	</script>
</xqlc:extends>

<xqlc:extends name="content">
	<form id="queryForm" action="${ctx}/cms/content/getCategoryList/${category.id}" method="get">
        <div class="row-fluid">
            <div class=" span12">
                <div class="widget-box">
                    <div class="widget-content">
                        <table id="queryTable" class="table table-striped table-bordered table-hover">
                            <thead>
	                            <tr>
		                            <!-- 选项 -->
		                            <th><fmt:message key="ui.cms.options"/></th>
		                            <!-- 栏目名称 -->
		                            <th><fmt:message key="ui.cms.categoryName"/></th>
		                            <!-- 栏目审核状态 -->
		                            <th><fmt:message key="ui.cms.auditStatus"/></th>
	                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="category" items="${pageInfo.content}" >
                                <tr>
                                    <!-- 单选框-->
                                    <td  style="text-align: center"><input type="checkbox" name="chk" value="${category.id}"></td>
                                    <!-- 栏目名称 -->
                                    <td  style="text-align: center">
                                    <a href="#lookModal_${category.id}" id="model"  role="button" data-toggle="modal">${category.name}</a>
                                    </td>
                                    <!-- 栏目审核状态 -->
                                    <td  style="text-align: center">
                                        <c:if test="${category.auditStatus == 'nocheck' }"><fmt:message key="ui.cms.nocheck"/></c:if>
                                        <c:if test="${category.auditStatus == 'pass' }"><fmt:message key="ui.cms.pass"/></c:if>
                                        <c:if test="${category.auditStatus == 'notpass' }"><fmt:message key="ui.cms.noPass"/></c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="widget-foot">
                        <div class="pagination pagination-centered pull-right">
                            <xqlc:page page="${pageInfo}" formId="queryForm" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>    
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseContentPage.jsp" />
