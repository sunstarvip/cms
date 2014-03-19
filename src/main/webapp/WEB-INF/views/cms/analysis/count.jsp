<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="css">
  <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/icon.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/static/themes/uibasic/css/zTreeStyle/zTreeStyle.css" type="text/css"  />
  <style type="text/css">
    .ui-layout-north {
        padding: 0;
        overflow: hidden;
        margin: 0;
    }
</style>
</xqlc:extends>

<xqlc:extends name="javascript">
	<xqlc:importjs prefix="http://111.4.117.119/xqlc-ui/static/js/"
		src="plugins/jquery.contextmenu.r2, plugins/xqlc.table.popover, plugins/jquery.metadata, plugins/jquery.validate, plugins/messages_cn" />
	<script type="text/javascript" src="${ctx}/static/websitetheme/js/jquery.ztree.all-3.2.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$(function() {
				$(window).resize(function() {
					$('#frameDiv').height($(window).height() - 90);
				});
				$('#frameDiv').height($(window).height() - 90);
			});
			function selectTreeNodePath(treeNode) {
				var str = "/" + treeNode.name;
				while (true) {
					if (treeNode.getParentNode() == null)
						return str;
					treeNode = treeNode.getParentNode();
					str = "/" + treeNode.name + str;
				}
			}
			var setting_ = {
				callback : {
					onClick : function(event, treeId, treeNode) {
						var path = selectTreeNodePath(treeNode);
						$('#center_frame').attr('src',
								'${ctx}/cms/adCategory/groupAndAdCategoryList/' + treeNode.id);
					}
				}
			};
			var zNodes_ = [];
			var treeObj;
			$(function() {
				loadJobTree();
			});
			function loadJobTree(nodeId) {
				$.ajax({
					type : "get",
					url : '${ctx}/cms/adGroup/adGroupTree',
					dataType : "json",
					success : function(data) {
						zNodes_ = data;
						treeObj = $.fn.zTree.init($("#groupAndAdCategoryTree"), setting_, zNodes_);
						if (!nodeId) {
							var nodes = treeObj.getNodes();
							if (nodes.length > 0) {
								$('#center_frame').attr('src','${ctx}/cms/adCategory/groupAndAdCategoryList/'+ nodes[0].id);
									treeObj.selectNode(nodes[0]);
							};
						} else {
							var node = treeObj.getNodeByParam("id", nodeId,null);
									treeObj.expandNode(node, true, false, true);
								}
							},
							error : function(XMLHttpRequest, textStatus,
									errorThrown) {
								alert(errorThrown);
							}
						});
			}
			//处理页面变形
			if ($(window).width() < 960) {
				$('body').css({
					'padding-top' : '0px'
				});
			} else {
				$('body').css({
					'padding-top' : '40px'
				});
			}
			$(window).resize(function() {
				if ($(window).width() < 960) {
					$('body').css({
						'padding-top' : '0px'
					});
				} else {
					$('body').css({
						'padding-top' : '40px'
					});
				}
			});
			$.fn.datepicker.dates['I18N'] = {
				days : [ "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日" ],
				daysShort : [ "周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日" ],
				daysMin : [ "日", "一", "二", "三", "四", "五", "六", "日" ],
				months : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月",
						"九月", "十月", "十一月", "十二月" ],
				monthsShort : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月",
						"九月", "十月", "十一月", "十二月" ],
				today : "今日"
			};
			$('#start_Time').datepicker({
				language : 'I18N'
			});
			$('#end_Time').datepicker({
				language : 'I18N'
			});

			$("#save_button").click(function() {
						var start = $("#startTime").val();
						var end = $("#endTime").val();
						var sp_startDate = start.split("-");
						var d_time = new Date(sp_startDate[0], sp_startDate[1],
								sp_startDate[2]);
						var d_sDate = d_time.getTime();
						var sp_endTime = end.split("-");
						var d_endTime = new Date(sp_endTime[0], sp_endTime[1],
								sp_endTime[2]);
						var d_eDate = d_endTime.getTime();
						if (d_sDate > d_eDate) {
							$("#checkTime").show();
							return false;
						} else {
							$("#checkTime").hide();
						}
					});
		});
		$(function() {
			var value = $('#type').val();
			if(value == 1) {
				$("#version").show();
				$("#content").hide();
			}
			if(value == 2) {
				$("#version").show();
				$("#content").hide();
			}
			if(value == 3) {
				$("#version").hide();
				$("#content").show();
			}
			$('#type').on(
					'change',
					function() {
						var value = $('#type').val();
						if(value == 1||value == 2) {
							$("#version").show();
							$("#content").hide();
						}
						if(value == 3) {
							$("#version").hide();
							$("#content").show();
						}
					});
			//对重复用的方法封装
			function stopSubmit() {
				$("#editForm").submit(function() {return false});
			}
			//权重验证
			$("#weight").on('change', function() {
				var w = $("#weight").val();
				if(w!=""){
					var r = new RegExp("^[0-9]{1}$");
					if(!r.test(w)){
						$("#s1").html("<font color='red'><fmt:message key='ui.cms.inputAnNum' /></font>");
						stopSubmit();
					}else{
						$("#s1").html("");
					}
					return true;
				}
			});
			
			//链接地址验证
			$("#linkAddress").on('change',function(){
				var m =$("#linkAddress").val();
				if(m!=""){
					var r=new RegExp("^http[s]?:\\/\\/([\\w-]+\\.)+[\\w-]+([\\w-./?%&=]*)?$");
		            if(!r.test(m)){
		               $("#s").html("<font color='red'><fmt:message key='ui.cms.linkCheck' /></font>");
		               stopSubmit();
		            }else{
		                $("#s").html("");
		           }
				}else{
					$("#s").html("");
				}
				return true;
			});
			
		});
		
		
		
		
		
		
	</script>
</xqlc:extends>
<xqlc:extends name="title">
	统计管理
</xqlc:extends>

<xqlc:extends name="body">
	统计管理
	<div class="widget-content">
		<div>
			<ul><li>内容节点统计</li><li></li><li></li><li></li></ul>
		</div>
	</div>
</xqlc:extends>

<jsp:include page="/common/ContentPage.jsp" />
