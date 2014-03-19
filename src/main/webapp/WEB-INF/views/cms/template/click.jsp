<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="javascript">
	<script type="text/javascript">
		$(function() {
			
			$("#click").click(function() {
				var width = window.screen.width;
				var height = window.screen.height;
				alert("width="+width);
				alert("height="+height);
				$.get('${ctx}/cms/original/original?width='+width+"&height="+height, {}, function() {
					
				}, 'json')
			})
		})
	</script>
</xqlc:extends>

<xqlc:extends name="title">
	click me
</xqlc:extends>

<xqlc:extends name="body">
	<a id="click" class="btn btn-primary">click me!</a>
</xqlc:extends>

<jsp:include page="/common/ContentPage.jsp" />