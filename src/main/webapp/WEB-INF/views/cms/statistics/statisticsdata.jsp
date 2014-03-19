<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<xqlc:extends name="title">
	内容访问量统计
</xqlc:extends>

<xqlc:extends name="javascript">
	<xqlc:importjs
		src="plugins/jquery.contextmenu.r2, plugins/xqlc.table.popover" />
</xqlc:extends>

<xqlc:extends name="body">
	
</xqlc:extends>

<jsp:include page="/common/ContentPage.jsp" />