<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<xqlc:extends name="content">
    <form:form id="editForm" action="${ctx}/cms/lssued/save" modelAttribute="lssued" cssClass="form-horizontal validation">
        <form:hidden path="id"/>
        <div class="appcontent">
	        <h3>
	            <span><fmt:message key="ui.base.edit"/></span>
	        </h3>
	    </div>
	    <div class="toolbar">
	        <ul>
	            <li class="btn-group">
	                <button type="submit" class="btn btn-small btn-primary">
                        <fmt:message key="ui.cms.save"/>
                    </button>
	                <button type="button" class="btn btn-small btn-warning btn-cancel">
                        <fmt:message key="ui.cms.cancel"/>
                    </button>
	            </li>
	        </ul>
	    </div>
        <div class="row-fluid">
            <div class=" span12">
                <div class="row-fluid">
			            <fmt:message key="ui.cms.lssuedMessage"/>
			    </div>
                <div class="widget-box">
                    <div class="widget-title">
                        <span class="icon"><i class="icon-th"></i></span>
                        <h5><fmt:message key="ui.cms.edit"/></h5>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><fmt:message key="ui.cms.category"/></label>
                        <div class="controls">
                            <select id="category" name="category_id" onchange="findTitle()">
                                <c:forEach items="${categoryInfo}" var="category">
                                <option value="${category.id}">${category.name}</option>
                                </c:forEach>
                            </select>
                            
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><fmt:message key="ui.cms.type"/></label>
                        <div class="controls">
                            <select name="type" id="type" onchange="findTitle()">  
                                <option value="0"><fmt:message key="ui.cms.normalNews"/></option> 
                                <option value="1"><fmt:message key="ui.cms.linkNews"/></option>
                                <option value="2"><fmt:message key="ui.cms.pictureNews"/></option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
    
    <xqlc:extends name="javascript">
        <xqlc:importjs src="plugins/jquery.metadata, plugins/jquery.validate, plugins/messages_cn" />
        <script type="text/javascript">
        $(function() {
            $('#category').val('${content.category.id}');
        });
        </script>
        <script type="text/javascript">
        $(function() {
            $('#type').val('${content.type}');
        });
        </script>
    </xqlc:extends>
</xqlc:extends>

<jsp:include page="/WEB-INF/views/cms/base/baseLssuedPage.jsp" />
