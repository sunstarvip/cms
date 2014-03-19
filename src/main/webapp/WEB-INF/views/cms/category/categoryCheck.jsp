
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="body">
    <form:form action="${ctx}/cms/category/check" method="post" modelAttribute="category">
    <form:hidden path="id"/>
    <input type="hidden" value="${parentId}" name="parentId"></input>
    <div class="appcontent">
		<h3>
		    <span><fmt:message key="ui.cms.checkShow" /></span>	
		</h3>
    </div>
	<div class="toolbar">
	    <ul>
	        <li class="btn-group">
	             <!-- 编辑按钮 -->
	            <a class="btn btn-small btn-primary" href="${ctx}/cms/category/update?updateId=${category.id}">
	                <fmt:message key="ui.cms.edit"/>
	            </a>
	            <!-- 通过与驳回按钮 -->
	            <c:if test="${category.auditStatus == 'nocheck'}">
	                <a class="btn btn-small btn-success" href="${ctx}/cms/category/pass/${category.id}">
                        <fmt:message key="ui.base.pass"/>
                    </a>
                    <a class="btn btn-small btn-warning" href="${ctx}/cms/category/reject/${category.id}">
                        <fmt:message key="ui.base.reject"/>
                    </a>
	            </c:if>
                <c:if test="${category.auditStatus == 'nopass'}">
                    <a class="btn btn-small btn-success" href="${ctx}/cms/category/pass/${category.id}">
                        <fmt:message key="ui.base.pass"/>
                    </a>
                </c:if>
                <c:if test="${category.auditStatus == 'pass'}">
                    <a class="btn btn-small btn-warning" href="${ctx}/cms/category/reject/${category.id}">
                        <fmt:message key="ui.base.reject"/>
                    </a>
                </c:if>
	            <!--返回按钮 -->
	            <button type="button" class="btn btn-small btn-cancel">
	               <fmt:message key="ui.cms.cancel"/>
	            </button>
	        </li>
	    </ul>
	</div>
    <div class="detailedinfo">
	    <table class="table">
	        <tbody>
	        <!-- 栏目名称 -->
	        <tr>
	            <td>
	                <h5><fmt:message key="ui.cms.categoryName" /></h5>
	            </td>
	            <td>
	                ${category.name}
	            </td>
	        </tr>
	        <!-- 栏目英文名称 -->
	        <tr>
                <td>
                    <h5><fmt:message key="ui.cms.englishName" /></h5>
                </td>
                <td>
                    ${category.englishName}
                </td>
            </tr>
            <!-- 栏目类型 -->
            <tr>
                <td>
                    <h5><fmt:message key="ui.base.type" /></h5>
                </td>
                <td>
                    <c:if test="${category.type == '1'}"><fmt:message key="ui.cms.commonCategory"/></c:if>
                    <c:if test="${category.type == '2'}"><fmt:message key="ui.cms.linkCategory"/></c:if>
                </td>
            </tr>
            <!--栏目访问路径 -->
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.visitPath" /></h5>
                </td>
                <td>
                    ${category.path}
                </td>
            </tr>
            <!-- 上级栏目 -->
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.parentCategory" /></h5>
                </td>
                <td>
                    ${category.categoryParent.name}
                </td>
            </tr>
            <!--所属角色 -->
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.ownRole" /></h5>
                </td>
                <td>
                    ${category.founder.name}
                </td>
            </tr>
            <!-- 栏目是否可见 -->
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.categoryVisible"/></h5>
                </td>
                <td>
                    ${category.visible}
                </td>
            </tr>
            <!-- 栏目是否头部菜单可见 -->
            <tr style="display: none">
                <td>
                    <h5><fmt:message key="ui.cms.categoryTopVisible"/></h5>
                </td>
                <td>
                    ${category.topVisible}
                </td>
            </tr>
            <!--栏目审核方式 -->
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.categoryAuditMode" /></h5>
                </td>
                <td>
                    <c:if test="${category.auditCategoryMethod == '1'}">
                        <fmt:message key="ui.cms.workflow" />
                    </c:if>
                    <c:if test="${category.auditCategoryMethod == '2'}">
                        <fmt:message key="ui.cms.personnelAudit" />
                    </c:if>
                </td>
            </tr>
            <!--栏目审核人 -->
            <c:if test="${category.auditCatreviewMethod == '2'}">
            <%-- <tr>
                <td>
                    <h5><fmt:message key="ui.cms.reviewCheckUser" /></h5>
                </td>
                <td>
                    ${category.auditCatreviewMethod}
                </td>
            </tr> --%>
            <c:if test="${not empty categoryRoles }">
             <tr>
                <td>
                    <table class="table table-bordered" id="tab">
	                    <thead>
	                        <tr>
	                            <th><h5><fmt:message key="ui.cms.reviewCheckUser" /></h5></th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:if test="${not empty categoryRoles}">
	                            <c:forEach items="${categoryRoles}" var="role">
	                                <tr>
	                                    <td>${role.name}</td>
	                                </tr>
	                            </c:forEach>
	                        </c:if>
	                    </tbody>
	                </table>
                </td>
            </tr>
            </c:if>
            
            </c:if>
            <!--审核内容 -->
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.auditContent" /></h5>
                </td>
                <td>
                    <c:if test="${category.auditCatcontent == 'yes'}">
	                    <fmt:message key="ui.cms.yes" />
	                </c:if> 
	                <c:if test="${category.auditCatcontent == 'no'}">
	                    <fmt:message key="ui.cms.no" />
	                </c:if>
                </td>
            </tr>
            <!--内容审核方式 -->
            <c:if test="${category.auditCatcontent == 'yes' }">
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.contentAuditMode" /></h5>
                </td>
                <td>
                    <c:if test="${category.auditCatcontentMethod == '1'}">
                        <fmt:message key="ui.cms.workflow" />
                    </c:if> 
                    <c:if test="${category.auditCatcontentMethod == '2'}">
                        <fmt:message key="ui.cms.personnelAudit" />
                    </c:if>
                </td>
            </tr>
            </c:if>
            <!--内容审核人 -->
            <c:if test="${category.auditCatcontentMethod == '2'}">
           <%--  <tr>
                <td>
                    <h5><fmt:message key="ui.cms.contentCheckUser" /></h5>
                </td>
                <td>
                    ${category.auditCatreviewMethod}
                </td>
            </tr> --%>
            <c:if test="${not empty contentRoles }">
             <tr>
                <td>
                    <table class="table table-bordered" id="tab">
	                    <thead>
	                        <tr>
	                            <th><h5><fmt:message key="ui.cms.contentCheckUser" /></h5></th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:if test="${not empty contentRoles}">
	                            <c:forEach items="${contentRoles}" var="role">
	                                <tr>
	                                    <td>${role.name}</td>
	                                </tr>
	                            </c:forEach>
	                        </c:if>
	                    </tbody>
	                </table>
                </td>
            </tr>
            </c:if>
            
            </c:if>
            <!--评论内容 -->
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.reviewContent" /></h5>
                </td>
                <td>
                    <c:if test="${category.reviewCatcontent == 'yes'}">
	                    <fmt:message key="ui.cms.yes" />
	                </c:if> 
	                <c:if test="${category.reviewCatcontent == 'no'}">
	                    <fmt:message key="ui.cms.no" />
	                </c:if>
                </td>
            </tr>
            <!-- 审核评论 -->
            <c:if test="${category.reviewCatcontent == 'yes' }">
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.auditReview" /></h5>
                </td>
                <td>
                    <c:if test="${category.auditCatreview == 'yes'}">
                        <fmt:message key="ui.cms.yes" />
                    </c:if> 
                    <c:if test="${category.auditCatreview == 'no'}">
                        <fmt:message key="ui.cms.no" />
                    </c:if> 
                </td>
            </tr>
            </c:if>
            <!-- 评论审核方式 -->
            <c:if test="${category.auditCatreview == 'yes'}">
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.reviewAuditMode" /></h5>
                </td>
                <td>
                    <c:if test="${category.auditCatreviewMethod == '1'}">
                    <fmt:message key="ui.cms.workflow" />
                </c:if> 
                <c:if test="${category.auditCatreviewMethod == '2'}">
                    <fmt:message key="ui.cms.personnelAudit" />
                </c:if>
                </td>
            </tr>
            </c:if>
            <!-- 评论审核人 -->
            <c:if test="${category.auditCatreviewMethod == '2'}">
            <%-- <tr>
                <td>
                    <h5><fmt:message key="ui.cms.reviewCheckUser" /></h5>
                </td>
                <td>
                    ${category.auditCatreviewMethod}
                </td>
            </tr> --%>
            <c:if test="${not empty reviewRoles }">
             <tr>
                <td>
                    <table class="table table-bordered" id="tab">
	                    <thead>
	                        <tr>
	                            <th><h5><fmt:message key="ui.cms.reviewCheckUser" /></h5></th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:if test="${not empty reviewRoles}">
	                            <c:forEach items="${reviewRoles}" var="role">
	                                <tr>
	                                    <td>${role.name}</td>
	                                </tr>
	                            </c:forEach>
	                        </c:if>
	                    </tbody>
	                </table>
                </td>
            </tr>
            </c:if>
            
            
            
            
            </c:if>
            <!--Logo-->
            <c:if test="${not empty category.logoImage}">
            <tr>
                <td>
                    <h5><fmt:message key="ui.cms.logo" /></h5>
                </td>
                <td>
                    <img src="${ctx}/cms/category/showPhoto/${category.id}" style="width: 50px; height: 50px">
                </td>
            </tr>
            </c:if>
            <!-- 栏目英文名称 -->
            <c:if test="${not empty roles }">
            <tr>
                <td>
                    <table class="table table-bordered" id="tab">
	                    <thead>
	                        <tr>
	                            <th><h5><fmt:message key="ui.base.role" /></h5></th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:if test="${not empty roles}">
	                            <c:forEach items="${roles}" var="role">
	                                <tr>
	                                    <td>${role.name}</td>
	                                </tr>
	                            </c:forEach>
	                        </c:if>
	                    </tbody>
	                </table>
                </td>
            </tr>
            </c:if>
	        </tbody>
	    </table>
	</div>
	</form:form>
</xqlc:extends>

<xqlc:extends name="javascript">
    <script type="text/javascript">
    // 通过
    /* $(function() {
        $('#pass').click(
	        function() {
	            if ($("input[name='chk']:checked").length == 0) {
	                alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
	            } else {
	                $('#queryForm')[0].action = "${ctx}/cms/category/batchPass";
	                $('#queryForm').submit();
	            }
	        });
    });
    //驳回
    $(function() {
        $('#reject').click(
	        function() {
	            if ($("input[name='chk']:checked").length == 0) {
	                alert('${xqlc:i18n("ui.cms.atLeastChooseOne", locale)}');
	            } else {
	                $('#queryForm')[0].action = "${ctx}/cms/category/batchReject";
	                $('#queryForm').submit();
	            }
	        });
    }) */
    </script>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseCategoryPage.jsp" />
