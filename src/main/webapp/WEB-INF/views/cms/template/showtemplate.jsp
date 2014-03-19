<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
    <div class="appcontent">
        <h3>
            <span><fmt:message key="ui.cms.templateInfo"/></span>
        </h3>
    </div>
    <div class="toolbar">
        <ul>
            <li class="btn-group">
                <a class="btn btn-small btn-primary" href="${ctx}/cms/template/update/${templateinfo.id}">
                    <fmt:message key="ui.cms.update"/>
                </a>
                <a class="btn btn-small btn-warning" href="${ctx }/cms/template/list">
                    <fmt:message key="ui.cms.comeBack"/>
                </a>
            </li>
        </ul>
    </div>
	<div class="widget-content">
		<div class="row-fluid">
			<div class="widget-box">
				<div class="control-group">
					<label class="control-label" for="inputName"><fmt:message key="ui.cms.templateName"/>：
						${templateinfo.name}
					</label>
				</div>
				
				<div class="control-group">
 					<label class="control-label" for="inputCode"><fmt:message key="ui.cms.effect"/>：
					</label>
					<div class="controls">
					${code}
					</div>
				</div>
			</div>
		</div>
	</div>

    <!-- 弹窗 -->
	<tags:dialog id="import_template">
		<jsp:attribute name="title"><fmt:message key="ui.cms.pleaseAddTemplate"/></jsp:attribute>
		<jsp:attribute name="content">
			<form id="edit" name="template" action="${ctx}/cms/template/improttemplate" method="post" enctype="multipart/form-data">
				<div class="control-group">
	  				<label class="control-label" for="import"><fmt:message key="ui.cms.importTemplate"/>：
	  					<input type="file" name="templatefile" />
	  				</label>
	  			</div>
	  			<div>
        			<button type="submit" class="btn btn-primary" id="btn" name="btn" style="margin-left: 200px"><fmt:message key="ui.cms.submit"/></button>
        			<a href="${ctx }/cms/template/list" class="buttons btn btn-warning" style="margin-left:200px"><fmt:message key="ui.cms.comeBack"/></a>
        		</div>
			</form>
		</jsp:attribute>
		<jsp:attribute name="footer">
			<button id="import_sure" type="button" class="btn"><fmt:message key="ui.cms.ok"/></button>
			<button class="btn" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.close"/></button>
		</jsp:attribute>
	</tags:dialog>
	
	<xqlc:extends name="javascript">
	    <xqlc:importjs
	        src="plugins/jquery.contextmenu.r2, plugins/xqlc.table.popover" />
        <script type="text/javascript">
            $(function() {
                $("#import").click(function() {
                    $("#import_template").modal();
                })
            })
        </script>
	</xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseTemplatePage.jsp" />