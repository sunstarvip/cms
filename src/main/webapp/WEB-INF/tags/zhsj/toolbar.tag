<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ attribute name="title" required="true"%>

<div class="navbar navbar-fixed-top" style="margin: -1px -1px 0;">
	<div class="navbar-inner">
		<div class="container" style="width: auto; padding: 0 20px;">
			<a class="brand" href="#">${title}</a>
			<jsp:doBody />
		</div>
	</div>
</div>