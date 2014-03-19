<%@ tag pageEncoding="UTF-8"%>
<%@tag import="java.util.List"%>
<%@tag import="com.xqlc.cms.news.version.entity.Version"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<%@ attribute name="id" required="true"%>
<%@ attribute name="value" type="List" required="true" %> 
<%@ attribute name="fileTypeExts" required="false"%>
<%@ attribute name="maxQueueSize" required="false"%>

<script type="text/javascript">
    $(function () {
        var formSubmit = false;
        var uploadComplete = false;
        var fileVersion = [];
        
        var maxQueueSize;//最大文件数目
        var queueSize = 0;//文件队列大小
        $('input[name="oldVersions"]').each(function(){    
            fileVersion.push($(this).val());    
        });  

        $("#file_upload").uploadify({
            'method':'post',
            'auto':true,
            'buttonText':'${xqlc:i18n("ui.cms.chooseFile", locale)}',
            'buttonClass':'button',
            <c:if test="${not empty fileTypeExts}">
            'fileTypeExts': '${fileTypeExts}',
            </c:if>
            
            //判断是否设定了最大上传文件数目
            /* <c:if test="${not empty maxQueueSize}">
            'fileTypeExts': '${fileTypeExts}',
            </c:if> */
            
            'swf':'${ctx}/static/upload/img/uploadify.swf',
            'uploader':'${ctx}/system/version/up1oad;jsessionid=<%=session.getId()%>',
            'onUploadSuccess':function (file, data, response) {
                fileVersion.push(data);
                $('#versionIds').val(fileVersion.join(","));
                $('#uploadTable > tbody').append($('<tr id="'+ data +'"><td>' + file.name + '</td>' +
                        '<td>' + file.size + '</td><td><fmt:message key="ui.cms.recordSaveTime"/></td><td>' +
                        '<a href="${ctx}/system/version/downloadVersion/'+ data +
                        ' title="' + "${xqlc:i18n('ui.cms.download', locale)}" 
                        + '" class="btn"><i title="' + "${xqlc:i18n('ui.cms.download', locale)}" + '" class="icon-arrow-down">' +
                                '</i></a>&nbsp;<a href="javascript:deleteFile(\'' + data
                                + '\')" title="' + "${xqlc:i18n('ui.cms.delete', locale)}" 
                                +'" class="btn"><i title="' + "${xqlc:i18n('ui.cms.download', locale)}" 
                                + '" class="icon-remove">' + '</i></a></td></tr>'));
            }
        });
    });
    var deleteVersion = [];
    function deleteFile(id){
        $.ajax({
            type: "get",
            url: '${ctx}/system/version/delete/' + id,
            dataType: "text",
            success: function (data) {
                if(data == "success"){
                    $('#'+id).remove();
                    deleteVersion.push(id);
                    $('#deleteversionIds').val(deleteVersion.join(","));
                }

                else
                    alert("${xqlc:i18n('ui.cms.errorInDelete', locale)}");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown);
            }
        });
    }
</script> <input type="file" name="file_upload" id="file_upload" />
<br>
<table id="uploadTable" class="table table-bordered table-striped">
	<thead>
		<tr>
			<th><fmt:message key="ui.cms.fileName" /></th>
			<th><fmt:message key="ui.cms.fileSize" /></th>
			<th><fmt:message key="ui.cms.uploadTime" /></th>
			<th><fmt:message key="ui.cms.operate" /></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${value}" var="v">
			<input type="hidden" name="oldVersions" value="${v.id}" />
			<tr id="${v.id}">
				<td>${v.name}</td>
				<td>${v.sizes}</td>
				<td><fmt:formatDate value="${v.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>
					<a href="${ctx}/system/version/downloadVersion/${v.id}" class="btn">
					    <i title="${xqlc:i18n('ui.cms.download', locale)}" class="icon-arrow-down"></i>
					</a> 
					<a href="javascript:deleteFile('${v.id}')" class="btn">
					    <i title="${xqlc:i18n('ui.cms.delete', locale)}" class="icon-remove"></i>
					</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<input type="hidden" id="versionIds" name="versionIds" value="">
<input type="hidden" id="deleteversionIds" name="deleteversionIds"
	value="">