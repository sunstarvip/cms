<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="css">
    <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/icon.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/zTreeStyle.css" type="text/css"  />
    <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/loading.css" type="text/css"  />
    <style type="text/css">
    .ui-layout-north {
        padding: 0;
        overflow: hidden;
        margin: 0;
    }
    #preview{width:50px;height:50px;solid #000;overflow:hidden;}
	#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
	#large{position:absolute;display:none;z-index:999;}

    </style>
</xqlc:extends>

<xqlc:extends name="javascript">

	<script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.exedit-3.5.js"></script>
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
			} else {
				$("#categoryCheck").show();
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
			} else {
				$("#contentCheck").show();
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
			} else {
				$("#reviewCheck").show();
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
                              
                           }else {
                               $('#content_frame').attr('src','${ctx}/cms/category/list');
                           }
                           
                       };
                   } 
                       var node = treeObj.getNodeByParam("id", nodeId,null);
                       treeObj.expandNode(node, true, false, true);
                   
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
		$('#content_frame').attr('src','${ctx}/cms/category/create?nodeId='+pid);
	}
	
	//新增下级栏目
	function addNextType(){
		hideRMenu();
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
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
		$('#content_frame').attr('src','${ctx}/cms/category/update?updateId='+id);
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
		$("#name").on('change', function() {
			$.get('${ctx}/cms/category/repeat?categoryId=' + $("#id").val(), {
				'category.name':$('#name').val()
			}, function(response){
				if(!response) {
					$("#checkName").html("<font color='#B94A48'>${xqlc:i18n('ui.cms.chooseOther', locale)}!</font>");
				}else {
					$("#checkName").html("");
				};
			}, 'json');
			$.get('${ctx}/cms/category/repeatEName?categoryId=' + $("#id").val(), {
				'category.englishName':$('#englishName').val()
			}, function(response){
				if(!response) {
					$("#checkEname").html("<font color='#B94A48'>${xqlc:i18n('ui.cms.chooseOther', locale)}!</font>");
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
		
		$("#selectTemplate_button").click(function() {
			temp_val = $('input[name = "temp_chk"]:checked').val();
			$('#templateModal').hide();
			if($('#templateModal').attr('data-flag') == 'categoryTemplate'){
				$('#templatePath').val(temp_val);
			}
			if($('#templateModal').attr('data-flag') == 'contentTemplate'){
				$('#contentPath').val(temp_val);
			}
		});
		
		$("#category_template").click(function() {
			$('#templateModal').attr({'data-flag':'categoryTemplate'});
		});
		
		$("#content_template").click(function() {
			$('#templateModal').attr({'data-flag':'contentTemplate'});
		});
		
		$('#templateModal').on('hidden', function () {
			  $('#templateModal').attr({'data-flag':''});
			  $("input[name='temp_chk']").attr("checked",false);
		});
		
		$('input[name="cancel"]').click(function() {
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
    });
    </script>
</xqlc:extends>

			
<xqlc:extends name="content">
<form>
<input type="hidden" id="mark" name="mark" value="${mark}">	

<div class="row-fluid">
   <div class="span3">
       <h3>
        <span><fmt:message key="ui.cms.category"/></span>
       </h3>
       <ul id="categoryTree" class="ztree"></ul>
   </div>
   
<%-- iframe--%>
	<iframe id="content_frame" name="content_frame" class="span9" height="700px" style="overflow:auto; border:none;" src=""></iframe>
</div>

</form>
   <!-- 添加 -->
	<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width:950px; left:35%">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h5><fmt:message key="ui.cms.editCategory"/></h5>
		</div>
		<div class="modal-body">
	    	<form:form class="form-horizontal validation" id="editForm" action="" modelAttribute="category" method="post" enctype="multipart/form-data">
				<form:hidden path="id"/>
				 <input type="hidden" id="roleIds" name="roleIds"/>
				 <input type="hidden" value="${nodeId}" name="parentId"/>
				<div class="widget-content">
					<div class="control-group">
					<label class="control-label"><fmt:message key="ui.cms.categoryName"/>:</label>
						<div class="controls">
							<input type="text" id="name" name="name" value="" class="{required:true,messages:{required:' '}}"/>
						</div>
						<span id="checkName" style="margin-left: 23%"></span>
					</div>	
				</div>
				<!-- 栏目英文名 -->
				<div class="widget-content">
					<div class="control-group">
						<label class="control-label"><fmt:message key="ui.cms.categoryEnglishName"/>:</label>
							<div class="controls">
								<input type="text" id="englishName" name="englishName" value="${category.englishName}" placeholder="点击自动生成"
								class="{required:true,messages:{required:' '}}"/>
								<span id="checkEname" style="margin-left: 23%"></span>
							</div>
						</div>	
					</div>
					<div class="row-fluid">
           				<div class="span5">
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.type"/>:</label>
								<div class="controls">
									<form:select path="type" cssClass="{required:true,messages:{required:' '}}">
										<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
										<form:option value="1"><fmt:message key="ui.cms.commonCategory"/></form:option>
										<form:option value="2"><fmt:message key="ui.cms.linkCategory"/></form:option>
									</form:select>
								</div>
							</div>
						</div>
						</div>
						<div class="span7">
							<div class="widget-content">
								<div id="visitPath" class="control-group" style="display: none">
									<label class="control-label"><fmt:message key="ui.cms.visitPath"/>:</label>
										<div class="controls">
											<form:input path="path"  cssClass="{required:true,messages:{required:' '}}"/>
										</div>
								</div>
							</div>
						</div>
					</div>
					<div class="widget-content">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.categoryAuditMode"/>:</label>
							<div class="controls">
								<form:select path="auditCategoryMethod" cssClass="{required:true,messages:{required:' '}}">
									<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
									<form:option value="1"><fmt:message key="ui.cms.workflow"/></form:option>
									<form:option value="2"><fmt:message key="ui.cms.personnelAudit"/></form:option>
								</form:select>
							</div>
						</div>
					</div>
					<!-- 栏目审核人 -->
					<div class="widget-content" id="categoryCheck" style="display:none">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.categoryCheckUser"/>:</label>
							<div class="controls">
								<input type="hidden" name="categoryCheckId" id="categoryCheckId" value="${category.categoryCheckUser.id}">
								<input type="text" name="categoryCheckName" id="categoryCheckName" value="${category.categoryCheckUser.userName}" readonly="readonly">
								<a href="#userModal" id="category_role" role="button" class="btn" data-toggle="modal">
								    <fmt:message key="ui.cms.selectPerson"/>
								</a>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<!-- 审核内容 -->
           				<div class="span5">	
							<div class="widget-content">
								<div class="control-group">
									<label class="control-label"><fmt:message key="ui.cms.auditContent"/>:</label>
									<div class="controls">
										<form:select path="auditCatcontent" cssClass="{required:true,messages:{required:' '}}">
											<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
											<form:option value="yes"><fmt:message key="ui.cms.yes"/></form:option>
											<form:option value="no"><fmt:message key="ui.cms.no"/></form:option>
										</form:select>
									</div>
								</div>
							</div>
						</div>
						<!-- 内容审核方式 -->
						<div class="span7">
							<div class="widget-content" id="auditContentMethod" style="display: none">
								<div class="control-group">
									<label class="control-label"><fmt:message key="ui.cms.contentAuditMode"/>:</label>
									<div class="controls">
										<form:select path="auditCatcontentMethod" cssClass="{required:true,messages:{required:' '}}">
											<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
											<form:option value="1"><fmt:message key="ui.cms.workflow"/></form:option>
											<form:option value="2"><fmt:message key="ui.cms.personnelAudit"/></form:option>
										</form:select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 内容审核人 -->
					<div class="widget-content" id="contentCheck" style="display:none">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.contentCheckUser"/>:</label>
							<div class="controls">
								<input type="hidden" name="contentCheckId" id="contentCheckId" value="${category.contentCheckUser.id}">
								<input type="text" name="contentCheckName" id="contentCheckName" value="${category.contentCheckUser.userName}" readonly="readonly">
								<a href="#userModal" id="content_role" role="button" class="btn" data-toggle="modal">
								    <fmt:message key="ui.cms.selectPerson"/>
								</a>
							</div>
						</div>
					</div>	
					<div class="row-fluid">
					<!-- 评论内容 -->
					<div class="span5 widget-content">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.reviewContent"/>:</label>
							<div class="controls">
								<form:select path="reviewCatcontent" cssClass="{required:true,messages:{required:' '}}">
									<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
									<form:option value="yes"><fmt:message key="ui.cms.yes"/></form:option>
									<form:option value="no"><fmt:message key="ui.cms.no"/></form:option>
								</form:select>
							</div>
						</div>
					</div>
					<!-- 审核评论 -->
					<div class="span7">
					<div id="auditAssess" class="widget-content" style="display: none">
						<div class="control-group">
						<label class="control-label"><fmt:message key="ui.cms.auditReview"/>:</label>
							<div class="controls">
								<form:select path="auditCatreview" cssClass="{required:true,messages:{required:' '}}">
									<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
									<form:option value="yes"><fmt:message key="ui.cms.yes"/></form:option>
									<form:option value="no"><fmt:message key="ui.cms.no"/></form:option>
								</form:select>
							</div>
						</div>
					</div>
					</div>
					</div>
					<!-- 评论审核方式 -->
					<div class="widget-content" id="auditReviewMethod" style="display: none">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.reviewAuditMode"/>:</label>
							<div class="controls">
								<form:select path="auditCatreviewMethod" cssClass="{required:true,messages:{required:' '}}">
									<form:option value=""><fmt:message key="ui.cms.pleaseChoose"/></form:option>
									<form:option value="1"><fmt:message key="ui.cms.workflow"/></form:option>
									<form:option value="2"><fmt:message key="ui.cms.personnelAudit"/></form:option>
								</form:select>
							</div>
						</div>
					</div>
					<!-- 评论审核人 -->
					<div class="widget-content" id="reviewCheck" style="display:none">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.reviewCheckUser"/>:</label>
							<div class="controls">
								<input type="hidden" name="reviewCheckId" id="reviewCheckId" value="${category.reviewCheckUser.id}">
								<input type="text" name="reviewCheckName" id="reviewCheckName" value="${category.reviewCheckUser.userName}" readonly="readonly">
								<a href="#userModal" id="review_role" role="button" class="btn" data-toggle="modal">
								    <fmt:message key="ui.cms.selectPerson"/>
								</a>
							</div>
						</div>
					</div>	
					<!-- Logo -->
					<div class="widget-content">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.logo"/>:</label>
							<div class="controls">
								<input type="file" id="logoImage" name="file" value="${category.logoImage}" onchange="previewImage(this)"/>
								<button id="delete" type="button" class="btn"><fmt:message key="ui.cms.delete"/></button>
								<div id="large"></div>
								<span id="preview">
									<img id="imghead" width=50 height=50 src="">
								</span>
							</div>
						</div>
					</div>
					<!-- 为栏目绑定模板 -->
					<div class="widget-content" id="templateCheck">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.bindCategoryTemplate"/>:</label>
							<div class="controls">
								<input type="text" name="templatePath" id="templatePath" readonly="readonly" value="${category.templatePath}">
								<a href="#templateModal" id="category_template" role="button" class="btn" data-toggle="modal">
								    <fmt:message key="ui.cms.chooseTemplate"/>
								</a>
							</div>
						</div>
					</div>
					<!-- 为内容绑定模版 -->
					<div class="widget-content" id="content_template">
						<div class="control-group">
							<label class="control-label"><fmt:message key="ui.cms.bindContentTemplate"/>:</label>
							<div class="controls">
								<input type="text" name="contentPath" id="contentPath" readonly="readonly" value="${category.contentPath}">
								<a href="#templateModal" id="content_template" role="button" class="btn" data-toggle="modal">
								    <fmt:message key="ui.cms.chooseTemplate"/>
								</a>
							</div>
						</div>
					</div>
					<!-- 绑定角色 -->
					<div class="widget-content">
                        <div class="control-group">
                            <label class="control-label"><fmt:message key="ui.cms.boundRole"/>:</label>
                            <div class="controls">
                                <a href="#roleModal" role="button" class="btn" data-toggle="modal">
                                   <fmt:message key="ui.cms.chooseRole"/>
                                </a>
                                <button type="button" class="btn btn-danger" id="delRolesBtn" style="display: none">删除</button>
                            </div>
                        </div>
                    </div>
                    <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"></label>
                                <div class="controls" >
                                    <tr>
                                        <td></td>
                                        <td>
                                            <table class="table table-bordered" id="tab">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            <input type="checkbox" id="tab_chk_all" />
                                                        </th>
                                                        <th><fmt:message key="ui.cms.roleName"/></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:if test="${not empty roles}">
                                                        <c:forEach items="${roles}" var="role">
                                                            <tr>
                                                                <td><input type="checkbox" name="tab_chk_role" value="${role.id}" /></td>
                                                                <td>${role.name}</td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </div>
                            </div>
                        </div>
				<div class="modal-footer">
						<button class="btn btn-primary" type="button" id="saveType_btn"><fmt:message key="ui.cms.save"/></button>
						<input class="btn" type="reset" value="${xqlc:i18n('ui.cms.reset',locale)}" />
						<button class="btn" data-dismiss="modal" aria-hidden="true"> <i class="icon-remove"></i><fmt:message key="ui.cms.cancel"/></button>
				</div>
			</form:form>
		</div>
	</div>
	<!-- 人员选择器 -->
	<div id="userModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width:950px;left:35%">
		<div class="modal-header">
			<button type="button" class="close">×</button>
			<h3 id="myModalLabel"><fmt:message key="ui.cms.roleList"/></h3>
		</div>
		<div id="modalbody" class="modal-body" style="height:350px">
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span3">
						<ul id="deptUserTree" class="ztree"></ul>
					</div>
					
					
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn btn-primary" id="selectUser_button"><fmt:message key="ui.cms.ok"/></button>
			<input type="button" class="btn" name="cancel" value="${xqlc:i18n('ui.cms.cancel',locale)}">
		</div>
	</div>
	<!-- 模版选择器 -->
	<div id="templateModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="templateModalLabel" style="width:950px;left:35%">
		<div class="modal-header">
			<button type="button" class="close">×</button>
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
    
    <!-- 角色Modal -->
    <div id="roleModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="userModalLabel"><fmt:message key="ui.cms.roleList"/></h3>
        </div>
        <div id="modalbody" class="modal-body">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div id="frameDiv">
                        <iframe id="roloe_frame" name="role_frame" width="100%" height="400px"  style="overflow: hidden; border: none;" src="${ctx}/cms/content/roleList"></iframe>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
             <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true" id="selectRole_btn"> <fmt:message key="ui.cms.ok"/></button>
             <button class="btn" data-dismiss="modal" aria-hidden="true"> <fmt:message key="ui.cms.cancel"/></button>
        </div>
    </div>

	<div id="rMenu" class="rmenu">
		<ul style="width:120px;">
			<li id="m_add" onclick="addType()">
				<i class="icon-plus"></i><fmt:message key="ui.cms.createPeerCategory"/>
			</li>
			<li id="m_add_next" onclick="addNextType()">
				<i class="icon-plus"></i><fmt:message key="ui.cms.createNextCategory"/>
			</li>
			<li id="m_del" onclick="delType()">
				<i class="icon-remove"></i><fmt:message key="ui.cms.deleteCategory0"/>
			</li>
			<li id="m_update" onclick="updateType()">
				<i class="icon-pencil"></i><fmt:message key="ui.cms.updateCategory"/>
			</li>
			<li id="m_copy" onclick="copyId()">
				<i class="icon-pencil"></i><fmt:message key="ui.cms.copyCategoryId"/>
			</li>
			<li id="m_publish" onclick="publish()">
				<i class="icon-pencil"></i><fmt:message key="ui.cms.publishCategory"/>
			</li>
		</ul>
   </div>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseCategoryTreePage.jsp"></jsp:include>
