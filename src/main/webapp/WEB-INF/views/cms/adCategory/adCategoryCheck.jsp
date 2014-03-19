<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
    <form:form id="editForm" modelAttribute="adCategory" cssClass="form-horizontal validation">
        <form:hidden path="id"/>
        <div class="appcontent">
            <h3>
                <span><fmt:message key="ui.cms.adCategoryCheck"/></span>
            </h3>
        </div>
        <div class="toolbar">
            <ul>
                <li class="btn-group">
                    <!-- 新增按钮 -->
                    <%-- <a class="btn btn-small btn-success" href="${ctx}/cms/adCategory/createAdCategory?parentId=${adCategory.id}">
                        <fmt:message key="ui.base.create"/>
                    </a> --%>
                     <!-- 编辑按钮 -->
                    <a class="btn btn-small btn-primary" href="${ctx}/cms/adCategory/update?adCategoryId=${adCategory.id}">
                        <fmt:message key="ui.cms.edit"/>
                    </a>
                    <!-- 绑定广告 -->
                    <a class="btn btn-small" data-original-title="<fmt:message key="ui.cms.bindAdvertise"/>"
	                    href="#advertiseModal" id="model" role="button"
	                    data-toggle="modal" onclick="selectAds('${adCategory.id}');"><fmt:message key="ui.cms.bindAdvertise"/></a>
                    <!--返回按钮 -->
                     <a class="btn btn-small btn-warning " href="javascript:history.go(-1)">
                        <fmt:message key="ui.base.cancel"/>
                     </a>
                </li>
            </ul>
        </div>
        <div class="detailedinfo">
                    <table class="table">
                        <tbody>
                        <!-- 广告位名称 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.adPositionName"/></h5>
                            </td>
                            <td>
                                ${adCategory.name}
                            </td>
                        </tr>
                        
                        <!-- 高度 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.width"/></h5>
                            </td>
                            <td>
                               ${adCategory.width}px
                            </td>
                        </tr>
                         <!-- 宽度 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.height"/></h5>
                            </td>
                            <td>
                                ${adCategory.height}px
                            </td>
                        </tr>
                        <!-- 类型 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.adCategoryType"/></h5>
                            </td>
                            <td>
                                ${adCategory.adCategoryType}
                            </td>
                        </tr>
                        <!-- 创建时间 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.base.createTime"/></h5>
                            </td>
                            <td>
                                <fmt:formatDate value="${adCategory.createTime}" type="date"/>
                            </td>
                        </tr>
                         <!-- 站点状态 -->
                        <tr>
                        	<td>
                        		<h5><fmt:message key="ui.cms.isUse" /></h5>
                        	</td>
                        	<td>
                        		<c:if test="${adCategory.useCode == 'yes'}"><fmt:message key="ui.cms.yes" /></c:if>
                        		<c:if test="${adCategory.useCode == 'no'}"><fmt:message key="ui.cms.no" /></c:if>
                        		<%-- ${adCategory.useCode } --%>
                        	</td>
                        </tr>
                        <c:if test="${not empty adCategory.advertiseList }">
                        	<c:forEach items="${adCategory.advertiseList }" var="advertise">
                        	<tr>
                        		<td>
                        			<h5><fmt:message key="ui.cms.advertiseName"/>：</h5>
                        		</td>
                        		<td>${advertise.name }</td>
                        	</tr>
                        	</c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </div>
    </form:form>
    <!--绑定广告 -->
    <div id="advertiseModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
       	<input type="hidden" id="adIds" nsme="adIds" value="">
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
                        <td><input type="checkbox" multiple="multiple" name="choose" id = "choose" value="${advertise.id}"></td>
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
    </xqlc:extends>
    <xqlc:extends name="javascript">
        <script type="text/javascript">
            $(function() {
                $('#name').on('change', function() {        
                    $('#ename').val(getFirst($('#name').val()));
                });
                
              //处理全选
                $('#selectAll').on('click',function() {
                      $('[name="choose"]').prop('checked',$('#choose').prop('checked'));
                });
            });
            
            
            //绑定广告
            function selectAds(adCategoryId) {
                $("#chooseAdvertise").click(function() {
                    var chk_val = [];
                    $("input[name='choose']:checked").each(function() {
                        var id = $(this).val();
                        chk_val.push(id);
                    });
                    $("#adIds").val(chk_val.join(","));
                    var ids = $("#adIds").val();
                    $.post('${ctx}/cms/adCategory/bindAdvertise/' + adCategoryId + '/' + ids, {}, function(response) {
                        if (response == 'success') {
                            $.pageMessage('${xqlc:i18n("ui.cms.operSuccess",locale)}');
                            window.location.href = '${ctx}/cms/adCategory/CheckAdCategory/' + adCategoryId;
                        } else {
                            $.pageMessage('${xqlc:i18n("ui.cms.operError",locale)}');
                        }
                    }, 'json');

                });
            }
        </script>
   </xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseAdCategoryPage.jsp" />
