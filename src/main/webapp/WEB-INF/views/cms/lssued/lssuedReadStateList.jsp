<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
    <form id="queryForm" action="${ctx}/cms/content/treeList/${categoryId}" method="get">
     <input type="hidden" name="treChk" id="treChk"/>
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.lssuedReadStateList"/></span>
            </h3>
        </div>
        <div class="row-fluid">
	        <div class="widget-box">
	            <div class="widget-content">
	                <xqlc:table id="queryTable" items="${pageInfo}">
	                    <xqlc:row var="lssued">
	                        <xqlc:column title="${xqlc:i18n('ui.cms.inputTitle', locale)}" style="text-align: center">
	                            ${lssued.acceptUser.userName}
	                        </xqlc:column>
	                        <xqlc:column title="${xqlc:i18n('ui.cms.acceptStatus', locale)}" style="text-align: center">
	                            ${lssued.acceptStatus}
	                        </xqlc:column>
	                    </xqlc:row>
	                </xqlc:table>
	            </div>
	            <div class="widget-foot">
	                <div class="pagination pagination-centered pull-right">
	                    <xqlc:page page="${pageInfo}" formId="queryForm" />
	                </div>
	            </div>
	        </div>
        </div>
    </form>
    
    <xqlc:extends name="javascript">
    <xqlc:importjs prefix="http://111.4.117.119/xqlc-ui/static/js/" src="plugins/xqlc.table.popover, plugins/jquery.metadata,
                   plugins/jquery.validate, plugins/messages_cn" />
    <script type="text/javascript" src="${ctx}/static/websitetheme/js/jquery.ztree.all-3.2.min.js"></script>
    </xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseLssuedPage.jsp" />