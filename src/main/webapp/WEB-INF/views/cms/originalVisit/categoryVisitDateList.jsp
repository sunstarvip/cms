<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--<%@ taglib prefix="util" uri="http://www.xqlc.com/util" %>--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="locale" value="${pageContext.request.locale}"/>
<xqlc:extends name="stylebase">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/ui/treetable/jquery.treeTable.css">
    <style type="text/css">

            #myModal .modal-body {
            height: 300px;
            }

            #myModal {
            width: 800px;
            }
            #myModal {
                margin: -30px 0 0 -400px;
            }

            #operateModal .modal-body {
            height: 300px;
            }
            #operateModal .modal-body {
                width: 800px;
            }
            #categoryIframe,body{
            height:100%;
            }
            #categoryIframe,body{
                width:100%;
            }
            #operateIframe,body{
                width:100%;
            }
            #operateIframe,body{
                height:100%;
            }

    </style>
</xqlc:extends>
<xqlc:extends name="scriptbase">
        <script src="${ctx}/static/js/ui/treetable/jquery.treeTable.js" type="text/javascript"> </script>
        <script type="text/javascript">
            $(function() {
                $('#categoryTable tbody tr').css({'cursor':'pointer'});
                $('#categoryTable tbody tr').on('click', function() {
                    $('#categoryIframe').attr('src','${ctx}/cms/original/visitDataContent?categoryId='+$(this).attr('data-row-id'));
//                $('#myModal').modal();
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

//               $(function(){
//                   var option = {
//                       theme:'vsStyle',
//                       expandLevel : 2,
//                       beforeExpand : function($treeTable, id) {
//                           console.log("a");
//                           //判断id是否已经有了孩子节点，如果有了就不再加载，这样就可以起到缓存的作用
//                           if ($('.' + id, $treeTable).length) { return; }
//                           //这里的html可以是ajax请求
//                           var html = '<tr id="8" class="child-of-6"><td>5.1</td><td>可以是ajax请求来的内容</td></tr>'
//                                   + '<tr id="9" class="child-of-6"><td>5.2</td><td>动态的内容</td></tr>';
//
//                           $treeTable.addChilds(html);
//                       },
//                       onSelect : function($treeTable, id) {
//                           window.console && console.log('onSelect:' + id);
//
//                       }
//
//                   };
//                   $('#treeTable1').treeTable(option);
//               });


        </script>
</xqlc:extends>

<xqlc:extends name="title">
    cms访问统计管理
</xqlc:extends>

<xqlc:extends name="body">
    <form id="countForm" action="" method="get">
        <div class="widget-content">
            <%--<span style="text-align: left">${pageInfo.content[0].site.name}:</span>  --%>
            <table class="table table-striped table-bordered table-hover" id="categoryTable">
            </table>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <table id="treeTable" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <td>栏目名称</td>
                            <td>内容量</td>
                            <td>访问量</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${categoryTreeList}" var="cateTree">
                            <script style="text/javascript">console.log('${cateTree.entity}')</script>
                            <script style="text/javascript">console.log('${cateTree.id}+"---"+${cateTree.name}+"---"+${cateTree.entity.key}+"---"+${cateTree.children}')</script>
                        </c:forEach>

                        <c:forEach items="${categories}" var="category">
                            <%--<tr id = "${category.id}">--%>
                                <%--<td style="padding-left: 19px;">--%>
                                        <%--${category.name}--1--%>
                                <%--</td>--%>
                                <%--<td>--%>
                                    <%--<c:forEach items="${categoryVdList}" var="categoryVd">--%>
                                        <%--<c:if test="${category.id == categoryVd[0]}">${categoryVd[1]}</c:if>--%>
                                    <%--</c:forEach>--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                            <c:forEach items="${category.categoryChild}" var = "child">
                                <tr id = "${child.id}">
                                    <td style="padding-left: 19px;">
                                            ${child.name}
                                    </td>
                                    <td>
                                        <c:forEach items="${contentList}" var="content">
                                            <c:if test="${child.id == content[0]}">${content[1]}</c:if>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <c:forEach items="${categoryVdList}" var="categoryVd">
                                            <c:if test="${child.id == categoryVd[0]}">${categoryVd[1]}</c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <c:forEach items="${child.categoryChild}" var="child1">
                                    <%--<c:set var="index" value="0" scope="request" /><!-- 自增序号，注意scope-->--%>
                                    <%--<c:set var="level" value="0" scope="request" /><!-- 记录树的层次，注意scope--><c:import url="treeTable.jsp" />--%>
                                    <tr id="${child1.id}" class="child-of-${child.id}">
                                        <td style="padding-left: 19px;">
                                                ${child1.name}
                                        </td>
                                        <td>
                                            <c:forEach items="${contentList}" var="content">
                                                <c:if test="${child1.id == content[0]}">${content[1]}</c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <c:forEach items="${categoryVdList}" var="categoryVd">
                                                <c:if test="${child1.id == categoryVd[0]}">${categoryVd[1]}</c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                    <c:forEach items="${child1.categoryChild}" var="child2">
                                        <tr id="${child2.id}" class="child-of-${child1.id}">
                                             <td style="padding-left: 19px;">
                                                ${child2.name}
                                             </td>
                                            <td>
                                                <c:forEach items="${contentList}" var="content">
                                                    <c:if test="${child2.id == content[0]}">${content[1]}</c:if>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <c:forEach items="${categoryVdList}" var="categoryVd">
                                                    <c:if test="${child2.id == categoryVd[0]}">${categoryVd[1]}</c:if>
                                                </c:forEach>
                                            </td>
                                        </tr>
                                        <c:forEach items="${child2.categoryChild}" var="child3">
                                            <tr id = "${child3.id}" class="child-of-${child2.id}">
                                                <td style="padding-left: 19px;">
                                                    ${child3.name}
                                                </td>
                                                <td>
                                                    <c:forEach items="${contentList}" var="content">
                                                        <c:if test="${child3.id == content[0]}">${content[1]}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:forEach items="${categoryVdList}" var="categoryVd">
                                                        <c:if test="${child3.id == categoryVd[0]}">${categoryVd[1]}</c:if>
                                                    </c:forEach>
                                                </td>
                                            </tr>
                                            <c:forEach items="${child3.categoryChild}" var="child4">
                                                <tr id = "${child4.id}" class="child-of-${child3.id}">
                                                    <td style="padding-left: 19px;">
                                                            ${child4.name}
                                                    </td>
                                                    <td>
                                                        <c:forEach items="${contentList}" var="content">
                                                            <c:if test="${child4.id == content[0]}">${content[1]}</c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <c:forEach items="${categoryVdList}" var="categoryVd">
                                                            <c:if test="${child4.id == categoryVd[0]}">${categoryVd[1]}</c:if>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                                <c:forEach items="${child4.categoryChild}" var="child5">
                                                    <tr id = "${child5.id}" class="child-of-${child4.id}">
                                                        <td style="padding-left: 19px;">
                                                                ${child5.name}
                                                        </td>
                                                        <td>
                                                            <c:forEach items="${contentList}" var="content">
                                                                <c:if test="${child5.id == content[0]}">${content[1]}</c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td>
                                                            <c:forEach items="${categoryVdList}" var="categoryVd">
                                                                <c:if test="${child5.id == categoryVd[0]}">${categoryVd[1]}</c:if>
                                                            </c:forEach>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:forEach>
                                        </c:forEach>
                                    </c:forEach>
                                </c:forEach>
                            </c:forEach>
                    </c:forEach>
                    </tbody>
                </table>
                <script type="text/javascript">
                    $(function() {
                        $('#treeTable').treeTable({'initialState':'expanded'});
                    });
                </script>
            </div>
        </div>
    </form>
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3>内容访问统计</h3>
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
            <iframe id = "operateIframe"  frameborder="0" scrolling="auto" width="100%" height="auto" src="">

            </iframe>
        </div>
    </div>
</xqlc:extends>
<jsp:include page="/WEB-INF/views/cms/base/baseOriginalVisitPage.jsp"/>