<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>


 <xqlc:extends name="javascript">
	<script type="text/javascript">
		$(function() {
			//处理全选
			$("#chk_all").click(function() {
						$("input[name = 'chk']").prop("checked", $("#chk_all").prop("checked"));
			});
		});
	</script>
</xqlc:extends>
<xqlc:extends name="body">
	<form id="queryForm" action="${ctx}/cms/content/roleList" method="get">
		<xqlc:table id="role_table" items="${pageInfo}">
			<xqlc:row var="role">
				<xqlc:column  title='<input id="chk_all" type="checkbox">'>
					<input type="checkbox" name="chk" value="${role.id},${role.name}">
				</xqlc:column>
				<xqlc:column title="${xqlc:i18n('ui.cms.roleName',locale)}">${role.name}</xqlc:column>
			</xqlc:row>
		</xqlc:table>
		<div class="pagination pagination-centered">
			<xqlc:page page="${pageInfo}" formId="queryForm"></xqlc:page>
		</div>
	</form>

</xqlc:extends>

<jsp:include page="/common/ContentPage.jsp" />