<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="css">
  <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/icon.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/zTreeStyle.css" type="text/css"  />
  <style type="text/css">
    .ui-layout-north {
        padding: 0;
        overflow: hidden;
        margin: 0;
    }
	</style>
</xqlc:extends>

<xqlc:extends name="content">
    <form id="queryForm" action="${ctx}/cms/review/list" method="get">
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.newsReviewCheck"/></span>
            </h3>
        </div>
        <div class="toolbar">
            <ul>
                <li class="btn-group">
                    
                    <a id="batch_check" class="btn btn-small btn-success">
                        <fmt:message key="ui.base.check"/>
                    </a>
                   
                    <a id="batch_delete" class="btn btn-small btn-danger">
                        <fmt:message key="ui.base.delete"/>
                    </a>
                </li>
               
                <li class="btn-group">
                <div class="buttons pull-right form-inline">
                    <!-- 查询内容标题 -->
                   <%--  <fmt:message key="ui.cms.title"/>:
                    <input class="input-small" type="text" id="input_search" name="queryParameter.reviewContent.title_li" value="${reviewContent.title_li}" placeholder="${xqlc:i18n('ui.cms.inputTitle', locale)}"> --%>
                    <!-- 查询内容创建人 -->
                    <fmt:message key="ui.cms.publisher"/>:
                    <input class="input-small" type="text" id="input_search" name="queryParameter.reviewUser_li" value="${reviewUser_li}" placeholder="${xqlc:i18n('ui.cms.publisher', locale)}">
                    <!-- 查询内容审核状态 -->
                   <%--  <select class="input-medium" id="input_search_auditStatus" name="queryParameter.auditStatus">
                        <option value=""><fmt:message key="ui.cms.pleaseChoose"/></option>
                        <option value="1"><fmt:message key="ui.cms.noPass"/></option>
                        <option value="2"><fmt:message key="ui.cms.pass"/></option> 
                    </select> --%>
                    <button type="submit" class="btn-info btn-small"><fmt:message key="ui.cms.search" /></button>
                </div>
                </li>
            </ul>
        </div>
        <table id="queryTable" class="table table-striped table-bordered table-hover">
	        <thead>
	        <%-- <tr>
	            <!-- 复选框 -->
	            <th style="text-align: center"><input id="chk_all" type="checkbox"></th>
	            <!-- 评论的内容标题 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.newsTitle"/></th>
	            <!-- 评论人 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.publisher"/></th>
	            <!-- 评论内容 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.reviewContent"/></th>
	            <!-- 评论时间 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.reviewTime"/></th>
	            <!-- 评论审核状态 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.auditStatus"/></th>
	            <!-- 审核人员 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.contentCheckUser"/></th>
	        </tr> --%>
	        </thead>
	        <tbody>
	        	<c:forEach items="${maps }" var="content">
	        		<script type = "text/javascript">console.log('${maps}')</script>
	        		<tr>
       				 	<%-- <td style="text-align: center" colspan="4">${content.key.title}</td> --%>
       				 	<th style="text-align: center">${content.key.title}</th>
       				 	<!-- <td style="text-align: center"></td>
       				 	<td style="text-align: center"></td>
       				 	<td style="text-align: center"></td>
       				 	<td style="text-align: center"></td>
       				 	<td style="text-align: center"></td>
       				 	<td style="text-align: center"></td> -->
	        		</tr>
	        		<tr>
       				 	<!-- 复选框 -->
			            <th style="text-align: center"><fmt:message key="ui.cms.Checked"/></th> 
			            <!-- 评论人 -->
			            <th style="text-align: center"><fmt:message key="ui.cms.publisher"/></th>
			            <!-- 评论内容 -->
			            <th style="text-align: center"><fmt:message key="ui.cms.reviewContent"/></th>
			            <!-- 评论时间 -->
			            <th style="text-align: center"><fmt:message key="ui.cms.reviewTime"/></th>
			            <!-- 评论审核状态 -->
			            <th style="text-align: center"><fmt:message key="ui.cms.auditStatus"/></th>
        			</tr>
	        		<c:forEach items="${content.value }" var="reviews">
	        			<tr>
	        				<td style="text-align: center"><input type="checkbox" name="chk" value="${reviews.id}"></td>
	        				<td style="text-align: center">${reviews.reviewUser }</td>
	        				<td style="text-align: center">${reviews.reviewBody }</td>
	        				<td  style="text-align: center"><fmt:formatDate value="${reviews.createTime}" type="date"/></td>
	        				<td style="text-align: center">
                          <c:choose>  
                               <c:when test="${review.auditStatus == '1'}">  
                                      <span style="color:red">
                                      <fmt:message key="ui.cms.nocheck"/>
                                      </span> 
                               </c:when>
                               <c:when test="${review.auditStatus == '2'}">  
                                       <fmt:message key="ui.cms.pass"/>
                               </c:when>
                               <c:otherwise>
                               </c:otherwise>
                        </c:choose>
                            </td>
	        			</tr>
	        		</c:forEach>
	        	</c:forEach>
	        <%-- <c:if test="${ not empty newReviews}">
	        <c:forEach var="review" items="${newReviews}" >
	            <tr id = "${review.id}">
	                <!-- 复选框 -->
	                <td  style="text-align: center"><input type="checkbox" name="chk" value="${review.id}"></td>
	                <!--评论的内容标题 -->
	                <td  style="text-align: center">
	                    <span  name="contentTitle">
	                            ${review.reviewContent.title}
	                    </span>
	                </td>
	             
                    <!-- 评论人 -->
                    <td  style="text-align: center">${review.reviewUser}</td>
                    <!-- 评论创建时间 -->
                    <td  style="text-align: center">
                        <span  name="contentTitle" >
	                            ${review.reviewBody}
	                    </span>
                    [<fmt:formatDate value="${review.createTime}" type="date"/>]
                    </td>
                     <!-- 评论时间 -->
                    <td  style="text-align: center"><fmt:formatDate value="${review.createTime}" type="date"/></td>
                    <!-- 评论审核状态 -->
                    <td  style="text-align: center">
                        <c:choose>  
                               <c:when test="${review.auditStatus == '1'}">  
                                      <span style="color:red">
                                      <fmt:message key="ui.cms.nocheck"/>
                                      </span> 
                               </c:when>
                               <c:when test="${review.auditStatus == '2'}">  
                                       <fmt:message key="ui.cms.pass"/>
                               </c:when>
                               <c:otherwise>
                               </c:otherwise>
                        </c:choose>
                    </td>
                    <!-- 审核人员 -->
                    <td  style="text-align: center">
                        <c:if test="${not empty review.reviewContent.reviewChecker }">
                        ${review.reviewContent.reviewChecker }
                        </c:if>
                    </td>
	            </tr>
	        </c:forEach>
	        </c:if> --%>
	        </tbody>
	    </table>
       <%--  <div class="pagination pagination-centered">
            <xqlc:page page="${pageinfo}" formId="queryForm" />
        </div> --%>
    </form>
    
	
	
	<xqlc:extends name="javascript">
    <script type="text/javascript" src="${ctx}/static/websitetheme/js/jquery.ztree.all-3.2.min.js"></script>
   
    <script type="text/javascript">
        $(function() {
            // 处理全选
            $('#chk_all').click(function() {
            	$('[name="chk"]').prop('checked', $('#chk_all').prop('checked'));
            });
            
            // 处理按钮的提示
            $('.tip-top').tooltip({
                placement : 'top'
            });
            // 批量删除$('#batch_new')
            $('#batch_delete').click(function() {
                if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                	 if (confirm('${xqlc:i18n("ui.cms.sureDelete", locale)}')) {
                		 $('#queryForm')[0].method = 'post';
                         $('#queryForm')[0].action = '${ctx}/cms/review/batchDelete';
                         $('#queryForm').submit();
                         return true;
                     } else {
                         return false;
                     }
                   
                }
            });
           
          
            // 批量审核
            $('#batch_check').click(function() {
                if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                    $('#queryForm')[0].method = 'post';
                    $('#queryForm')[0].action = '${ctx}/cms/review/batchCheck';
                    $('#queryForm').submit();
                }
            }); 
            
            // 搜索状态
            if('${auditStatus}') {//审核评论auditReview 0.否   1.是
                $('#input_search_auditStatus').val('${auditStatus}');
            }
        });
        
	        
	    </script>
	    <script type="text/javascript">
            $(function() {
               /*  $('#queryTable tbody tr').css({'cursor':'pointer'});
                $('#queryTable tbody tr').on('click', function() {
                    window.location.href = '${ctx}/cms/content/check/' + $(this).attr('id') + '/${categoryId}';
                });
                $('input[name="chk"]').parent('td').on('click', function(event) {
                   event.stopPropagation();
                });
                $('span[name="contentTitle"]').parent('td').on('click', function(event) {
                    event.stopPropagation();
                 }); */
            //选择进入单个站点
           
                $("#button_site").on('click',function() {
                    //确认按钮处理
                    if($("#site_id").val()==""||$("#site_id").val()==null){
                        alert('${xqlc:i18n("ui.cms.pleaseChooseSite", locale)}');
                    }else{
                       // window.location.href="${ctx}/cms/category/siteConnectCategory/"+$("#site_id").val();
                       // window.open("${ctx}/cms/category/categoryTree?siteId="+$("#site_id").val()+"&mark=category",'_blank');
                    	window.open("${ctx}/cms/index/intoContent?siteId="+$("#site_id").val(),'_blank');
                    }
                });
            });
        </script>
	</xqlc:extends>
</xqlc:extends>
<jsp:include page="/WEB-INF/views/cms/base/baseReviewPage.jsp" />
