<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="javascript">
<script type="text/javascript">
	$(function(){
		$('#chk_all').click(function() {
        	$('[name="chk_category"]').attr('checked', !!$('#chk_all').attr('checked'));
     });
	});
</script>
</xqlc:extends>

<xqlc:extends name="content">
	<form id="adCategorylist" action="${ctx}/cms/adCategory/adCategoryList">
		<div class="row-fluid">
			<div class=" span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-th"></i></span>
						<h5>
							<fmt:message key="ui.cms.adPositionManagement" />
						</h5>
					</div>
					<div class="widget-content">
						<xqlc:table items="${page}" id="querytable">
							<xqlc:row var="adCategory">
								<xqlc:column title="<input type='checkbox' id='chk_all'>" width="30px" style="text-align: center">
									<center>
										<input type="checkbox" name="chk_category" value="${adCategory.id},${adCategory.name}" width="30px">
									</center>
								</xqlc:column>
								<xqlc:column title="${xqlc:i18n('ui.cms.adCategoryName',locale)}"
									style="text-align: center">${adCategory.name}</xqlc:column>
								<xqlc:column title="${xqlc:i18n('ui.cms.isUse',locale)}" style="text-align: center">
									<c:if test="${adCategory.useCode == 'yes'}"><fmt:message key="ui.cms.yes"/></c:if>
									<c:if test="${adCategory.useCode == 'no'}"><fmt:message key="ui.cms.no"/></c:if>
								</xqlc:column>
							</xqlc:row>
						</xqlc:table>
						<div class="widget-foot">
							<div class="pagination pagination-centered pull-right">
								<xqlc:page page="${page}" formId="adCategorylist"></xqlc:page>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseAdCategoryPage.jsp" />