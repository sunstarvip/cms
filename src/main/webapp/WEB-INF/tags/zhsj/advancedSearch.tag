<%@ tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ attribute name="id" required="true"%>
<%@ attribute name="template" required="true"%>
<%@ attribute name="form" required="true"%>
<%@ attribute name="input" required="true"%>
<%@ attribute name="width" required="false"%>

<div class="buttons input-append pull-right">
	<jsp:doBody />
	<div class="btn-group">
		<button type="button" class="btn btn-mini" id="${id}_btn_advanced">
			<fmt:message key="ui.cms.advancedSearch" />
		</button>
		<button type="button" id="${id}_btn_search"
			class="btn btn-mini btn-primary">
			<fmt:message key="ui.cms.search" />
		</button>
	</div>
</div>
<script type="text/javascript">
    $(function() {
        $('#' + '${template}').hide();
        $('#' + '${id}_btn_advanced').tablepopover({
            placement: function(tip) {
                $(tip).attr('left_bottom', true)
                return 'bottom'
            },
            html: true,
            content: function() {
                return '<form id="${id}_layout_form" class="form-horizontal">' + $('#${template}').html() + '</form>'
            },
            <c:choose>
                <c:when test="${not empty width}">width: ${width},</c:when>
                <c:otherwise>width: 400,</c:otherwise>
            </c:choose>
            title: '<fmt:message key="ui.cms.advancedSearch" />'

        });
        $('#' + '${id}_btn_search').click(function() {
            if ($('#' + '${id}_layout_form').length) {
                $('#' + '${id}_layout_form').find('[data-id]').each(function() {
                    var id = $(this).attr('data-id');
                    var value = $(this).val();
                    $('#' + id).val(value)
                })
            } else {
                var id = $('#' + '${input}').attr('data-id')
                var value = $('#' + '${input}').val()
                $('#' + id).val(value)
            }
            $('#' + '${form}').submit();
        });
    });
</script>