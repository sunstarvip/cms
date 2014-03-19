<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ attribute name="id" required="true"%>
<%@ attribute name="title" fragment="true"%>
<%@ attribute name="content" fragment="true"%>
<%@ attribute name="footer" fragment="true"%>

<div id="${id}" class="modal hide fade" role="dialog" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h3 id="myModalLabel"><jsp:invoke fragment="title" /></h3>
	</div>
	<div class="modal-body">
		<jsp:invoke fragment="content" />
	</div>
	<div class="modal-footer">
		<jsp:invoke fragment="footer" />
	</div>
</div>