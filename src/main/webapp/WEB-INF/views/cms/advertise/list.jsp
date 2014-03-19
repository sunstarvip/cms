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

<xqlc:extends name="javascript">
<script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.exedit-3.5.js"></script>
	<script type="text/javascript">
	$(function() {
		/* if ($(window).width() < 960) {
			$('body').css({
				'padding-top' : '0px'
			});
		} else {
			$('body').css({
				'padding-top' : '40px'
			});
		} */
		/* $(window).resize(function() {
			if ($(window).width() < 960) {
				$('body').css({
					'padding-top' : '0px'
				});
			} else {
				$('body').css({
					'padding-top' : '40px'
				});
			}
		}); */
		$('.tip-top').tooltip({
			placement : 'top'
		});
   	
    	// 批量删除
    	$('#batch_del').click(function () {
       	 if($("input[name='chk']:checked").length == 0) {
       		 alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
       	 } else {
       		 if (confirm('${xqlc:i18n("ui.cms.sureDelete", locale)}')) {
           		 $('#queryForm')[0].action = "${ctx}/cms/advertise/batchDelete";
                    $('#queryForm').submit();
    				return true;
    			} else {
    			return false;
    		}
       	 }
        });
    	$(window).resize(function() {
			$('#frameDiv').height($(window).height() - 90);
		});
		$('#frameDiv').height($(window).height() - 90);
	});
	function selectTreeNodePath(treeNode) {
		var str = "/" + treeNode.name;
		while (true) {
			if (treeNode.getParentNode() == null)
				return str;
			treeNode = treeNode.getParentNode();
			str = "/" + treeNode.name + str;
		}
	}
	var setting_ = {
		callback : {
			onClick : function(event, treeId, treeNode) {
				var path = selectTreeNodePath(treeNode);
				$('#center_frame').attr('src',
						'${ctx}/cms/adCategory/groupAndAdCategoryList/' + treeNode.id);
			}
		}
	};
	var zNodes_ = [];
	var treeObj;
	$(function() {
		loadJobTree();
	});
	function loadJobTree(nodeId) {
		$.ajax({
			type : "get",
			url : '${ctx}/cms/adGroup/adGroupTree',
			dataType : "json",
			success : function(data) {
				zNodes_ = data;
				treeObj = $.fn.zTree.init($("#groupAndAdCategoryTree"), setting_, zNodes_);
				if (!nodeId) {
					var nodes = treeObj.getNodes();
					if (nodes.length > 0) {
						$('#center_frame').attr('src','${ctx}/cms/adCategory/groupAndAdCategoryList/'+ nodes[0].id);
							treeObj.selectNode(nodes[0]);
					};
				} else {
					var node = treeObj.getNodeByParam("id", nodeId,null);
							treeObj.expandNode(node, true, false, true);
						}
					},
					error : function(XMLHttpRequest, textStatus,
							errorThrown) {
						/* alert(errorThrown); */
					}
				});
	}
	function getAdCategory(advertiseId) {
		var ids = [];
		$("#selectCategory_button").click(function(){
			$("input[name='chk_category']:checked",window.frames["center_frame"].document).each(function() {
				var value = $(this).val();
				var str = value.split(",");
				ids.push(str[0]);
       		});
			$("#adCategoryIds").val(ids.join(","));
			var adCategoryIds = $("#adCategoryIds").val();
			$.post('${ctx}/cms/advertise/bindAdCategory/'+advertiseId + "/" + adCategoryIds,{
		 		},function(response){
			 		if(response == 'success'){
			 			$.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
				 		window.location.href="${ctx}/cms/advertise/advertiseList";
			 		}else{
			 			$.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
			 		}
		 	},'json');
		});
	}
</script>
<script type="text/javascript">
    $(function() {
    	if($("input[name='chk']").length!=0){
        $('#querytable tbody tr').css({'cursor':'pointer'});
        $('#querytable tbody tr').on('click', function() {
            /* $('#myModal_' + $(this).attr('data-row-id')).modal(); */
            window.location.href = '${ctx}/cms/advertise/check/' + $(this).attr('data-row-id');
        });
    	}
    	 $('input[name="chk"]').parent('td').on('click', function(event) {
      	   event.stopPropagation();
          });
    	 // 处理全选
         $(function() {
             $('#chk_all').click(function() {
                 $('[name="chk"]').prop('checked', $('#chk_all').prop('checked'));
             });
         });
    });
</script>
</xqlc:extends>

<xqlc:extends name="content">
	<%-- <div id="pop">
		<div class="control-group">
			<label class="control-label" style="text-align: left; width: 100px"><fmt:message key="ui.cms.type"/></label>
			<div class="controls" style="margin-left: 100px">
				<select data-id="type">
					<option><fmt:message key="ui.cms.pleaseChoose"/></option>
					<option value="1" <c:if test="${type == '1'}">selected</c:if>><fmt:message key="ui.cms.flash"/></option>
					<option value="2" <c:if test="${type == '2'}">selected</c:if>><fmt:message key="ui.cms.image"/></option>
					<option value="3" <c:if test="${type == '3'}">selected</c:if>><fmt:message key="ui.cms.text"/></option>
				</select>
			</div>
		</div>
	</div> --%>
	<form id="queryForm" action="${ctx}/cms/advertise/advertiseList">
		<input type="hidden" id="name" name="queryParameter.name_li" value="${name_li}" /> 
		<input type="hidden" id="type" name="queryParameter.type" value="${type}" /> 
		<input type="hidden" id="adCategoryIds" name="adCategoryIds" value="">
		<div class="appcontent">
		<!-- 广告管理字体 -->
		<h3>
		<span><fmt:message key="ui.cms.advertiseManagement" /></span>	
		</h3>
        </div>
         <div class="toolbar">
            <ul>
                <li class="btn-group">
						<!-- 添加按钮 -->
						<a class="btn btn-small btn-success" href="${ctx}/cms/advertise/create">
			          	<fmt:message key="ui.cms.create" />
			          	</a> 
			          	<!-- 删除按钮 -->
                        <button type="button" id="batch_del" class="btn btn-small btn-danger">
                            <fmt:message key="ui.base.delete" />
                        </button>
			          	<!-- 绑定广告位 -->
                       <%--  <a class="btn btn-small" href="#bindModal" onclick="getAdCategory('${advertise.id}')">
                        <fmt:message key="ui.cms.bindAdPosition"/>
                        </a>  --%>
                </li>
                <%-- <li>
                    <!-- 高级搜索 -->
						<tags:advancedSearch id="advanced_search" template="pop" form="queryForm" input="input_search">
							<input type="text" id="input_search" data-id="name" value="${name_li}" placeholder="<fmt:message key="ui.cms.advertiseName"/>">
						</tags:advancedSearch>
                </li> --%>
            </ul>
        </div>
		<xqlc:table items="${page}" id="querytable">
			<xqlc:row var="advertise">
			    <xqlc:column title='<input id="chk_all" type="checkbox">'>
                <input type="checkbox" name="chk" value="${advertise.id}">
                </xqlc:column>
				<xqlc:column title="${xqlc:i18n('ui.cms.advertiseName',locale)}">
					<!-- <a href="#myModal_${advertise.id}" id="model"  role="button" data-toggle="modal">${advertise.name}</a> -->
					${advertise.name}
				</xqlc:column> 
				<xqlc:column title="${xqlc:i18n('ui.cms.type',locale)}">
					<c:if test="${advertise.type == '1' }">
						<fmt:message key="ui.cms.flash" />
					</c:if>
					<c:if test="${advertise.type == '2' }">
						<fmt:message key="ui.cms.image" />
					</c:if>
					<c:if test="${advertise.type == '3' }">
						<fmt:message key="ui.cms.text" />
					</c:if>
				</xqlc:column>
				<xqlc:column title="${xqlc:i18n('ui.cms.startTime',locale) }"><fmt:formatDate value="${advertise.startTime}"/></xqlc:column>
				<xqlc:column title="${xqlc:i18n('ui.cms.endTime',locale) }"><fmt:formatDate value="${advertise.endTime}"/></xqlc:column>
				<!-- 操作 -->
				<%--
				<xqlc:column title="${xqlc:i18n('ui.cms.operate',locale)}"
					style="text-align: center">
					<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.update"/>" href="${ctx}/cms/advertise/update/${advertise.id}"><i
						class="icon-pencil"></i></a>
					<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.delete"/>"
						onclick="javascript:if(confirm('${xqlc:i18n('ui.cms.sureDelete',locale)}')) window.location.href='${ctx}/cms/advertise/delete/${advertise.id }'"><i
						class="icon-remove"></i></a>
					<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.bindAdPosition"/>" href="#bindModal" id="model" role="button" data-toggle="modal" onclick="getAdCategory('${advertise.id}')"><i
						class="icon-lock"></i></a>
				</xqlc:column>
				 --%>
			</xqlc:row>
		</xqlc:table>
		<!-- 绑定广告位 -->
		<div id="bindModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel"><fmt:message key="ui.cms.adCategoryList"/></h3>
		</div>
		<div id="modalbody" class="modal-body">
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span3">
						<ul id="groupAndAdCategoryTree" class="ztree"></ul>
					</div>
					<div id="frameDiv" class="span9">
						<iframe id="center_frame" name="center_frame" width="100%" height="100%" style="overflow:auto; border:none;"></iframe>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn" id="selectCategory_button" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.ok"/></button>
			<button class="btn" id="cancel" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.cancel"/></button>
		</div>
		</div>
		 <!-- 查看广告详细信息 -->
                	<c:forEach items="${page.content}" var="detail">
		<div id="myModal_${detail.id}" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel"><fmt:message key="ui.base.detail"/></h3>
			</div>
			<div id="modalbody" class="modal-body">
				<div class="row-fluid">
       							<div class="span6">
						<font size="2"><strong><fmt:message key="ui.cms.advertiseName"/>：</strong></font>
						<font size="2">${detail.name}</font>
					</div>
				</div>
				<div class="row-fluid">
       							<div class="span6">
       								<font size="2"><strong><fmt:message key="ui.cms.showPattern"/>：</strong></font>
						<font size="2">
							<c:if test="${detail.showPattern == '1' }"><fmt:message key="ui.cms.fix"/></c:if>
							<c:if test="${detail.showPattern == '2' }"><fmt:message key="ui.cms.float"/></c:if>
							<c:if test="${detail.showPattern == '3' }"><fmt:message key="ui.cms.cmp"/></c:if>
						</font>
       							</div>
					<div class="span6">
						<font size="2"><strong><fmt:message key="ui.cms.type"/>：</strong></font>
						<font size="2">
							<c:if test="${detail.type == '1' }"><fmt:message key="ui.cms.flash"/></c:if>
							<c:if test="${detail.type == '2' }"><fmt:message key="ui.cms.image"/></c:if>
							<c:if test="${detail.type == '3' }"><fmt:message key="ui.cms.text"/></c:if>
						</font>
					</div>
				</div>
				<div class="row-fluid">
       							<div class="span6">
       								<font size="2"><strong><fmt:message key="ui.cms.linkAddress"/>：</strong></font>
						<font size="2">${detail.linkAddress}</font>
       							</div>
       						</div>
       						<div class="row-fluid">
       							<div class="span6">
       								<font size="2"><strong><fmt:message key="ui.cms.ownAdCategoryList"/>：</strong></font>
						<c:forEach items="${detail.adCategoryList}" var="adCategory">
						<font size="2">${adCategory.name}</font>
						</c:forEach>
       							</div>
       							<div class="span6">
       								<font size="2"><strong><fmt:message key="ui.cms.weight"/>：</strong></font>
						<font size="2">${detail.weight}</font>
       							</div>
       						</div> 
       						<div class="row-fluid">
       							<div class="span6">
       								<font size="2"><strong><fmt:message key="ui.cms.startTime"/>：</strong></font>
						<font size="2">${detail.startTime}</font>
       							</div>
       							<div class="span6">
       								<font size="2"><strong><fmt:message key="ui.cms.endTime"/>：</strong></font>
						<font size="2">${detail.endTime}</font>
       							</div>
       						</div>
       				       <!-- 附件 -->
       				     <c:if test="${!empty advertise.versions}">
                           <div class="row-fluid">
                             <xqlc:table id="queryTable" items="${advertise.versions}">
                             <xqlc:row var="version">
                                <xqlc:column title="${xqlc:i18n('ui.cms.fileName', locale)}" style="text-align: center" propertyName="name"/>
                                <xqlc:column title="${xqlc:i18n('ui.cms.fileSize', locale)}" style="text-align: center" propertyName="sizes"/>
                                <xqlc:column title="${xqlc:i18n('ui.cms.uploadTime', locale)}" style="text-align: center" propertyName="createTime"/>
                             </xqlc:row>
                             </xqlc:table>
			  </div>
		    </c:if>
		 </div>
			<div class="modal-footer">
			    <!-- 查看列表 -->
			    <a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.update"/>" href="${ctx}/cms/advertise/update/${advertise.id}"><i
						class="icon-pencil"></i></a>
					<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.delete"/>"
						onclick="javascript:if(confirm('${xqlc:i18n('ui.cms.sureDelete',locale)}')) window.location.href='${ctx}/cms/advertise/delete/${advertise.id }'"><i
						class="icon-remove"></i></a>
					<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.bindAdPosition"/>" href="#bindModal" id="model" role="button" data-toggle="modal" onclick="getAdCategory('${advertise.id}')"><i
						class="icon-lock"></i></a>
				<button class="btn" id="btn_cancel" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.close"/></button>
			</div>
		</div>
	</c:forEach>
		<div class="widget-foot">
			<div class="pagination pagination-centered">
				<xqlc:page page="${page}" formId="queryForm"></xqlc:page>
			</div>
		</div>
	</form>
</xqlc:extends>

<%-- <jsp:include page="/WEB-INF/views/cms/base/baseAddvertisePage.jsp" /> --%>
<jsp:include page="/WEB-INF/views/cms/base/baseAddvertisePage.jsp" />
