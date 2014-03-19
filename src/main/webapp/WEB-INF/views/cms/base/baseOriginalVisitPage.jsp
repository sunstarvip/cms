<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>

<xqlc:extends name="title">
    <fmt:message key="ui.cms.CMSManagement"/>
</xqlc:extends>

<xqlc:extends name="header">
    <fmt:message key="ui.cms.CMSManagement"/>
</xqlc:extends>
<xqlc:extends name="style">
    <xqlc:block name="stylebase">

    </xqlc:block>
</xqlc:extends>
<xqlc:extends name="script">

    <xqlc:block name="scriptbase">

    </xqlc:block>
</xqlc:extends>

<xqlc:extends name="body">
    <div class="banner">
        <div class="container">
            <h1 class="pull-left">
                <xqlc:block name="header">
                </xqlc:block>
            </h1>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row-fluid">
                <div class="span3">
                    <xqlc:block name="nav">
                    <h3>
                        <span>cms统计管理</span>
                    </h3>
                    <ul>
                        <xqlc:permission key="cmsCount_year">
                            <li class="active">
                                    <a href="${ctx}/cms/original/countList?queryParameter.countType=year">
                                        <i class="icon-list-alt"></i>
                                        <span>年统计</span>
                                        <i class="icon-chevron-right pull-right"></i>
                                    </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_month">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=month">
                                    <i class="icon-list-alt"></i>
                                    <span>月统计</span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_day">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=day">
                                    <i class="icon-list-alt"></i>
                                    <span>天统计</span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_content">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=content">
                                    <i class="icon-list-alt"></i>
                                    <span>内容节点统计 </span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_ips">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=ip">
                                    <i class="icon-list-alt"></i>
                                    <span>ip地址统计</span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_space">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=space">
                                    <i class="icon-list-alt"></i>
                                    <span>地区统计</span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_os">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=os">
                                    <i class="icon-list-alt"></i>
                                    <span>操作系统统计</span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_account">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=account">
                                    <i class="icon-list-alt"></i>
                                    <span>账号统计</span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_browser">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=browser">
                                    <i class="icon-list-alt"></i>
                                    <span>浏览器统计</span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                        <xqlc:permission key="cmsCount_resolution">
                            <li class="active">
                                <a href="${ctx}/cms/original/countList?queryParameter.countType=resolution">
                                    <i class="icon-list-alt"></i>
                                    <span>分辨率统计</span>
                                    <i class="icon-chevron-right pull-right"></i>
                                </a>
                            </li>
                        </xqlc:permission>
                    </ul>
                </xqlc:block>
            </div>
            <div class="span9">
                <xqlc:block name="content">
                </xqlc:block>
            </div>
        </div>
    </div>

</xqlc:extends>


<jsp:include page="/common/ContentPage.jsp" />