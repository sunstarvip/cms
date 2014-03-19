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
</xqlc:extends>

<xqlc:extends name="content">
    
     <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.contentInformation" /></span>
            </h3>
        </div>
     <div class="toolbar">
         <ul>
            <li class="btn-group">
               <a class="btn btn-small" href="${ctx}/cms/content/create/${content.category.id}">
                  <i class="icon-plus"></i><fmt:message key="ui.cms.create"/>
               </a>
               <a class="btn btn-small" href="${ctx}/cms/content/treeList/${content.category.id}">
                  <i class="icon-plus"></i><fmt:message key="ui.cms.list"/>
               </a>
            </li>
          
         </ul>
     
     </div>   
      <div class="form-horizontal validation">
        <div class="row-fluid">
            <div class=" span12">
                <div class="widget-box">
                    
                    <div class="widget-content">
                        <!-- 显示标题内容 -->
                        <div class="widget-content">
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
                                <label class="control-label"><fmt:message key="ui.cms.type"/></label>
                                <div class="controls">
                                    <c:choose>  
									       <c:when test="${content.type == 0}">  
									           <fmt:message key="ui.cms.normalNews"/>
									       </c:when>  
									       <c:when test="${content.type == 1}">  
									           <fmt:message key="ui.cms.linkNews"/>
									       </c:when>  
									       <c:when test="${content.type == 2}">  
                                               <fmt:message key="ui.cms.pictureNews"/>
                                           </c:when>
									       <c:otherwise>  
									       </c:otherwise>  
									</c:choose> 
                                </div>
                            </div>
                        </div>
                        <!-- 显示所在栏目 -->
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.category"/></label>
                                <div class="controls">
                                    <c:out value="${content.category.name}" />
                                </div>
                            </div>
                        </div>
                        <!-- 显示关键字 -->
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.keys"/></label>
                                <div class="controls">
                                    <c:out value="${content.keyWord}" />
                                </div>
                            </div>
                        </div>
                        <!-- 显示浏览权限 -->
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
                        <!-- 显示内容审核方式 -->
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.auditMode"/></label>
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
                        <!-- 显示新闻是否允许评论 -->
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.commentContent"/></label>
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
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.ui.cms.auditComments"/></label>
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
                        <!-- 显示评论的审核方式 -->
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.auditMode"/></label>
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
                        <!-- 显示新闻的内容 -->
                        <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"><fmt:message key="ui.cms.newsContent"/></label>
                                <div class="controls">
                                    <c:out escapeXml="false" value="${content.contentBody}" />
                                </div>
                            </div>
                        </div>
                        <div class="widget-content">
                            <xqlc:table id="queryTable" items="${content.versions}">
                                <xqlc:row var="version">
                                    <xqlc:column title="${xqlc:i18n('ui.cms.fileName', locale)}" style="text-align: center" propertyName="name"/>
                                    <xqlc:column title="${xqlc:i18n('ui.cms.fileSize', locale)}" style="text-align: center" propertyName="size"/>
                                    <xqlc:column title="${xqlc:i18n('ui.cms.uploadTime', locale)}" style="text-align: center" propertyName="createTime"/>
                                    <xqlc:column title="${xqlc:i18n('ui.cms.download', locale)}" style="text-align: center" >
                                        <a href="${ctx}/system/version/downloadVersion/${version.id}" class="btn">
                                            <i title="${xqlc:i18n('ui.cms.download', locale)}" class="icon-arrow-down"></i>
                                        </a>
                                    </xqlc:column>
                                </xqlc:row>
                            </xqlc:table>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn btn-primary" onclick="self.location.href='${ctx}/cms/content/back/${content.category.id}'">
                                <fmt:message key="ui.cms.comeBack"/>
                            </button>
                            <button type="button" class="btn btn-warning" onclick="self.location.href='${ctx}/cms/content/change/${content.id}/false'">
                                <fmt:message key="ui.cms.update"/>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </div>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseContentPage.jsp" />
