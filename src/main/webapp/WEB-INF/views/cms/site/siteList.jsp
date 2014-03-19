<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.List"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
    <form id="queryForm" action="${ctx}/cms/site/list">
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.siteList" /></span>
            </h3>
        </div>
        <div class="toolbar">
            <ul>
                <li>
                    <!-- 新增按钮 -->
                    <a class="btn btn-small btn-info" href="${ctx}/cms/site/create">
                        <fmt:message key="ui.base.create"/>
                    </a>
                </li>
                <li class="divider"></li>
                <li> <a id="batch_blockUp" class="btn btn-small btn-danger">
                        <fmt:message key="ui.cms.batchBlockUp"/>
                    </a>
                </li>
                <li class="divider"></li>
                <li> <a id="batch_start" class="btn btn-small btn-success">
                        <fmt:message key="ui.cms.batchStart"/>
                     </a>
                </li>
                <li class="divider"></li>
                <!-- 高级搜索 -->
                <li class="btn-group">
                	 <input type="text" id="name" name="queryParameter.name_li" value="${name_li}"
                	 placeholder="<fmt:message key="ui.cms.siteName"/>">
                	 
                </li>
                <li class="divider"></li>
                <li>
                <button class="btn btn-small btn-primary" type="button" id="searchBtn">
                	 <fmt:message key="ui.cms.search"/></button>
                </li>
            </ul>
        </div>
        <xqlc:table id="queryTable" items="${pageInfo}">
            <xqlc:row var="site">
                <xqlc:column title='<input id="chk_all" type="checkbox">'>
                <input type="checkbox" name="chk" value="${site.id}">
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.siteName',locale)}">
                     <c:choose>
                 	<c:when test="${site.mainSite == 'yes'}">
                 		<div class="tip-top" data-original-title="${xqlc:i18n('ui.cms.path',locale)}：${site.path }">
                 		<span style="color:orange"><fmt:message key="ui.cms.mainSite"/>/</span>${site.name }
                 		</div>
                 	</c:when>
                 	<c:when test="${site.mainSite == 'no'}">
                 	    <div class="tip-top" data-original-title="${xqlc:i18n('ui.cms.path',locale)}：${site.path }">
                 		<span style="color:gray"><fmt:message key="ui.cms.nomainSite"/>/</span>${site.name }
                 		</div>
                 	</c:when>
                 	<c:otherwise>
                 	    <div class="tip-top" data-original-title="${xqlc:i18n('ui.cms.path',locale)}：${site.path }">
                 		${site.name }
                 		</div>
                 	</c:otherwise>
                 </c:choose>
                </xqlc:column>
                
                <!-- 站点标示 -->
                <%-- <xqlc:column title="${xqlc:i18n('ui.cms.englishName', locale)}" propertyName="ename" /> --%>
                <!-- 创建时间 -->
                <xqlc:column title="${xqlc:i18n('ui.base.createTime', locale)}">
                <fmt:formatDate value="${site.createTime}" type="date"/>
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.parkedDomains', locale)}" propertyName="webDomain" />
                <!-- 訪問路徑 -->
                <%-- <xqlc:column title="${xqlc:i18n('ui.cms.path', locale)}" propertyName="path" /> --%>
                <xqlc:column title="${xqlc:i18n('ui.cms.siteAbbreviation',locale)}" propertyName="simpleName" />
                <!-- 主站点 -->
               <%--  <xqlc:column title="${xqlc:i18n('ui.cms.whetherMainSite',locale)}" >
                 <c:choose>
                 	<c:when test="${site.mainSite == 'yes'}">
                 		<fmt:message key="ui.cms.yes"/>
                 	</c:when>
                 	<c:when test="${site.mainSite == 'no'}">
                 		<fmt:message key="ui.cms.no"/>
                 	</c:when>
                 	<c:otherwise>
                 	</c:otherwise>
                 </c:choose>
             </xqlc:column> --%>
                <xqlc:column title="${xqlc:i18n('ui.cms.whetherUseSite', locale)}" >
                	<c:choose>
                		<c:when test="${site.startFlag == 'yes'}">
                			<fmt:message key="ui.cms.yes"/>
                		</c:when>
                		<c:when test="${site.startFlag == 'no'}">
                			<fmt:message key="ui.cms.no"/>
                		</c:when>
                		<c:otherwise>
                		</c:otherwise>
                	</c:choose>
                </xqlc:column>
                <%-- <xqlc:column title="${xqlc:i18n('ui.cms.manipulate',locale)}">
                    <!-- 选择站点 -->
                    <a class="tip-top btn" href="${ctx}/cms/category/siteConnectCategory/${site.id}">
                        <fmt:message key="ui.base.inside"/>
                    </a>
                </xqlc:column> --%>
            </xqlc:row>
        </xqlc:table>
        <div class="pagination pagination-centered">
            <xqlc:page page="${pageInfo}" formId="queryForm" />
        </div>
    </form>
    <xqlc:extends name="javascript">
    <script type="text/javascript">
           // 处理按钮的提示
           $(function() {
           	$('.tip-top').tooltip({
                   placement : 'top'
               });
           });
           // 批量停用
           $(function() {
           	$('#batch_blockUp').click(function() {
                   if($("input[name='chk']:checked").length==0){
                       alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
                   }else{
                       $('#queryForm')[0].method = 'post';
                       $('#queryForm')[0].action = '${ctx}/cms/site/batchBlockUp';
                       $('#queryForm').submit();
                   }
                   
               });
           });
           // 批量启用
           $(function() {
           	$('#batch_start').click(function() {
                   if($("input[name='chk']:checked").length==0){
                       alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
                   }else{
                        $('#queryForm')[0].method = 'post';
                        $('#queryForm')[0].action = '${ctx}/cms/site/batchStart';
                        $('#queryForm').submit();
                   }
                  
               });
           });
       // 处理全选
       $(function() {
           $('#chk_all').click(function() {
               $('[name="chk"]').prop('checked', $('#chk_all').prop('checked'));
           });
       });
       
       //选择进入单个站点
       $("#button_site").click(function() {
           //确认按钮处理
           if($("#site_id").val()==""||$("#site_id").val()==null){
               alert('${xqlc:i18n("ui.cms.pleaseChooseSite", locale)}');
           }else{
               window.location.href="${ctx}/cms/category/siteConnectCategory/"+$("#site_id").val();
           }
       });
       
       </script>
	   <script type="text/javascript">
	        $(function() {
	        	if($("input[name='chk']").length!=0){
	            $('#queryTable tbody tr').css({'cursor':'pointer'});
	            $('#queryTable tbody tr').on('click', function() {
	                window.location.href = '${ctx}/cms/site/readOnly/' + $(this).attr('data-row-id');
	            });
	        	}
	            $('input[name="chk"]').parent('td').on('click', function(event) {
            	   event.stopPropagation();
	            });
	            
	            $("#searchBtn").click(function() {
	            	$("#queryForm_page_id").val('');
	            	$("#queryForm").submit();
	            });
	        });
	    </script>
	</xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseSitePage.jsp" />
