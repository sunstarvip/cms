<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<xqlc:extends name="css">
     <style type="text/css">
        body {
            height: 100%;
        }
     </style>
    <xqlc:block name="style">
    </xqlc:block>
</xqlc:extends>

<xqlc:extends name="javascript">
    <script type="text/javascript">
        $(function() {
            if (window.parent.ROOT) {
                window.parent.iframeResize($('body').height());
            }
        });
    </script>

    <xqlc:block name="script">
    </xqlc:block>
</xqlc:extends>
<xqlc:extends name="body">
        <div class="row-fluid">
            <div class="span12">
                <xqlc:block name="content">
                </xqlc:block>
            </div>
        </div>
</xqlc:extends>

<jsp:include page="/common/BasePage.jsp" />