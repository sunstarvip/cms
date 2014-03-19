<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
     <input type="hidden" name="treChk" id="treChk"/>
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.sendManagement" /></span>
            </h3>
        </div>
        <div class="toolbar">
            <ul>
                <li class="btn-group">
                    <a id="batch_lssued" class="btn btn-small" href="#myModal" role="button" data-toggle="modal">
                        <fmt:message key="ui.cms.batchSend"/>
                    </a>
                    <a id="batch_delete" class="btn btn-small btn-danger" href="#">
                        <fmt:message key="ui.cms.batchDelete"/>
                    </a>
                </li>
            </ul>
        </div>
        <xqlc:table id="queryTable" items="${pageInfo}">
            <xqlc:row var="cont">
                <xqlc:column style="text-align: center" title='<input id="chk_all" type="checkbox">'>
                    <input type="checkbox" name="chk" value="${cont.id}">
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.title', locale)}" style="text-align: center">
                    <c:if test="${cont.beNew%2 == 1}">
                         <i class="icon-picture"></i>
                    </c:if>
                    <a onclick="readState('${cont.id}');" class="btn btn-link">${cont.title}</a>
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.type', locale)}" style="text-align: center">
                    <c:choose>  
                           <c:when test="${cont.type == 0}">  
                               <fmt:message key="ui.cms.normalNews"/>
                           </c:when>  
                           <c:when test="${cont.type == 1}">  
                               <fmt:message key="ui.cms.linkNews"/>
                           </c:when>  
                           <c:otherwise>  
                               <fmt:message key="ui.cms.pictureNews"/>
                           </c:otherwise>  
                    </c:choose>
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.category', locale)}" style="text-align: center">
                    ${cont.category.name}
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.founder', locale)}" style="text-align: center">
                    ${cont.founder.userName}
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.createTime', locale)}" style="text-align: center">
                    <fmt:formatDate value="${cont.createTime}" type="date"/>
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.auditStatus', locale)}" style="text-align: center">
                    <c:choose>  
                           <c:when test="${cont.auditStatus == '1'}">  
                               <fmt:message key="ui.cms.uncommitted"/> 
                           </c:when>  
                           <c:when test="${cont.auditStatus == '2'}">  
                               <fmt:message key="ui.cms.unaudited"/>
                           </c:when>  
                           <c:when test="${cont.auditStatus == '3'}">  
                               <fmt:message key="ui.cms.noPass"/>
                           </c:when>
                           <c:when test="${cont.auditStatus == '4'}">  
                               <fmt:message key="ui.cms.pass"/>
                           </c:when>
                           <c:otherwise>  
                           </c:otherwise>  
                    </c:choose>
                </xqlc:column>
                <xqlc:column title="${xqlc:i18n('ui.cms.contentChecker', locale)}" style="text-align: center">
                    ${cont.contentChecker.userName}
                </xqlc:column>
            </xqlc:row>
        </xqlc:table>
                    <div class="widget-foot">
                        <div class="pagination pagination-centered pull-right">
                            <xqlc:page page="${pageInfo}" formId="queryForm" />
                        </div>
                    </div>
    </form>
    <div class="widget-content" style="display:none">
        <div class="control-group">
            <label class="control-label"><fmt:message key="ui.cms.contentChecker"/></label>
            <input type="hidden" name="lssuedUserId" id="lssuedUserId" value="${cont.contentChecker.id}">
        </div>
    </div>
    <!-- 部门员工Modal -->
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
            <button type="button" class="btn" id="selectUser_button" data-dismiss="modal" aria-hidden="true">
                <fmt:message key="ui.cms.ok"/>
            </button>
            <button class="btn" id="cancel" data-dismiss="modal" aria-hidden="true">
                <fmt:message key="ui.cms.cancel"/>
            </button>
        </div>
    </div>
    <!-- 阅读状态 -->
    <div id="readStateModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="readStateModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="readStateModalLabel"><fmt:message key="ui.cms.lssuedReadStateList"/></h3>
        </div>
        <div id="modalbody" class="modal-body" style="height:200px">
            <div class="container-fluid">
                <div class="row-fluid">
                    <iframe id="readCenter_frame" name="readCenter_frame" width="100%" height="100%" style="overflow:auto; border:none;"></iframe>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn" id="cancel" data-dismiss="modal" aria-hidden="true">
                <fmt:message key="ui.cms.cancel"/>
            </button>
        </div>
    </div>
    
    <xqlc:extends name="javascript">
    <xqlc:importjs prefix="http://111.4.117.119/xqlc-ui/static/js/" src="plugins/xqlc.table.popover, plugins/jquery.metadata,
                   plugins/jquery.validate, plugins/messages_cn" />
    <script type="text/javascript" src="${ctx}/static/websitetheme/js/jquery.ztree.all-3.2.min.js"></script>
    <script type="text/javascript">
        $(function() {
            // 处理全选
            $('#chk_all').click(function() {
                $('[name="chk"]').attr('checked', !!$('#chk_all').attr('checked'));
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
                    $('#queryForm')[0].action = '${ctx}/cms/content/batchPublish/${categoryId}';
                    $('#queryForm').submit();
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
                                '${ctx}/cms/dept/deptAndUserLssuedList/' + treeNode.id);
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
                    url : '${ctx}/cms/dept/deptTree',
                    dataType : "json",
                    success : function(data) {
                        zNodes_ = data;
                        treeObj = $.fn.zTree.init($("#deptUserTree"), setting_, zNodes_);
                        if (!nodeId) {
                            var nodes = treeObj.getNodes();
                            if (nodes.length > 0) {
                                $('#center_frame').attr('src','${ctx}/cms/dept/deptAndUserLssuedList/'+ nodes[0].id);
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
            
            $(function() {
                var chk_val =[];
                $("#selectUser_button").click(function() {
                    chk_val =[];
                         $("input[name='lssuedChk']:checked",window.frames["center_frame"].document).each(function() {
                            chk_val.push( $(this).val());
                        });
                         
                        $("#treChk").val(chk_val);
                    
                     if($("input[name='lssuedChk']:checked",window.frames["center_frame"].document).length == 0) {
                         alert("${xqlc:i18n('ui.cms.atLeastChooseOne', locale)}");
                     }else {
                          $('#queryForm')[0].method = 'post';
                         $('#queryForm')[0].action = '${ctx}/cms/lssued/batchLssued/${categoryId}';
                         $('#queryForm').submit(); 
                     }
                });
            });
            // 搜索状态
            if('${auditStatus}') {//审核评论auditReview 0.否   1.是
                $('#input_search_auditStatus').val('${auditStatus}');
            }
            function readState(obj) {
                $("#readCenter_frame").attr("src", "${ctx}/cms/lssued/readState/" + obj);
                $("#readStateModal").modal('show');
            }
        });
	    </script>
	    <script type="text/javascript">
        $(function() {
            $('#queryTable tbody tr').css({'cursor':'pointer'})
            $('#queryTable tbody tr').on('click', function() {
                window.location.href = '${ctx}/crm/base/client/info?id=' + $(this).attr('data-row-id')
            })
        });
    </script>
	</xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseLssuedPage.jsp" />