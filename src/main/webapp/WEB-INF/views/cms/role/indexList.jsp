<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.List"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
	<div id="pop">
        <div class="control-group">
            <label class="control-label" style="text-align: right; width: 100px"><fmt:message key="ui.cms.accessProtocol"/></label>
                <select data-id="agreement">
                	<option value=""><fmt:message key="ui.cms.pleaseChoose"/></option>
                	<option value="1" <c:if test="${agreement == '1'}">selected</c:if>>HTTP://</option>
                	<option value="2" <c:if test="${agreement == '2'}">selected</c:if>>HTTPS://</option>
                </select>
            
         </div>
         <div class="control-group">
            <label class="control-label" style="text-align: right; width: 100px"><fmt:message key="ui.cms.isUse"/></label>
            <div class="controls" style="margin-left: 100px">
                <select data-id="start">
                    <option value=""><fmt:message key="ui.cms.pleaseChoose"/></option>
                    <option value="yes" <c:if test="${start == 'yes'}">selected</c:if>><fmt:message key="ui.cms.start"/></option>
                    <option value="no" <c:if test="${start == 'no'}">selected</c:if>><fmt:message key="ui.cms.forbidden"/></option>
                </select>
                
            </div>
         </div>
    </div>
    <form id="queryForm" action="${ctx}/cms/role/list">
        <input type="hidden" id="name" name="queryParameter.name_li" value="${name_li}">
        <input type="hidden" id="agreement" name="queryParameter.agreement" value="${agreement}">
        <input type="hidden" id="start" name="queryParameter.start" value="${start}">
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.siteList" /></span>
            </h3>
        </div>
        <div class="toolbar">
            <ul>
                <!-- 高级搜索 -->
                <li>
                    <tags:advancedSearch id="advanced_search" template="pop" form="queryForm" input="input_search">
                       <input type="text" id="input_search" data-id="name" value="${name_li}" placeholder="站点名称">
                    </tags:advancedSearch>
                </li>
            </ul>
        </div>
        <xqlc:table id="queryTable" items="${pageInfo}">
            <xqlc:row var="site">
                <xqlc:column title="${xqlc:i18n('ui.cms.siteName',locale)}" propertyName="name" />
                <xqlc:column title="${xqlc:i18n('ui.cms.englishName', locale)}" propertyName="ename" />
                <!-- 创建时间 -->
                <xqlc:column title="${xqlc:i18n('ui.base.createTime', locale)}">
                <fmt:formatDate value="${site.createTime}" type="date"/>
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.parkedDomains', locale)}" propertyName="webDomain" />
                <xqlc:column title="${xqlc:i18n('ui.cms.path', locale)}" propertyName="path" />
                <xqlc:column title="${xqlc:i18n('ui.cms.siteAbbreviation',locale)}" propertyName="simpleName" />
                <xqlc:column title="${xqlc:i18n('ui.cms.whetherMainSite',locale)}" >
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
             </xqlc:column>
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
            </xqlc:row>
        </xqlc:table>
        <div class="pagination pagination-centered">
            <xqlc:page page="${pageInfo}" formId="queryForm" />
        </div>
    </form>
    <xqlc:extends name="javascript">
    <xqlc:importjs prefix="http://111.4.117.119/xqlc-ui/static/js/" src="plugins/xqlc.table.popover, plugins/jquery.metadata,
                   plugins/jquery.validate, plugins/messages_cn" />
    <script type="text/javascript">
           // 处理按钮的提示
           $(function() {
           	$('.tip-top').tooltip({
                   placement : 'top'
               });
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
	        });
	    </script>
	</xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseRolePage.jsp" />
