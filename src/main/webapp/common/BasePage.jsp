<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <xqlc:block name="title">
        </xqlc:block>
    </title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/core/bootstrap/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/ui/datetime/datetimepicker.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/lib/xqlcuiextend/xqlc-platform-icons.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/lib/xqlcui/xqlc-ui-main.css">
    <%--UEdeitor相关--%>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/ueditor/themes/default/css/ueditor.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/upload/css/uploadify.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/ui/menu/dcmegamenu.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/ui/menu/white.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/ui/select/select2.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/lib/xqlcui/xqlc-ui-basecore.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/ui/treetable/jquery.treeTable.css">
    <xqlc:block name="css">
    </xqlc:block>
    <script src="${ctx}/static/js/core/jquery/jquery.js"></script>
    <script src="${ctx}/static/js/core/bootstrap/bootstrap.js"></script>
    <script src="${ctx}/static/js/ui/datetime/bootstrap-datetimepicker.js"></script>
    <script src="${ctx}/static/js/ui/datetime/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    
    <script src="${ctx}/static/js/lib/xqlcuiextend/xqlc.core.js"></script>
    <script src="${ctx}/static/js/lib/xqlcuiextend/xqlc.table.popover.js"></script>
    <script src="${ctx}/static/upload/js/jquery.uploadify-3.1.js"></script>
    <%--UEdeitor相关--%>
    <script type="text/javascript" src="${ctx}/static/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="${ctx}/static/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/ueditor/lang/zh-cn/zh-cn.js"></script>
    <%--Validate相关--%>
    <script src="${ctx}/static/js/ui/validate/jquery.metadata.js"></script>
    <script src="${ctx}/static/js/ui/validate/jquery.validate.js"></script>
    <script src="${ctx}/static/js/ui/validate/messages_cn.js"></script>
    <script src="${ctx}/static/js/ui/menu/jquery.hoverIntent.minified.js"></script>
    <script src="${ctx}/static/js/ui/menu/jquery.dcmegamenu.js"></script>
    <script src="${ctx}/static/js/ui/caroufredsel/jquery.carouFredSel-6.2.1.js"></script>
    <script src="${ctx}/static/js/ui/holder/holder.js"></script>
    <script src="${ctx}/static/websitetheme/js/bootstrap-datepicker.js"></script>
    <script src="${ctx}/static/websitetheme/js/jquery.pin.min.js"></script>
    <script src="${ctx}/static/js/ui/pinyin/xqlc-pinyin.js"></script>
    <script src="${ctx}/static/js/ui/zClip/jquery.zclip.js"></script>
    <script src="${ctx}/static/js/ui/select/select2.js"></script>
    <script src="${ctx}/static/js/core/jqueryui/jquery-ui.js"></script>
    <script src="${ctx}/static/js/ui/treetable/jquery.treeTable.js"></script>
    <script type="text/javascript">
	    $(function() {
		    $('.btn-cancel').click(function() {
		        location.href = document.referrer;
		    });

            $.extend({
                getOrderProcessUser: function (serviceOrderId, formKey, returnSelectId) {
                    var formKey = encodeURIComponent(formKey);
                    $.get('${ctx}/workFlow/querySelectEmployee/'+ serviceOrderId +'.json', {
                        'formKey' : formKey
                    }, function(response) {
                        $('#' + returnSelectId).empty();
                        for (var i = 0; i < response.length; i++) {
                            $('#' + returnSelectId).append($('<option value="' + response[i].id + '">' + response[i].name + '('+ response[i].email +')</option>'));
                        }
                    }, 'json');
                },

                getOrderProcessUserByAreaAndProductLine: function (formKey, area, productLine,productModel, returnSelectId) {
                    var formKey = encodeURIComponent(formKey);
                    var area = encodeURIComponent(area);
                    var productLine = encodeURIComponent(productLine);
                    var productModel = encodeURIComponent(productModel);
                    $.get('${ctx}/workFlow/querySelectEmployee.json', {
                        'formKey' : formKey,
                        'area' : area,
                        'productLine' : productLine,
                        'productModel' : productModel
                    }, function(response) {
                        $('#' + returnSelectId).empty();
                        for (var i = 0; i < response.length; i++) {
                            $('#' + returnSelectId).append($('<option value="' + response[i].id + '">' + response[i].name + '('+ response[i].email +')</option>'));
                        }
                    }, 'json');
                }


            });
	    });
    </script>

    <xqlc:block name="javascript">
    </xqlc:block>
</head>


<body>
<xqlc:block name="body">
</xqlc:block>
</body>
</html>