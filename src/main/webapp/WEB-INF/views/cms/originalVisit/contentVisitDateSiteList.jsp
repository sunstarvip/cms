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
            #myModal .modal-body {
                height: 500px;
            }

            #myModal {
                width: 900px;
            }

            #categoryIframe,body{
            height:100%;
            }
            #categoryIframe,body{
            width:100%;
            }

    </style>
</xqlc:extends>
<xqlc:extends name="javascript">
    <script type="text/javascript">
        $(function() {
            $('#categoryTable tbody tr').css({'cursor':'pointer'});
            $('#categoryTable tbody tr').on('click', function() {
                window.location.href="${ctx}/cms/original/visitDataCategory?siteId="+$(this).attr('data-row-id');
                <%--$('#categoryIframe').attr('src','${ctx}/cms/original/visitDataCategory?siteId='+$(this).attr('data-row-id'));--%>
                <%--$('#myModal').modal();--%>
            });
            $('input[name="chk"]').parent('td').on('click', function(event) {
                event.stopPropagation();
            });

            $('input[name="chk_all"]').parent('td').on('click', function(event) {
                event.stopPropagation();
            });

            $('a[name="check_button"]').parent('td').on('click', function(event) {
                event.stopPropagation();
            });
        });

        function checkOperate(categoryId){
            console.log(categoryId);
            $('#opereateIframe').attr('src','${ctx}/cms/original/operateVisitDate?categoryId='+categoryId);
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
    内容节点统计
</xqlc:extends>

<xqlc:extends name="body">
    <div class="appcontent">
        <h3>
            <span style="font-size: x-large;">内容节点统计</span>
        </h3>
    </div>
    <form id="countForm" action="${ctx }/cms/original/categoryVisitDate" method="get">
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
            <table class="table table-striped table-bordered table-hover" id="categoryTable">
                <thead>
                <tr>
                    <td>站点名称</td>
                    <td>访问量</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.content }" var="site">
                    <tr data-row-id = ${site.id }>
                        <td>${site.name}</td>
                        <td>
                            <c:forEach items="${visitSiteNumList }" var = "visitSite">
                                <c:if test="${site.id == visitSite[0]}">${visitSite[1]}</c:if>
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
    </form>
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3>栏目访问统计</h3>
        </div>
        <div class="modal-body">
            <iframe id = "categoryIframe"  frameborder="0" scrolling="auto" width="100%" height="auto" src="">

            </iframe>
        </div>
    </div>
    <div id="operateModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3>统计详情</h3>
        </div>
        <div class="modal-body">
            <iframe id = "opereateIframe"  frameborder="0" scrolling="auto" width="100%" height="auto" src="">

            </iframe>
        </div>
    </div>
</xqlc:extends>
<jsp:include page="/WEB-INF/views/cms/base/baseOriginalVisitPage.jsp"></jsp:include>