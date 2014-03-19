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
        $(function(){
            $('#ipTimeTable').hide();
        });

        function showIpTime(){
            $('#ipTimeTable').show();
            $('#ipNumTable').hide();
        }
        function showIpNum(){
            $('#ipTimeTable').hide();
            $('#ipNumTable').show();
        }
        $(function(){
            $('#startTime_field').change(function(){
                var sTime = $('input[name = "startTime"]').prop('value');
                var eTime = $('input[name = "endTime"]').prop('value');
                if(sTime != '' && eTime != ''){
                    if(sTime > eTime){
                        alert('开始时间必须小于结束时间！');
                        $('input[name = "startTime"]').prop('value','');
                    };
                };
            });
        });
        $(function(){
            $('#endTime_field').change(function(){
                var ssTime = $('input[name = "startTime"]').prop('value');
                var eeTime = $('input[name = "endTime"]').prop('value');
                if(ssTime != '' && eeTime != ''){
                    if(eeTime < ssTime){
                        alert('结束时间必须大于结束时间！');
                        $('input[name = "endTime"]').prop('value','');
                    };
                };
            });
        });
    </script>
</xqlc:extends>
<xqlc:extends name="title">
    cms访问统计管理
</xqlc:extends>

<xqlc:extends name="body">
    <form id="countForm" action="${ctx }/cms/original/countList?queryParameter.countType=${queryParameter.countType}" method="get">
        <div class="widget-content">
            <a id = "ipTimeBtn" name = "ipTimeBtn_button" style="button" class="btn btn-info btn-mini" onclick="showIpTime();">ip访问时间</a>
            <a id = "ipNumBtn" name = "ipNumBtn_button" style="button" class="btn btn-info btn-mini" onclick="showIpNum();">ip访问量</a>
        </div>
        </br>
        <div class="widget-content">
            <table class="table table-striped table-bordered table-hover" id="ipTimeTable">
                <thead>
                    <tr>
                        <td>ip</td>
                        <td>访问时间</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${ipTimeVisitDataList}" var="ipTimeVisitDataList">
                        <tr>
                            <td>${ipTimeVisitDataList[0]}</td>
                            <td>${ipTimeVisitDataList[1]}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="widget-content">
            <table class="table table-striped table-bordered table-hover" id="ipNumTable">
                <thead>
                <tr>
                    <td>ip</td>
                    <td>访问量</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${visitDataIpList}" var="ip">
                    <tr>
                        <td>${ip[0]}</td>
                        <td>
                           ${ip[1]}
                        </td>
                        <td class="stop">
                            <%--<a id = "operateBtn" name = "check_button" style="button" class="btn btn-info btn-mini" data-toggle="operateModal" onclick="checkOperate('${site.id }');">查看</a>--%>
                            <a id = "exportBtn" name = "export_button" style="button" class="btn btn-info btn-mini">导出</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <%--<div class="pagination pagination-centered">--%>
            <%--<xqlc:page page="${pageInfo}" formId="countForm" />--%>
        <%--</div>--%>
    </form>
</xqlc:extends>
<jsp:include page="/WEB-INF/views/cms/base/baseOriginalVisitPage.jsp"></jsp:include>