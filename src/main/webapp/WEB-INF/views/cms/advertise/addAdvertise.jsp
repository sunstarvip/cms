<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="css">
  <link href="${ctx}/static/css/ui/datetime/datetimepicker.css" rel="stylesheet" media="screen">
  <style type="text/css">
    .ui-layout-north {
        padding: 0;
        overflow: hidden;
        margin: 0;
    }
</style>
<style type="text/css">
	    .bs-docs-sidenav {
	        background-color: #FFFFFF;
	        border-radius: 6px 6px 6px 6px;
	        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
	        margin: 30px 0 0;
	        padding: 0;
	        width: 228px;
	    }
	    .bs-docs-sidenav.affix {
	        top: 40px;
	    }
	    .bs-docs-sidenav {
	        width: 170px;
	    }
	
	</style>

</xqlc:extends>

<xqlc:extends name="javascript">
	<script type="text/javascript" src="${ctx}/static/js/ui/datetime/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx}/static/js/ui/datetime/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<!-- 验证框架 -->
	   <script type="text/javascript">
		    $(function() {
		     $("#editForm").validate();
		 });
	   </script>
	<script type="text/javascript">
		$(function() {
			$('.form_datetime').datetimepicker({
		        //language:  'fr',
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView:0,
				forceParse: 0,
		        showMeridian: 1,
		        pickerPosition: "bottom-left"
		    });

				$(window).resize(function() {
					$('#frameDiv').height($(window).height() - 90);
				});
				$('#frameDiv').height($(window).height() - 90);
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
			$.fn.datepicker.dates['I18N'] = {
				days : [ "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日" ],
				daysShort : [ "周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日" ],
				daysMin : [ "日", "一", "二", "三", "四", "五", "六", "日" ],
				months : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月",
						"九月", "十月", "十一月", "十二月" ],
				monthsShort : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月",
						"九月", "十月", "十一月", "十二月" ],
				today : "今日"
			};
			$('#start_Time').datepicker({
				language : 'I18N'
			});
			$('#end_Time').datepicker({
				language : 'I18N'
			});

			$("#save_button").click(function() {
						var start = $("#startTime").val();
						var end = $("#endTime").val();
						var sp_startDate = start.split("-");
						var d_time = new Date(sp_startDate[0], sp_startDate[1],
								sp_startDate[2]);
						var d_sDate = d_time.getTime();
						var sp_endTime = end.split("-");
						var d_endTime = new Date(sp_endTime[0], sp_endTime[1],
								sp_endTime[2]);
						var d_eDate = d_endTime.getTime();
						if (d_sDate > d_eDate) {
							$("#checkTime").show();
							return false;
						} else {
							$("#checkTime").hide();
						}
					});
		});
		$(function() {
			var value = $('#type').val();
			if(value == 1) {
				$("#version").show();
				$("#content").hide();
			}
			if(value == 2) {
				$("#version").show();
				$("#content").hide();
			}
			if(value == 3) {
				$("#version").hide();
				$("#content").show();
			}
			$('#type').on(
					'change',
					function() {
						var value = $('#type').val();
						if(value == 1||value == 2) {
							$("#version").show();
							$("#content").hide();
						}
						if(value == 3) {
							$("#version").hide();
							$("#content").show();
						}
						if(value ==""){
							$("#version").hide();
							$("#content").hide();
						}
					});
		});
		
	</script>
</xqlc:extends>
<xqlc:extends name="title">
	<fmt:message key="ui.cms.advertiseManagement" />
</xqlc:extends>
<!-- 左边导航 -->
<xqlc:extends name="nav">
    <h3>
        <span><fmt:message key="ui.base.powerManagement"/></span>
    </h3>
    <ul>
        <%-- <li><a href="${ctx}/cms/index/sitelist" id="siteManagement"><fmt:message key="ui.cms.siteManagement" /></a></li>
        <li><a href="${ctx}/cms/index/categorylist" id="categoryManagement"><fmt:message key="ui.cms.categoryManagement" /></a></li>
        <li><a href="${ctx}/cms/index/contentlist" id="contentManage"><fmt:message key="ui.cms.contentManage" /></a></li>
        <li><a href="${ctx}/cms/index/templist" id="templateManagement"><fmt:message key="ui.cms.templateManagement" /></a></li>
        <li><a href="${ctx}/cms/index/grouplist" id="adCategoryManagement"><fmt:message key="ui.cms.adPositionManagement" /></a></li> --%>
        <li class="active">
            <a href="${ctx}/cms/index/advertiselist" id="advertiseManagement">
            <i class="icon-user"></i>
            <fmt:message key="ui.cms.advertiseManagement" />
            <i class="icon-chevron-right pull-right"></i>
            </a>
        </li>
    </ul>
</xqlc:extends>
<!-- content部分 -->
<xqlc:extends name="content">
			<div class="appcontent">
            <h3>
                <span><fmt:message key="ui.base.edit"/></span>
            </h3>
        </div>
		<form:form id="editForm" class="form-horizontal" action="${ctx}/cms/advertise/save" modelAttribute="advertise" cssClass="form-horizontal validation" method="post">
			<form:hidden path="id" />
			
			
         <div class="headInfo clearfix">
          <div class="actions">
          </div>
        </div>
        <div class="block-fluid clearfix">
             <div class="formlayout">
                <ul>
                   <li>
                   <!-- 广告名 -->
                   <span><fmt:message key="ui.cms.advertiseName" /></span>
                   <div class="formright">
                   <form:input path="name" cssClass="{required:true,messages:{required:' '}}" />
                   </div>
                   </li>
                   <li>
                   <!-- 广告类型 -->
                   <span><fmt:message key="ui.cms.type" /></span>
                   <div class="formright">
                   <form:select path="type" cssClass="{required:true,messages:{required:' '}}">
							<form:option value="">
								<fmt:message key="ui.cms.pleaseChoose" />
							</form:option>
							<form:option value="1">
								<fmt:message key="ui.cms.flash" />
							</form:option>
							<form:option value="2">
								<fmt:message key="ui.cms.image" />
							</form:option>
							<form:option value="3">
								<fmt:message key="ui.cms.text" />
							</form:option>
			       </form:select>
                   </div>
                   </li>
                   <li id="version" style="display: none">
                   <!-- 附件 -->
                   <span><fmt:message key="ui.cms.attachments"/></span>
                   <div class="formright">
                   <tags:i18nUpload id="fileupload" value="${advertise.versions}"></tags:i18nUpload>
                   <input type="hidden" name="oldVersions" value="${oldVersions}"/>
                   </div>
                   </li>
                   <li class="contenteditor" id="content" style="display:none">
                   <!-- 文字 -->
                   <span><fmt:message key="ui.cms.textContent"/>:</span>
                   <div class="formright">
                   <label class="editor clearfix">
                   <form:textarea path="textContent" rows="3"/>
                   </label>
                   </div>
                   </li>
                   <li id="link">
                   <!-- Link -->
                   <span><fmt:message key="ui.cms.linkAddress" />:</span>
                   <div class="formright">
                   <form:input path="linkAddress" cssClass="{url:true}"/>
                   </div>
                   </li>
                   <li>
                   <!-- StartTime -->
                   <span><fmt:message key="ui.cms.startTime" /></span>
                   <div class="formright">
                   <%-- <input size="10" style="width: 170px;" id="startTime" name="startTime" type="text"
											value="${advertise.startTime}" class="{required:true,messages:{required:' '}}" readonly/>
											<span class="add-on" style="width:15px"><i class="icon-remove"></i></span>
                                            <span class="add-on"><i class="icon-th"></i></span> --%>
                   <%-- <xqlc:datetimepicker name="startTime" id="startTime" value="${xqlc:formatDate(advertise.startTime,'yyyy-MM-dd HH:mm')}"/>  --%>      
                   <xqlc:datetimepicker name="startTime" id="startTime" value="${advertise.startTime}"/>                   
                   </div>
                   </li>
                   <li>
                   <!-- EndTime -->
                   <span><fmt:message key="ui.cms.endTime" /></span>
                   <div class="formright">
                  <%--  <input size="10" style="width: 170px;" id="endTime" name="endTime" type="text"
											value="${advertise.endTime}" class="{required:true,messages:{required:' '}}" readonly />
											<span class="add-on"><i class="icon-remove"></i></span>
                                            <span class="add-on"><i class="icon-th"></i></span> --%>
                    <xqlc:datetimepicker name="endTime" id="endTime" value="${advertise.endTime}"/>                         
                   </div>
                   </li>
                   <li>
                   <!-- 权重 -->
                   <span><fmt:message key="ui.cms.sort" /></span>
                   <div class="formright">
                   <form:input path="weight" cssClass="{required:true,digits:true,messages:{required:' '}}" />
									<span id="s1"></span>
                   </div>
                   </li>
                </ul>
                <div class="footer tar">
                    <button type="submit" class="btn btn-small btn-success">
                                 <fmt:message key="ui.cms.save"/>
                     </button>
                     <button type="button" class="btn btn-warning btn-cancel btn-small">
								 <fmt:message key="ui.cms.cancel" />
					</button>
               </div>
             </div>
         </div>
				<!-- 按钮 -->	
	<%-- <div class="widget-content">
              
         
						
						
						
						<div id="link" class="widget-content">
							<label class="control-label" for="linkAddress"><fmt:message key="ui.cms.linkAddress" />:</label>
							<div class="controls">
								<form:input path="linkAddress" cssClass="{url:true}"/>
							</div>
						</div>
						
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.startTime" /></label>
								<div class="controls">
									<div class="input-append date form_datetime" data-date="2013-01-01 00:00:00"
									 	data-date-format="yyyy-mm-dd HH:mm:ss" data-link-field="dtp_input1" data-autoclose="true">
										<input size="10" style="width: 170px;" id="startTime" name="startTime" type="text"
											value="${advertise.startTime}" class="{required:true,messages:{required:' '}}" readonly/>
											<span class="add-on"><i class="icon-remove"></i></span>
                                            <span class="add-on"><i class="icon-th"></i></span>
									</div>
									
								</div>
							</div>
						</div>
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.endTime" /></label>
								<div class="controls">
									<div class="input-append date form_datetime" data-date="2013-01-01 00:00:00"
									 	data-date-format="yyyy-mm-dd HH:mm:ss" data-link-field="dtp_input1" data-autoclose="true">
										<input size="10" style="width: 170px;" id="endTime" name="endTime" type="text"
											value="${advertise.endTime}" class="{required:true,messages:{required:' '}}" readonly />
											<span class="add-on"><i class="icon-remove"></i></span>
                                            <span class="add-on"><i class="icon-th"></i></span>
									</div>
									</font></span>
								</div>
							</div>
						</div>
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.sort" /></label>
								<div class="controls">
									<form:input path="weight" cssClass="{required:true,digits:true,messages:{required:' '}}" />
									<span id="s1"></span>
								</div>
							</div>
						</div>
						
					</div>
				</div>
				</div>
	</div> --%>
		</form:form>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseAddvertisePage.jsp" />
