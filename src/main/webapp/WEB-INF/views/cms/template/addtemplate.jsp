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
            <span><fmt:message key="ui.cms.addTemplate" /></span>
        </h3>
    </div>
    <div class="toolbar">
        <ul>
            <li class="btn-group">
                <a id="import" class="btn btn-small" href="#">
                    <fmt:message key="ui.cms.importTemplate"/>
                </a>
                <button id="btn" name="btn" type="submit" class="btn btn-small btn-primary">
                    <fmt:message key="ui.base.submit"/>
                </button>
                <a class="btn btn-small btn-warning" href="${ctx }/cms/template/list">
                    <fmt:message key="ui.cms.comeBack"/>
                </a>
            </li>
        </ul>
    </div>
	<form id="edit" name="template" action="${ctx}/cms/template/save" method="post">
		<div class="row-fluid">
			<div class="widget-box">
				<div class="control-group">
					<label class="control-label" for="inputFile"><font style="color: red">*</font><fmt:message key="ui.cms.templateFile"/>：
						<input id="file" type="text" name="file" value="${template.file}" />
					<span id="checkfileempty" style="display: none"><font style="color: red; font-size: 10px"><fmt:message key="ui.cms.fileIsExists"/></font></span>
					<span id="checkfilenull" style="display: none"><font style="color: red; font-size: 10px"><fmt:message key="ui.cms.fileIsNull"/></font></span>
					</label>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="inputName"><font style="color: red">*</font><fmt:message key="ui.cms.templateName"/>：
						<input id="name" type="text" name="name" value="${template.name}" />
					<span id="checknamenull" style="display: none"><font style="color: red; font-size: 10px"><fmt:message key="ui.cms.nullMessage"/></font></span>
					</label>
				</div>
			</div>
		</div>
	</form>
		
    <xqlc:extends name="javascript">
    <xqlc:importjs
        src="plugins/jquery.contextmenu.r2, plugins/xqlc.table.popover" />
    <script type="text/javascript">
        $(function() {
        //验证文件是否重复
        $("#file").change(function() {
            var name = $("#file").val();
            $("#checkfilenull").hide();
            if(name != null && name != '') {
                $.get('${ctx}/cms/template/repeat/'+name, {}, function(response){
                    if(response == true) {
                        $("#checkfileempty").show();
                    } else {
                        $("#checkfileempty").hide();
                    }
                }, 'json')
            } else {
                $("#checkfilenull").show();
            }
        });
        
        //验证文件是否为空
        $("#file").click(function() {
            var file = $("#file").val();
            $("#checkfileempty").hide();
            if(file == null || file == '') {
                $("#checkfilenull").show();
            }
        });
        
        //验证名称是否为空
        $("#name").click(function() {
            var name = $("#name").val();
            if(name == null || name == '') {
                $("#checknamenull").show();
            } else {
                $("#checknamenull").hide();
            }
        });
        
        $("#name").change(function() {
            var name = $("#name").val();
            if(name == null || name == '') {
                $("#checknamenull").show();
            } else {
                $("#checknamenull").hide();
            }
        });
        
        })
    </script>
</xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseTemplatePage.jsp" />