<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
      <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.base.edit"/></span>
            </h3>
        </div>
    <form:form id="editForm" class="form-horizontal"  action="" modelAttribute="site" cssClass="form-horizontal validation" enctype="multipart/form-data" method="post">
        <form:hidden path="id"/>
        <input type="hidden" name="siteId" value="${site.id}">
        <div class="headInfo clearfix">
	        <div class="actions">
	        </div>
        </div>
         <div class="block-fluid clearfix">
             <div class="formlayout">
                <ul>
                   <li>
                       <!-- 站点名称 -->
                       <span><fmt:message key="ui.cms.siteName"/>:</span>
                       <div class="formright">
                       <input id="name" name="name" type="text" value="${site.name}"  
                                    placeholder="${xqlc:i18n('ui.cms.fillSiteName', locale)}"
                                    class="{required:true}" />
                                    <span id="checkName" style="display:none">
                                    <font color='#B94A48'>Please Change Name!</font>
                                    </span>
                       <input type="hidden" name="oldName" value="${site.name}" >             
                       </div>
                   </li>
                   <li>
                        <!-- 站点标示 -->
                        <span><fmt:message key="ui.cms.englishName"/>:</span>
                        <div class="formright">
                        <input id="ename" name="ename" type="text" value="${site.ename}" 
                                    placeholder="${xqlc:i18n('ui.cms.autogenerationTheMark',locale)}"
                                    class="{required:true}"/>
                                    <span id="checkEname" style="display:none" >
                                        <font color='#B94A48'>Please Change Name!</font>
                                    </span>
                        <input type="hidden" name="oldEName" value="${site.ename}">
                        </div>
                   </li>
                   <li>
                       <!-- 域名别称 -->
                       <span><fmt:message key="ui.cms.domainAnotherNamer"/>:</span>
                       <div class="formright">
                       <form:input path="nlckDomain" cssClass="required" placeholder="${xqlc:i18n('ui.cms.fillByname', locale)}"/>
                       </div>
                   </li>
                   <li>
                       <!-- 站点简称 -->
                       <span><fmt:message key="ui.cms.siteAbbreviation"/>:</span>
                       <div class="formright">
                        <form:input path="simpleName" cssClass="{required:true}" placeholder="${xqlc:i18n('ui.cms.fillShortName', locale)}"/>
                       </div>
                   </li>
                   <li>
                       <!-- 访问协议 -->
                       <span><fmt:message key="ui.cms.accessProtocol"/>:</span>
                       <div class="formright">
                       <select name="agreement" id="agreement">  
                                    <option value="1">HTTP://</option> 
                                    <option value="2">HTTPS://</option>
                                </select>
                       </div>
                   </li>
                   <li>
                      <!-- 绑定域名 -->
                      <span><fmt:message key="ui.cms.parkedDomains"/>:</span>
                      <div class="formright">
                       <input name="webDomain" value="${site.webDomain }" class="{required:true}" id="prependedInput" type="text" 
                           placeholder="${xqlc:i18n('ui.cms.fillInDomain', locale)}">
                      </div>
                   </li>
                   <li>
                      <!-- 访问路径 -->
                      <span><fmt:message key="ui.cms.path"/>:</span>
                      <div class="formright">
                      <form:input path="path" cssClass="{url:true}" placeholder="${xqlc:i18n('ui.cms.fillInPath2', locale)}"/>
                      </div>
                   
                   </li>
                   <li>
                       <!-- 后台国际化 -->
                      <span><fmt:message key="ui.cms.theBackgroundOfInternationalization"/>:</span>
                      <div class="formright">
                        <form:input path="blackConver" cssClass="required" placeholder="${xqlc:i18n('ui.cms.backgroundI18n', locale)}"/>
                      </div>
                   </li>
                   <li>
                      <!-- 前台国际化 -->
                      <span><fmt:message key="ui.cms.theForegroundOfInternationalization"/>:</span>
                      <div class="formright">
                       <form:input path="beforeConver" cssClass="required" placeholder="${xqlc:i18n('ui.cms.fillInI18n', locale)}"/>
                      </div>
                   </li>
                   <li>
                      <!-- 是否主站点  -->
                      <span><fmt:message key="ui.cms.whetherMainSite"/>:</span>
                      <div class="formright">
                      <label class="radio inline">
                          <form:radiobutton path="mainSite" value="yes"/><fmt:message key="ui.base.yes"/>
                      </label>
                      <label class="radio inline">
                          <form:radiobutton path="mainSite" value="no"/><fmt:message key="ui.base.no"/>
                      </label>
                      </div>
                   </li>
                   <li>
                      <!-- 是否启用站点  -->
                      <span><fmt:message key="ui.cms.whetherUseSite"/>:</span>
                      <div class="formright">
                      <label class="radio inline">
                          <form:radiobutton path="startFlag" value="yes" /><fmt:message key="ui.base.yes"/>
                      </label>
                      <label class="radio inline">
                           <form:radiobutton path="startFlag" value="no" /><fmt:message key="ui.base.no"/>
                      </label>
                      </div>
                   </li>
                   <li>
                      <!-- 绑定管理角色 -->
                      <span><fmt:message key="ui.cms.operateRole"/>:</span>
                      <div class="formright">
                        <c:if test="${not empty site.operateRole }">
                                
                                <xqlc:ajaxSelect id="type_ownersId" name="roleIds" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleId}" valueInfo="${roles}"/>
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
                                <c:if test="${ empty site.operateRole }">
                                
                                <xqlc:ajaxSelect id="type_ownersId" name="roleIds" url="${ctx}/platform/account/role.json" multiple="true"
	                               formatResult="formatResult" formatSelection="formatSelection" value="${roleId}" />
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
                </ul>
                <div class="footer tar">
                     <button id="saveType_btn" type="button" class="btn btn-small btn-success">
                        <fmt:message key="ui.cms.save"/>
                     </button>
                    <a href="${ctx}/cms/site/list" class="btn btn-small btn-warning">
                        <fmt:message key="ui.cms.cancel"/>
                    </a>
               </div>
             </div>
         </div>
                
    </form:form>

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
					<%--
					
					<div id="frameDiv" class="span9">
						<iframe id="center_frame" name="center_frame" width="100%" height="100%" style="overflow:auto; border:none;"></iframe>
					</div>
					 --%>
					
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn btn-primary" id="selectUser_button"><fmt:message key="ui.cms.ok"/></button>
			<input type="button" class="btn" name="cancel" value="${xqlc:i18n('ui.cms.cancel', locale)}">
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
    
    <xqlc:extends name="javascript">
     <script type="text/javascript">
        $(function() {
               // 验证框架 
	        $("#editForm").validate();
               //是否重名
               $('#name').on('change',function(){
               	$.get('${ctx}/cms/site/repeat',{ name: $('#name').val()},function(data){
               		if(data == "true"){
               			$('#checkName').show();
               			$('#name').val('');
               		}else if(data == "false"){
               			$('#checkName').hide();
               		}
               	});
   			      
               });
             $('#ename').on('change',function(){
             	$.get('${ctx}/cms/site/enameRepeat',{ ename: $('#ename').val()},function(data){
             		if(data == "true"){
             			$('#checkEname').show();
             			$('#name').val('');
             		}else if(data == "false"){
             			$('#checkEname').hide();
             		}
             	});
             });
               
	    });
        </script>
        <script type="text/javascript">
            $(function() {
                // 处理页面变形
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
                $("#ename").on('blur',function() {
                    var result = $("#ename").val();
                    if(!(/^\w+$/.test(result))) {
                        $("#checkEname").show();
                    };
                    if((/^\w+$/.test(result)) || $("#ename").val() == ""){
                        $("#checkEname").hide();
                    };
                });
                //保存站点
        		$('#saveType_btn').on('click',function() {
        			$('#editForm')[0].method ="post";
                    $('#editForm')[0].action = "${ctx}/cms/site/save";
                    $('#editForm').submit();
                }); 
            });
        </script>
        <script type="text/javascript">
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
			alert($('#templateModal').attr('data-flag'));
			temp_val = $('input[name = "temp_chk"]:checked').val();
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
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseSitePage.jsp" />
