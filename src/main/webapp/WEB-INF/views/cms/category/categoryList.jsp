<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="css">
<style type="text/css">
    #queryTable thead tr th {
    text-align: center
    }
</style>
</xqlc:extends>

<xqlc:extends name="content">
	<form id="queryForm" action="${ctx}/cms/category/list/${category.id}">
	<input type = "hidden" name = "parentId" value="${parent.id }"/>
	<input type="hidden" id="name" name="queryParameter.name_li" value="${name_li}">
    <input type="hidden" id="type" name="queryParameter.type" value="${type}">
    <%-- <input type="hidden" id="userName" name="queryParameter.categoryCheckUser.userName_li" value="${categoryCheckUser_userName_li}"> --%>
	   <div class="appcontent">
        <h3>
            <span><fmt:message key="ui.cms.checkList"/></span>
        </h3>
    </div>
    <!-- 按钮 -->
    <div class="toolbar">
        <ul>
            <li>    
                 <button type="button" id="batch_pass"
                 class="buttons btn btn-success btn-small"><fmt:message key="ui.cms.pass"/>
                 </button>
            </li>
            <li class="divider"></li>
            <li>
                 <button type="button" id="batch_reject"
                 class="buttons btn btn-small btn-inverse"><fmt:message key="ui.cms.noPass"/>
                 </button>
            </li>
            <li class="divider"></li>
            <li>
                <button type="button" id="batch_delete"
                    class="buttons btn btn-danger btn-small">
                    <fmt:message key="ui.base.delete" />
                </button>
            </li>
            <li class="divider"></li>
            <li>
                <select id="input_search_auditStatus" name="auditStatus" class="input-medium">
                        <option value=""><fmt:message key="ui.cms.pleaseChoose"/></option>
                        <option value="nocheck"><fmt:message key="ui.cms.nocheck"/></option>
                        <option value="pass"><fmt:message key="ui.cms.auditPass"/></option>
                        <option value="nopass"><fmt:message key="ui.cms.noPass"/></option>
                </select>
                
            </li>
            <li>
            <button type="submit" class="btn-primary btn-small"><fmt:message key="ui.cms.search" /></button>
            </li>
            <li class="divider"></li>
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
            <li>
                <button class="btn btn-info btn-small" name="button" id="button_site" type="button">
                <fmt:message key="ui.cms.ok"/>
                </button>
            </li>
        </ul>
    </div>
		<table id="queryTable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<!-- 复选框 -->
					<th><input id="chk_all" type="checkbox"></th>
					<!-- 栏目名称 -->
					<th><fmt:message key="ui.cms.categoryName" /></th>
					<!-- 父栏目 -->
					<th><fmt:message key="ui.cms.parentCategory" /></th>
					<!-- 栏目类型 -->
					<th><fmt:message key="ui.cms.type" /></th>
					<!-- 栏目站点 -->
					<th><fmt:message key="ui.cms.ownSite" /></th>
					<!-- 创建时间 -->
					<th><fmt:message key="ui.cms.createTime" /></th>
					<!-- 操作 -->
					<%-- <th><fmt:message key="ui.cms.operate" /></th> --%>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${pageInfo.content}" var="category">
			    <c:if test="${not empty category.categoryParent}">
			        <tr id="${category.id}">
                        <!-- 复选框 -->
                        <td style="text-align: center"><input type="checkbox"
                            name="chk" value="${category.id}"></td>
                        <!-- 栏目名称 -->
                        <td style="text-align: center">
                            ${category.name}
                            <%-- <a
                            href="#lookModal_${category.id}" id="model" role="button"
                            data-toggle="modal">${category.name}</a></td> --%>
                        <!-- 父栏目 -->
                        <td style="text-align: center">${category.categoryParent.name}</td>
                        <!-- 栏目类型 -->
                        <td style="text-align: center"><c:if
                                test="${category.type =='1' }">
                                <fmt:message key="ui.cms.commonCategory" />
                            </c:if> <c:if test="${category.type == '2'}">
                                <fmt:message key="ui.cms.linkCategory" />
                            </c:if></td>
                        <!-- 栏目站点 -->
                        <td style="text-align: center">${category.site.name}</td>
                        <!-- 创建时间 -->
                        <td style="text-align: center"><fmt:formatDate
                                value="${category.createTime}" type="date" /></td>
                    </tr>
			    </c:if>
			</c:forEach>
	        </tbody>
	    </table>
        <div class="pagination pagination-centered">
            <xqlc:page page="${pageInfo}" formId="queryForm" />
        </div>
				
	</form>

</xqlc:extends>

<xqlc:extends name="javascript">
    <script type="text/javascript">
	    $(function() {
        	<c:if test="${not empty message}">
        		window.parent.loadCategoryTree('${parent.id}');
        	</c:if>
            console.log("${message}");
            // 处理全选
            $('#chk_all').click(
                    function() {
                        $('[name="chk"]').prop('checked',
                                !!$('#chk_all').prop('checked'));
                    });
            // 处理按钮的提示
            $('.tip-top').tooltip({
                placement : 'top'
            });

            // 批量通过
            $('#batch_pass')
                    .click(
                            function() {
                                if ($("input[name='chk']:checked").length == 0) {
                                    alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
                                } else {
                                   /*  $('#queryForm')[0].target = "_parent"; */
                                    $('#queryForm')[0].method = "post";
                                    $('#queryForm')[0].action = "${ctx}/cms/category/batchPass";
                                    $('#queryForm').submit();
                                }
                            });
            // 批量驳回
            $('#batch_reject')
                    .click(
                            function() {
                                if ($("input[name='chk']:checked").length == 0) {
                                    alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
                                } else {
                                	/* $('#queryForm')[0].target = "_parent"; */
                                	$('#queryForm')[0].method = "post";
                                    $('#queryForm')[0].action = "${ctx}/cms/category/batchReject";
                                    $('#queryForm').submit();
                                }
                            });
            // 批量删除
            $('#batch_delete')
                    .click(
                            function() {
                                if ($("input[name='chk']:checked").length == 0) {
                                    alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
                                } else {
                                    if (confirm('${xqlc:i18n("ui.cms.sureDelete", locale)}')) {
                                    	/* $('#queryForm')[0].target = "_parent"; */
                                    	$('#queryForm')[0].method = "post";
                                        $('#queryForm')[0].action = "${ctx}/cms/category/batchDelete";
                                        $('#queryForm').submit();
                                        }
                                }
                            });
            $("#nocheckTab").click(function() {
                $('#tab1').attr({
                    'z-index' : '1'
                });
            });
            $("#passTab").click(function() {
                $('#tab2').attr({
                    'z-index' : '2'
                });
            });
            $("#nopassTab").click(function() {
                $('#tab3').attr({
                    'z-index' : '3'
                });
            });
        });
        //单个删除
        function deleteCategory(id) {
            $.get('${ctx}/cms/content/deletecheck/' + id,
                {},
                function(response) {
                    if (response) {
                        if (confirm('${xqlc:i18n("ui.cms.sureDelete", locale)}')) {
                            location.href = '${ctx}/cms/category/delete/'
                                    + id;
                        };
                    } else {
                        if (confirm('${xqlc:i18n("ui.cms.deleteCategory",locale)}')) {
                            location.href = '${ctx}/cms/category/delete/'
                                    + id;
                        }
                    }
                }, 'json');
        }
        /* //单个审核
        function pass(id) {
            location.href = "${ctx}/cms/category/check/pass/" + id;
        }
        //单个驳回
        function nopass(id) {
            location.href = "${ctx}/cms/category/check/nopass/" + id;
        } */
        //弹窗查看页面
        $(function() {
            $('#queryTable tbody tr').css({'cursor':'pointer'});
            $('#queryTable tbody tr').on('click', function() {
                window.location.href = '${ctx}/cms/category/readOnly?parentId=${parent.id}&cursorId=' + $(this).attr('id');
                    //readOnly
            });
            $('input[name="chk"]').parent('td').on('click', function(event) {
               event.stopPropagation();
            });
        });
        //搜索框初始化
        $(function() {
            console.log('${auditStatus}');
            // 搜索状态
            if('${auditStatus}') {//审核评论auditReview 0.否   1.是
                $('#input_search_auditStatus').val('${auditStatus}');
            }else {
                $('#input_search_auditStatus').val('');
            }
        });
        //选择进入单个站点
        $(function() {
            $("#button_site").on('click',function() {
                //确认按钮处理
                if($("#site_id").val()==""||$("#site_id").val()==null){
                    alert('${xqlc:i18n("ui.cms.pleaseChooseSite", locale)}');
                }else{
                   // window.location.href="${ctx}/cms/category/siteConnectCategory/"+$("#site_id").val();
                   // window.open("${ctx}/cms/category/categoryTree?siteId="+$("#site_id").val()+"&mark=category",'_blank');
                	window.open("${ctx}/cms/index/intoCategory/"+$("#site_id").val(),'_blank');
                }
            });
        })
    </script>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseContentPage.jsp" />

