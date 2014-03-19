<%@ tag import="com.xqlc.webapp.platform.account.service.UserService" %>
<%@ tag import="com.xqlc.core.spring.SpringApplicationContext" %>
<%@ tag import="com.xqlc.webapp.platform.account.entity.User" %>
<%@ tag import="com.xqlc.core.utils.SecurityUtil" %>
<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>

<%@ attribute name="active" required="true"%>

<%
    UserService userService = SpringApplicationContext.getBean(UserService.class);
    User user = userService.get(SecurityUtil.getCurrentUser());
    jspContext.setAttribute("__user__", user);
%>

<div class="user-profile">
    <div class="figure">
        <img src="http://placekitten.com/70/70" alt="John Pixel avatar">

        <div class="figcaption">
            <strong>${__user__.name}</strong>
            <em>角色或会员级别</em>
            <ul>
                <li><a title="" href="index.html#" class="btn btn-primary btn-flat"
                       data-original-title="Message inbox">修改密码</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="user-nav nav-collapse collapse">
    <ul>
        <xqlc:permission key="personal_center_mian_myInfo">
        <li<c:if test="${active == 'personal_center_mian_myInfo'}"> class="active"</c:if>>
            <a href="<c:url value='/platform/account/user/myInfo'/>"><i class="custom-platform-vcard-add"></i> 个人设置 </a>
        </li>
        </xqlc:permission>

        <li><a href="#"><i class="custom-platform-comment-add"></i>我的消息</a></li>
        <li class="submenu"><a href="#">
            <i class="custom-platform-user-delete"></i>我的论坛
            <span class="badge"><i class="icon-circle-arrow-down"></i></span>
            <ul>
            <li <c:if test="${active == 'myThemeList'}"> class="active"</c:if>><a href="<c:url value='/forum/theme/myThemeList'/>"><i class=" custom-platform-rss-add"></i>我发表的帖子</a></li>
            <li <c:if test="${active == 'myRevertThemeList'}"> class="active"</c:if>><a href="<c:url value='/forum/theme/myRevertList'/>"><i class=" custom-platform-rss-add"></i>我回复的帖子</a></li>
            </ul>
        </a></li>
        <li><a href="#"><i class="custom-platform-application-view-gallery"></i>我申请的服务</a></li>
        <li<c:if test="${active == 'mycourse'}"> class="active"</c:if>>
            <a href="<c:url value='/public/study/selectCourse/list'/>"><i class="custom-platform-building-add"></i>我的课程</a>
        </li>
        <li class="submenu">
            <a href="#">
                <i class="custom-platform-page-error"></i>我的考试
                <span class="badge"><i class="icon-circle-arrow-down"></i></span>
            </a>
            <ul>
                <li<c:if test="${active == 'init'}"> class="active"</c:if>><a href="<c:url value='/public/exam/initCanTests'/>"><i class=" custom-platform-rss-add"></i>未考试</a></li>
                <li<c:if test="${active == 'list'}"> class="active"</c:if>><a href="<c:url value='/public/exam/examPaperList'/>"><i class=" custom-platform-vcard-add"></i>已考试</a></li>
                <li<c:if test="${active == 'makeup'}"> class="active"</c:if>><a href="<c:url value='/public/exam/makeup'/>"><i class="custom-platform-bullet-key"></i>补考</a>
                </li>

            </ul>
        </li>
        <li<c:if test="${active == 'plan'}"> class="active"</c:if>><a href="<c:url value='/public/study/plan/list'/>"><i class="custom-platform-page-error"></i>我的进度</a></li>
        <li<c:if test="${active == 'task'}"> class="active"</c:if>><a href="<c:url value='/public/study/task/taskList'/>"><i class="custom-platform-page-error"></i>任务管理</a></li>
        <li<c:if test="${active == 'eval'}"> class="active"</c:if>><a href="<c:url value='/evaluation/study/courseList'/>"><i class="custom-platform-page-error"></i>评价管理</a></li>
        <li><a href="#"><i class="custom-platform-page-white-paste"></i>待我审核</a></li>
        <li><a href="#"><i class="custom-platform-calendar-link"></i>待办事项</a></li>
        <li><a href="#"><i class="custom-platform-user-add"></i>在线客服</a></li>
        <li><a href="#"><i class="custom-platform-book-previous"></i>问题跟踪</a></li>
        <li><a href="#"><i class="custom-platform-page-white"></i>空间设置</a></li>
        <li><a href="#"><i class="custom-platform-help"></i>帮助中心</a></li>
    </ul>
</div>
<script type="text/javascript">
    $('.user-nav > ul > li > ul').hide(); //Hide all sub menus
    $('.user-nav > ul > li > ul > li.active').parent('ul').slideToggle('slow'); // Slide down the current sub menu
    $('.user-nav > ul > li.submenu > a').click(
            function () {
                $(this).parent().siblings().find('ul').slideUp('normal'); // Slide up all menus except the one clicked
                $(this).parent().find('ul').slideToggle('normal'); // Slide down the clicked sub menu
                return false;
            }
    );
</script>