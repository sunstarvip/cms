<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="javascript">
 <!-- 验证框架 -->
   <script type="text/javascript">
	    $(function() {
	     $("#editForm").validate();
	 });
   </script>
    <script type="text/javascript">
       $(function() {
              //是否重名
              $('#name').on('change',function(){
              	$.get('${ctx}/cms/adCategory/repeat',{ name: $('#name').val()},function(data){
              		if(data == "true"){
              			$('#checkName').show();
              			$('#name').val('');
              		}else if(data == "false"){
              			$('#checkName').hide();
              		}
              	});
              });
            
       });
     </script>
	<script type="text/javascript">
		//绑定模版
		function getTemp(){
	 		var value_ = $('input[name="temp_chk"]:checked').val();
	 		$("#templateName_id").val(value_);
		};
		$(function(){
			$("#adCategorySize").on("change",function(){
				
				var sizeValue= $("#adCategorySize").val();
				if(sizeValue == "other"){
					$("#table_tr_width_id").show();
					$("#table_tr_height_id").show();
				} else{
					$("#table_tr_width_id").hide();
					$("#table_tr_height_id").hide();
				}
			});
			//保存广告位
    		$('#saveType_btn').on('click',function() {
    			$('#editForm')[0].method ="post";
                $('#editForm')[0].action = "${ctx}/cms/adCategory/saveAdCategory";
                $('#editForm').submit();
            }); 
			
		});
		
		
	</script>

</xqlc:extends>

<xqlc:extends name="content">
			<div class="appcontent">
	            <h3>
	                <span><fmt:message key="ui.cms.edit" /></span>
	            </h3>
            </div>
		<form:form id="editForm" action="" class="form-horizontal" modelAttribute="adCategory" cssClass="form-horizontal validation" method="post">
			<form:hidden path="id" />
			<input type="hidden" id="parentId" name="parentId" value="${parentId }">
			
          <div class="headInfo clearfix">
	          <div class="actions">
	          </div>
        </div>
        <div class="block-fluid clearfix">
             <div class="formlayout">
                <ul>
                   <li>
                   <!--广告位名 -->
                   <span><fmt:message key="ui.cms.adPositionName" />:</span>
                   <div class="formright">
                   <input type="text" name="name" id="name" value="${adCategory.name}" class="{required:true}"/>
	                       <span id="checkName" style="display:none">
	                       <font color='red'>Please Change Name!</font>
	                       </span>
                   </div>
                   </li>
                   <li>
                   <!-- 大小 -->
                   <span><fmt:message key="ui.cms.adCategorySize" />:</span>
                   <div class="formright">
                   <select id="adCategorySize" name="adCategorySize" value = "${dictionary.name }" >
                    		<c:forEach items="${adCategorySize }" var="adCategorySize">
                    				<option value="${adCategorySize.code }">${adCategorySize.name }</option>
                    		</c:forEach>
                    			<option value="other"><fmt:message key="ui.cms.other" /></option>
                   </select>
                   </div>
                   </li>
                   <li id = "table_tr_width_id" style="display: none">
                   <!-- 宽度 -->
                   <span><fmt:message key="ui.cms.width" />:</span>
                   <div class="formright">
                    <form:input path="width" cssClass="{required:true,digits:true,messages:{required:' 请输入宽度'}}" />${adCategory.width } px
                   </div>
                   </li>
                   <li id = "table_tr_height_id" style="display: none">
                   <!-- 高度 -->
                   <span><fmt:message key="ui.cms.height" />:</span>
                   <div class="formright">
                   <form:input path="height" cssClass="{required:true,digits:true,messages:{required:' 请输入高度'}}" /> ${adCategory.height } px
                   </div>
                   </li>
                   <li>
                   <!-- 类型 -->
                   <span><fmt:message key="ui.cms.adCategoryType" />:</span>
                   <div class="formright">
                   <select id="adCategoryType" name="adCategoryType" value = "${adCategory.adCategoryType }">
                    		<%-- <option><fmt:message key="ui.cms.pleaseChoose" /></option> --%>
                    		<option><fmt:message key="ui.cms.fixadCategory" /></option>
                    		<option><fmt:message key="ui.cms.dangling" /></option>
                    		<option><fmt:message key="ui.cms.Carousel" /></option>
                   </select>
                   </div>
                   </li>
                   <li>
                   <!--是否启用  -->
                   <span><fmt:message key="ui.cms.isUse" />:</span>
                   <div class="formright">
                    <form:select path="useCode">
                        <form:option cssClass="{required:true,messages:{required:' '}}" value="yes">
                            <fmt:message key="ui.base.yes"/>
                        </form:option>
                        <form:option cssClass="{required:true,messages:{required:' '}}" value="no">
                            <fmt:message key="ui.base.no"/>
                        </form:option>
                        </form:select>
                   </div>
                   </li>
                </ul>
                <div class="footer tar">
                     <button type="button" id="saveType_btn" class="btn btn-small btn-success" >
							<fmt:message key="ui.base.save" />
					</button>
					<a href="${ctx}/cms/adCategory/adCategoryList/${selectGroupId }"
						class="btn btn-small btn-warning">
						<fmt:message key="ui.base.cancel" />
				   </a>
               </div>
             </div>
         </div>
    </form:form>
	
	<div id="templateModal" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="templateModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h4 id="myModalLabel"><fmt:message key="ui.cms.templateList"/></h4>
		</div>
		<div id="modalbody" class="modal-body" style="height:200px">
			<div class="container-fluid">
				<div class="row-fluid">
					<xqlc:table id="queryTable" items="${templateList}">
                            <xqlc:row var="template">
                                <xqlc:column style="text-align: center" title=" ">
                                    <input type="radio" name="temp_chk" value="${template.path}" />
                                </xqlc:column>
                                <xqlc:column title="${xqlc:i18n('ui.cms.templateName',locale)}" style="text-align: center">${template.name}</xqlc:column>
                                <xqlc:column title="${xqlc:i18n('ui.cms.templatePath',locale)}" style="text-align: center">${template.path}</xqlc:column>
                            </xqlc:row>
                    </xqlc:table>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn" id="selectTemplate_button" data-dismiss="modal"
				aria-hidden="true" onclick="getTemp();"><fmt:message key="ui.cms.ok"/>111</button>
			<button class="btn" id="cancel" data-dismiss="modal"
				aria-hidden="true"><fmt:message key="ui.cms.cancel"/></button>
		</div>
	</div>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseAdCategoryPage.jsp" />
