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

<xqlc:extends name="css">
  <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/icon.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/zTreeStyle.css" type="text/css"  />
  <style type="text/css">
        
     </style>
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

<xqlc:extends name="javascript">
<script type="text/javascript" src="${ctx}/static/websitetheme/js/jquery.ztree.all-3.2.min.js"></script>
    <script type="text/javascript">
		$(function() {
			
			// 验证框架 
	        $("#editForm").validate();
			
        	//根据新闻内容类型,动态显示图片资源的DIV
        	$("#type").on('change', function() {
        		var value = $('#type').val();
        		if(value == 1) {
        			$('#pictureResourceDiv').show();
        		}else {
        			$('#pictureResourceDiv').hide();
        			$('#file').val('');
        		}
        	});

    		//根据是否有图片动态显示删除按钮
			var result = $('#logoImage').val();
			if(result != null && result != "") {
				$("#delete").show();
			}else {
				$("#delete").hide();
			}
			$("#logoImage").on('change', function() {
				if('${logoImage}' != null) {
					$("#delete").show();
				}else {
					$("#delete").hide();
				}
			});
			$("#delete").click(function() {
				$("#logoImage").val("");
				$("#imghead").hide();
			});
			
			//$('#category').val('${content.category.id}'); 
        	if('${content.category.id}'){
            	$('#category').val('${content.category.id}');
        	}else {
            	$('#category').val('${categoryId}');
        	}
          
            //为评论审核方式添加默认值
            function defaultAuditReviewMethod() {
            	$('#auditReviewMethod').val("1");
            	/* $('#reviewCheckerDiv').hide(); */
            	$('#reviewCheck').hide();
            	$('#reviewCheck_c').hide();
            }

            //为是否评论内容添加默认值
            function defaultAuditReview() {
                $('#auditReview').val("0");
                defaultAuditReviewMethod();
                $("#auditReviewMethodDiv").hide();
                $("#auditReviewMethod").val('');
            }
            //更新评论审核方式
            function auditReviewMethod() {
                if('${content.auditReviewMethod}' == '2') {
                   /*  $('#reviewCheckerDiv').show(); */
                    $('#reviewCheck').show();
            	    $('#reviewCheck_c').show();
                }else {
                }
            }
          
            //更新是否审核评论
            function auditReview() {
                if('${content.auditReview}' == '1') {
                    $("#auditReviewMethodDiv").show();
                    if('${content.auditReviewMethod}') {//评论审核方式  1.工作流   2.人
                        $('#auditReviewMethod').val('${content.auditReviewMethod}');
                        auditReviewMethod();
                    }
                }else {
                    $('#auditReviewMethod').val('');
                }
            }
            
            //更新是否评论内容
            function reviewContent(){
                if('${content.reviewContent}' == '1') {//评论内容reviewContent 0.否   1.是
                    $("#auditReviewDiv").show();
                    if('${content.auditReview}') {//审核评论auditReview 0.否   1.是
                        $('#auditReview').val('${content.auditReview}');
                        auditReview();
                    }
                }else {
                    $('#auditReview').val('');
                    $('#auditReviewMethod').val('');
                }
            }
            
            //从栏目中获得审核评论的方法
            function auditCatreviewMethod() {
                if('${category.auditCatreviewMethod}' == '1') {
                    $('#auditReviewMethod').val('1');
                }else if('${category.auditCatreviewMethod}' == '2') {
                    $('#auditReviewMethod').val('2');
                    /* $('#reviewCheckerDiv').show(); */
                    $('#reviewCheck').show();
            	    $('#reviewCheck_c').show();
                }
            }
            
            //从栏目中获得是否审核评论
            function auditCatreview() {
                if('${category.auditCatreview}' == 'yes') {
                    $("#auditReviewMethodDiv").show();
                    $('#auditReview').val('1');
                    auditCatreviewMethod();
                }else {
                    $('#auditReview').val('0');
                    $('#auditReviewMethod').val('');
                }
            }
            
            //从栏目中获得是否评论内容
            function reviewCatcontent() {
                if('${category.reviewCatcontent}' == 'yes') {
                    $('#reviewContent').val('1');
                    $("#auditReviewDiv").show();
                    auditCatreview();
                }else {
                    $('#reviewContent').val('0');
                    $('#auditReview').val('');
                    $('#auditReviewMethod').val('');
                }
            }
            
            //优先从Content类中获取是否评论的设定值,如果不存在从栏目获取是否评论的设定值,都不存在的情况下再自行设定
            if('${content.reviewContent}') {
                $('#reviewContent').val('${content.reviewContent}');
                reviewContent();
            }else {
                reviewCatcontent();
            }
            
            //更新是否评论内容
            function auditContentMethod() {
            	if('${content.auditContentMethod}' == '2') {
                    $('#contentCheck').show();
                    $('#contentCheck_b').show();
                }else if('${content.auditContentMethod}' == '1') {
                }
            }
            
            //从栏目获得是否评论内容
            function auditCatcontentMethod() {
            	if('${category.auditCatcontentMethod}' == '1') {
                    $('#auditContentMethod').val('1');
                }else if('${category.auditCatcontentMethod}' == '2') {
                    $('#auditContentMethod').val('2');
                    $('#contentCheck').show;
                    $('#contentCheck_b').show;
                }
            }
            
        	//优先从Content类中获取内容审核方式的设定值,如果不存在从栏目获取内容审核方式的设定值,都不存在的情况下再自行设定
        	if('${content.auditContentMethod}') {
        		$('#auditContentMethod').val('${content.auditContentMethod}');
        		auditContentMethod();
        	}else {
        		auditCatcontentMethod();
        	}
        	//根据是否评论内容,动态显示评论是否审核的DIV
        	$('#reviewContent').on(
                    'change',
                    function() {
                        var value = $('#reviewContent').val();
                        if(value == 0) {
                            $("#auditReviewDiv").hide();
                            $('#auditReview').val('');
                            $('#auditContentMethod').val('');
                        }
                        else{
                            $("#auditReviewDiv").show();
                            defaultAuditReview();
                        }
                });
        	//根据评论是否审核,动态显示评论审核方式DIV
            $('#auditReview').on(
                    'change',
                    function() {
                        var value = $('#auditReview').val();
                        if(value == 0) {
                            $("#auditReviewMethodDiv").hide();
                            $('#auditContentMethod').val('');
                        }
                        else{
                            $("#auditReviewMethodDiv").show();
                            defaultAuditReviewMethod();
                        }
                });
            //根据内容审核方式,动态显示内容审核人员DIV
            var value = $('#auditContentMethod').val();
            if(value =="2"){
            	$('#contentCheck').show();
            }
            $('#auditContentMethod').on(
                    'change',
                    function() {
                        var value = $('#auditContentMethod').val();
                        if(value == 1) {
                            $('#contentCheck').hide();
                            $('#contentCheck_b').hide();
                        }
                        else{
                            $('#contentCheck').show();
                            $('#contentCheck_b').show();
                        }
                });
            //根据评论审核方式,动态显示评论审核人员DIV
            $('#auditReviewMethod').on(
                    'change',
                    function() {
                        var value = $('#auditReviewMethod').val();
                        if(value == 1) {
                            $('#reviewCheck').hide();
                    	    $('#reviewCheck_c').hide();
                        }
                        else{
                            $('#reviewCheck').show();
                    	    $('#reviewCheck_c').show();
                        }
                });
            
            //部门树
            $(function() {
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
                                '${ctx}/cms/dept/deptAndUserList/' + treeNode.id);
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
                    url : '${ctx}/cms/content/deptTree',
                    dataType : "json",
                    success : function(data) {
                        zNodes_ = data;
                        treeObj = $.fn.zTree.init($("#deptTree"), setting_, zNodes_);
                        if (!nodeId) {
                            var nodes = treeObj.getNodes();
                            if (nodes.length > 0) {
                                $('#center_frame').attr('src','${ctx}/cms/dept/deptAndUserList/'+ nodes[0].id);
                                    treeObj.selectNode(nodes[0]);
                            };
                        } else {
                            var node = treeObj.getNodeByParam("id", nodeId,null);
                                    treeObj.expandNode(node, true, false, true);
                                }
                            },
                            error : function(XMLHttpRequest, textStatus,
                                    errorThrown) {
                               /*  alert(errorThrown); */
                            }
                        });
            }
            
            $(function() {
                var chk_val;
                $("#selectUser_button").click(function() {
                         $("input[name='chk']:checked",window.frames["center_frame"].document).each(function() {
                            chk_val = $(this).val();
                        });
                     if($('#myModal').attr('data-flag') == 'content'){
                         var result = chk_val.split(",");
                         
                     } else  if($('#myModal').attr('data-flag') == 'review'){
                         var result = chk_val.split(",");
                     }
                });
                
                $("#content_checker").click(function() {
                     $('#myModal').attr({'data-flag':'content'});
                });
                
                $("#review_checker").click(function() {
                     $('#myModal').attr({'data-flag':'review'});
                });
                
                $('#myModal').on('hidden', function () {
                      $('#myModal').attr({'data-flag':''});
                      $("input[name='chk']",window.frames["center_frame"].document).attr("checked",false);
                     
                });
            });
            
            $(function() {
    			var chk_val;
    			$("#selectUser_button").click(function() {
                 		 $("input[name='chk']:checked",window.frames["center_frame"].document).each(function() {
                   			chk_val = $(this).val();
                   		});
    				 if($('#myModal').attr('data-flag') == 'category'){
    					 var result = chk_val.split(",");
    					 $('#categoryCheckId').val(result[0]);
    					 $('#categoryCheckName').val(result[1]);
    					 
    				 } else  if($('#myModal').attr('data-flag') == 'content'){
    					 var result = chk_val.split(",");
    					 $('#contentCheckId').val(result[0]);
    					 $('#contentCheckName').val(result[1]);
    				 }else if($('#myModal').attr('data-flag') == 'review'){
    					 var result = chk_val.split(",");
    					 $('#reviewCheckId').val(result[0]);
    					 $('#reviewCheckName').val(result[1]);
    				 }
    			});
            });
            
          //初始化新闻内容的类型
            $(function() {
                if('${content.type}') {
                    if('${content.picPath}') {
                        $('#contentType').val("3");
                    }else {
                        $('#contentType').val('${content.type}');
                    }
                    pictureResource();
                }
            });
        });
		
		//设定新闻内容的类型
		$(function() {
            var type = $('#contentType').val();
            if('${content.type}'){
            $('#type').val('${content.type}');
            }else{
            	$('#type').val('1');
            }
            
            
            $('#contentType').on('change', function() {
                var v = $('#contentType').val();
                if(v == '3') {
                	v = '1';
                }
                $('#type').val(v);
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
    		img.onload = function(){
      		var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
      		img.width = rect.width;
     		img.height = rect.height;
      		img.style.marginLeft = rect.left+'px';
      		img.style.marginTop = rect.top+'px';
    	}
    		var reader = new FileReader();
    		reader.onload = function(evt){img.src = evt.target.result;}
    		reader.readAsDataURL(file.files[0]);
			img.onmousemove = function(event){
			event = event || window.event;
			ei.style.display = "block";
			ei.innerHTML = '<img style="border:1px solid gray;" src="' + this.src + '" />';
			ei.style.top  = document.body.scrollTop + event.clientY + 12 + "px";
			ei.style.left = document.body.scrollLeft + event.clientX + 12 + "px";
		}
			img.onmouseout = function(){
			ei.innerHTML = "";
			ei.style.display = "none";
		}
  	}
  	else {
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
	function clacImgZoomParam( maxWidth, maxHeight, width, height ){
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
    	$("#selectTemplate_button").click(function() {
            var value_ = $('input[name="temp_chk"]:checked').val();
            $("#templateName_id").val(value_);
        });
	});
	
	$(function() {
		//如果栏目模板不为空则绑定栏目模板，如果不为空则绑定模板
		var contentpath = $("#content_template_").val();
		var categorypath = $("#category_template_").val();
    	  if(contentpath != null && contentpath != "") {
    		  $('#templateName_id').val(contentpath);
          }else {
        	 
        	  $('#templateName_id').val(categorypath);
          }
	});
	
	$(function() {
		
        //选择角色
        var oldRoles = "${content.accessUser}";
           var chk_roleIds =[];
           if($.trim(oldRoles) != "") {
               chk_roleIds = $.trim(oldRoles).split(",");
           }
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
	
	$(function(){
        var type = '${content.type}';
	    if(type == "3"){
		    $("#pictureResourceDiv").show();
            $("#pubPathDiv").hide();
	    }else if(type == "2"){
            $("#pubPathDiv").show();
            $("#pictureResourceDiv").hide();
        }else {
            $("#pubPathDiv").hide();
            $("#pictureResourceDiv").hide();
        }
		$("#contentType").on('change',function(){
			type= $("#contentType").val();
			if(type == "3"){
				$("#pictureResourceDiv").show();
                $("#pubPathDiv").hide();
			}else if(type == "2"){
                $("#pubPathDiv").show();
				$("#pictureResourceDiv").hide();
			}else {
                $("#pubPathDiv").hide();
                $("#pictureResourceDiv").hide();
            }
		});
		
	})
    </script>
    
    
</xqlc:extends>

<xqlc:extends name="body">
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.base.edit"/></span>
            </h3>
        </div> 

<!-- 内容审核人 -->
<!-- 评论审核人 -->
   

    <form:form id="editForm" class="form-horizontal" action="${ctx}/cms/content/save" modelAttribute="content" 
        cssClass="form-horizontal validation" enctype="multipart/form-data">
        <form:hidden path="id"/>
        <input type="hidden" name="siteId" id="siteId" value="${content.site.id}"/>
        <!-- <input type="hidden" id="roleIds" name="roleIds"/>
        <input type="hidden" name="roleIds_con" id="roleIds_con"/>
        <input type="hidden" name="roleIds_pin" id="roleIds_pin"/> -->
        <div class="headInfo clearfix">
	        <div class="actions">
	        </div>
        </div>
        
        <div class="block-fluid clearfix">
             <div class="formlayout doubleColumn">
                <ul>
                   <li class="fullWidth">
                    <%-- 内容标题 --%>
                    <span><fmt:message key="ui.cms.title"/>:</span>
                    <div class="formright">
                    <form:input path="title" cssClass="required" placeholder="${xqlc:i18n('ui.cms.inputTitle', locale)}"/>
                    </div>
                   </li>
                   <li class="fullWidth">
                   <%-- 内容副标题 --%>
                   <span><fmt:message key="ui.cms.subtitle"/>:</span>
                   <div class="formright">
                   <form:input path="subTitle" placeholder="${xqlc:i18n('ui.cms.subtitle', locale)}"/>
                   </div>
                   </li>
                   <li class="fullWidth">
                   <%-- 内容类型 --%>
                   <span><fmt:message key="ui.cms.type"/>:</span>
                   <div class="formright">
                    <input type="hidden" name="type" id="type" value="${content.type}" />
                    <select name="contentType" id="contentType">  
                           <option value="1"><fmt:message key="ui.cms.normalNews"/></option> 
                           <option value="2"><fmt:message key="ui.cms.linkNews"/></option>
                           <option value="3"><fmt:message key="ui.cms.pictureNews"/></option>
                    </select>
                   </div>
                   </li>
                   <li class="fullWidth" id="pubPathDiv" style="display: none">
                       <%-- 新闻发布地址 --%>
                       <span><fmt:message key="ui.cms.pubPath"/>:</span>
                       <div class="formright">
                           <form:input path="pubPath" placeholder="${xqlc:i18n('ui.cms.pubPath', locale)}"/>
                       </div>
                   </li>
                   <li id="pictureResourceDiv" style="display: none" >
                   <%-- 图片新闻图片资源 --%>
                   <span><fmt:message key="ui.cms.pictureResource"/>:</span>
                   <div class="formright">
                    <input type="file" id="logoImage" name="file" onchange="previewImage(this)"/>
				    <input id="image" type="hidden" name="oldPath" value="${content.picPath}"/>
					<button id="delete" type="button" class="btn"><fmt:message key="ui.cms.delete"/></button>
					<div id="large"></div>
					<span id="preview">
							<img id="imghead" width=50 height=50 src="${ctx}/cms/content/showImage/${content.id}">
					</span>
                   </div>
                   </li>
                   <li class="fullWidth">
                   <%-- 栏目 --%>
                   <span><fmt:message key="ui.cms.category"/>:</span>
                   <div class="formright">
                   <select id="category" name="category_id">
                             <c:forEach items="${categoryInfo}" var="category">
                             <option value="${category.id}">${category.name}</option>
                             </c:forEach>
                   </select>
                   </div>
                   </li>
                   <li class="fullWidth" style="display: none">
                   <%-- 关键字 --%>
                   <span><fmt:message key="ui.cms.keys"/>:</span>
                   <div class="formright">
                    <form:input path="keyWord" placeholder="${xqlc:i18n('ui.cms.keysMessage', locale)}" />
                   </div>
                   </li>
                   <li style="display: none">
                   <%-- 内容审核方式 --%>
                   <span><fmt:message key="ui.cms.contentAuditMode"/>:</span>
                   <div class="formright">
                   <select name="auditContentMethod" id="auditContentMethod" value="1">
                           <option value="1"><fmt:message key="ui.cms.workflow"/></option> 
                           <option value="2"><fmt:message key="ui.cms.personnelAudit"/></option>
                   </select>
                   </div>
                   </li>
                   <li id="contentCheck" style="display:none">
                   <!-- 绑定内容审核角色 -->
                   <span><fmt:message key="ui.cms.contentRole"/>:</span>
                   <div class="formright">
                        <c:if test="${not empty content.contentChecker }">
                               
                               <xqlc:ajaxSelect id="type_roleIds_con" name="roleIds_con" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleIds_con_id}" valueInfo="${roleIds_cons}"/>
						          <span id="owners_id" style="display: none;"></span>
						           <script type="text/javascript">
						           function formatResult(data) {
						           	return '<h5>' + data.name + '</h5>';
						           }
						           function formatSelection(data) {
						           	return data.name;
						           }
						           </script>
                               </c:if>
                               <c:if test="${empty content.contentChecker }">
                                
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
                               </c:if>
                   </div>
                   </li>
                   <li class="fullWidth" style="display:none">
                   <%-- 选择是否评论内容 --%>
                   <span><fmt:message key="ui.cms.commentContent"/>:</span>
                   <div class="formright">
                   <select name="reviewContent" id="reviewContent" value="0">
                              <option value="0"><fmt:message key="ui.cms.no"/></option> 
                              <option value="1"><fmt:message key="ui.cms.yes"/></option>
                   </select>
                   </div>
                   </li>
                   <li id="auditReviewDiv" style="display:none" class="fullWidth">
                   <%-- 选择评论是否审核 --%>
                   <span><fmt:message key="ui.cms.ui.cms.auditComments"/>:</span>
                   <div class="formright">
                   <select name="auditReview" id="auditReview">  
                            <option value="0"><fmt:message key="ui.cms.no"/></option> 
                            <option value="1"><fmt:message key="ui.cms.yes"/></option>
                   </select>
                   </div>
                   
                   </li>
                   <li id="auditReviewMethodDiv" style="display: none">
                   <%-- 评论审核方式 --%>
                   <span><fmt:message key="ui.cms.auditMode"/>：</span>
                   <div class="formright">
                    <select name="auditReviewMethod" id="auditReviewMethod">  
                             <option value="1"><fmt:message key="ui.cms.workflow"/></option> 
                             <option value="2"><fmt:message key="ui.cms.personnelAudit"/></option>
	               </select>
                   </div>
                   </li>
                   <li id="reviewCheck" style="display:none">
                   <!-- 绑定评论审核角色 -->
                   <span><fmt:message key="ui.cms.reviewCheck"/>:</span>
                   <div class="formright">
                   <c:if test="${not empty content.reviewChecker }">
                               
                               <xqlc:ajaxSelect id="type_roleIds_pin" name="roleIds_pin" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleIds_pin_id}" valueInfo="${roleIds_pins}"/>
						          <span id="owners_id" style="display: none;"></span>
						           <script type="text/javascript">
						           function formatResult(data) {
						           	return '<h5>' + data.name + '</h5>';
						           }
						           function formatSelection(data) {
						           	return data.name;
						           }
						           </script>
                               </c:if>
                               <c:if test="${empty content.reviewChecker }">
                                
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
                               </c:if>
                   </div>
                   </li>
                   <li  class="contenteditor" class="fullWidth">
                   <%-- 内容正文 --%>
                   <span><fmt:message key="ui.cms.newsContent"/>:</span>
                   <div class="formright">
                   <label class="editor clearfix">
                    <tags:ueditor name="contentBody" value="${content.contentBody}" id="contentBody"></tags:ueditor>
                   </label>
                   </div>
                   </li>
                   <li id="templateCheck" class="fullWidth">
                   <%-- 模板绑定 --%>
                   <input type="hidden" id="content_template_" name="content_template_" value="${content.templatePath}" >
                   <input type="hidden" id="category_template_" name="category_template_" value="${category.contentPath}">
                   <span><fmt:message key="ui.cms.bindContentTemplate"/>:</span>
                   <div class="formright">
                   <input type="text" name="templatePath" id="templateName_id" value="${content.templatePath}" readonly="readonly">
					<a href="#templateModal" id="content_template" role="button" class="btn" data-toggle="modal">
					    <fmt:message key="ui.cms.chooseTemplate"/>
					</a>
                   </div>
                   </li>
                   <li class="fullWidth">
                     <%-- 角色绑定 --%>
                     <span><fmt:message key="ui.cms.boundRole"/>:</span>
                     <div class="formright">
                    <c:if test="${not empty content.accessUser }">
                                
                                <xqlc:ajaxSelect id="type_roleIds" name="roleIds" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleIds_id}" valueInfo="${roleIds_id_s}"/>
						          <span id="owners_id" style="display: none;"></span>
						           <script type="text/javascript">
						           function formatResult(data) {
						           	return '<h5>' + data.name + '</h5>';
						           }
						           function formatSelection(data) {
						           	return data.name;
						           }
						           </script>
                                </c:if>
                                 <c:if test="${empty content.accessUser }">
                                
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
                                </c:if>
                     </div>
                   </li>
                   <li class="fullWidth">
                   <!-- 附件 -->
                   <span><fmt:message key="ui.cms.attachments"/></span>
                   <div class="formright">
                    <tags:i18nUpload id="fileupload" value="${content.versions}"></tags:i18nUpload>
                    <input type="hidden" name="oldVersions" value="${oldVersions}"/>
                   </div>
                   </li>
                </ul>
             </div>
                <div class="footer tar">
                      <button type="submit" class="btn btn-small btn-success">
                                 <fmt:message key="ui.cms.save"/>
                      </button>
                             
					 <button class="btn-cancel btn-small btn-warning">
		                        <fmt:message key="ui.base.cancel"/>
		             </button>
               </div>
         </div>
        
    </form:form>
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel"><fmt:message key="ui.cms.roleList"/></h3>
        </div>
        <div id="modalbody" class="modal-body" style="height:200px">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span3">
                        <ul id="deptUserTree" class="ztree"></ul>
                    </div>
                    <div id="frameDiv" class="span9">
                        <iframe id="center_frame" name="center_frame" width="100%" height="100%" style="overflow:auto; border:none;"></iframe>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn" id="selectUser_button" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.ok"/></button>
            <button class="btn" id="cancel" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.cancel"/></button>
        </div>
    </div>
    
    <div id="templateModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="templateModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h4 id="myModalLabel"><fmt:message key="ui.cms.templateList"/></h4>
		</div>
		<div id="modalbody" class="modal-body" style="height:200px">
			<div class="container-fluid">
				<div class="row-fluid">
					<xqlc:table id="queryTable" items="${templateInfo}">
                            <xqlc:row var="template">
                                <xqlc:column style="text-align: center" title=" ">
                                    <input type="radio" name="temp_chk" value="${template.path}" />
                                </xqlc:column>
                                <xqlc:column title="${xqlc:i18n('ui.cms.templateName',locale)}" style="text-align: center">${template.name}</xqlc:column>
                                <xqlc:column title="${xqlc:i18n('ui.cms.templatePath',locale)}" style="text-align: center">${template.path}</xqlc:column>
                            </xqlc:row>
                    </xqlc:table>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn" id="selectTemplate_button" data-dismiss="modal" aria-hidden="true">
			    <fmt:message key="ui.cms.ok"/>
			</button>
			<button class="btn" id="cancel" data-dismiss="modal" aria-hidden="true">
			    <fmt:message key="ui.cms.cancel"/>
			</button>
		</div>
	</div>
	<!-- 角色Modal -->
    
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseContentPage.jsp" />
