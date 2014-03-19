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
  <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/loading.css" type="text/css"  />
  <style type="text/css">
    .ui-layout-north {
        padding: 0;
        overflow: hidden;
        margin: 0;
    }
    html body {
		height: 100%;
	}
</style>
</xqlc:extends>
<xqlc:extends name="javascript">
 <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.core-3.5.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.excheck-3.5.js"></script>
        <script type="text/javascript" src="${ctx}/static/js/ui/tree/jquery.ztree.exedit-3.5.js"></script>
        <script type="text/javascript">
        $(function() {
            $('.tip-top').tooltip({
                placement : 'top'
            });
            
            $.fn.datepicker.dates['I18N'] = {
                    days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
                    daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
                    daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
                    months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                    monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                    today: "今日"
            };
            $('#dpBegin').datepicker({language:'I18N'});
            $('#dpEnd').datepicker({language:'I18N'});
            
            $("#search").click(function() {
                var name = $("#names_").val();
                location.href = "${ctx}/cms/template/list?queryParameter.name_li="+name;
            });
            
            $('#batchdelete').click(function () {
                if($("input[name='chk']:checked").length == 0) {
                     alert('${xqlc:i18n("ui.cms.atLeastChooseOne",locale)}');
                 } else {
                    if (confirm('${xqlc:i18n("ui.cms.sureDelete",locale)}')) {
                        $('#templatelist')[0].action = "${ctx}/cms/template/deletebatch";
                        $('#templatelist').submit();
                        return true;
                    } else {
                        return false;
                    }
                }
            });
        });

        function checkAll() {
            var all = document.getElementById("all");
            var ones = document.getElementsByName("one");
            var allStatus = all.checked;
            for ( var i = 0; i < ones.length; i++) {
                var one = ones[i];
                one.checked = allStatus;
            }
        }

        function checkOne(obj) {
            var ones = document.getElementById(obj.id);
            if (ones.checked == false)
                document.getElementById("all").checked = false;
        }
        
        function selectTreeNodePath(treeNode) {
            var str = "/" + treeNode.name;
            while (true) {
                if (treeNode.getParentNode() == null)
                    return str;
                treeNode = treeNode.getParentNode();
                str = "/" + treeNode.name + str;
            }
        }
        function getTemplateId(id) {
            $("#template_id").val(id);
            $("#binding").modal();
        }
        
        $(function() {
            $("#checksubmit").click(function() {
                var nodes = treeObj.getCheckedNodes(true);
                var ids = [];
                for ( var i = 0; i < nodes.length; i++) {
                    ids.push(nodes[i].id);
                }
                $("#category_id").val(ids.join(","));
                var id = $("#template_id").val();   
                $.post('${ctx}/cms/template/bind/'+id, {'ides' : $("#category_id").val()}, function(response) {
                    
                }, 'json') ;
            });
        });
        
        var setting_ = {
            check: {
                autoCheckTrigger: true,
                enable: true,
                chkStyle: "checkbox",
                chkboxType: {"Y":"s","N":"p"}
            },
            callback: {
                onClick : function(event, treeId, treeNode) {
                    var path = selectTreeNodePath(treeNode);
                },
                onCheck: function(event, treeId, treeNode){
                    
                }
            }
        };
        
        var zNodes_ = [];
        var treeObj;
        $(function() {
            loadCategoryTree();
        });
        function loadCategoryTree(nodeId) {
            $.ajax({
                type : "get",
                url : '${ctx}/cms/category/tree',
                dataType : "json",
                success : function(data) {
                    zNodes_ = data;
                    treeObj = $.fn.zTree.init($("#categorytree"), setting_, zNodes_);
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
                // 处理全选
                $(function() {
                    $('#chk_all').click(function() {
                        $('[name="chk"]').prop('checked', $('#chk_all').prop('checked'));
                    });
                });
            });

            $(function() {
                $("#import").click(function() {
                    $("#import_template").modal();
                });
            });
        </script>
</xqlc:extends>

<xqlc:extends name="content">
	<form id="templatelist">
		<input type="hidden" id="category_id" name="category_id" value="" />
		<input type="hidden" id="template_id" name="template_id" />
		<div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.templateList" /></span>
            </h3>
        </div>
		<div class="toolbar">
            <ul>
                <li>
                    <a id="import" class="btn btn-small btn-success" href="#">
                        <fmt:message key="ui.cms.importTemplate"/>
                    </a>
                </li>
                <li class="divider"></li> 
                <li>
                    <a id="flush" class="btn btn-small btn-info" href="${ctx}/cms/template/flush">
                        <fmt:message key="ui.cms.updateTemplate"/>
                    </a>
                </li>
                <li class="divider"></li> 
                <li>
                    <a id="batchdelete" class="btn btn-small btn-danger" href="#">
                        <fmt:message key="ui.cms.batchDelete"/>
                    </a>
                </li>
                <li class="divider"></li> 
                <li>
                    <input id="names_" type="text" name="name" placeholder="${xqlc:i18n('ui.cms.templateName', locale)}" />
                </li>
                <li class="divider"></li> 
                <li>
                    <button id="search" type="button" class="btn btn-small btn-primary">
                        <fmt:message key="ui.cms.search"/>
                    </button>
                </li>
            </ul>
        </div>
		<xqlc:table items="${templatePage}" id="querytable">
			<xqlc:row var="template">
				<%--
				<xqlc:column style="text-align:center" title="<input type='checkbox'  id='all' onClick='checkAll()' />">
					<input type="checkbox" id="${template.id}" name='one' onClick='checkOne(this)' value="${template.id}" />
				</xqlc:column>
				 --%>
				<xqlc:column title='<input id="chk_all" type="checkbox">'>
                <input type="checkbox" name="chk" value="${template.id}">
                </xqlc:column>
				
				<input type="hidden" name="queryParameter.map"  value="${map}"/>
				
				<xqlc:column title="${xqlc:i18n('ui.cms.templateName', locale)}">
				    ${template.name}
				</xqlc:column>
				
				<xqlc:column title="${xqlc:i18n('ui.cms.templatePath', locale)}">
					<a class="tip-top" data-original-title="${template.path}">
						<xqlc:substring value="${template.path}" length="40"/>
					</a>
				</xqlc:column>
				
				<xqlc:column title="${xqlc:i18n('ui.cms.ownSite', locale)}">
						${template.siteName}
				</xqlc:column>
				
				<xqlc:column title="${xqlc:i18n('ui.cms.createTime', locale)}">
					<fmt:formatDate value="${template.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</xqlc:column>
				
				<xqlc:column title="${xqlc:i18n('ui.cms.operate', locale)}">
					<button type="button" name="temp_a" class="tip-top btn" data-original-title="${xqlc:i18n('ui.cms.bindCategory', locale) }" 
						 onclick="getTemplateId('${template.id}')"><i class="icon-th"></i></button>
				</xqlc:column>
				
			</xqlc:row>
		</xqlc:table>
		<div class="widget-foot">
			<div class="pagination pagination-centered pull-right">
				<xqlc:page page="${templatePage}" formId="templatelist"></xqlc:page>
			</div>
		</div>
	</form>
	<%--栏目树 --%>
	<div class="modal  hide fade" id="binding">
		<div class="modal-header">
			<a class="close" data-dismiss="modal">×</a>
				<h3><fmt:message key="ui.cms.chooseCategory"/></h3>
		</div>
		<div class="modal-body">
			<h4><fmt:message key="ui.cms.categoryTree"/></h4>
			<ul id="categorytree" class="ztree"></ul>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" id="checksubmit"><fmt:message key="ui.cms.ok"/></button>
			<button class="btn" data-dismiss="modal" aria-hidden="true"><fmt:message key="ui.cms.close"/></button>
		</div>
	</div>
	
	<%-- 弹窗--%>
	<tags:dialog id="import_template">
		<jsp:attribute name="title"><fmt:message key="ui.cms.pleaseAddTemplate"/></jsp:attribute>
		<jsp:attribute name="content">
			<form id="edit" name="template" action="${ctx}/cms/template/improttemplate" method="post" enctype="multipart/form-data">
				<div class="control-group">
	  				<label class="control-label" for="import"><fmt:message key="ui.cms.importTemplate"/>：
	  					<input type="file" name="templatefile" />
	  				</label>
	  			</div>
	  			<div >
        			<button type="submit" class="btn btn-primary" id="btn" name="btn" style="margin-left: 50px"><fmt:message key="ui.cms.submit"/></button>
        			<a href="${ctx }/cms/template/list" class="buttons btn btn-warning" style="margin-left:50px"><fmt:message key="ui.cms.comeBack"/></a>
        		</div>
			</form>
		</jsp:attribute>
	</tags:dialog>
	
	
</xqlc:extends>
<%-- <xqlc:extends name="javascript">
    <xqlc:importjs
        src="plugins/jquery.contextmenu.r2, plugins/xqlc.table.popover" />
        <script type="text/javascript" src="${ctx}/static/websitetheme/js/jquery.ztree.all-3.2.min.js"></script>
        
        </xqlc:extends> --%>

<jsp:include page="/WEB-INF/views/cms/base/baseTemplatePage.jsp" />
<%-- <jsp:include page="/WEB-INF/views/cms/base/baseSitePage.jsp" /> --%>
