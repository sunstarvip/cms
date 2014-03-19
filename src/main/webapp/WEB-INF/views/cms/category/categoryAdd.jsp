<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="title">
	<fmt:message key="ui.cms.categoryManagement"/>
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
    #preview{width:50px;height:50px;solid #000;overflow:hidden;}
	#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
	#large{position:absolute;display:none;z-index:999;width:262px;height:207px;}
</style>
</xqlc:extends>

<xqlc:extends name="body">

    <div class="appcontent">
        <h3>
            <span><fmt:message key="ui.cms.edit"/></span>
        </h3>
    </div>
   <!-- 人员选择器 -->
	
	<!-- 模版选择器 -->
	<div id="templateModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="templateModalLabel" style="width:750px;left:35%">
		<div class="modal-header">
			<button type="button" id = "cancel" class="close">×</button>
			<h4 id="myModalLabel"><fmt:message key="ui.cms.templateList"/></h4>
		</div>
		<div id="modalbody" class="modal-body" style="height:350px;">
			<div class="container-fluid">
				<div class="row-fluid">
					<xqlc:table id="queryTable" items="${templateInfo}">
                            <xqlc:row var="template">
                                <xqlc:column style="text-align: center" title=" ">
                                    <input type="radio" name="temp_chk" value="${template.path}" />
                                </xqlc:column>
                                <xqlc:column title="${xqlc:i18n('ui.cms.templateName',locale)}" style="text-align: center">
                                    ${template.name}
                                </xqlc:column>
                                <xqlc:column title="${xqlc:i18n('ui.cms.templatePath',locale)}" style="text-align: center">
                                    ${template.path}
                                </xqlc:column>
                            </xqlc:row>
                    </xqlc:table>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn btn-primary" id="selectTemplate_button"><fmt:message key="ui.cms.ok"/></button>
			<input type="button" class="btn" name="cancel" value="${xqlc:i18n('ui.cms.cancel',locale)}">
		</div>
	</div>
    
    <!-- 栏目审核人 -->
     <!-- 内容审核人 -->
     <!-- 评论审核人 -->
    <!-- 角色Modal -->
     <!-- 管理角色Modal -->
    
		<form:form id="editForm" class="form-horizontal" action="" modelAttribute="category" 
		    cssClass="form-horizontal validation" enctype="multipart/form-data" method="post">
			<form:hidden path="id"/>
			<input type="hidden" value="${nodeId}" name="parentId"></input>
			<input type="hidden" value="${root }" name="siteId"></input>
			
			<div class="headInfo clearfix">
		        <div class="actions">
		        </div>
             </div>
		<div class="block-fluid clearfix">
             <div class="formlayout doubleColumn">
                <ul>
                  <li class="fullWidth">
                     <!-- 栏目名 -->
                     <span><fmt:message key="ui.cms.categoryName"/>:</span>
                     <div class="formright">
                     <input type="text" id="name" name="name" value="${category.name}" class="{required:true}"/>
                     <span id="checkName"></span>
                     </div>
                  </li>
                  <li class="fullWidth">
                     <!-- 栏目英文名 -->
                     <span><fmt:message key="ui.cms.categoryEnglishName"/>:</span>
                     <div class="formright">
                     <input type="text" id="englishName" name="englishName" value="${category.englishName}" placeholder="${xqlc:i18n('ui.cms.ClickToGenerate', locale)}"
					 class="{required:true}"/>
					<span id="checkEname"></span>
                     </div>
                  </li>
                  <li class="fullWidth">
                     <!-- 栏目排序 -->	
                     <span><fmt:message key="ui.cms.categorySort"/>:</span>
                     <div class="formright">
                     <input type="text" id="categorySort" name="categorySort" value="${category.categorySort}" class="{required:true}"/>
					 <span id="checkName"></span>
                     </div>
                  </li>
                   <li>
                       <!--类型 -->
                       <span><fmt:message key="ui.cms.type"/>:</span>
                       <div class="formright">
                       <form:select path="type" cssClass="{required:true}">
							<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
							<form:option value="1"><fmt:message key="ui.cms.commonCategory"/></form:option>
							<form:option value="2"><fmt:message key="ui.cms.linkCategory"/></form:option>
	                   </form:select>
                       </div>
                   </li>
                   <!-- 链接栏目 -->
                   <li id="visitPath" style="display: none">
                       <span><fmt:message key="ui.cms.visitPath"/>:</span>
                       <div class="formright">
                       <form:input path="path" placeholder="http(s)://"  cssClass="{required:true}"/>
                       </div>
                       
                   </li>
                   <li class="fullWidth"> 
                   <!-- 栏目是否可见 -->
                   <span><fmt:message key="ui.cms.categoryVisible"/>:</span>
                   <div class="formright">
                   <form:select path="visible" cssClass="{required:true}" value="yes">
						<form:option value="yes"><fmt:message key="ui.cms.visible"/></form:option>
						<form:option value="no"><fmt:message key="ui.cms.invisible"/></form:option>
				   </form:select>
                   </div>
                   </li>
                  <li class="fullWidth" style="display: none">
                      <!-- 栏目是否头部菜单可见 -->
                      <span><fmt:message key="ui.cms.categoryTopVisible"/>:</span>
                      <div class="formright">
                          <form:select path="topVisible" cssClass="{required:true}" value="no">
                              <form:option value="yes"><fmt:message key="ui.cms.visible"/></form:option>
                              <form:option value="no"><fmt:message key="ui.cms.invisible"/></form:option>
                          </form:select>
                      </div>
                  </li>
                  <li class="fullWidth">
                      <!-- 栏目是否允许订阅 -->
                      <span><fmt:message key="ui.cms.categoryFocusable"/>:</span>
                      <div class="formright">
                          <form:select path="focusable" cssClass="{required:true}">
                              <form:option value="yes"><fmt:message key="ui.cms.focusable"/></form:option>
                              <form:option value="no"><fmt:message key="ui.cms.unfocusable"/></form:option>
                          </form:select>
                      </div>
                  </li>
                   <li style="display: none">
                   <!-- 栏目审核方式 -->
                   <span><fmt:message key="ui.cms.categoryAuditMode"/>:</span>
                   <div class="formright">
                   <form:select path="auditCategoryMethod" cssClass="{required:true}" value="1">
						<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
						<form:option value="1"><fmt:message key="ui.cms.workflow"/></form:option>
						<form:option value="2"><fmt:message key="ui.cms.personnelAudit"/></form:option>
				   </form:select>
                   </div>
                   </li>
                   <li id="categoryCheck" style="display:none">
                    <!-- 绑定栏目审核角色 -->
                    <span><fmt:message key="ui.cms.checkCategoryRole"/>:</span>
                    <div class="formright">
                     <xqlc:ajaxSelect id="type_roleIds_c" name="roleIds_c" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleIds_c_id}"/>
						          <span id="owners_id" style="display: none;"></span>
						           <script type="text/javascript">
						           function formatResult(data) {
						           	return '<h5>' + data.name + '</h5>';
						           }
						           function formatSelection(data) {
						           	return data.name;
						           }
						           </script>
                    </div>
                   
                   </li>
                   <!-- 调样式用 -->
                   <li style="display: none">
                       <span></span>
                       <div class="formright">
                       <input name="none" placeholder="none"  class="{required:true}"/>
                       </div>
                       
                   </li>
                   <li class="fullWidth" style="display: none">
                      <!-- 审核内容 -->
                      <span><fmt:message key="ui.cms.auditContent"/>:</span>
                      <div class="formright">
                      <form:select path="auditCatcontent" cssClass="{required:true,messages:{required:' '}}" value="no">
							<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
							<form:option value="yes"><fmt:message key="ui.cms.yes"/></form:option>
							<form:option value="no"><fmt:message key="ui.cms.no"/></form:option>
					 </form:select>
                      </div>
                   </li>
                   <li id="auditContentMethod" style="display: none">
                   <!-- 内容审核方式 -->
                   <span><fmt:message key="ui.cms.contentAuditMode"/>:</span>
                   <div class="formright">
                   <form:select path="auditCatcontentMethod" cssClass="{required:true,messages:{required:' '}}">
							<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
							<form:option value="1"><fmt:message key="ui.cms.workflow"/></form:option>
							<form:option value="2"><fmt:message key="ui.cms.personnelAudit"/></form:option>
					</form:select>
                   </div>
                   </li>
                   <li id="contentCheck" style="display:none">
                   <!-- 绑定内容审核角色 -->
                   <span><fmt:message key="ui.cms.contentCheckUser"/>:</span>
                   <div class="formright">
                   <xqlc:ajaxSelect id="type_roleIds_con" name="roleIds_con" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleIds_con_id}"/>
						          <span id="owners_id" style="display: none;"></span>
						           <script type="text/javascript">
						           function formatResult(data) {
						           	return '<h5>' + data.name + '</h5>';
						           }
						           function formatSelection(data) {
						           	return data.name;
						           }
						           </script>
                   </div>
                   </li>
                   <li class="fullWidth" style="display: none">
                   <!-- 评论内容 -->
                   <span><fmt:message key="ui.cms.reviewContent"/>:</span> 
                   <div class="formright">
                   <form:select path="reviewCatcontent" cssClass="{required:true,messages:{required:' '}}" value="no">
							<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
							<form:option value="yes"><fmt:message key="ui.cms.yes"/></form:option>
							<form:option value="no"><fmt:message key="ui.cms.no"/></form:option>
				   </form:select>   
                   </div>
                   </li>
                   <li id="auditAssess" style="display: none" class="fullWidth">
                   <!-- 审核评论 -->
                   <span><fmt:message key="ui.cms.auditReview"/>:</span>
                   <div class="formright">
                   <form:select path="auditCatreview" cssClass="{required:true,messages:{required:' '}}">
							<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
							<form:option value="yes"><fmt:message key="ui.cms.yes"/></form:option>
							<form:option value="no"><fmt:message key="ui.cms.no"/></form:option>
				   </form:select>
                   </div>
                   </li>
                   <li id="auditReviewMethod" style="display: none">
                   <!-- 评论审核方式 -->
                   <span><fmt:message key="ui.cms.reviewAuditMode"/>:</span>
                   <div class="formright">
                   <form:select path="auditCatreviewMethod" cssClass="{required:true,messages:{required:' '}}">
							<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
							<form:option value="1"><fmt:message key="ui.cms.workflow"/></form:option>
							<form:option value="2"><fmt:message key="ui.cms.personnelAudit"/></form:option>
				   </form:select>
                   </div>
                   </li>
                   <li id="reviewCheck" style="display:none">
                   <!-- 绑定评论审核角色 -->
                   <span><fmt:message key="ui.cms.reviewCheck"/>:</span>
                   <div class="formright">
                   <xqlc:ajaxSelect id="type_roleIds_pin" name="roleIds_pin" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleIds_pin_id}"/>
						          <span id="owners_id" style="display: none;"></span>
						           <script type="text/javascript">
						           function formatResult(data) {
						           	return '<h5>' + data.name + '</h5>';
						           }
						           function formatSelection(data) {
						           	return data.name;
						           }
						           </script>
                   </div>
                   </li>
                   <li class="fullWidth">
                   <!-- Logo -->
                   <span><fmt:message key="ui.cms.logo"/>:</span>
                   <div class="formright">
                   <input type="file" id="logoImage" name="file" value="${category.logoImage}" onchange="previewImage(this)"/>
				   <button id="delete" type="button" class="btn"><fmt:message key="ui.cms.delete"/></button>
					<div id="large"></div>
					<span id="preview">
						<img id="imghead" width=50 height=50 src="${ctx}/cms/category/showImage/${category.id}">
					</span>
                   </div>
                   </li>
                   <li id="templateCheck" class="fullWidth">
                   <%-- 栏目模板绑定 --%>
                    <input type="hidden" id="content_template_" name="content_template_" value="${content.templatePath}" >
                    <input type="hidden" id="category_template_" name="category_template_" value="${category.contentPath}">
                    <span><fmt:message key="ui.cms.bindCategoryTemplate"/>:</span>
                    <div class="formright">
                    <input type="text" name="templatePath" id="templatePath" value="${category.templatePath}" readonly="readonly">
						<a href="#templateModal" id="category_template" role="button" class="btn" data-toggle="modal">
						    <fmt:message key="ui.cms.chooseTemplate"/>
						</a>
                    </div>
                   </li>
                   <li class="fullWidth">
                   <!-- 为内容绑定模版 -->
                   <span><fmt:message key="ui.cms.bindContentTemplate"/>:</span>
                   <div class="formright">
                   <input type="text" name="contentPath" id="contentPath" readonly="readonly" value="${category.contentPath}">
						<a href="#templateModal" id="content_template" role="button" class="btn" data-toggle="modal">
						    <fmt:message key="ui.cms.chooseTemplate"/>
						</a>
                   </div>
                   </li>
                   <li class="fullWidth">
                   <!-- 绑定角色 -->
                   <span><fmt:message key="ui.cms.boundRole"/>:</span>
                   <div class="formright">
                    <xqlc:ajaxSelect id="type_roleIds" name="roleIds" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleIds_id}"/>
						          <span id="owners_id" style="display: none;"></span>
						           <script type="text/javascript">
						           function formatResult(data) {
						           	return '<h5>' + data.name + '</h5>';
						           }
						           function formatSelection(data) {
						           	return data.name;
						           }
						           </script>
                   </div>
                   </li>
                   <li class="fullWidth">
                   <!-- 绑定管理角色 -->
                   <span><fmt:message key="ui.cms.managementRole"/>:</span>
                   <div class="formright">
                    <xqlc:ajaxSelect id="type_roleIds_p" name="roleIds_p" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleIds_p_id}"/>
						          <span id="owners_id" style="display: none;"></span>
						           <script type="text/javascript">
						           function formatResult(data) {
						           	return '<h5>' + data.name + '</h5>';
						           }
						           function formatSelection(data) {
						           	return data.name;
						           }
						           </script>
                   </div>
                   </li>
                </ul>
               </div>
                <div class="footer tar">
                    <button class="btn btn-primary" type="button" id="saveType_btn"><fmt:message key="ui.cms.save"/></button>
					<input class="btn" type="reset" value="${xqlc:i18n('ui.cms.reset',locale)}" />
					<a href="javascript:history.go(-1);" class="btn" data-dismiss="modal" aria-hidden="true">
					<i class="icon-remove"></i><fmt:message key="ui.cms.cancel"/></a>
               </div>
         </div>	
			
		</form:form>

</xqlc:extends>

<xqlc:extends name="javascript">
	<script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.exedit-3.5.js"></script>
     <!-- 验证框架 -->
   <script type="text/javascript">
	    $(function() {
	     $("#editForm").validate();
	 });
   </script>
    
	<script type="text/javascript">
	
	// 自动截取站点名的首字母
	$(function() {
        $('#name').on('change', function() {		
    		$('#englishName').val(getFirst($('#name').val()));
    	});
		$("#englishName").on('blur',function() {
        	var result = $("#englishName").val();
        	if(!(/^[A-Za-z0-9]+$/.test(result))) {
        		$("#checkEname").html("<font color='#B94A48'>请输入数字或字母</font>");
        	};
        	if((/^[A-Za-z0-9]+$/.test(result)) || result == ""){
        		$("#checkEname").html("");
        	};
        });
	});
	//各个DIV得联动效果
	$(function() {
		$('#type').on('change',function() {
			var value = $('#type').val();
			if(value ==""||value == "1") {
				$("#visitPath").hide();
			} else {
				$("#visitPath").show();
			}
		});
		$('#auditCategoryMethod').on('change',function() {
			var value = $('#auditCategoryMethod').val();
			if(value ==""||value == "1") {
				$("#categoryCheck").hide();
				$("#categoryCheck_a").hide();
			} else {
				$("#categoryCheck").show();
				$("#categoryCheck_a").show();
			}
		});
		$('#auditCatcontent').on('change',function() {
			var value = $('#auditCatcontent').val();
			if(value ==""||value == "no") {
				$("#auditContentMethod").hide();
				$("#contentCheck").hide();
				$("#auditCatcontentMethod").val("");
			} else {
				$("#auditContentMethod").show();
			}
		});
		$('#auditCatcontentMethod').on('change',function() {
			var value = $('#auditCatcontentMethod').val();
			if(value == ""||value == "1") {
				$("#contentCheck").hide();
				$("#contentCheck_b").hide();
			} else {
				$("#contentCheck").show();
				$("#contentCheck_b").show();
			}
		});
		$('#reviewCatcontent').on('change',function() {
			var value = $('#reviewCatcontent').val();
			if(value == ""||value == "no") {
				$("#auditAssess").hide();
				$('#auditCatreview').val("");
				$('#auditCatreviewMethod').val("");
				$("#auditReviewMethod").hide();
				$("#reviewCheck").hide();
			} else {
				$("#auditAssess").show();
			}
		});
		$('#auditCatreview').on('change', function(){
			var str = $('#auditCatreview').val();
			if(str ==""||str =="no"){
				$("#auditReviewMethod").hide();
				$("#reviewCheck").hide();
				$('#auditCatreviewMethod').val("");
			} else {
				$("#auditReviewMethod").show();
			}
		});
		$('#auditCatreviewMethod').on('change',function() {
			var value = $('#auditCatreviewMethod').val();
			if(value == ""||value == "1") {
				$("#reviewCheck").hide();
				$("#reviewCheck_c").hide();
			} else {
				$("#reviewCheck").show();
				$("#reviewCheck_c").show();
			}
		});
	});
	//删除图片
	$(function() {
		$("#delete").click(function() {
			$("#logoImage").val('');
			$("#imghead").hide();
		});
	});
	</script>
	<script type="text/javascript">
	//栏目树
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
    		  
        edit: {
               drag: {
                   autoExpandTrigger: true,
                   prev: dropPrev,
                   inner: dropInner,
                   next: dropNext
               },
               enable: true,
               showRemoveBtn: false,
               showRenameBtn: false
           },
           data: {
               simpleData: {
                   enable: true
               }
           },
           callback : {
               beforeDrag: beforeDrag,
               onRightClick: OnRightClick,
               onClick : function(event, treeId, treeNode) {
                   var path = selectTreeNodePath(treeNode);
                   var mark = $("#mark").val();
                   if(mark == "content") {
                       $('#content_frame').attr('src', '${ctx}/cms/content/treeList/' + treeNode.id);
                   }
               },
               onDrop: onDrop,
               beforeDragOpen: beforeDragOpen
           }
       };
       var zNodes_ = [];
       var treeObj;
       var thisNode;
       $(function() {
           rMenu = $("#rMenu");
           hideRMenu();
           loadCategoryTree();
       });
       function loadCategoryTree(nodeId) {
           $.ajax({
               type : "get",
               url : '${ctx}/cms/category/tree',
               dataType : "json",
               success : function(data) {
                   zNodes_ = data;
                   treeObj = $.fn.zTree.init($("#categoryTree"), setting_, zNodes_);
                   if (!nodeId) {
                       var nodes = treeObj.getNodes();
                       var mark = $("#mark").val();
                       if (nodes.length > 0) {
                           if(mark == "content") {
                               $('#content_frame').attr('src','${ctx}/cms/content/treeList/' + nodes[0].id);
                               treeObj.selectNode(nodes[0]);
                           }else {
                               $('#content_frame').attr('src','${ctx}/cms/category/list');
                           }
                       };
                   } else {
                       var node = treeObj.getNodeByParam("id", nodeId,null);
                       treeObj.expandNode(node, true, false, true);
                   }
               },
               error : function(XMLHttpRequest, textStatus,
               	    errorThrown) {}
           });
       }
       
       //拖拽操作结束后传值到后台修改父id
       function onDrop(event, treeId, treeNode) {
           treeObj.selectNode(treeNode);
           if(treeNode[0].getParentNode()==null){
               loadCategoryTree(pid);
               $.pageMessage('${xqlc:i18n("ui.cms.operError",locale)}');
           }else{
               var id = treeNode[0].id;
               var pid = treeNode[0].getParentNode().id;
               $.get('${ctx}/cms/category/moveCategory/' +pid + '/' + id, {}, function(response) {
                   if (response == 'success') {
                    $.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
                    loadCategoryTree(pid);
                   } else {
                       $.pageMessage('${xqlc:i18n("ui.cms.operError",locale)}');
                   }
               }, 'json'); 
           }
       }
     
       function dropPrev(treeId, nodes, targetNode) {
           var pNode = targetNode.getParentNode();
           if (pNode && pNode.dropInner === false) {
               return false;
           } else {
               for (var i=0,l=curDragNodes.length; i<l; i++) {
                   var curPNode = curDragNodes[i].getParentNode();
                   if (curPNode && curPNode !== targetNode.getParentNode() && curPNode.childOuter === false) {
                       return false;
                   }
               }
           }
           return true;
       }
       
       function dropInner(treeId, nodes, targetNode) {
           if (targetNode && targetNode.dropInner === false) {
               return false;
           } else {
               for (var i=0,l=curDragNodes.length; i<l; i++) {
                   if (!targetNode && curDragNodes[i].dropRoot === false) {
                       return false;
                   } else if(curDragNodes[i].parentTId && curDragNodes[i].getParentNode() !== targetNode && curDragNodes[i].getParentNode().childOuter === false) {
                       return false;
                   }
               }
           }
           return true;
       }
       
       function dropNext(treeId, nodes, targetNode) {
           var pNode = targetNode.getParentNode();
           if (pNode && pNode.dropInner === false) {
               return false;
           } else {
               for (var i=0,l=curDragNodes.length; i<l; i++) {
                   var curPNode = curDragNodes[i].getParentNode();
                   if (curPNode && curPNode !== targetNode.getParentNode() && curPNode.childOuter === false) {
                       return false;
                   }
               }
           }
           return true;
       }

       function beforeDrag(treeId, treeNodes) {
           for (var i=0,l=treeNodes.length; i<l; i++) {
               if (treeNodes[i].drag === false) {
                   curDragNodes = null;
                   return false;
               }
               if (treeNodes[i].parentTId && treeNodes[i].getParentNode().childDrag === false) {
                   curDragNodes = null;
                   return false;
               }
           }
           curDragNodes = treeNodes;
           return true;
       }
       
       function beforeDragOpen(treeId, treeNode) {
           autoExpandNode = treeNode;
           return false;
       }
	//右键菜单
    function OnRightClick(event, treeId, treeNode) {
    	var mark = $("#mark").val();
		if(mark == 'category'){
			if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
				treeObj.cancelSelectedNode();
				showRMenu("${siteId}", event.clientX, event.clientY, treeNode);
			} else if (treeNode && !treeNode.noR) {
				treeObj.selectNode(treeNode);
				showRMenu("node", event.clientX, event.clientY, treeNode);
			}
			thisNode = treeNode;
		} else if(mark == content){
			
		};
	}
      
    function showRMenu(type, x, y,treeNode) {
    	$("#rMenu ul").show();
		if (treeNode.getParentNode()== null) {
			$("#m_add").hide();
			$("#m_add_next").show();
			$("#m_del").hide();
			$("#m_update").hide();
			$("#m_copy").hide();
			$("#m_publish").hide();
		} else {
			$("#m_add").show();
			$("#m_add_next").show();
			$("#m_del").show();
			$("#m_update").show();
			$("#m_copy").show();
			$("#m_publish").show();
		}
		rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
		$("body").bind("mousedown", onBodyMouseDown);
	}
      
	function hideRMenu() {
		if (rMenu) rMenu.css({"visibility": "hidden"});
		$("body").unbind("mousedown", onBodyMouseDown);
	}
	
	function onBodyMouseDown(event){
		if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
			rMenu.css({"visibility" : "hidden"});
		}
	}
	
	//新增同级栏目
	function addType(){
		hideRMenu();
		var nodes = treeObj.getSelectedNodes();
		var pid = nodes[0].getParentNode().id;
		$('#myModal').modal({}).attr({'data-id':pid});
		$('#myModal').attr({'data-flag':'create'});
	}
	
	//新增下级栏目
	function addNextType(){
		hideRMenu();
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
		/* $('#myModal').modal({}).attr({'data-id':id});
		$('#myModal').attr({'data-flag':'create'}); */
		$('#content_frame').attr('src','${ctx}/cms/category/create?nodeId='+id);
	}
	
	//删除栏目
	function delType() {
		hideRMenu();
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
		$.get('${ctx}/cms/content/deletecheck/' + id, {}, function(response){
			if(response) {
				if(confirm('${xqlc:i18n("ui.cms.sureDelete",locale)}')) {
					deleteCategory();
				};
			}else {
				if(confirm('${xqlc:i18n("ui.cms.deleteCategory",locale)}')) {
					deleteCategory();
	        	};
			};
		}, 'json');
	}
	
	//删除栏目的递归
	function deleteCategory() {
		hideRMenu();
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
		var selectTypeId = nodes[0].getParentNode().id;
		$.get('${ctx}/cms/category/deleteOnRight/' + id, {}, function(r) {
			if(r == 'success') {
				loadCategoryTree(selectTypeId);
				$.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
			}else {
				$.pageMessage('${xqlc:i18n("ui.cms.operError",locale)}');
			}
		}, 'json');
	}
	
	//修改栏目
	function updateType() {
		hideRMenu();
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
		var pid = nodes[0].getParentNode().id;
		$('#myModal').modal({}).attr({'data-id':pid});
		$('#myModal').attr({'data-flag':'update'});
		$.get('${ctx}/cms/category/updateCategory/' + id, {}, function(response) {
			$("#id").val(response.id);
			$("#name").val(response.name);
			$("#englishName").val(response.englishName);
			$("#type").val(response.type);
			if($("#type").val() == '2'){
				$("#visitPath").show();
				$("#path").val(response.path);
			}

			$("#auditCategoryMethod").val(response.auditCategoryMethod);
			if($("#auditCategoryMethod").val() == '2') {
				$("#categoryCheck").show();
			} 
			$("#auditCatcontent").val(response.auditCatcontent);
			if($("#auditCatcontent").val() == 'yes') {
				$("#auditContentMethod").show();
				$("#auditCatcontentMethod").val(response.auditCatcontentMethod);
			}
			if($("#auditCatcontentMethod").val() == '2'){
			} 
			$("#reviewCatcontent").val(response.reviewCatcontent);
			if($("#reviewCatcontent").val() == 'yes') {
				$("#auditAssess").show();
				$("#auditCatreview").val(response.auditCatreview);
			}
			if($("#auditCatreview").val() == 'yes') {
				$("#auditReviewMethod").show();
				$("#auditCatreviewMethod").val(response.auditCatreviewMethod);
			}
			if($("#auditCatreviewMethod").val() == '2') {
				$("#reviewCheck").show();
			} 
			$("#imghead").attr("src", "${ctx}/cms/category/showPhoto/" + response.id);
			$("#templatePath").val(response.templatePath);
			$("#contentPath").val(response.contentPath);
			$('#myModal').modal();
		}, 'json');
	};
	
	//复制栏目ID
	function copyId() {
		hideRMenu();
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
		 $("#m_copy").zclip({
                path: "${ctx}/static/zClip/ZeroClipboard.swf",
                copy: function() {
                    return id;
                },
                //复写copy后自带的提示弹框,实现空弹框
                afterCopy: function() {
                    
                }
            });
	}
	
	//发布栏目
	function publish() {
		hideRMenu();
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
		$.get('${ctx}/cms/category/publishCategory/' + id, {}, function(r) {
			if(r == 'success') {
				loadCategoryTree(id);
				treeObj.expandNode(thisNode, true, false, true);
				$.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
			}else {
				$.pageMessage('${xqlc:i18n("ui.cms.operError",locale)}');
			}
		}, 'json');

		
	}
	
	//ajax加载样式
	$(function() {
		var ajaxbg = $("#background,#progressBar"); 
		ajaxbg.hide(); 
		$(document).ajaxStart(function () { 
		    ajaxbg.show(); 
		}).ajaxStop(function () { 
		    ajaxbg.hide(); 
		});
		
		//验证栏目中文名和英文名是否重复
		$("#name").on('blur', function() {
			$.get('${ctx}/cms/category/repeat?categoryId=' + $("#id").val() + '&parentId=${nodeId}', {
				'category.name':$('#name').val()
			}, function(response){
				if(!response) {
					$("#checkName").html("<font color='#B94A48'>该栏目名称已存在，请重新输入!</font>");
				}else {
					$("#checkName").html("");
				};
			}, 'json');
			/* $.get('${ctx}/cms/category/repeatEName?categoryId=' + $("#id").val() + '&parentId=${nodeId}', {
				'category.englishName':$('#englishName').val()
			}, function(response){
				if(!response) {
					$("#checkEname").html("<font color='#B94A48'>该栏目英文名已存在,请重新输入!</font>");
				}else {
					$("#checkEname").html("");
				};
			}, 'json'); */
		});
		
		$("#englishName").on('change',function(){
			$.get('${ctx}/cms/category/repeatEName?categoryId=' + $("#id").val() + '&parentId=${nodeId}', {
				'category.englishName':$('#englishName').val()
			}, function(response){
				if(!response) {
					$("#checkEname").html("<font color='#B94A48'>该栏目英文名已存在,请重新输入!</font>");
				}else {
					$("#checkEname").html("");
				};
			}, 'json');
		});
		
		//modal关闭后清空值
		$('#myModal').on('hidden', function () {
			$("#id").val('');
			$("#name").val('');
			$("#englishName").val('');
			$("#type").val('');
			$("#path").val('');
			$("#auditCategoryMethod").val('');
			$("#categoryCheckName").val('');
			$("#auditCatcontent").val('');
			$("#auditCatcontentMethod").val('');
			$("#contentCheckName").val('');
			$("#reviewCatcontent").val('');
			$("#auditCatreview").val('');
			$("#auditCatreviewMethod").val('');
			$("#reviewCheckName").val('');
			$("#logoImage").val('');
			$("#templatePath").val('');
			$("#contentPath").val('');
			$("#checkName").html("");
			$("#imghead").attr('src','');
		});
		
		//保存栏目
		$('#saveType_btn').click(function() {
			/* if ($('#editForm').valid()) {
            	$('#editForm')[0].action = "${ctx}/cms/category/save/" + $('#myModal').attr('data-id');
                   $('#editForm').submit();
            } */
            window.parent.href="${ctx}/cms/category/categoryTree";
            $('#editForm')[0].action = "${ctx}/cms/category/save";
                  $('#editForm').submit();
        }); 
    });
	
	
	 
	$(function() {
		var chk_val;
		var temp_val;
		$("#selectUser_button").click(function() {
		    $("input[name='chk']:checked",window.frames["center_frame"].document).each(function() {
        			chk_val = $(this).val();
        			$("#userModal").hide();
             		});
			if($('#userModal').attr('data-flag') == 'category'){
			 var result = chk_val.split(",");
			 $('#categoryCheckId').val(result[0]);
			 $('#categoryCheckName').val(result[1]);
			} else  if($('#userModal').attr('data-flag') == 'content'){
			 var result = chk_val.split(",");
			 $('#contentCheckId').val(result[0]);
			 $('#contentCheckName').val(result[1]);
			}else if($('#userModal').attr('data-flag') == 'review'){
			 var result = chk_val.split(",");
			 $('#reviewCheckId').val(result[0]);
			 $('#reviewCheckName').val(result[1]);
			}
		});
				
		$("#category_role").click(function() {
			 $('#userModal').attr({'data-flag':'category'});
		});
		
		$("#content_role").click(function() {
			 $('#userModal').attr({'data-flag':'content'});
		});
		
		$("#review_role").click(function() {
			 $('#userModal').attr({'data-flag':'review'});
		});
		$('#userModal').on('hidden', function () {
			  $('#userModal').attr({'data-flag':''});
			  $("input[name='chk']",window.frames["center_frame"].document).attr("checked",false);
		});
		
		$("#selectTemplate_button").on('click',function() {
			temp_val = $('input[name = "temp_chk"]:checked').val();
			$("#templateModal").hide();
			$('#templateModal').modal('hide');
		    if($('#templateModal').attr('data-flag') == 'categoryTemplate'){
				$('#templatePath').val(temp_val);
			}
			if($('#templateModal').attr('data-flag') == 'contentTemplate'){
				$('#contentPath').val(temp_val);
			} 
		});
		$("input[name = 'cancel']").on('click',function(){
			$('#templateModal').modal('hide');
		});
		
		$("#cancel").on('click',function(){
			$('#templateModal').modal('hide');
		});
		$("#category_template").on('click',function() {
			$('#templateModal').attr({'data-flag':'categoryTemplate'});
		});
		
		$("#content_template").on('click',function() {
			$('#templateModal').attr({'data-flag':'contentTemplate'});
		});
		
		$('#templateModal').on('hidden', function () {
			  $('#templateModal').attr({'data-flag':''});
			  $("input[name='temp_chk']").attr("checked",false);
		});
		
		$('input[name="cancel"]').on('click',function() {
			$("#userModal").hide();
			$("#templateModal").hide();
		});
	});
	</script>
	<script type="text/javascript">
    //图片预览处理
   	function previewImage(file) {
  		var MAXWIDTH  = 50;
  		var MAXHEIGHT = 50;
  		var div = document.getElementById('preview');
  		if (file.files && file.files[0]) {
    		div.innerHTML = '<img id=imghead>';
    		var img = document.getElementById('imghead');
			var ei = document.getElementById("large");

    		img.onload = function() {
	      		var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
	      		img.width = rect.width;
	     		img.height = rect.height;
	      		img.style.marginLeft = rect.left+'px';
	      		img.style.marginTop = rect.top+'px';
	    	}
	   		var reader = new FileReader();
	   		reader.onload = function(evt) {
	   			img.src = evt.target.result;
	   		}
	   		reader.readAsDataURL(file.files[0]);
			img.onmousemove = function(event){

				event = event || window.event;
				ei.style.display = "block";
				ei.innerHTML = '<img style="border:1px solid gray;" src="' + this.src + '" />';
				ei.style.top  = document.body.scrollTop + event.clientY + "px";
				ei.style.left = document.body.scrollLeft + event.clientX + "px";
			}
			img.onmouseout = function(){
				ei.innerHTML = "";
				ei.style.display = "none";
			}
	  	}else {
	    	var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
	    	file.select();
	    	var src = document.selection.createRange().text;
	    	div.innerHTML = '<img id=imghead>';
	    	var img = document.getElementById('imghead');
	    	img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
	    	var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
	    	status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
	    	div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;margin-left:"+rect.left+"px;"+sFilter+src+"\"'></div>";
	  	}
	}
    
	function clacImgZoomParam( maxWidth, maxHeight, width, height){
    	var param = {top:0, left:0, width:width, height:height};
    	if( width>maxWidth || height>maxHeight ){
        	rateWidth = width / maxWidth;
        	rateHeight = height / maxHeight;
        	if( rateWidth > rateHeight ){
            	param.width =  maxWidth;
            	param.height = Math.round(height / rateWidth);
        	}else {
            	param.width = Math.round(width / rateHeight);
            	param.height = maxHeight;
        	}
    	}
    	param.left = Math.round((maxWidth - param.width) / 2);
    	param.top = Math.round((maxHeight - param.height) / 2);
    	return param;
	}
	
    $(function() {
        //选择角色
        var chk_roleIds = [];
        $("#selectRole_btn").click(function() {
             $("input[name='chk']:checked",window.frames["role_frame"].document).each(function() {
                var curVal = $(this).val();
                var index = curVal.indexOf(",");
                var roleId = curVal.substring(0,index);
                var roleName = curVal.substring(index+1);
                //
                var addRoleIndex =$.inArray(roleId,chk_roleIds);
                if(addRoleIndex == -1) {
                    chk_roleIds.push(roleId);
                     $("#tab > tbody").append($('<tr><td><input type="checkbox" name="tab_chk_role" value="'+ roleId +'" /></td>'+
                            '<td>'+ roleName +'</td></tr>'));
                }
            });
        });
         
        $('#tab_chk_all').click(function() {
            $('input[name="tab_chk_role"]').prop('checked', $('#tab_chk_all').prop('checked'));
        });
         
        $("#delRolesBtn").click(function() {
            if($("input[name='tab_chk_role']:checked").length > 0) {
                $("input[name='tab_chk_role']:checked").each(function() {
                    var delRoleId = $(this).val();
                    var delRoleIndex =$.inArray(delRoleId,chk_roleIds);
                    $(this).parent().parent().remove();
                    if(delRoleIndex != -1) {
                        chk_roleIds.splice(delRoleIndex,1);
                    }
                 });
            }
            $("#tab_chk_all").prop("checked", false);
            $("#delRolesBtn").hide();
        });
         

        $('form').on('submit',function() {
            $("#roleIds").val(chk_roleIds.join(","));
        });
        
        $(document).on('click',':checkbox',function() {
            $('#delRolesBtn').toggle($("input[name='tab_chk_role']:checked").length > 0);
        });
        
        //管理角色
        var chk_roleIds_r = [];
        $("#selectRole_btn_p").click(function() {
             $("input[name='chk']:checked",window.frames["role_frame_p"].document).each(function() {
                var curVal = $(this).val();
                var index = curVal.indexOf(",");
                var roleId = curVal.substring(0,index);
                var roleName = curVal.substring(index+1);
                //
                var addRoleIndex =$.inArray(roleId,chk_roleIds_r);
                if(addRoleIndex == -1) {
                    chk_roleIds_r.push(roleId);
                     $("#tab_p > tbody").append($('<tr><td><input type="checkbox" name="tab_chk_role_r" value="'+ roleId +'" /></td>'+
                            '<td>'+ roleName +'</td></tr>'));
                }
            });
        });
         
        $('#tab_chk_all_a').click(function() {
            $('input[name="tab_chk_role_r"]').prop('checked', $('#tab_chk_all_a').prop('checked'));
        });
         
        $("#delRolesBtn_d").click(function() {
            if($("input[name='tab_chk_role_r']:checked").length > 0) {
                $("input[name='tab_chk_role_r']:checked").each(function() {
                    var delRoleId = $(this).val();
                    var delRoleIndex =$.inArray(delRoleId,chk_roleIds_r);
                    $(this).parent().parent().remove();
                    if(delRoleIndex != -1) {
                        chk_roleIds_r.splice(delRoleIndex,1);
                    }
                 });
            }
            $("#tab_chk_all_a").prop("checked", false);
            $("#delRolesBtn_d").hide();
        });
         

        $('form').on('submit',function() {
            $("#roleIds_p").val(chk_roleIds_r.join(","));
        });
        
        $(document).on('click',':checkbox',function() {
            $('#delRolesBtn_d').toggle($("input[name='tab_chk_role_r']:checked").length > 0);
        });
        
        
        //栏目审核角色
        var chk_roleIds_c = [];
        $("#selectRole_category").click(function() {
             $("input[name='chk']:checked",window.frames["category_frame"].document).each(function() {
                var curVal = $(this).val();
                var index = curVal.indexOf(",");
                var roleId = curVal.substring(0,index);
                var roleName = curVal.substring(index+1);
                //
                var addRoleIndex =$.inArray(roleId,chk_roleIds_c);
                if(addRoleIndex == -1) {
                    chk_roleIds_c.push(roleId);
                     $("#tab_c > tbody").append($('<tr><td><input type="checkbox" name="tab_chk_category" value="'+ roleId +'" /></td>'+
                            '<td>'+ roleName +'</td></tr>'));
                }
            });
        });
         
        $('#tab_chk_all_c').click(function() {
            $('input[name="tab_chk_category"]').prop('checked', $('#tab_chk_all_c').prop('checked'));
        });
         
        $("#delRolesBtn_c").click(function() {
            if($("input[name='tab_chk_category']:checked").length > 0) {
                $("input[name='tab_chk_category']:checked").each(function() {
                    var delRoleId = $(this).val();
                    var delRoleIndex =$.inArray(delRoleId,chk_roleIds_c);
                    $(this).parent().parent().remove();
                    if(delRoleIndex != -1) {
                        chk_roleIds_c.splice(delRoleIndex,1);
                    }
                 });
            }
            $("#tab_chk_all_c").prop("checked", false);
            $("#delRolesBtn_c").hide();
        });
         

        $('form').on('submit',function() {
            $("#roleIds_c").val(chk_roleIds_c.join(","));
        });
        
        $(document).on('click',':checkbox',function() {
            $('#delRolesBtn_c').toggle($("input[name='tab_chk_category']:checked").length > 0);
        });
        
        //内容审核角色
        var chk_roleIds_con = [];
        $("#selectRole_content").click(function() {
             $("input[name='chk']:checked",window.frames["content_frame_c"].document).each(function() {
                var curVal = $(this).val();
                var index = curVal.indexOf(",");
                var roleId = curVal.substring(0,index);
                var roleName = curVal.substring(index+1);
                //
                var addRoleIndex =$.inArray(roleId,chk_roleIds_con);
                if(addRoleIndex == -1) {
                    chk_roleIds_con.push(roleId);
                     $("#tab_con > tbody").append($('<tr><td><input type="checkbox" name="tab_chk_content" value="'+ roleId +'" /></td>'+
                            '<td>'+ roleName +'</td></tr>'));
                }
            });
        });
         
        $('#tab_chk_all_con').click(function() {
            $('input[name="tab_chk_content"]').prop('checked', $('#tab_chk_all_con').prop('checked'));
        });
         
        $("#delRolesBtn_con").click(function() {
            if($("input[name='tab_chk_content']:checked").length > 0) {
                $("input[name='tab_chk_content']:checked").each(function() {
                    var delRoleId = $(this).val();
                    var delRoleIndex =$.inArray(delRoleId,chk_roleIds_con);
                    $(this).parent().parent().remove();
                    if(delRoleIndex != -1) {
                        chk_roleIds_con.splice(delRoleIndex,1);
                    }
                 });
            }
            $("#tab_chk_all_con").prop("checked", false);
            $("#delRolesBtn_con").hide();
        });
         

        $('form').on('submit',function() {
            $("#roleIds_con").val(chk_roleIds_con.join(","));
        });
        
        $(document).on('click',':checkbox',function() {
            $('#delRolesBtn_con').toggle($("input[name='tab_chk_content']:checked").length > 0);
        });
        
      //评论审核角色
        var chk_roleIds_pin = [];
        $("#selectRole_pin").click(function() {
             $("input[name='chk']:checked",window.frames["pin_frame"].document).each(function() {
                var curVal = $(this).val();
                var index = curVal.indexOf(",");
                var roleId = curVal.substring(0,index);
                var roleName = curVal.substring(index+1);
                //
                var addRoleIndex =$.inArray(roleId,chk_roleIds_pin);
                if(addRoleIndex == -1) {
                    chk_roleIds_pin.push(roleId);
                     $("#tab_pin > tbody").append($('<tr><td><input type="checkbox" name="tab_chk_pin" value="'+ roleId +'" /></td>'+
                            '<td>'+ roleName +'</td></tr>'));
                }
            });
        });
         
        $('#tab_chk_all_pin').click(function() {
            $('input[name="tab_chk_pin"]').prop('checked', $('#tab_chk_all_pin').prop('checked'));
        });
         
        $("#delRolesBtn_pin").click(function() {
            if($("input[name='tab_chk_pin']:checked").length > 0) {
                $("input[name='tab_chk_pin']:checked").each(function() {
                    var delRoleId = $(this).val();
                    var delRoleIndex =$.inArray(delRoleId,chk_roleIds_pin);
                    $(this).parent().parent().remove();
                    if(delRoleIndex != -1) {
                        chk_roleIds_pin.splice(delRoleIndex,1);
                    }
                 });
            }
            $("#tab_chk_all_pin").prop("checked", false);
            $("#delRolesBtn_pin").hide();
        });
         

        $('form').on('submit',function() {
            $("#roleIds_pin").val(chk_roleIds_pin.join(","));
        });
        
        $(document).on('click',':checkbox',function() {
            $('#delRolesBtn_pin').toggle($("input[name='tab_chk_pin']:checked").length > 0);
        });
        
    });
    </script>
    <script type="text/javascript">
    
  	$("#id").val('${category.id}');
	$("#name").val('${category.id}');
	$("#englishName").val('${category.englishName}');
	$("#type").val('${category.type}');
	if($("#type").val() == '2'){
		$("#visitPath").show();
		$("#path").val('${category.path}');
	}

	$("#auditCategoryMethod").val('${category.auditCategoryMethod}');
	if($("#auditCategoryMethod").val() == '2') {
		$("#categoryCheck").show();
	} 
	$("#auditCatcontent").val('${category.auditCatcontent}');
	if($("#auditCatcontent").val() == 'yes') {
		$("#auditContentMethod").show();
		$("#auditCatcontentMethod").val('${category.auditCatcontentMethod}');
	}
	if($("#auditCatcontentMethod").val() == '2'){
	} 
	$("#reviewCatcontent").val('${category.reviewCatcontent}');
	if($("#reviewCatcontent").val() == 'yes') {
		$("#auditAssess").show();
		$("#auditCatreview").val('${category.auditCatreview}');
	}
	if($("#auditCatreview").val() == 'yes') {
		$("#auditReviewMethod").show();
		$("#auditCatreviewMethod").val('${category.auditCatreviewMethod}');
	}
	if($("#auditCatreviewMethod").val() == '2') {
		$("#reviewCheck").show();
	} 
	$("#imghead").attr("src", "${ctx}/cms/category/showPhoto/${category.id}");
	$("#templatePath").val('${category.templatePath}');
	$("#contentPath").val('${category.contentPath}');
    </script>
</xqlc:extends>

<jsp:include page="/common/BasePage.jsp" />
