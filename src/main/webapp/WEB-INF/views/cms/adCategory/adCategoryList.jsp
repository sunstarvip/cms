<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="javascript">
	<script type="text/javascript">
		$(function() {
			<c:if test="${not empty success}">
				window.parent.loadCategoryTree();
			</c:if>
			// 处理全选
			$('#chk_all').click(function() {
				$('[name="chk"]').prop('checked',$('#chk_all').prop('checked'));
			});
			
			// 批量删除
			$('#batch_del').click(function() {
				var groupId = '${adgroup.id}';
				if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                	$('#adCategorylist')[0].target = "_parent";
					$('#adCategorylist')[0].action = '${ctx}/cms/adCategory/batchDelete';
					$('#adCategorylist').submit();
                }
			});

			$('.tip-top').tooltip({
				placement : 'top'
			});
		});
		//删除广告位
		function deleteAdCategory(adCategoryId) {
			$.get('${ctx}/cms/adCategory/stopDel/' + adCategoryId, {}, function(response) {
				if (response == 0) {
					var message = '${xqlc:i18n("ui.cms.sureDelete", locale)}';
						if (confirm(message)) {
							$('#adCategorylist')[0].method = "get";
							$('#adCategorylist')[0].action = "${ctx}/cms/adCategory/delete/" + adCategoryId;
							$('#adCategorylist')[0].submit();
						return true;
					} else {
						return false;
					}
				} else {
					var message = '${xqlc:i18n("ui.cms.delete1", locale)}' + response + '${xqlc:i18n("ui.cms.forbidden2", locale)}'
											+ '${xqlc:i18n("ui.cms.sureDelete", locale)}';
						if (confirm(message)) {
							$('#adCategorylist')[0].method = "get";
							$('#adCategorylist')[0].action = "${ctx}/cms/adCategory/delete/" + adCategoryId;
							$('#adCategorylist')[0].submit();
							return true;
						} else {
							return false;
						}
					}
				}, 'json');
		}

		//禁用广告位
		function forbiddenAdCategory(adCategoryId) {
			$.get('${ctx}/cms/adCategory/stopDel/' + adCategoryId, {}, function(response) {
				if (response == 0) {
					var message = '${xqlc:i18n("ui.cms.sureToForbidden", locale)}';
					if (confirm(message)) {
						$('#adCategorylist')[0].method = "get";
						$('#adCategorylist')[0].action = "${ctx}/cms/adCategory/updateUseStatus/no/" + adCategoryId;
						$('#adCategorylist')[0].submit();
					return true;
				} else {
					return false;
				}
			} else {
				var message = '${xqlc:i18n("ui.cms.forbidden1", locale)}' + response + '${xqlc:i18n("ui.cms.forbidden2", locale)}'
											+ '${xqlc:i18n("ui.cms.sureToForbidden", locale)}';
					if (confirm(message)) {
						$('#adCategorylist')[0].method = "get";
						$('#adCategorylist')[0].action = "${ctx}/cms/adCategory/updateUseStatus/no/" + adCategoryId;
						$('#adCategorylist')[0].submit();
						return true;
					} else {
					return false;
					}
				}
			}, 'json');
		}
		//启用广告位
		function useAdCategory(adCategoryId) {
			$('#adCategorylist')[0].method = "get";
			$('#adCategorylist')[0].action = "${ctx}/cms/adCategory/updateUseStatus/yes/"
					+ adCategoryId;
			$('#adCategorylist')[0].submit();
		}

		function selectAds(adCategoryId) {
			$("#chooseAdvertise").click(function() {
				var chk_val = [];
				$("input[name='choose']:checked").each(function() {
					var id = $(this).val();
					chk_val.push(id);
				});
				$("#adIds").val(chk_val.join(","));
				var ids = $("#adIds").val();
				if (ids != null && ids != "") {
				$.post('${ctx}/cms/adCategory/bindAdvertise/' + adCategoryId + '/' + ids, {}, function(response) {
					if (response == 'success') {
						$.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
						window.location.href = "${ctx}/cms/adCategory/adCategoryList";
					} else {
						$.pageMessage('${xqlc:i18n("ui.cms.operError",locale)}');
					}
				}, 'json');
				}
			});
		}

		//处理绑定广告的全选
		$(function() {
			$('#selectAll').click(function() {
				$('[name="choose"]').prop('checked', $('#selectAll').prop('checked'));
			});
				
			$("#add").on('click',function () {
				/* var groupId = '${adgroup.id}';
				window.parent.create(groupId); */
				/* var siteId = '${site.id}'; */
				var nodeId = '${nodeId}';
				/* window.parent.create(nodeId); */
			 	if(nodeId == null || nodeId ==""){
					alert('${xqlc:i18n("ui.cms.choosePoint",locale)}');
				}else {
					$("#add").attr('href','${ctx}/cms/adCategory/createAdCategory?parentId='+nodeId);
				} 
			});
		});
		
		// 批量启用
        $(function() {
        	$('#batch_start').click(function() {
        		var groupId = '${adgroup.id}';
                if($("input[name='chk']:checked").length==0){
                    alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
                }else{
                     $('#adCategorylist')[0].method = 'post';
                     $('#adCategorylist')[0].action = '${ctx}/cms/adCategory/batchStart';
                     $('#adCategorylist').submit();
                }
               
            });
        });
		
    	// 批量停用
        $(function() {
        	var groupId = '${adgroup.id}';
        	$('#batch_blockUp').click(function() {
                if($("input[name='chk']:checked").length==0){
                    alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
                }else{
                    $('#adCategorylist')[0].method = 'post';
                    $('#adCategorylist')[0].action = '${ctx}/cms/adCategory/batchBlockUp';
                    $('#adCategorylist').submit();
                }
                
            });
        });
			
	</script>
	<script type="text/javascript">
		$(function(){
			/*  window.parent.loadTreeAgain(); */
			/* window.parent.loadCategoryTree(); */
		});
        $(function() {
            $('#querytable tbody tr').css({'cursor':'pointer'});
            $('#querytable tbody tr').on('click', function(event) {
            	if(null  ==$(this).attr('data-row-id')){
            		//alert(1111111);
            		event.stopPropagation();
            		
            	}else{
            		
            	window.location.href = '${ctx}/cms/adCategory/CheckAdCategory/' + $(this).attr('data-row-id');
            	}
					
            });
            $('input[name="chk"]').parent('td').on('click', function(event) {
           	   event.stopPropagation();
            });
        });
      //选择进入单个站点
        $(function() {
            $("#button_site").on('click',function() {
                //确认按钮处理
                if($("#site_id").val()==""||$("#site_id").val()==null){
                    alert('${xqlc:i18n("ui.cms.pleaseChooseSite", locale)}');
                }else{
                   // window.location.href="${ctx}/cms/category/siteConnectCategory/"+$("#site_id").val();
                    window.open("${ctx}/cms/index/intoAdCategory?siteId="+$("#site_id").val(),'_blank');
                }
            });
        })
      
    </script>
</xqlc:extends>

<xqlc:extends name="content">
	<%-- <div id="pop">
		<div class="control-group">
            <label class="control-label" style="text-align:left; width:100px"><fmt:message key="ui.cms.width"/> (px):</label>
            <div class="controls" style="margin-left:100px">
               	<input type="text" data-id="width1" value="${width_ge}" style="width:75px" />
               	<button data-id="span_show" type="button">-</button>
               	   <input type="text" data-id="width2" value="${width_le}" style="width:75px" />
            </div>
        </div>
		<div class="control-group">
			<label class="control-label" style="text-align: left; width: 100px"><fmt:message key="ui.cms.isUse" />:</label>
			<div class="controls" style="margin-left: 100px">
				<select data-id="useCode">
					<option value=""> <fmt:message key="ui.cms.pleaseChoose" /></option>
					<option value="yes" <c:if test="${useCode == 'yes'}">selected</c:if>> <fmt:message key="ui.cms.yes" /></option>
					<option value="no" <c:if test="${useCode == 'no'}">selected</c:if>><fmt:message key="ui.cms.no" /></option>
				</select>
			</div>
		</div>
	</div> --%>
	<form id="adCategorylist" action="${ctx}/cms/adCategory/adCategoryList?parentId=${nodeId}">
		<input type="hidden" id="name" name="queryParameter.name_li" value="${name_li}"> 
		<input type="hidden" id="width1" name="queryParameter.width_ge" value="${width_ge}"> 
		<input type="hidden" id="width2" name="queryParameter.width_le" value="${width_le}"> 
		<input type="hidden" id="useCode" name="queryParameter.useCode" value="${useCode}">
		<input type = "hidden" name = "parentId" value="${parent.id }"/>
		
		<div class="row-fluid">
			<div class=" span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>
						<fmt:message key="ui.cms.adPositionManagement" />
						</h3>
					</div>
				<div class="toolbar">
            		<ul>
                		<li>
                   			<!--新增  -->
                   			<%-- <a type="button" id="add" class="buttons btn btn-small btn-primary" href ="">
							<fmt:message key="ui.base.create" /></a> --%>
							<!-- 删除 -->
							<button type="button" id="batch_del" class="buttons btn btn-danger btn-small">
								<fmt:message key="ui.cms.delete" />
							</button>
                		</li>
                		<li class="divider"></li> 
                		<li>
							<!--批量启用  -->
							<a id="batch_start" class="btn btn-small btn-success">
                        		<fmt:message key="ui.cms.start"/>
                   			</a>
                		</li>
                		<li class="divider"></li> 
                		<li>
                   			<!-- 批量停用 -->
                   			<a id="batch_blockUp" class="btn btn-small btn-inverse">
                        		<fmt:message key="ui.cms.blockUp"/>
                    		</a>
                		</li>
                		<li class="divider"></li> 
                		<li>
							<!-- 高级搜索 -->
                			<%-- <tags:advancedSearch id="advanced_search" template="pop" form="adCategorylist" input="input_search">
							<input type="text" id="input_search" data-id="name" value="${name_li}" placeholder="<fmt:message key="ui.cms.adCategoryName"/>">
						</tags:advancedSearch> --%>
                		</li>
                		<li class="btn-group">
                		    <select id="site_id">
		                        <option value="" selected="selected">
		                            <fmt:message key="ui.cms.switchSite" />
		                        </option>
		                        <c:forEach items="${useSites}" var="site">
		                            <option value="${site.id}">${site.name}</option>
		                        </c:forEach>
		                    </select> 
		                    
                		</li>
                		<li class="divider"></li> 
                		<li>
                		    <button class="btn btn-primary btn-small" name="button" id="button_site" type="button">
			                <fmt:message key="ui.base.ok"/>
			                </button>
                		</li>
          		 	</ul>
        </div>	
						
						
					<div class="widget-content">
						<xqlc:table items="${adCategories}" id="querytable">
							<xqlc:row var="adCategory">
								<xqlc:column title="<input type='checkbox' id='chk_all'>" width="20px">
									<input type="checkbox" name="chk" value="${adCategory.id }">
								</xqlc:column>
								<xqlc:column title="${xqlc:i18n('ui.cms.adCategoryName',locale)}">
									${adCategory.name}
									<%-- <a href="#myModal_${adCategory.id}" id="model" role="button" data-toggle="modal">${adCategory.name}</a> --%>
									<%-- <a href="${ctx}/cms/adCategory/update/${adCategory.id}/${adCategory.group.id}">${adCategory.name}</a> --%>
								</xqlc:column>
								<%-- <xqlc:column title="${xqlc:i18n('ui.cms.ownGroup',locale)}">${adCategory.adgroup.name}</xqlc:column> --%>
								<xqlc:column title="${xqlc:i18n('ui.cms.width',locale)}">${adCategory.width}px</xqlc:column>
								<xqlc:column title="${xqlc:i18n('ui.cms.height',locale)}">${adCategory.height}px</xqlc:column>
								<xqlc:column title="${xqlc:i18n('ui.cms.adCategoryType',locale)}">${adCategory.adCategoryType}</xqlc:column>
								<xqlc:column title="${xqlc:i18n('ui.cms.isUse',locale)}">
									<c:if test="${adCategory.useCode == 'yes'}"><fmt:message key="ui.cms.yes" /></c:if>
									<c:if test="${adCategory.useCode == 'no'}"><fmt:message key="ui.cms.no" /></c:if>
								</xqlc:column>
								<xqlc:column title="${xqlc:i18n('ui.cms.createTime',locale)}">
									<fmt:formatDate value="${adCategory.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
								</xqlc:column>
							
							</xqlc:row>
						</xqlc:table>
						<!-- 查看广告位详细信息 -->
						<c:forEach items="${page.content}" var="detail">
							<div id="myModal_${detail.id}" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h3 id="myModalLabel">
										<fmt:message key="ui.cms.detail" />
									</h3>
								</div>
								<div id="modalbody" class="modal-body">
									<div class="row-fluid">
										<div class="span6">
											<font size="2"><strong><fmt:message key="ui.cms.adCategoryName" />：</strong></font> 
											<font size="2">${detail.name}</font>
										</div>
										<div class="span6">
											<font size="2"><strong><fmt:message key="ui.cms.ownGroup" />：</strong></font> 
											<%-- <font size="2">${detail.adgroup.name}</font> --%>
										</div>
									</div>
									<div class="row-fluid">
										<div class="span6">
											<font size="2"><strong><fmt:message key="ui.cms.width" />：</strong></font>
											<font size="2">${detail.width} px</font>
										</div>
										<div class="span6">
											<font size="2"><strong><fmt:message key="ui.cms.height" />：</strong></font> 
										    <font size="2">${detail.height} px</font>
										</div>
									</div>
									<div class="row-fluid">
										<div class="span6">
											<font size="2"><strong><fmt:message key="ui.cms.isUse" />：</strong></font>
											<font size="2"> 
											<c:if test="${detail.useCode == 'yes'}"><fmt:message key="ui.cms.yes" /></c:if> 
											<c:if test="${detail.useCode == 'no'}"><fmt:message key="ui.cms.no" /></c:if>
											</font>
										</div>
									</div>
									<div class="row-fluid">
										<div class="span6">
											<font size="2"><strong><fmt:message key="ui.cms.advertiseList" />：</strong></font>
											<c:forEach items="${detail.advertiseList}" var="advertise">
												<font size="2">${advertise.name}</font>
											</c:forEach>
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.update"/>"
										href="${ctx}/cms/adCategory/update/${adCategory.id}"><i
										class="icon-pencil"></i></a>
									<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.delete"/>"
										onclick="deleteAdCategory('${adCategory.id}');"><i
										class="icon-remove"></i></a>
									<c:if test="${adCategory.useCode == 'no'}">
										<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.useAdPosition"/>"
											onclick="useAdCategory('${adCategory.id}');"><i
											class="icon-ok-circle"></i></a>
									</c:if>
									<c:if test="${adCategory.useCode == 'yes'}">
										<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.forbiddenAdPosition"/>"
											onclick="forbiddenAdCategory('${adCategory.id}');"><i
											class="icon-ban-circle"></i></a>
									</c:if>
									<a class="tip-top btn" data-original-title="<fmt:message key="ui.cms.putAdvertise"/>"
										href="#advertiseModal" id="model" role="button"
										data-toggle="modal" onclick="selectAds('${adCategory.id}');"></a>
									<button class="btn" id="btn_cancel" data-dismiss="modal" aria-hidden="true">
										<fmt:message key="ui.cms.close" />
									</button>
								</div>
							</div>
						</c:forEach>
						<div class="widget-foot">
							<div class="pagination pagination-centered">
								<xqlc:page page="${page}" formId="adCategorylist"></xqlc:page>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--绑定广告 -->
			<div id="advertiseModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 id="myModalLabel">
						<fmt:message key="ui.cms.advertiseList" />
					</h3>
				</div>
				<div id="modalbody" class="modal-body">
					<table class="table table-bordered">
						<tr align="center">
							<th width="30"><fmt:message key="ui.cms.number" /></th>
							<th width="20"><input type="checkbox" id="selectAll"></th>
							<th width="100"><fmt:message key="ui.cms.advertiseName" /></th>
							<th width="100"><fmt:message key="ui.cms.startTime" /></th>
							<th width="100"><fmt:message key="ui.cms.endTime" /></th>
						</tr>
						<c:forEach items="${advertiseList}" var="advertise" varStatus="s">
							<tr align="center">
								<td>${s.index+1 }</td>
								<td><input type="checkbox" multiple="multiple" name="choose" value="${advertise.id}"></td>
								<td>${advertise.name}</td>
								<td><fmt:formatDate value="${advertise.startTime}" pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${advertise.endTime}" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="modal-footer">
					<button class="btn" id="chooseAdvertise" data-dismiss="modal" aria-hidden="true">
						<fmt:message key="ui.cms.ok" />
					</button>
					<button class="btn" id="cancel" data-dismiss="modal" aria-hidden="true">
						<fmt:message key="ui.cms.cancel" />
					</button>
				</div>
			</div>
		</div>
		<input type="hidden" name="adIds" id="adIds" value="">
	</form>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseAdCategoryPage.jsp" />
