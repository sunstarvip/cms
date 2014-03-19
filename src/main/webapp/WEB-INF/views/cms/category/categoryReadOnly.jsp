
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="title">
	<fmt:message key="ui.cms.categoryCheckManagement"/>
</xqlc:extends>

<xqlc:extends name="javascript">
	<script type="text/javascript">
		//审核通过
		function pass(id) {
			location.href = "${ctx}/cms/category/check/pass/" + id;
		}
		//审核不通过
		function nopass(id) {
			location.href = "${ctx}/cms/category/check/nopass/" + id;
		}
	</script>
</xqlc:extends>

<xqlc:extends name="content">
  <div class="appcontent">
		<!-- 广告管理字体 -->
		<h3>
		    <span><fmt:message key="ui.cms.checkShow" /></span>	
		</h3>
        </div>

	  <div class="toolbar">
            <ul>
                <li class="btn-group">
                     <!-- 编辑按钮 -->
                    <a class="btn btn-small btn-primary" href="${ctx}/cms/category/update/${category.id}">
                        <fmt:message key="ui.cms.edit"/>
                    </a>
                    <!--返回按钮 -->
                    <button type="button" class="btn btn-small btn-cancel">
                       <fmt:message key="ui.cms.cancel"/>
                    </button>
                </li>
            </ul>
        </div>



	<div class="form-horizontal validation">
		<div class="row-fluid">
			<div class=" span12">
				<div class="widget-box">
					<div class="widget-content">
						<!-- 栏目名称 -->
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.categoryName" />：</label>
								<div class="controls">
									<c:out value="${category.name}"/>
								</div>
							</div>
						</div>
						<!-- 栏目英文名称 -->
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.englishName" />： </label>
								<div class="controls">
									<c:out value="${category.englishName}"></c:out>
								</div>
							</div>
						</div>
						<!-- 栏目类型 -->
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.type" />： </label>
								<div class="controls">
									<c:if test="${category.type == '1'}"><fmt:message key="ui.cms.commonCategory"/></c:if>
									<c:if test="${category.type == '2'}"><fmt:message key="ui.cms.linkCategory"/></c:if>
								</div>
							</div>
						</div>
						<!--栏目访问路径 -->
						<c:if test="${category.type == '2'}">
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.visitPath" />： </label>
								<div class="controls">
									<c:out value="${category.path}" />
								</div>
							</div>
						</div>
						</c:if>
						<!-- 上级栏目 -->
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.parentCategory" />： </label>
								<div class="controls">
									<c:out value="${category.categoryParent.name}" />
								</div>
							</div>
						</div>
						<!--所属角色 -->
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.ownRole" />： </label>
								<div class="controls"> xxxxx </div>
							</div>
						</div>
						<!--栏目审核方式 -->
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.categoryAuditMode" />： </label>
								<div class="controls">	
									<c:if test="${category.auditCategoryMethod == '1'}">
										<fmt:message key="ui.cms.workflow" />
									</c:if>
									<c:if test="${category.auditCategoryMethod == '2'}">
										<fmt:message key="ui.cms.personnelAudit" />
									</c:if>
								</div>
							</div>
						</div>
						<!--栏目审核人 -->
						<c:if test="${category.auditCategoryMethod == '2'}">
							<div class="widget-content">
								<div class="control-group">
									<label class="control-label"><fmt:message key="ui.cms.categoryCheckUser" />： </label>
									<div class="controls">	
										<%-- <c:out value="${category.categoryCheckUser.userName}"></c:out> --%>
										<c:out value="${category.auditCatreviewMethod}"></c:out>
										
									</div>
								</div>
							</div>
						</c:if>
						<!--审核内容 -->
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.auditContent" />： </label>
								<div class="controls">	
									<c:if test="${category.auditCatcontent == 'yes'}">
										<fmt:message key="ui.cms.yes" />
									</c:if> 
									<c:if test="${category.auditCatcontent == 'no'}">
										<fmt:message key="ui.cms.no" />
									</c:if>
								</div>
							</div>
						</div>
						<!--内容审核方式 -->
						<c:if test="${category.auditCatcontent == 'yes' }">
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.contentAuditMode" />： </label>
								<div class="controls">	
									<c:if test="${category.auditCatcontentMethod == '1'}">
										<fmt:message key="ui.cms.workflow" />
									</c:if> 
									<c:if test="${category.auditCatcontentMethod == '2'}">
										<fmt:message key="ui.cms.personnelAudit" />
									</c:if>
								</div>
							</div>
						</div>
						</c:if>
						<!--内容审核人 -->
						<c:if test="${category.auditCatcontentMethod == '2'}">
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.contentCheckUser" />： </label>
								<div class="controls">	
									<%-- <c:out value="${category.contentCheckUser.userName}"></c:out> --%>
									<c:out value="${category.auditCatreviewMethod}"></c:out>
								</div>
							</div>
						</div>
						</c:if>
						<!--评论内容 -->
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.reviewContent" />： </label>
								<div class="controls">	
									<c:if test="${category.reviewCatcontent == 'yes'}">
										<fmt:message key="ui.cms.yes" />
									</c:if> 
									<c:if test="${category.reviewCatcontent == 'no'}">
										<fmt:message key="ui.cms.no" />
									</c:if>
								</div>
							</div>
						</div>
						<!-- 审核评论 -->
						<c:if test="${category.reviewCatcontent == 'yes' }">
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.auditReview" />： </label>
								<div class="controls">	
									<c:if test="${category.auditCatreview == 'yes'}">
										<fmt:message key="ui.cms.yes" />
									</c:if> 
									<c:if test="${category.auditCatreview == 'no'}">
										<fmt:message key="ui.cms.no" />
									</c:if>
								</div>
							</div>
						</div>
						</c:if>
						<!-- 评论审核方式 -->
						<c:if test="${category.auditCatreview == 'yes'}">
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.reviewAuditMode" />： </label>
								<div class="controls">	
									<c:if test="${category.auditCatreviewMethod == '1'}">
										<fmt:message key="ui.cms.workflow" />
									</c:if> 
									<c:if test="${category.auditCatreviewMethod == '2'}">
										<fmt:message key="ui.cms.personnelAudit" />
									</c:if>
								</div>
							</div>
						</div>
						</c:if>
						<!-- 评论审核人 -->
						<c:if test="${category.auditCatreviewMethod == '2'}">
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.reviewCheckUser" />： </label>
								<div class="controls">	
									<%-- <c:out value="${category.reviewCheckUser.userName}"></c:out> --%>
									<c:out value="${category.auditCatreviewMethod}"></c:out>
								</div>
							</div>
						</div>
						</c:if>
						<!--Logo-->
						<c:if test="${not empty category.logoImage}">
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.logo" />： </label>
								<div class="controls">	
									<img src="${ctx}/cms/category/showPhoto/${category.id}" style="width: 50px; height: 50px">
								</div>
							</div>
						</div>
						</c:if>
						
						 <div class="widget-content">
                            <div class="control-group">
                                <label class="control-label"></label>
                                <div class="controls" >
                                    <tr>
                                        <td></td>
                                        <td>
                                            <table class="table table-bordered" id="tab">
                                                <thead>
                                                    <tr>
                                                        <th><fmt:message key="ui.cms.roleName" /></th>
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
                                </div>
                            </div>
                        </div>
					</div>
					<%--
					
					<div class="modal-footer">
					<a class="btn btn-primary" onclick="pass('${category.id}')">
						<fmt:message key="ui.cms.auditPass" />
					</a>
					<a class="btn btn-warning" onclick="nopass('${category.id}')">
						<fmt:message key="ui.cms.auditReject" />
					</a>
					<button type="button" class="btn btn-cancel">
                       <fmt:message key="ui.cms.cancel"/>
                    </button>
					</div>
					
					 --%>
				</div>
			</div>
		</div>
	</div>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseCategoryPage.jsp" />
