<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%-- <xqlc:extends name="javascript">
    <xqlc:importjs prefix="http://111.4.117.119/xqlc-ui/static/js/" src="plugins/xqlc.table.popover, plugins/jquery.metadata,
                   plugins/jquery.validate, plugins/messages_cn" />
	<script type="text/javascript">
		$(function() { 
			// 处理全选
            $('#lssuedChk_all').click(function() {
                $('[name="lssuedChk"]').attr('checked', !!$('#lssuedChk_all').attr('checked'));
            });
		});
	</script>
</xqlc:extends> --%>

<xqlc:extends name="body">
	<form id="queryForm" action="${ctx}/cms/adGroup/list" method="get">
        <div class="row-fluid">
            <div class=" span12">
                <div class="widget-box">
                    <div class="widget-content">
                        <xqlc:table id="queryTable" items="${pageInfo}">
                            <xqlc:row var="user">
                                <xqlc:column style="text-align: center" title='<input id="lssuedChk_all" type="checkbox">'>
                                    <input type="checkbox" name="lssuedChk" value="${user.id}">
                                </xqlc:column>
                                <xqlc:column title="姓名" propertyName="userName" style="text-align: center" />
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
        </div>
    </form>    
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseDeptAndUser.jsp" />
