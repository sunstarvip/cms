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
			/* var type = ${adCategory.adCategoryType};
			alert("type");
			$('#typeSelect').val(type); */
			//保存广告位
    		$('#saveType_btn').on('click',function() {
    			$('#editForm')[0].method ="post";
                $('#editForm')[0].action = "${ctx}/cms/adCategory/saveAdCategory";
                $('#editForm').submit();
            }); 
		});
		/* $(function(){
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
		}); */
		
		 /* $(function(){
			 $('#editForm')[0].target = "_parent";
			$("#editForm")[0].method ="post";
			$("#editForm")[0].action = "${ctx}/cms/adCategory/saveAdCategory";
			$("#editForm").submit();
		});  */
	</script>

</xqlc:extends>

<xqlc:extends name="content">
			<div class="appcontent">
	            <h3>
	                <span><fmt:message key="ui.cms.edit" /></span>
	            </h3>
            </div>
		<form:form id="editForm" action="" method="post" modelAttribute="adCategory" cssClass="form-horizontal validation">
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
                   <li id = "table_tr_width_id">
                   <input type="hidden" value="" name="adCategorySize"/>
                   <!-- 宽度 -->
                   <span><fmt:message key="ui.cms.width" />:</span>
                   <div class="formright">
                    <form:input path="width" cssClass="{required:true,digits:true,messages:{required:' 请输入宽度'}}" /> px
                   </div>
                   </li>
                   <li id = "table_tr_height_id">
                   <!-- 高度 -->
                   <span><fmt:message key="ui.cms.height" />:</span>
                   <div class="formright">
                   <form:input path="height" cssClass="{required:true,digits:true,messages:{required:' 请输入高度'}}" />  px
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
                     <button id="saveType_btn" type="button" class="btn btn-small btn-success" >
							<fmt:message key="ui.base.save" />
						</button>
                   <a href="${ctx}/cms/adCategory/adCategoryList/${selectGroupId }"
						class="btn btn-small btn-warning">
						<fmt:message key="ui.base.cancel" /></a>
               </div>
             </div>
         </div>
			
			<%-- <div class="toolbar">
				<ul>
					<li>
						<button id="saveType_btn" type="button" class="btn btn-small btn-success" >
							<fmt:message key="ui.base.save" />
						</button>
					</li>
					<li><a href="${ctx}/cms/adCategory/adCategoryList/${selectGroupId }"
						class="btn btn-small btn-warning">
						<fmt:message key="ui.base.cancel" /></a>
				    </li>
				</ul>
						<div class="widget-content">
							<div class="control-group">
								<label class="control-label"><fmt:message key="ui.cms.isUse" /></label>
								<div class="controls">
									<form:radiobutton path="useCode" cssClass="{required:true,messages:{required:' '}}"
										value="yes" />
									<fmt:message key="ui.cms.yes" />
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<form:radiobutton path="useCode" cssClass="{required:true,messages:{required:' '}}" value="no" />
									<fmt:message key="ui.cms.no" />
								</div>
							</div>
						</div>
					</div>
		<div class="detailedinfo">
	        <table class="table">
	            <tbody>
	            <tr>
	                <td>
	                    <h5><fmt:message key="ui.cms.adPositionName" /></h5>
	                </td>
	                <td>
	                    <input type="text" name="name" id="name" value="${adCategory.name}" 
	                       class="{required:true,remote:'${ctx}/cms/adCategory/repeatName/${selectGroupId}
	                       <c:if test="${not empty adCategory.id }">/${adCategory.id }</c:if>', 
	                       messages:{required:'请输入名称 ',remote:'该广告位已存在,请重新输入!'}}"/>
	                        <input type="text" name="name" id="name" value="${adCategory.name}" class="{required:true}"/>
	                        <span id="checkName" style="display:none">
	                       <font color='red'>Please Change Name!</font>
	                       </span>
	                </td>
                </tr>
                <tr id = "table_tr_width_id">
                    <td>
                        <h5><fmt:message key="ui.cms.width" /></h5>
                        <input type="hidden" value="" name="adCategorySize"/>
                    </td>
                    <td>
                        <form:input path="width" cssClass="{required:true,digits:true,messages:{required:' 请输入宽度'}}" />
                    </td>
                </tr>
                <tr id = "table_tr_height_id">
                    <td>
                        <h5><fmt:message key="ui.cms.height" /></h5>
                    </td>
                    <td>
                        <form:input path="height" cssClass="{required:true,digits:true,messages:{required:' 请输入高度'}}" />
                    </td>
                </tr>
                 <tr>
                    <td>
                        <h5><fmt:message key="ui.cms.adCategoryType" /></h5>
                    </td>
                    <td>
                    	<input type = "text" name = "adCategoryType" value="${adCategory.adCategoryType }" />
                    	<form:select path="adCategoryType" id="typeSelect">
                    		<form:option value="${adCategory.adCategoryType }">${adCategory.adCategoryType }</form:option>
                    		<c:if test="${adCategory.adCategoryType == '固定广告位'}">
                    			<form:option value=""><fmt:message key="ui.cms.Carousel" /></form:option>
                    			<form:option value=""><fmt:message key="ui.cms.dangling" /></form:option>
                    		</c:if>
                    		<c:if test="${adCategory.adCategoryType == '轮播广告位'}">
                    			<form:option value=""><fmt:message key="ui.cms.fixadCategory" /></form:option>
                    			<form:option value=""><fmt:message key="ui.cms.dangling" /></form:option>
                    		</c:if>
                    		<c:if test="${adCategory.adCategoryType == '悬浮广告位'}">
                    			<form:option value=""><fmt:message key="ui.cms.fixadCategory" /></form:option>
                    			<form:option value=""><fmt:message key="ui.cms.Carousel" /></form:option>
                    		</c:if>
                    		<form:option value="">固定广告位</form:option>
                    		<form:option value="">轮播广告位</form:option>
                    		<form:option value="">悬浮广告位</form:option>
                    	</form:select>
                    	<select id="adCategoryType" name="adCategoryType" value = "${adCategory.adCategoryType }">
                    		<option><fmt:message key="ui.cms.pleaseChoose" /></option>
                    		<option><fmt:message key="ui.cms.fixadCategory" /></option>
                    		<option><fmt:message key="ui.cms.dangling" /></option>
                    		<option><fmt:message key="ui.cms.Carousel" /></option>
                    	</select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5><fmt:message key="ui.cms.isUse" /></h5>
                    </td>
                    <td>
                        <form:select path="useCode">
                        		<form:option cssClass="{required:true,messages:{required:' '}}" value="yes">
	                            	<fmt:message key="ui.base.yes"/>
	                        	</form:option>
                        		 <form:option cssClass="{required:true,messages:{required:' '}}" value="no">
	                            	<fmt:message key="ui.base.no"/>
	                       	 	</form:option>
                        </form:select>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>	 --%>
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
