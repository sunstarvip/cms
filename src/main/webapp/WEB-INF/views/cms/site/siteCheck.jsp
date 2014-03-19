<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
    <form:form id="editForm" modelAttribute="site" cssClass="form-horizontal validation">
        <form:hidden path="id"/>
        <div class="toolbar">
            <ul>
                <li class="btn-group">
                    <!-- 新增按钮 -->
                    <a class="btn btn-small btn-success" href="${ctx}/cms/site/create">
                        <fmt:message key="ui.base.create"/>
                    </a>
                    <!-- 编辑按钮 -->
                    <a class="btn btn-small btn-primary" href="${ctx}/cms/site/update/${site.id}">
                        <fmt:message key="ui.cms.edit"/>
                    </a>
                    <!-- 站点的启用与停用选择 -->
                    <c:choose>
                        <c:when test="${site.startFlag == 'yes'}">
                            <a id="batch_blockUp" class="btn btn-small btn-danger" 
                                href="${ctx}/cms/site/blockUp/${site.id}">
		                        <fmt:message key="ui.cms.blockUp"/>
		                    </a>
                        </c:when>
                        <c:when test="${site.startFlag == 'no'}">
                            <a id="batch_start" class="btn btn-small btn-success" 
                                href="${ctx}/cms/site/start/${site.id}">
		                        <fmt:message key="ui.cms.start"/>
		                    </a>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                    <a class="btn btn-small btn-cancel" href="${ctx}/cms/site/list">
                        <fmt:message key="ui.base.cancel"/>
                    </a>
                </li>
            </ul>
        </div>
        <div class="detailedinfo">
            <div class="row-fluid">
                <div class="span5 offset4">
                    <table>
                        <tbody>
                        <!-- 站点名称 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.siteName"/></h5>
                            </td>
                            <td>
                                ${site.name}
                            </td>
                        </tr>
                        <!-- 站点标示 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.englishName"/></h5>
                            </td>
                            <td>
                                ${site.ename}
                            </td>
                        </tr>
                        <!-- 创建时间 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.base.createTime"/></h5>
                            </td>
                            <td>
                                <fmt:formatDate value="${site.createTime}" type="date"/>
                            </td>
                        </tr>
                        <!-- 访问协议 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.accessProtocol"/></h5>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${site.agreement==1}">
                                        HTTP://
                                    </c:when>
                                    <c:when test="${site.agreement==2}">
                                        HTTPS://
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <!-- 绑定域名 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.parkedDomains"/></h5>
                            </td>
                            <td>
                                ${site.webDomain}
                            </td>
                        </tr>
                        <!-- 访问路径 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.path"/></h5>
                            </td>
                            <td>
                                ${site.path}
                            </td>
                        </tr>
                        <!-- 域名别称  -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.domainAnotherNamer"/></h5>
                            </td>
                            <td>
                                ${site.nlckDomain}
                            </td>
                        </tr>
                        <!-- 域名重定向  -->
                        <%-- <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.domainNameRedirect"/></h5>
                            </td>
                            <td>
                                ${site.redirectDomin}
                            </td>
                        </tr> --%>
                        <!-- 是否使用相对路径  -->
                        <%-- <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.useRelativePaths"/></h5>
                            </td>
                            <td>
                                <c:choose>  
                                    <c:when test="${site.relativePath == 'yes'}">  
                                         <fmt:message key="ui.cms.yes"/>
                                    </c:when>  
                                    <c:when test="${site.relativePath == 'no'}">  
                                         <fmt:message key="ui.cms.no"/>
                                    </c:when>  
                                    <c:otherwise>  
                                    </c:otherwise>  
                                </c:choose> 
                            </td>
                        </tr> --%>
                        <!-- 动态页面后缀 -->
                        <%-- <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.dynamicPagesSuffix"/></h5>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${site.dynamicSuffix==1}">
                                        .jhtml
                                    </c:when>
                                    <c:when test="${site.dynamicSuffix==2}">
                                        .html
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr> --%>
                        <!-- 静态页面后缀  -->
                        <%-- <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.staticPagesSuffix"/></h5>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${site.staticSuffix==1}">
                                        .html
                                    </c:when>
                                    <c:when test="${site.staticSuffix==2}">
                                        .shtml
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr> --%>
                        <!-- 静态页目录 -->
                        <%-- <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.staticPageDirectory"/></h5>
                            </td>
                            <td>
                                ${site.staticColumn}
                            </td>
                        </tr> --%>
                        <!-- 开启静态页 -->
                        <%-- <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.openTheStaticPage"/></h5>
                            </td>
                            <td>
                                <c:choose>  
                                    <c:when test="${site.staticIndex == 'yes'}">  
                                         <fmt:message key="ui.cms.yes"/> 
                                    </c:when>  
                                    <c:when test="${site.staticIndex == 'no'}">  
                                         <fmt:message key="ui.cms.no"/>                                                                            
                                    </c:when>  
                                    <c:otherwise>  
                                    </c:otherwise>  
                                </c:choose>
                            </td>
                        </tr> --%>
                        <!-- 后台国际化 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.theBackgroundOfInternationalization"/></h5>
                            </td>
                            <td>
                                ${site.blackConver}
                            </td>
                        </tr>
                        <!-- 前台国际化 -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.theForegroundOfInternationalization"/></h5>
                            </td>
                            <td>
                                ${site.beforeConver}
                            </td>
                        </tr>
                        <!-- 站点简称  -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.siteAbbreviation"/></h5>
                            </td>
                            <td>
                                ${site.simpleName}
                            </td>
                        </tr>
                        <!-- 是否主站点  -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.whetherMainSite"/></h5>
                            </td>
                            <td>
                                <c:choose>  
                                    <c:when test="${site.mainSite == 'yes'}">  
                                          <fmt:message key="ui.cms.yes"/>
                                    </c:when>  
                                    <c:when test="${site.mainSite == 'no'}">  
                                          <fmt:message key="ui.cms.no"/>
                                    </c:when>  
                                    <c:otherwise>  
                                    </c:otherwise>  
                                </c:choose>
                            </td>
                        </tr>
                        <!-- 是否启用站点  -->
                        <tr>
                            <td>
                                <h5><fmt:message key="ui.cms.whetherMainSite"/></h5>
                            </td>
                            <td>
                                <c:choose>  
                                    <c:when test="${site.startFlag == 'yes'}">  
                                         <fmt:message key="ui.cms.yes"/>
                                    </c:when>  
                                    <c:when test="${site.startFlag == 'no'}">  
                                         <fmt:message key="ui.cms.no"/>
                                    </c:when>  
                                    <c:otherwise>  
                                    </c:otherwise>  
                                </c:choose>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </form:form>
    <xqlc:extends name="javascript">
        <script type="text/javascript">
            $(function() {
                // 处理页面变形
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
                $('#name').on('change', function() {        
                    $('#ename').val(getFirst($('#name').val()));
                });
            });
        </script>
   </xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseSitePage.jsp" />
