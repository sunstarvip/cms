<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<xqlc:extends name="title">
	员工部门管理
</xqlc:extends>

<xqlc:extends name="javascript">
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
</xqlc:extends>

<jsp:include page="/common/ContentPage.jsp" />
