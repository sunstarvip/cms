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

<xqlc:extends name="content">
    <form id="queryForm" action="${ctx}/cms/content/treeList/${categoryId}" method="get">
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.contentList" /></span>
            </h3>
        </div>
        <div class="toolbar">
            <ul>
                <li>
                    <!-- 新增按钮 -->
                    <a class="btn btn-small btn-success" href="${ctx}/cms/content/create/${categoryId}">
                        <fmt:message key="ui.base.create"/>
                    </a>
                 </li>  
                 <li class="divider"></li> 
                    <!-- 返回栏目列表 -->
	                <%-- <a id="categoryCheck_button" class="btn btn-small" target="_parent" href="${ctx}/cms/category/list">
	                    <fmt:message key="ui.cms.categoryList"/>
	                </a> --%>
	                <%--<li>--%>
                        <%--<!-- 设为最新 -->--%>
                        <%--<a id="batch_new" class="btn btn-small btn-warning">--%>
                            <%--<fmt:message key="ui.cms.makeNew"/>--%>
                        <%--</a>--%>
	                <%--</li>--%>
                    <%--<li class="divider"></li>--%>
                    <%--<li>--%>
                        <%--<!-- 提交 -->--%>
                        <%--<a id="batch_submit" class="btn btn-small btn-info">--%>
                            <%--<fmt:message key="ui.base.submit"/>--%>
                        <%--</a>--%>
	                <%--</li>--%>
	                <%--<li class="divider"></li> --%>
	                <%--<li>--%>
                        <%--<!-- 审核 -->--%>
                        <%--<a id="batch_check" class="btn btn-small">--%>
                            <%--<fmt:message key="ui.base.check"/>--%>
                        <%--</a>--%>
	                <%--</li>--%>
	                <%--<li class="divider"></li> --%>
	                <li>
                    <a id="batch_publish" class="btn btn-small btn btn-info">
                        <fmt:message key="ui.cms.publish"/>
                    </a>
	                </li>
	                <li class="divider"></li> 
                    <!-- 批量移除--暂时不用 -->
                   <%--  <a id="batch_move" class="btn btn-small">
                        <fmt:message key="ui.cms.batchMove"/>
                    </a> --%>
                    <li>
                    <a id="batch_delete" class="btn btn-small btn-danger">
                        <fmt:message key="ui.base.delete"/>
                    </a>
                    </li>
                    <li class="divider"></li> 
                    <!-- 切换站点 -->
                  <li>
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
                <!-- 模糊查询 -->
                <li>
                <div class="buttons pull-right form-inline">
                    <!-- 查询内容标题 -->
                    <%-- <fmt:message key="ui.cms.title"/>: --%>
                    <input class="input-small" type="text" id="input_search" name="queryParameter.title_li" value="${title_li}" placeholder="${xqlc:i18n('ui.cms.inputTitle', locale)}">
                    <!-- 查询内容创建人 -->
                    <%-- <fmt:message key="ui.cms.founder"/>: --%>
                    <input class="input-small" type="text" id="input_search" name="queryParameter.founder.name_li" value="${founder.name_li}" placeholder="${xqlc:i18n('ui.cms.founder', locale)}">
                    <!-- 查询内容审核状态 -->
                    <select class="input-medium" id="input_search_auditStatus" name="queryParameter.auditStatus">
                        <option value=""><fmt:message key="ui.cms.pleaseChoose"/></option>
                        <option value="1"><fmt:message key="ui.cms.uncommitted"/></option> 
                        <option value="2"><fmt:message key="ui.cms.unaudited"/></option> 
                        <option value="3"><fmt:message key="ui.cms.noPass"/></option>
                        <option value="4"><fmt:message key="ui.cms.pass"/></option> 
                        <option value="5"><fmt:message key="ui.cms.published"/></option>
                    </select>
                    <button type="submit" class="btn-info btn-small"><fmt:message key="ui.cms.search" /></button>
                    <input type="checkbox" name="siteSearch" value="yes" <c:if test="${not empty siteSearch}"> checked="check" </c:if> >
                    <%--<c:if test="${empty siteSearch}">--%>
                        <%--<input type="checkbox" name="siteSearch" value="yes" checked="check">--%>
                    <%--</c:if>--%>
                    全站搜索
                </div>
                </li>
            </ul>
        </div>
        <table id="queryTable" class="table table-striped table-bordered table-hover">
	        <thead>
	        <tr>
	            <!-- 复选框 -->
	            <th style="text-align: center"><input id="chk_all" type="checkbox"></th>
	            <!-- 列表标题 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.title"/></th>
	            <!-- 列表类型 -->
	            <%-- <th style="text-align: center"><fmt:message key="ui.cms.type"/></th> --%>
	            <!-- 内容创建人 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.founder"/></th>
	            <!-- 内容创建时间 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.createTime"/></th>
	            <!-- 内容审核状态 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.auditStatus"/></th>
	            <!-- 审核人员 -->
	            <th style="text-align: center"><fmt:message key="ui.cms.contentCheckUser"/></th>
	        </tr>
	        </thead>
	        <tbody>
	        <c:forEach var="content" items="${pageInfo.content}" >
	            <tr id = "${content.id}">
	                <!-- 复选框 -->
	                <td  style="text-align: center"><input type="checkbox" name="chk" value="${content.id}"></td>
	                <!-- 列表标题 -->
	                <td  style="text-align: center">
	                    <c:if test="${content.beNew%2 == 1}">
                        <img src="${ctx}/static/cms/images/new.gif">
	                    </c:if>
	                    
	                    <c:choose>  
                            <c:when test="${content.type == '1'}">  
                                <c:if test="${empty content.picPath}">
                                    <fmt:message key="ui.cms.normalNews"/>/
                                </c:if>
                                <c:if test="${not empty content.picPath}">
                                    <fmt:message key="ui.cms.pictureNews"/>/
                                </c:if>
                                <span  name="contentTitle">
                                    <c:if test="${not empty content.templatePath}">
                                        <a href="${ctx}${content.templatePath}?contentId=${content.id}" target="_Blank">${content.title}</a>
                                    </c:if>
                                    <c:if test="${empty content.templatePath}">
                                        ${content.title}
                                    </c:if>
                                </span>
                            </c:when>  
                            <c:when test="${content.type == '2'}">  
                                <fmt:message key="ui.cms.linkNews"/>/
                                <span  name="contentTitle">
                                    <a href="http://${content.pubPath}" target="_Blank">${content.title}</a>
                                </span>
                            </c:when>  
                            <c:otherwise>  
                                <fmt:message key="ui.cms.normalNews"/>/
                                <span  name="contentTitle">
                                    <c:if test="${not empty content.templatePath}">
                                        <a href="${ctx}${content.templatePath}?contentId=${content.id}" target="_Blank">${content.title}</a>
                                    </c:if>
                                    <c:if test="${empty content.templatePath}">
                                        ${content.title}
                                    </c:if>
                                </span>
                            </c:otherwise>  
                        </c:choose>
	                </td>
                    <!-- 内容创建人 -->
                    <td  style="text-align: center">${content.founder.name}</td>
                    <!-- 内容创建时间 -->
                    <td  style="text-align: center"><fmt:formatDate value="${content.createTime}" type="date"/></td>
                    <!-- 内容审核状态 -->
                    <td  style="text-align: center">
                        <c:choose>  
                               <c:when test="${content.auditStatus == '1'}">  
                                   <fmt:message key="ui.cms.uncommitted"/> 
                               </c:when>  
                               <c:when test="${content.auditStatus == '2'}">  
                                   <fmt:message key="ui.cms.unaudited"/>
                               </c:when>  
                               <c:when test="${content.auditStatus == '3'}">  
                                   <a href="#_modal_bhyj_${content.id}" role="button" data-toggle="modal">
                                       <fmt:message key="ui.cms.noPass"/>
                                   </a>
                                   
                               </c:when>
                               <c:when test="${content.auditStatus == '4'}">  
                                   <fmt:message key="ui.cms.pass"/>
                               </c:when>
                               <c:when test="${content.auditStatus == '5'}">  
                                   <fmt:message key="ui.cms.published"/>
                               </c:when>
                               <c:otherwise>  
                               </c:otherwise>  
                        </c:choose>
                    </td>
                    <!-- 审核人员 -->
                    <td  style="text-align: center">
                        <c:if test="${content.auditContentMethod == 1 }"><fmt:message key="ui.cms.workflow"/></c:if>
                        <c:if test="${content.auditContentMethod == 2 }"><fmt:message key="ui.cms.personnelAudit"/></c:if>
                    </td>
	            </tr>
	        </c:forEach>
	        </tbody>
	    </table>
        <div class="pagination pagination-centered">
            <xqlc:page page="${pageInfo}" formId="queryForm" />
        </div>
    </form>
    <!-- 批量移动内容 -->
    <div id="moveModal" class="modal hide fade">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
		    <h3><fmt:message key="ui.cms.chooseCategory"/></h3>
		</div>
		<div id="modalbody" class="modal-body" style="height:200px">
			<div class="container-fluid">
				<div class="row-fluid">
					<div class="span3">
						<ul id="categoryTree" class="ztree"></ul>
					</div>
					<div id="frameDiv" class="span9">
						<iframe id="center_frame" name="center_frame" width="100%" height="100%" style="overflow:auto; border:none;"></iframe>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn btn-primary" data-dismiss="modal" id="movesubmit"><fmt:message key="ui.cms.ok"/></button>
			<button class="btn" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.close"/></button>
		</div>
	</div>
	<!-- 查看驳回意见 -->
	<c:forEach items="${pageInfo.content}" var="a">
	<tags:dialog id="_modal_bhyj_${a.id}">
	    <jsp:attribute name="title"><fmt:message key="ui.cms.dismissList"/></jsp:attribute>
	    <jsp:attribute name="content">
	        <div class="tabbable"> <!-- Only required for left/right tabs -->
			    <ul class="nav nav-tabs">
				    <li class="active"><a href="#tab1" data-toggle="tab"><fmt:message key="ui.cms.currentOpinion"/>:</a></li>
					<li><a href="#tab2" data-toggle="tab"><fmt:message key="ui.cms.historyOpinion"/>:</a></li>
				</ul>
			    <div class="tab-content">
				    <div class="tab-pane active" id="tab1">
					<table>
					<tr>
					    <td width="200px">
						    <label class="label label-info">
						    <fmt:message key="ui.cms.dismissOpinion"/>
						    </label>
					    </td>
					    <td>
					        <label class="label label-info">
					        <fmt:message key="ui.cms.dismissTime"/>
					        </label>
					    </td>
					</tr>
					<c:forEach items="${a.dismisses}" var="c">
					<c:if test="${c.statue == '1'}">
						<tr>
							<td width="200px">${c.dismissComment }</td>
						 	<td><fmt:formatDate value="${c.createTime}"/></td>
						</tr>
					</c:if>
					</c:forEach>
					</table>
				</div>
				<div class="tab-pane" id="tab2">
					<table>
					<tr><td width="200px"><label class="label label-info"><fmt:message key="ui.cms.dismissOpinion"/></label></td><td><label class="label label-info"><fmt:message key="ui.cms.dismissTime"/></label></td></tr>
					<c:forEach items="${a.dismisses}" var="c">
					<c:if test="${c.statue == '0'}">
						<tr>
							<td width="200px">${c.dismissComment }</td>
						 	<td><fmt:formatDate value="${c.createTime}"/></td>
						</tr>
					</c:if>
					</c:forEach>
					</table>
				</div>
			</div>
		 </div>
	     </jsp:attribute>
	     <jsp:attribute name="footer">
	         <button class="btn" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.close"/></button>
	     </jsp:attribute>
    </tags:dialog>
	</c:forEach>
	
	<xqlc:extends name="javascript">
    <script type="text/javascript" src="${ctx}/static/websitetheme/js/jquery.ztree.all-3.2.min.js"></script>
    <script type="text/javascript">
        $(function() {
            // 处理全选
            $('#chk_all').click(function() {
            	$('[name="chk"]').prop('checked', $('#chk_all').prop('checked'));
            });
            
            // 处理按钮的提示
            $('.tip-top').tooltip({
                placement : 'top'
            });
            // 批量删除$('#batch_new')
            $('#batch_delete').click(function() {
                if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                    $('#queryForm')[0].method = 'post';
                    $('#queryForm')[0].action = '${ctx}/cms/content/batchDelete/${categoryId}';
                    $('#queryForm').submit();
                }
            });
            // 批量设置为新
            $('#batch_new').click(function() {
                if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                    $('#queryForm')[0].method = 'post';
                    $('#queryForm')[0].action = '${ctx}/cms/content/batchMakNew/${categoryId}';
                    $('#queryForm').submit();
                }
            }); 
            // 批量提交
            $('#batch_submit').click(function() {
                if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                    $('#queryForm')[0].method = 'post';
                    $('#queryForm')[0].action = '${ctx}/cms/content/batchSubmit/${categoryId}';
                    $('#queryForm').submit();
                }
            }); 
            // 批量审核
            $('#batch_check').click(function() {
                if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                    $('#queryForm')[0].method = 'post';
                    $('#queryForm')[0].action = '${ctx}/cms/content/batchCheck/${categoryId}';
                    $('#queryForm').submit();
                }
            }); 
            // 批量发布
            $('#batch_publish').click(function() {
                if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                    $('#queryForm')[0].method = 'post';
                    //$('#queryForm')[0].action = '${ctx}/cms/content/batchPublish/${categoryId}';
                    $('#queryForm')[0].action = '${ctx}/cms/content/batchDynamicPublish/${categoryId}';
                    $('#queryForm').submit();
                }
            });
            //批量移动
            $("#batch_move").click(function() {
                if($("input[name='chk']:checked").length == 0) {
                    alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                }else {
                    $('#moveModal').modal('show');
                    $("#movesubmit").click(function() {
                        var categoryId = "";
                        $("input[name='chk']:checked",window.frames["center_frame"].document).each(function() {
                            categoryId = $(this).val();
                       });
                       $('#queryForm')[0].method = 'post';
                       $('#queryForm')[0].action = '${ctx}/cms/content/batchMove/' + categoryId;
                       $('#queryForm').submit();
                    });
                }
            });
            // 搜索状态
            if('${auditStatus}') {//审核评论auditReview 0.否   1.是
                $('#input_search_auditStatus').val('${auditStatus}');
            }
        });
        
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
                            '${ctx}/cms/content/getCategoryList/' + treeNode.id);
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
                url : '${ctx}/cms/category/tree',
                dataType : "json",
                success : function(data) {
                    zNodes_ = data;
                    treeObj = $.fn.zTree.init($("#categoryTree"), setting_, zNodes_);
                    if (!nodeId) {
                        var nodes = treeObj.getNodes();
                        if (nodes.length > 0) {
                            $('#center_frame').attr('src','${ctx}/cms/content/getCategoryList/'+ nodes[0].id);
                                treeObj.selectNode(nodes[0]);
                        };
                    } else {
                    var node = treeObj.getNodeByParam("id", nodeId,null);
                            treeObj.expandNode(node, true, false, true);
                        }
                    },
                    error : function(XMLHttpRequest, textStatus,
                            errorThrown) {
                        alert(errorThrown);
                    }
                });
	        }
	    </script>
	    <script type="text/javascript">
            $(function() {
                $('#queryTable tbody tr').css({'cursor':'pointer'});
                $('#queryTable tbody tr').on('click', function() {
                    window.location.href = '${ctx}/cms/content/check/' + $(this).attr('id') + '/${categoryId}';
                });
                $('input[name="chk"]').parent('td').on('click', function(event) {
                   event.stopPropagation();
                });
                $('span[name="contentTitle"]').parent('td').on('click', function(event) {
                    event.stopPropagation();
                 });
            //选择进入单个站点
           
                $("#button_site").on('click',function() {
                    //确认按钮处理
                    if($("#site_id").val()==""||$("#site_id").val()==null){
                        alert('${xqlc:i18n("ui.cms.pleaseChooseSite", locale)}');
                    }else{
                       // window.location.href="${ctx}/cms/category/siteConnectCategory/"+$("#site_id").val();
                       // window.open("${ctx}/cms/category/categoryTree?siteId="+$("#site_id").val()+"&mark=category",'_blank');
                    	window.open("${ctx}/cms/index/intoContent?siteId="+$("#site_id").val(),'_blank');
                    }
                });
            });
        </script>
	</xqlc:extends>
</xqlc:extends>
<jsp:include page="/WEB-INF/views/cms/base/baseContentPage.jsp" />
