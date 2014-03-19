<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="css">
    <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/icon.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/zTreeStyle.css" type="text/css" />
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
    body { <%--overflow: hidden;
    --%>
    }
    </style>
</xqlc:extends>

<xqlc:extends name="javascript">
    <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript">
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
                }, 
                onDrop: onDrop,
                beforeDragOpen: beforeDragOpen
            }
        };
        var zNodes_ = [];
        var treeObj;
        $(function() {
            rMenu = $("#rMenu");
            hideRMenu();
            loadCategoryTree();
        });
        function loadCategoryTree(nodeId) {
            $.ajax({
                type : "get",
                 	 url : '${ctx}/cms/adCategory/adCategoryTree',
                dataType : "json",
                success : function(data) {
                	console.log(data);
                    zNodes_ = data;
                    treeObj = $.fn.zTree.init($("#groupTree"), setting_, zNodes_);
                        var nodes = treeObj.getNodes();
                        if (nodes.length > 0) {
                            $('#center_frame').attr('src','${ctx}/cms/adCategory/adCategoryList');
                            treeObj.selectNode(nodes[0]);
                        };
                    		treeObj.expandAll(true);
                        },
                        error : function(XMLHttpRequest, textStatus,
                                errorThrown) {
                        }
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
              $.get('${ctx}/cms/adGroup/moveGroup/' +pid + '/' + id, {}, function(response) {
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
                    } else if (curDragNodes[i].parentTId && curDragNodes[i].getParentNode() !== targetNode && curDragNodes[i].getParentNode().childOuter === false) {
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
                } else if (treeNodes[i].parentTId && treeNodes[i].getParentNode().childDrag === false) {
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
                if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
                    treeObj.cancelSelectedNode();
                    showRMenu("${root}", event.clientX, event.clientY, treeNode);
                } else if (treeNode && !treeNode.noR) {
                    treeObj.selectNode(treeNode);
                    showRMenu("node", event.clientX, event.clientY, treeNode);
                }
            }
          
          function showRMenu(type, x, y,treeNode) {
                $("#rMenu ul").show();
                if (treeNode.getParentNode()== null) {
                    $("#m_add").hide();
                    $("#m_add_next").show();
                    $("#m_del").hide();
                    $("#m_update").hide();
                } else {
                    $("#m_add").show();
                    $("#m_add_next").hide();
                    $("#m_del").hide();
                    $("#m_update").hide();
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
            //新增同级分组
            function addType(){
                hideRMenu();
                $("#saveUpdateType_btn").hide();
                $("#saveType_btn").show();
	                var nodes = treeObj.getSelectedNodes();
	                var pid = nodes[0].getParentNode().id;
              $('#center_frame').attr('src', '${ctx}/cms/adCategory/createAdCategory?parentId='+pid);
            }
            //新增下级分组
            function addNextType(){
                hideRMenu();
                $("#saveUpdateType_btn").hide();
                $("#saveType_btn").show();
                var nodes = treeObj.getSelectedNodes();
                var id = nodes[0].id;
                $('#center_frame').attr('src', '${ctx}/cms/adCategory/createAdCategory?parentId='+id);
            }
            //删除分组
            function delType() {
                hideRMenu();
                var nodes = treeObj.getSelectedNodes();
                var id = nodes[0].id;
                var selectTypeId = nodes[0].getParentNode().id;
                if (confirm('${xqlc:i18n("ui.cms.sureDelete",locale)}')) {
                    $.get('${ctx}/cms/adGroup/delete/' + id, {}, function(response) {
                         if (response == 'success') {
                             loadCategoryTree(selectTypeId);
                             $.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
                            } else {
                                $.pageMessage('${xqlc:i18n("ui.cms.operError",locale)}');
                            }
                     }, 'json');  
                    return true;
                } else {
                return false;
                }
            }
            //修改分组
            function updateType() {
                hideRMenu();
                $("#saveType_btn").hide();
                $("#saveUpdateType_btn").show();
                var nodes = treeObj.getSelectedNodes();
                var id = nodes[0].id;
                 alert(id);
                $("#center_frame").attr('src','${ctx}/cms/adCategory/update?nodeId='+id);
            };
            
            $(function() {
                //ajax加载样式
                var ajaxbg = $("#background,#progressBar"); 
                ajaxbg.hide(); 
                $(document).ajaxStart(function () { 
                ajaxbg.show(); 
                }).ajaxStop(function () { 
                ajaxbg.hide(); 
                });
                //modal关闭后清空值
                $('#myModal').on('hidden', function () {
                    $("#code").val('');
                    $("#name").val('');
                    $("#memo").val('');
                });
                //保存修改
                $('#saveUpdateType_btn').click(function() {
                    if ($('#editForm').valid()) {
                         $.post('${ctx}/cms/adGroup/updateSave/' + $('#myModal').attr('data-id'),{
                                'adGroup.code': $('#code').val(),
                                'adGroup.name': $('#name').val(),
                                'adGroup.memo': $('#memo').val()
                            }, function(response) {
                                $('#myModal').modal('hide');
                                if (response == 'success') {
                                    loadCategoryTree($('#myModal').attr('data-id'));
                                    $.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
                                } else {
                                    $.pageMessage('${xqlc:i18n("ui.cms.operError",locale)}');
                                }
                            }, 'json');
                    }
                });
            });
            
            function create(siteId) {
                alert(siteId);
                $('#center_frame').attr('src', '${ctx}/cms/adCategory/createAdCategory?parentId='+siteId);
            }
            
    </script>
</xqlc:extends>
<%-- <xqlc:extends name="post">
    <h3>
        <span>广告位管理</span>
    </h3>
    <ul id="groupTree" class="ztree"></ul>
</xqlc:extends> --%>
<xqlc:extends name="content">
    
    
  <form>
	<div class="row-fluid">
	
   <div class="span3">
       <h3>
        <span><fmt:message key="ui.cms.adPositionManagement"/></span>
       </h3>
       <ul id="groupTree" class="ztree"></ul>
   </div>
   
<%-- iframe--%>
	<iframe id="center_frame" name="center_frame" class="span9" height="700px" style="overflow:auto; border:none;" src=""></iframe>
</div>
</form>
    
    
    
   <!--  <div class="span3">
       <h3>
        <span>广告位管理</span>
    </h3>
    <ul id="groupTree" class="ztree"></ul>
   </div>
   <div class="span9">
   
    <div id="frameDiv">
        <iframe id="center_frame" name="center_frame" width="100%" height="100%"
            style="overflow: auto; border: none"></iframe>
    </div> -->
    <div id="rMenu">
        <ul style="width:120px;">
            <li id="m_add" onclick="addType()">
                <i class="icon-plus"></i><fmt:message key="ui.cms.createPeerGroup"/>
            </li>
            <li id="m_add_next" onclick="addNextType()">
                <i class="icon-plus"></i>
             		 <fmt:message key="ui.cms.nextadCategory"/>
                		
            </li>
            <li id="m_del" onclick="delType()">
                <i class="icon-remove"></i>
                	<fmt:message key="ui.cms.deleteadCategory"/>
            </li>
            <li id="m_update" onclick="updateType()">
                <i class="icon-pencil"></i>
                	<fmt:message key="ui.cms.updateadCategory"/>
            </li>
        </ul>
   </div>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseAdgroupTreePage.jsp" />
