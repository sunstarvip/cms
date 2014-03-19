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
            <span><fmt:message key="ui.cms.modifyTemplate"/></span>
        </h3>
    </div>
    <div class="toolbar">
        <ul>
            <li class="btn-group">
                <a id="flush" class="btn btn-small" href="${ctx}/cms/template/flush">
                    <fmt:message key="ui.cms.updateTemplate"/>
                </a>
                <button id="btn" name="btn" type="submit" class="btn btn-small btn-primary" style="margin-left: 200px">
                    <fmt:message key="ui.base.submit"/>
                </button>
                <a class="btn btn-small btn-warning" href="${ctx }/cms/template/list">
                    <fmt:message key="ui.cms.comeBack"/>
                </a>
            </li>
        </ul>
    </div>
	<div class="widget-content">
	   <form id="edit" name="template" action="${ctx}/cms/template/save" method="post">
			<div class="row-fluid">
				<div class="widget-box">
					<input type="hidden" name="id" value="${template.id}" />
					<div class="control-group">
						<label class="control-label" for="inputName"><font style="color: red">*</font><fmt:message key="ui.cms.templateName"/>：
							${template.name}
						</label>
					</div>
					<input type="hidden" name="queryParameter.path" value="${template.path}" />
					<div class="control-group">
						<label class="control-label" for="inputCode"><font style="color: red">*</font><fmt:message key="ui.cms.templateCode"/>：
						 	<tags:ueditor name="queryParameter.code" value="${code}" id="code" />
						</label>
					</div>
				</div>
			</div>
		</form>
	</div>

    <!-- 弹窗 -->
	<tags:dialog id="import_template">
		<jsp:attribute name="title"><fmt:message key="ui.cms.pleaseAddTemplate"/></jsp:attribute>
		<jsp:attribute name="content">
			<form id="edit" name="template" action="${ctx}/cms/template/improttemplate" method="post" enctype="multipart/form-data">
				<div class="control-group">
					<input type="radio" name ="queryParameter.type" value="static"><fmt:message key="ui.cms.staticTemplate"/>
					<input type="radio" name ="queryParameter.type" value="dynamic"><fmt:message key="ui.cms.dynamicTemplate"/>
				</div>
				<div class="control-group">
	  				<label class="control-label" for="import"><fmt:message key="ui.cms.importTemplate"/>：
	  					<input type="file" name="templatefile" />
	  				</label>
	  			</div>
	  			<div >
        			<button type="submit" class="btn btn-primary" id="btn" name="btn" style="margin-left: 50px"><fmt:message key="ui.cms.submit"/></button>
        			<a href="${ctx }/cms/template/list" class="buttons btn btn-warning" style="margin-left:50px"><fmt:message key="ui.cms.comeBack"/></a>
        		</div>
			</form>
		</jsp:attribute>
	</tags:dialog>
	
	<xqlc:extends name="javascript">
    <xqlc:importjs
        src="plugins/jquery.contextmenu.r2, plugins/xqlc.table.popover" />
		<script type="text/javascript">
		    $(function() {
		        $("#import").click(function() {
		            $("#import_template").modal();
		        });
		    })
		</script>
    </xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseTemplatePage.jsp" />