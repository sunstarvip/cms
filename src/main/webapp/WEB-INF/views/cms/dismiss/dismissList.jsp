<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="title">
    <fmt:message key="ui.cms.contentManage"/>
</xqlc:extends>
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
<xqlc:extends name="javascript">
    <script type="text/javascript" src="${ctx}/static/websitetheme/js/jquery.ztree.all-3.2.min.js"></script>
    <script type="text/javascript">
        $(function() {
            //处理页面变形
            if ($(window).width() < 960) {
                $('body').css({
                    'padding-top' : '0px'
                });
            } else {
                $('body').css({
                    'padding-top' : '40px'
                });
            }
            $(window).resize(function() {
                if ($(window).width() < 960) {
                    $('body').css({
                        'padding-top' : '0px'
                    });
                } else {
                    $('body').css({
                        'padding-top' : '40px'
                    });
                }
            });
        });
    </script>
</xqlc:extends>

<xqlc:extends name="body">
    <form id="queryForm" action="${ctx}/cms/content/treeList/${categoryId}" method="get">
     <input type="hidden" name="treChk" id="treChk"/>
        <tags:toolbar title="${xqlc:i18n('ui.cms.contentManage', locale)}">
        </tags:toolbar>
        <div class="row-fluid">
            <div class=" span12">
                <div class="widget-box">
                    <div class="widget-title">
                        <span class="icon"> <i class="icon-th"></i></span>
                        <h5><fmt:message key="ui.cms.dismissList"/></h5>
                    </div>
                    <div class="widget-content">
                 		    <div class="tabbable"> <!-- Only required for left/right tabs -->
    							<ul class="nav nav-tabs">
    								<li class="active"><a href="#tab1" data-toggle="tab"><fmt:message key="ui.cms.currentOpinion" />:</a></li>
    								<li><a href="#tab2" data-toggle="tab"><fmt:message key="ui.cms.historyOpinion" />:</a></li>
    							</ul>
    						<div class="tab-content">
   	 							<div class="tab-pane active" id="tab1">
    								<table>
    								<tr><td width="200px"><fmt:message key="ui.cms.dismissOpinion" /></td>
    								<td><fmt:message key="ui.cms.dismissTime" /></td></tr>
    								<c:forEach items="${newList}" var="newDismiss">
    									<tr>
    										<td width="200px">${newDismiss.comment}</td>
    									 	<td><fmt:formatDate value="${newDismiss.createTime}"/></td>
    									</tr>
    								</c:forEach>
    								</table>
    							</div>
    							<div class="tab-pane" id="tab2">
    								<table>
    								<tr><td width="200px"><fmt:message key="ui.cms.dismissOpinion" /></td>
    								<td><fmt:message key="ui.cms.dismissTime" /></td></tr>
    								<c:forEach items="${oldList}" var="oldDismiss">
    									<tr>
    										<td width="200px">${oldDismiss.comment}</td>
    									 	<td><fmt:formatDate value="${oldDismiss.createTime}"/></td>
    									</tr>
    								</c:forEach>
    								</table>
    							</div>
    						</div>
    					</div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseDismissPage.jsp" />