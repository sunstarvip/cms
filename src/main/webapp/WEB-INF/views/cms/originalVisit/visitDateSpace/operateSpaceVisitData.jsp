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
        #operateModal .modal-body {
            height: 300px;
        }

        #operateModal {
            width: 800px;
        }

        #operateIframe,body{
            height: 100%;
        }
    </style>
</xqlc:extends>
<xqlc:extends name="javascript">
    <script type="text/javascript">
        function checkOperate(siteId){
            <%--$('#operateIframe').attr('src','${ctx}/cms/original/visitDataIp?siteId='+siteId);--%>
            $('#operateModal').modal();
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
            <table class="table table-striped table-bordered table-hover" id="siteTable">
                <thead>
                <tr>
                    <td>站点名称</td>
                    <td>访问量</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${ipVisitDataList }" var="ipData">
                    <tr>
                        <td>${ipData[0]}</td>
                        <td>
                            <c:forEach items="${ipsAndSpaceMap }" var = "ipsAndSpaceMap">
                                <c:if test="${ipData[0] == ipsAndSpaceMap.key}">${ipsAndSpaceMap.value.space}</c:if>
                            </c:forEach>
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
    <div id="operateModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3>统计详情</h3>
        </div>
        <div class="modal-body">
            <iframe id = "operateIframe"  frameborder="0" scrolling="auto" width="100%" height="auto" src="">

            </iframe>
        </div>
    </div>
</xqlc:extends>
<jsp:include page="/WEB-INF/views/cms/base/baseOriginalVisitPage.jsp"></jsp:include>