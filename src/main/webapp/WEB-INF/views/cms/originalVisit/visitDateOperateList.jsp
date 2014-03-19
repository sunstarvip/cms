<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>


 <xqlc:extends name="javascript">
	<script type="text/javascript">
		
	</script>
</xqlc:extends>
<xqlc:extends name="body">
	<form id="queryForm" action="" method="get">
        <span style="text-align: left">${site.name}:</span>
		<table class="table">
			<thead>
				<tr>
					<td>栏目</td>
                    <td>访问量</td>
                    <td><script type="text/javascript">console.log('${counts}')</script></td>
				</tr>
			</thead>
            <tbody>
                    <tr>

                    </tr>
			</tbody>
		</table>
	</form>

</xqlc:extends>

<jsp:include page="/common/ContentPage.jsp" />