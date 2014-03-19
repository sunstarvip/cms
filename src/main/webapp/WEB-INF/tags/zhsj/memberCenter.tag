<%@ tag pageEncoding="UTF-8"%>
<%@tag import="java.lang.String"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="xqlc" uri="http://www.xqlc.com/xqlc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="zhsjtag" tagdir="/WEB-INF/tags/zhsj"%>

<%@ attribute name="type" type="String" required="true" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="locale" value="${pageContext.request.locale}" />

<c:if test="${(type=='index')||(type=='content')}">
    <table width="98%" border="0" class="hunline" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td width="2%" height="40" align="center" valign="middle"><img src="${ctx}/static/zhsj/images/img_blue.jpg" width="3" height="18" /></td>
            <td width="45%" class="text_black14B">我的订阅</td>
            <td width="53%" align="right">更多&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td height="157" colspan="3" align="center" valign="top" class="topline"><table width="98%" border="0" cellpadding="0" cellspacing="0" style="margin-top:4px;">
                <tr>
                    <td width="63%" align="center" valign="top"><table width="98%" border="0" cellpadding="0" cellspacing="0">
                        <c:forEach items="${focusContents}" var="content">
                            <tr >
                                <td class="rdline" width="5%" height="24" align="center" valign="middle"><img src="${ctx}/static/zhsj/images/ico_1.jpg" width="7" height="7" /></td>
                                <td class="rdline" width="95%" height="28" align="left"> <a href="${ctx}${content.templatePath}">${content}</a></td>
                            </tr>
                        </c:forEach>
                    </table></td>
                </tr>
            </table></td>
        </tr>
    </table>
</c:if>
<c:if test="${(type=='index')||(type=='forum')}">
    <table width="98%" border="0" class="hunline" cellpadding="0" bgcolor="#FFFFFF" cellspacing="0" style="margin-top:7px">
        <tr>
            <td width="2%" height="40" align="center" valign="middle">
                <img src="${ctx}/static/zhsj/images/img_blue.jpg" width="3" height="18" /></td>
            <td width="45%" class="text_black14B">我的论坛</td>
            <td width="53%" align="right">更多&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td height="157" colspan="3" align="center" valign="top" class="topline">
                <table width="98%" border="0" cellpadding="0" cellspacing="0" style="margin-top:4px;">
                    <tr>
                        <td width="63%" align="center" valign="top">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">

                                <tr >
                                    <td height="28" colspan="2" align="left" valign="middle" class="rdline">全部 贴子 回复</td>
                                </tr>

                                <c:forEach items="${MyMsgs}" var="msg">
                                    <tr>
                                        <td colspan="2" align="center" valign="top" class="line2_top">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="12%" align="center" valign="middle">
                                                        <img src="${ctx}/static/zhsj/images/ico_ren.jpg" alt="" width="57" height="63" />
                                                    </td>
                                                    <td width="88%">
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td height="30">王林 <span class="text_blue">发表的贴子</span></td>
                                                            </tr>
                                                            <tr>
                                                                <td height="30">《贴子名称》</td>
                                                            </tr>
                                                            <tr>
                                                                <td height="30">贴子的描述信息取100个字符 <span class="text_blue">查看全部 &gt;&gt;</span></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</c:if>
