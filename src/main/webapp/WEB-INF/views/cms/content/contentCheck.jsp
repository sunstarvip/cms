<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="title">
    <fmt:message key="ui.cms.contentManage"/>
</xqlc:extends>

<xqlc:extends name="javascript">
    <xqlc:importjs src="plugins/jquery.metadata, plugins/jquery.validate, plugins/messages_cn" />
    <script type="text/javascript">
        $(function() {
        	//根据内容审核方式动态加载内容审核人DIV
	        $(function() {
	        	if("${content.auditContentMethod}" == "2") {
	        		$("#contentCheckerDiv").show();
	        	}
	        });
        	//根据评论审核方式动态加载评论审核人DIV
	        function rcDiv() {
                if("${content.auditReviewMethod}" == "2") {
                    $("#reviewCheckerDiv").show();
                }
            }
	        //根据是否审核评论动态加载评论审核方式DIV
	        function armDiv() {
                if("${content.auditReview}" == "1") {
                    $("#auditReviewMethodDiv").show();
                    rcDiv();
                }
            }
	        //根据是否评论动态加载是否审核评论方式DIV
	        $(function auditReviewMethodDiv() {
                if("${content.reviewContent}" == "1") {
                    $("#auditReviewDiv").show();
                    armDiv();
                }
            });
	    })
    </script>
</xqlc:extends>

<xqlc:extends name="content">
    
     <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.contentInformation"/></span>
            </h3>
        </div>

      <div class="toolbar">
            <ul>
                <li class="btn-group">
                     <!-- 编辑按钮 -->
                    <a class="btn btn-small btn-primary" href="${ctx}/cms/content/update/${content.id}/${content.category.id}">
                        <fmt:message key="ui.cms.edit"/>
                    </a>
                    <!--返回按钮 -->
                     <a class="btn btn-small btn-warning" href="${ctx}/cms/content/treeList/${content.category.id}">
                        <fmt:message key="ui.base.cancel"/>
                    </a>
                </li>
            </ul>
        </div>
      <div class="form-horizontal validation">
        <div class="row-fluid">
            <div class=" span12">
            <%--
                <div class="row-fluid">
			        <fmt:message key="ui.cms.contentInformation"/>
			    </div>
                    <div class="widget-title">
                        <span class="icon"><i class="icon-flag"></i></span>
                        <h5><fmt:message key="ui.cms.check"/></h5>
                    </div>
            
             --%>
                <div class="widget-box">
                    <div class="widget-content">
                        <!-- 显示标题内容 -->
                        <div class="widget-content">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                            <div class="control-group">
                          
                            <label class="control-label"><fmt:message key="ui.cms.title"/>：</label>
                                <div class="controls">
                                    <c:out value="${content.title}" />
                                </div>
                            </div>
                        </div>
                        <!-- 显示内容类型 -->
                        <div class="widget-content">
                            <div class="control-group">
                 <label class="control-label"><fmt:message key="ui.cms.type"/>： </label>
                                <div class="controls">
                                    <c:choose>  
			                            <c:when test="${content.type == '1'}">  
			                                <c:if test="${empty content.picPath}">
			                                    <fmt:message key="ui.cms.normalNews"/>
			                                </c:if>
			                                <c:if test="${not empty content.picPath}">
			                                    <fmt:message key="ui.cms.pictureNews"/>
			                                </c:if>
			                            </c:when>  
			                            <c:when test="${content.type == '2'}">  
			                                <fmt:message key="ui.cms.linkNews"/>
			                            </c:when>  
			                            <c:otherwise>  
			                                <fmt:message key="ui.cms.normalNews"/>
			                            </c:otherwise>  
			                        </c:choose> 
                                </div>
                            </div>
                        </div>
                        <!-- 显示所在栏目 -->
                        <div class="widget-content">
                            <div class="control-group">
                 <label class="control-label"><fmt:message key="ui.cms.category"/>：  </label>
                                <div class="controls">
                                   ${content.category.name}
                                </div>
                            </div>
                        </div>
                        <!-- 显示关键字 -->
                        <div class="widget-content">
                            <div class="control-group" >
                 <label class="control-label"><fmt:message key="ui.cms.keys"/>： </label>
                                <div class="controls">
                                        <c:out value="${content.keyWord}" />
                                </div>
                            </div>
                        </div>
                        <!-- 显示权限 -->
                        <%-- <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.browseRight"/></label>
                                <div class="controls">
                                    <select name="role" id="role">  
                                        <option value="0">权限1</option> 
                                        <option value="1">权限2</option>
                                    </select>
                                    <c:choose>  
                                           <c:when test="${content.role == 0}">  
                                                                                                                                        权限1 
                                           </c:when>  
                                           <c:when test="${content.role == 1}">  
                                                                                                                                        权限2
                                           </c:when>  
                                           <c:otherwise>  
                                           </c:otherwise>  
                                    </c:choose> 
                                </div>
                            </div>
                        </div> --%>
                        <!-- 显示审核内容的方式 -->
                        <div class="widget-content">
                            <div class="control-group">
                <label class="control-label"><fmt:message key="ui.cms.auditMode"/>： </label>
                                <div class="controls">
                                    <c:choose>  
                                           <c:when test="${content.auditContentMethod == 1}">  
                                               <fmt:message key="ui.cms.workflow"/>
                                           </c:when>  
                                           <c:when test="${content.auditContentMethod == 2}">  
                                               <fmt:message key="ui.cms.personnelAudit"/>
                                           </c:when>  
                                           <c:otherwise>  
                                           </c:otherwise>  
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <!-- 显示内容审核人 -->
                       <%--  <div id="contentCheckerDiv" class="widget-content" style="display:none">
                            <div class="control-group">
                                           <label class="control-label"><fmt:message key="ui.cms.contentChecker"/>：  </label>
                                <div class="controls">
                                    <c:out value="${content.contentChecker.userName}" />
                                </div>
                            </div>
                        </div> --%>
                        <!-- 显示内容是否允许评论 -->
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.commentContent"/>：  </label>
                                <div class="controls">
                                    <c:choose>  
                                           <c:when test="${content.reviewContent == 1}">  
                                               <fmt:message key="ui.cms.yes"/>
                                           </c:when>  
                                           <c:when test="${content.reviewContent == 0}">  
                                               <fmt:message key="ui.cms.no"/>
                                           </c:when>  
                                           <c:otherwise>  
                                           </c:otherwise>  
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <!-- 显示评论是否需要审核 -->
                        <div id="auditReviewDiv" class="widget-content" style="display:none">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.ui.cms.auditComments"/>：  </label>
                                <div class="controls">
                                    <c:choose>  
                                           <c:when test="${content.auditReview == 1}">  
                                               <fmt:message key="ui.cms.yes"/>
                                           </c:when>  
                                           <c:when test="${content.auditReview == 0}">  
                                               <fmt:message key="ui.cms.no"/>
                                           </c:when>  
                                           <c:otherwise>  
                                           </c:otherwise>  
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <!-- 显示评论审核方式 -->
                        <div id="auditReviewMethodDiv" class="widget-content" style="display:none">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.auditMode"/>： </label>
                                <div class="controls">
                                    <c:choose>  
                                           <c:when test="${content.auditReviewMethod == 1}">  
                                               <fmt:message key="ui.cms.workflow"/>
                                           </c:when>  
                                           <c:when test="${content.auditReviewMethod == 2}">  
                                               <fmt:message key="ui.cms.personnelAudit"/>
                                           </c:when>  
                                           <c:otherwise>  
                                           </c:otherwise>  
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <!-- 评论审核人 -->
                       <%--  <div id="reviewCheckerDiv" class="widget-content" style="display:none">
                            <div class="control-group">
                                    <label class="control-label"><fmt:message key="ui.cms.reviewChecker"/>：  </label>
                                <div class="controls">
                                  &nbsp;&nbsp;&nbsp;  <c:out value="${content.reviewChecker.userName}" />
                                </div>
                            </div>
                        </div> --%>
                        <!-- 显示新闻的内容 -->
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.newsContent"/>：  </label>
                                <div class="controls">
                                    <c:out escapeXml="false" value="${content.contentBody}" />
                                </div>
                            </div>
                        </div>
                        <c:if test="${!empty content.versions}">
                        <!-- 附件 -->
                        <div class="widget-content">
                            <xqlc:table id="queryTable" items="${content.versions}">
	                            <xqlc:row var="version">
	                                <xqlc:column title="${xqlc:i18n('ui.cms.fileName', locale)}" style="text-align: center" propertyName="name"/>
	                                <xqlc:column title="${xqlc:i18n('ui.cms.fileSize', locale)}" style="text-align: center" propertyName="sizes"/>
	                                <xqlc:column title="${xqlc:i18n('ui.cms.uploadTime', locale)}" style="text-align: center" propertyName="createTime"/>
                                    <xqlc:column title="${xqlc:i18n('ui.cms.download', locale)}" style="text-align: center" >
                                        <a href="${ctx}/system/version/downloadVersion/${version.id}" class="btn">
                                            <i title="${xqlc:i18n('ui.cms.download', locale)}" class="icon-arrow-down"></i>
                                        </a>
                                    </xqlc:column>
	                            </xqlc:row>
                            </xqlc:table>
                        </div>
                        </c:if>
                        <div class="form-actions" >
                        <div >
                            <form id="dismissForm" action="${ctx}/cms/content/saveDismiss/${content.id}/${content.category.id}" Class="form-horizontal validation" method="post">
                                <div class="widget-content" style="margin-left: 0px">
		                            <div class="control-group" >
		                                <label class="control-label"><fmt:message key="ui.cms.dismissedComments"/>：  </label>
		                                <div class="controls" >
		                                    <textarea id="comment" name="dismissComment" rows="6" cols="6"></textarea>
		                                </div>
		                            </div>
	                            </div>
	                            <div align="center" class="text-center">
		                            <button type="button" class="btn btn-primary" onclick="self.location.href='${ctx}/cms/content/change/${content.id}/${content.category.id}'">
		                                <fmt:message key="ui.cms.pass"/>
		                            </button>
		                            <button type="submit" class="btn btn-warning">
		                                <fmt:message key="ui.cms.noPass"/>
		                            </button>
	                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </div>
  </div>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseContentPage.jsp" />
