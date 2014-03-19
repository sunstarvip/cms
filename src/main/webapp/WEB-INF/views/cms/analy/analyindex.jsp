<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<xqlc:extends name="css">
</xqlc:extends>

<xqlc:extends name="javascript">
	<script type="text/javascript">
		$(function() {
			$.fn.datepicker.dates['I18N'] = {
					days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
					daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
					daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
					months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
					monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
					today: "今日"
			};
			
			$('#dpBegin').datepicker({language:'I18N'});
			$('#dpEnd').datepicker({language:'I18N'});
		})
	</script>
</xqlc:extends>

<xqlc:extends name="title">
	统计分析管理
</xqlc:extends>

<xqlc:extends name="body">
	<div class="row-fluid">
		<div class="span12"></div>
		<div class="span12">
			<div class="span3">
			<ol>
				<li><a class="btn btn-primary">内容节点统计</a></li>
				<li><a class="btn btn-primary">当日访问量</a></li>
				<li><a class="btn btn-primary">当月访问量</a></li>
				<li><a class="btn btn-primary">当年访问量</a></li>
				<li><a class="btn btn-primary">操作系统统计</a></li>
				<li><a class="btn btn-primary">IP统计</a></li>
				<li><a class="btn btn-primary">浏览器统计</a></li>
				<li><a class="btn btn-primary">地区统计</a></li>
				<li><a class="btn btn-primary">账号统计</a></li>
			</ol>
			</div>
				
			<div class="span9">
				<div>
					<div class="control-group">
                             <font style="font-size: 10px;font-weight: bold;"></font>开始时间
                        <div data-date-minviewmode="months" data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date="" id="dpBegin" class="input-append date">
							<input type="datetime" size="16" id="beginTime" placeholder="请选择开始时间.例如：1998-09-01" style="width: 235px">
								<span class="add-on"><i class="icon-calendar"></i></span>
			 			</div>
                             <font style="font-size: 10px;color: red"></font>结束时间
                        <div data-date-minviewmode="months" data-date-viewmode="years" data-date-format="yyyy-mm-dd" data-date="" id="dpEnd" class="input-append date">
							<input type="datetime" size="16" id="endTime" placeholder="请选择结束时间.例如：1998-09-01" style="width: 235px">
								<span class="add-on"><i class="icon-calendar"></i></span>
                     	</div>
                     </div>
				</div>
				
				<div>
					<iframe id="analy_frame" name="analy_frame" src="" width="100%" height="100%" style="overflow:auto; border:none;"></iframe>
				</div>
			</div>
		</div>
	</div>
</xqlc:extends>

<jsp:include page="/common/BaseContentPage.jsp" />