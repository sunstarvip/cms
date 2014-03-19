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

        #opereateIframe,body{
            height: 100%;
        }

        #myModal .modal-body {
            height: 300px;
        }

        #myModal {
            width: 800px;
        }

        #myIframe,body{
            height: 100%;
        }
    </style>
</xqlc:extends>
<xqlc:extends name="javascript">
    <script type="text/javascript">
        function checkOperate(siteId){
            <%--$('#opereateIframe').attr('src','${ctx}/cms/original/visitDataBrowser?siteId='+siteId);--%>
            $('#operateModal').modal();
        }

        $(function() {
            $('#siteTable tbody tr').css({'cursor':'pointer'});
            $('#siteTable tbody tr').on('click', function() {
                $('#myIframe').attr('src','${ctx}/cms/original/visitDataResolution?siteId='+$(this).attr('data-row-id'));
                $('#myModal').modal();
            });

            $('a[name="check_button"]').parent('td').on('click', function(event) {
                event.stopPropagation();
            });
        });

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
    分辨率统计
</xqlc:extends>

<xqlc:extends name="body">
    <div class="appcontent">
        <h3>
            <span style="font-size: x-large;">分辨率统计</span>
        </h3>
    </div>
    <form id="countForm" action="${ctx }/cms/original/countList?queryParameter.countType=${queryParameter.countType}" method="get">
        <div class="toolbar">
            <ul>
                <li>
                    <span>查询时间：</span>
                </li>
                <li>
                    <xqlc:datepicker name="queryParameter.createTime_ge" id="startTime" value="${queryParameter.createTime_ge}"/>
                </li>
                <li>
                    <xqlc:datepicker name="queryParameter.createTime_le" id="endTime" value="${queryParameter.createTime_le}"/>
                </li>
                <li><button type="submit" class= "btn btn-primary" id="submitBtn">查询</button></li>
            </ul>
        </div>
        <div class="widget-content">
            <table class="table table-striped table-bordered table-hover" id="siteTable">
                <thead>
                <tr>
                    <td>站点名称</td>
                    <td>访问量</td>
                    <td>详情</td>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pageInfo.content }" var="site">
                        <tr data-row-id = ${site.id }>
                            <td>${site.name}</td>
                            <td>
                                <c:forEach items="${visitSiteNumList }" var = "visit">
                                    <c:if test="${site.id == visit[0]}">${visit[1]}</c:if>
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
        <div class="pagination pagination-centered">
            <xqlc:page page="${pageInfo}" formId="countForm" />
        </div>
    </form>
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3>统计统计详情</h3>
        </div>
        <div class="modal-body">
            <iframe id = "myIframe"  frameborder="0" scrolling="auto" width="100%" height="auto" src="">

            </iframe>
        </div>
    </div>

    <div id="operateModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3>统计统计详情</h3>
        </div>
        <div class="modal-body">
            <iframe id = "opereateIframe"  frameborder="0" scrolling="auto" width="100%" height="auto" src="">

            </iframe>
        </div>
    </div>
</xqlc:extends>
<jsp:include page="/WEB-INF/views/cms/base/baseOriginalVisitPage.jsp"></jsp:include>