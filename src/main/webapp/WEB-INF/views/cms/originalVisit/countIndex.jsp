<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>
<xqlc:extends name="css">
    <style type="text/css">

    </style>
</xqlc:extends>
<xqlc:extends name="javascript">
    <script type="text/javascript">
    </script>
</xqlc:extends>
<xqlc:extends name="title">
    cms访问统计管理
</xqlc:extends>

<xqlc:extends name="body">
    <div class="appcontent">
        <h3>
            <span style="font-size: x-large;">cms年访问统计管理</span>
        </h3>
    </div>
    <form id="countForm" action="${ctx }/cms/original/countList?queryParameter.countType=${queryParameter.countType}" method="get">
        <div class="toolbar">
        </div>
        <div class="widget-content">
            <table class="table table-striped table-bordered table-hover" id="siteTable">
                <thead>
                    <tr>
                        <td style="background-color: #63b9ff" colspan="10"><span>网站流量统计：包括年，月，日，内容，ip，地区等非常详细的报表</span></td>
                    </tr>
                </thead>
                <tbody>
                    <tr style="background-color: #63b9ff;">
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=year">年报表</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=month">月报表</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=day">日报表</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=content">内容节点</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=ip">ip</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=space">地区</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=os">操作系统</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=account">账号</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=browser">浏览器</a>
                        </td>
                        <td style="text-align: center;vertical-align:middle; width: 30px">
                            <a href="${ctx}/cms/original/countList?queryParameter.countType=resolution">分辨率</a>
                        </td>
                    </tr>
                </tbody>
            </table>

            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <td style="background-color: #63b9ff" colspan="2">网站流量统计概况</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>总访问量</td>
                        <td>${countMap.countVisit}</td>
                    </tr>
                    <tr>
                        <td>当日访问量</td>
                        <td>${countMap.countEeryDay}</td>
                    </tr>
                    <tr>
                        <td>最常用的浏览器</td>
                        <td>${countMap.maxVisitbroswer[0]}</td>
                    </tr>
                    <tr>
                        <td>最常用的操作系统</td>
                        <td>${countMap.maxVisitOs[0]}</td>
                    </tr>
                    <tr>
                        <td>访问最多的账号</td>
                        <td>${countMap.maxVisitAcc[0]}</td>
                    </tr>
                    <tr>
                        <td>访问最多的分辨率</td>
                        <td>${countMap.maxVisitResolution[0]}</td>
                    </tr>
                    <tr>
                        <td>访问最多的地区</td>
                        <td>${countMap.maxSpace.space}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
</xqlc:extends>
<jsp:include page="/WEB-INF/views/cms/base/baseOriginalVisitPage.jsp"></jsp:include>