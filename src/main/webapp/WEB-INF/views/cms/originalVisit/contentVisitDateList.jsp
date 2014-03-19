<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>


 <xqlc:extends name="javascript">
	<script type="text/javascript">
		   function showOperate(categoryId){
               alert(categoryId);
               $('#myModal').show();
               $('#contentIframe').attr('src','');
           }
	</script>
</xqlc:extends>
<xqlc:extends name="body">
	<form id="queryForm" action="" method="get">
        <span style="text-align: left">${category.name}:</span>
		<table class="table">
			<thead>
				<tr>
					<td>内容名称</td>
                    <td>访问量</td>
                    <td>操作</td>
				</tr>
			</thead>
            <tbody>
                <c:forEach items="${pageInfo.content}" var="content">
                    <tr>
                        <td>${content.name}</td>
                        <td>
                            <c:forEach items="${contentList}" var="contentVisitDate">
                                <c:if test="${content.id == contentVisitDate[0]}">${contentVisitDate[1]}</c:if>
                            </c:forEach>
                        </td>
                        <td> <a id = "operateBtn" name = "check_button" style="button" class="btn btn-info btn-mini" onclick="showOperate(${content.category.id});">详情</a></td>
                    </tr>
                </c:forEach>
			</tbody>
		</table>
	</form>
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3></h3>内容访问统计图</h3>
        </div>
        <div class="modal-body">
            <iframe id = "contentIframe"  frameborder="0" scrolling="auto" width="100%" height="auto" src="">

            </iframe>
        </div>
    </div>
</xqlc:extends>

<jsp:include page="/common/ContentPage.jsp" />