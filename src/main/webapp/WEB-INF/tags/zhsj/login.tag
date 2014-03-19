<%@ tag pageEncoding="UTF-8"%>
<%@ tag import="com.xqlc.core.utils.SecurityUtil" %>
<%@ tag import="com.xqlc.core.spring.SpringApplicationContext" %>
<%@ tag import="com.xqlc.webapp.platform.account.service.UserService" %>
<%@ tag import="com.xqlc.webapp.platform.account.entity.User" %>
<%@ tag import="com.xqlc.webapp.platform.account.entity.User.Type" %>
<%@ tag import="org.apache.commons.lang3.StringUtils" %>
<%@ tag import="java.util.Date"%>
<%@ tag import="java.lang.String"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="zhsjtag" tagdir="/WEB-INF/tags/zhsj"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />
<%--<style type="text/css">--%>
		<%--.black{--%>
			<%--color:#000;--%>
		<%--}--%>
<%--</style>--%>
<script src="${ctx }/static/zhsj/js/setHome.js"></script>
<%
    Date today = new Date();
    request.setAttribute("today", today);
    String userId = SecurityUtil.getCurrentUser();
    if (StringUtils.isNotEmpty(userId)) {
        Type type;
        UserService userService = SpringApplicationContext.getBean(UserService.class);
        User user = userService.get(userId);
        type = user.getType();
        if(type == Type.EMPLOYEE) {
            request.setAttribute("type", "employee");
        }else {
            request.setAttribute("type", "client");
        }
        request.setAttribute("user", user);
    }
%>

<%--<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bg_t">--%>
    <%--<tr>--%>
        <%--<td height="40">--%>
            <%--<table width="100%" border="0" cellpadding="0" cellspacing="0">--%>
                <%--<tr>--%>
                    <%--<form id='loginForm' action="${ctx}/login" method="post">--%>
                        <%--<%--%>
                            <%--String uri = request.getRequestURI();--%>
                            <%--String contextPath = request.getContextPath();--%>
                            <%--String webUrl = uri.substring(contextPath.length());--%>
                            <%--session.setAttribute("webUrl", webUrl);--%>
                        <%--%>--%>
                        <%--<c:choose>--%>
                            <%--<c:when test="${not empty user}">--%>
                                <%--&lt;%&ndash; <td width="3%" height="30" align="right" valign="middle">今天是</td>--%>
                                <%--<td width="12%"><fmt:formatDate value="${today}" type="date" dateStyle="full"/></td>--%>
                                <%--<td width="4%" height="30" align="right" valign="middle">用户名:</td> &ndash;%&gt;--%>
                                <%--<td width="4%" height="30" align="right" valign="middle">欢迎您，</td>--%>
                                <%--<td width="4%" height="30">${user.name}！</td>--%>
                                <%--<td width="24%" align="left">--%>
                                    <%--<c:if test="${type == 'employee'}">--%>
                                        <%--<a href="javascript:window.open('${ctx}/platform/index?webUrl=${webUrl}','_blank');void(0);"><font class="black">进入系统</font></a>&nbsp;--%>
                                        <%--&lt;%&ndash;<a href="javascript:window.open('${ctx}/platform/logout?webUrl=${webUrl}','_blank');void(0);">注销</a>&nbsp;&ndash;%&gt;--%>
                                        <%--<a href="${ctx}/platform/logout?webUrl=${webUrl}"><font class="black">注销</font></a>&nbsp;--%>
                                        <%--<a href="javascript:window.open('${ctx}/chinaData/member/userIndex','_blank');void(0);"><font class="black">进入用户中心</font></a>--%>
                                    <%--</c:if>--%>
                                    <%--<c:if test="${type == 'client'}">--%>
                                        <%--<a href="javascript:window.open('${ctx}/chinaData/member/userIndex','_blank');void(0);"><font class="black">进入用户中心</font></a>--%>
                                    <%--</c:if>--%>
                                <%--</td>--%>
                            <%--</c:when>--%>
                            <%--<c:otherwise>--%>
                                <%--<td width="1%" height="30" align="right" valign="middle"</td>--%>
                                <%--<td width="1%" height="30">--%>
                                <%--</td>--%>
                                <%--<td width="1%" height="30" align="right" valign="middle"></td>--%>
                                <%--<td width="1%">--%>
                                <%--</td>--%>
                                <%--<td width="28%" align="left">--%>
                                    <%--&lt;%&ndash;<button type="submit">登录</button>&ndash;%&gt;--%>
                                    <%--<a href="javascript:document.getElementById('loginForm').submit()"><font class="black">登录</font></a>--%>
                                    <%--&nbsp;--%>
                                    <%--<a href="javascript:window.open('${ctx}/chinaData/member/register','_self');void(0);"><font class="black">用户注册</font></a>--%>
                                    <%--&lt;%&ndash;<button type="button" onclick="javascript:window.open('${ctx}/chinaData/system/register');void(0);">用户注册</button>&ndash;%&gt;--%>
                                <%--</td>--%>
                            <%--</c:otherwise>--%>
                        <%--</c:choose>--%>
                    <%--</form>--%>
                    <%--<td width="9%">--%>
                        <%--<a href="${ctx}/template/zhsjdjmh/index.jsp" target="_blank"><font class="black">芝华数据蛋鸡数据</font></a>&nbsp;--%>
                    <%--</td>--%>
                    <%--<td width="9%">--%>
                        <%--<a href="${ctx}/template/zhsjhgjjmh/index.jsp" target="_blank"><font class="black">芝华数据宏观经济</font></a>&nbsp;--%>
                    <%--</td>--%>
                    <%--<td width="9%">--%>
                        <%--<a href="${ctx}/template/zhsjszmh/index.jsp" target="_blank"><font class="black">芝华数据生猪数据</font></a>&nbsp;--%>
                    <%--</td>--%>
                    <%--<td width="9%">--%>
                        <%--<a href="${ctx}/template/zhsjslmh/index.jsp" target="_blank"><font class="black">芝华数据饲料数据</font></a>&nbsp;--%>
                    <%--</td>--%>
                    <%--<td width="10%" align="center">--%>
                        <%--<a onclick="SetHome(window.location)" href="javascript:void(0)"><font class="black">设为首页</font></a>|--%>
                        <%--<a onclick="AddFavorite(window.location,document.title)" href="javascript:void(0)"><font class="black">加入收藏</font></a>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
        <%--</td>--%>
    <%--</tr>--%>
<%--</table>--%>
<%----------------------------------------------------------------%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="bg_t">
    <tr>
        <td height="40">
            <table width="1004" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <form id='loginForm' action="${ctx}/login" method="post">
                        <%
                            String uri = request.getRequestURI();
                            String contextPath = request.getContextPath();
                            String webUrl = uri.substring(contextPath.length());
                            session.setAttribute("webUrl", webUrl);
                        %>
                        <c:choose>
                            <c:when test="${not empty user}">
                                <%-- <td width="3%" height="30" align="right" valign="middle">今天是</td>
                                <td width="12%"><fmt:formatDate value="${today}" type="date" dateStyle="full"/></td>
                                <td width="4%" height="30" align="right" valign="middle">用户名:</td> --%>
                                <td width="4%" height="30" align="right" valign="middle">欢迎您，</td>
                                <td width="4%" height="30">${user.name}！</td>
                                <td width="24%" align="left">
                                    <c:if test="${type == 'employee'}">
                                        <a href="javascript:window.open('${ctx}/platform/index?webUrl=${webUrl}','_blank');void(0);"><font class="black">进入系统</font></a>&nbsp;
                                        <%--<a href="javascript:window.open('${ctx}/platform/logout?webUrl=${webUrl}','_blank');void(0);">注销</a>&nbsp;--%>
                                        <a href="${ctx}/platform/logout?webUrl=${webUrl}"><font class="black">注销</font></a>&nbsp;
                                        <a href="javascript:window.open('${ctx}/chinaData/member/userIndex','_blank');void(0);"><font class="black">进入用户中心</font></a>
                                    </c:if>
                                    <c:if test="${type == 'client'}">
                                    	<a href="${ctx}/platform/logout?webUrl=${webUrl}"><font class="black">注销</font></a>&nbsp;
                                        <a href="javascript:window.open('${ctx}/chinaData/member/userIndex','_blank');void(0);"><font class="black">进入用户中心</font></a>
                                    </c:if>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td width="86%" height="30" align="left">
                                        <%--<button type="submit">登录</button>--%>
                                    <a href="javascript:document.getElementById('loginForm').submit()"><font class="black">登录</font></a>
                                    &nbsp;
                                    <a href="javascript:window.open('${ctx}/chinaData/member/register','_self');void(0);"><font class="black">用户注册</font></a>
                                        <%--<button type="button" onclick="javascript:window.open('${ctx}/chinaData/system/register');void(0);">用户注册</button>--%>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </form>
                    <td width="14%" align="center">
                        <a onclick="SetHome(window.location)" href="javascript:void(0)"><font class="black">设为首页</font></a>|
                        <a onclick="AddFavorite(window.location,document.title)" href="javascript:void(0)"><font class="black">加入收藏</font></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e8e9eb">
    <tr>
        <td>
            <table width="1004" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="99" height="100" align="center" valign="middle"><img src="images/logo.jpg" width="65" height="64" /></td>
                    <td width="861" align="center" valign="middle">
                        <table width="100%" border="0" cellpadding="0" cellspacing="">
                            <tr>
                                <td width="39%" class="text_biaoti">芝华数据蛋鸡门户</td>
                                <td width="61%" class="text_biaoti">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="89%" align="right">
                                                <label for="textfield"></label>
                                                <input name="textfield" type="text" id="textfield" style="height:30px;" value="输入您想查找的信息" size="40" />
                                            </td>
                                            <td width="11%" align="left"><img src="images/ssss.jpg" width="35" height="35" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="20" class="www">www.china-data.com</td>
                                <td>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr class="bottomline">
                                            <td width="25%" height="28" align="center" valign="middle">芝华数据蛋鸡数据</td>
                                            <td width="25%" align="center" valign="middle">芝华数据宏观经济  </td>
                                            <td width="25%" align="center" valign="middle">芝华数据生猪数据  </td>
                                            <td width="25%" align="center" valign="middle">芝华数据饲料数据  </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>--%>
