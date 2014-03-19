<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.xqlc-cms.com/cms"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%--
<table width="960" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="99" height="100" align="center" valign="middle"><img src="${ctx}/static/zhsjdjmh/images/logo.jpg" width="65" height="64" /></td>
        <td width="861" align="center" valign="middle"><table width="100%" border="0" cellpadding="0" cellspacing="">
            <tr>
                <td class="text_biaoti">芝华数据宏观经济</td>
            </tr>
            <tr>
                <td height="20">&nbsp;</td>
            </tr>
        </table></td>
    </tr>
</table>
<table width="960" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="48" class="bg_menu"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                &lt;%&ndash;<td width="95" align="center" valign="middle" class="text_blue">&ndash;%&gt;
                    &lt;%&ndash;<a href="${ctx}/template/zhsjhgjjmh/index.jsp">首页</a>&ndash;%&gt;
                &lt;%&ndash;</td>&ndash;%&gt;
                &lt;%&ndash;<td width="95" align="center" valign="middle" class="text_blue">&ndash;%&gt;
                    &lt;%&ndash;<a href="${ctx}/template/zhsjhgjjmh/group.jsp?categoryId=1201308261531210009">宏观政策</a>&ndash;%&gt;
                &lt;%&ndash;</td>&ndash;%&gt;
                &lt;%&ndash;<td width="95" align="center" valign="middle" class="text_blue">&ndash;%&gt;
                    &lt;%&ndash;<a href="${ctx}/template/zhsjhgjjmh/group.jsp?categoryId=1201308261522230005">芝华短讯</a>&ndash;%&gt;
                &lt;%&ndash;</td>&ndash;%&gt;
                &lt;%&ndash;<td width="95" align="center" valign="middle" class="text_blue">&ndash;%&gt;
                    &lt;%&ndash;<a href="${ctx}/template/zhsjhgjjmh/group.jsp?categoryId=1201308261529180007">国内新闻</a>&ndash;%&gt;
                &lt;%&ndash;</td>&ndash;%&gt;
                &lt;%&ndash;<td width="95" align="center" valign="middle" class="text_blue">&ndash;%&gt;
                    &lt;%&ndash;<a href="${ctx}/template/zhsjhgjjmh/group.jsp?categoryId=1201308261530080008">国外新闻</a>&ndash;%&gt;
                &lt;%&ndash;</td>&ndash;%&gt;
                &lt;%&ndash;<td width="95" align="center" valign="middle" class="text_blue">&ndash;%&gt;
                    &lt;%&ndash;<a href="${ctx}/template/zhsjhgjjmh/group.jsp?categoryId=1201308261533360011">专题报告</a>&ndash;%&gt;
                &lt;%&ndash;</td>&ndash;%&gt;
                &lt;%&ndash;<td width="95" align="center" valign="middle" class="text_blue">&ndash;%&gt;
                    &lt;%&ndash;<a href="http://192.168.1.35:8080/chinaData/forum/bbsClass/list?siteId=16f0c3f7-4099-4be9-ab30-4ee12ddd8a64">论坛</a>&ndash;%&gt;
                &lt;%&ndash;</td>&ndash;%&gt;
                <cms:topMenu channelId="1201308261506190001" width="110" height="48" align="center" valign="middle" cssClass="text_blue" actClass="menu_on" />
                <td width="271" align="right"><label for="textfield3"></label>
                    <input name="textfield3" type="text" id="textfield3" value="输入您要查询的内容" /></td>
                <td width="119"><input type="submit" name="button" id="button" value="查询" /></td>
            </tr>
        </table></td>
    </tr>
</table>
<table width="960" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="205" bgcolor="#FFFFFF"><img src="${ctx}/static/zhsjhgjjmh/images/flash.jpg" width="960" height="205" /></td>
    </tr>
</table>--%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e8e9eb">
    <tr>
        <td>
            <table width="1004" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="99" height="100" align="center" valign="middle"><img src="${ctx}/static/zhsjhgjjmh/images/logo.jpg" width="65" height="64" /></td>
                    <td width="861" align="center" valign="middle">
                        <table width="100%" border="0" cellpadding="0" cellspacing="">
                            <tr>
                                <td width="39%" class="text_biaoti">芝华数据宏观经济</td>
                                <td width="61%" class="text_biaoti">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="89%" align="right">
                                                <label for="textfield"></label>
                                                <input name="textfield" type="text" id="textfield" style="height:30px;" value="输入您想查找的信息" size="40" />
                                            </td>
                                            <td width="11%" align="left"><img src="${ctx}/static/zhsjhgjjmh/images/ssss.jpg" width="35" height="35" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="20" class="www">&nbsp;&nbsp; maroeconomics.china-data.com</td>
                                <td>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr class="bottomline">
                                            <td width="25%" align="center" valign="middle">
                                                <a href="${ctx}/template/zhsjdjmh/index.jsp" target="_blank" class="blue">芝华数据蛋鸡数据</a>&nbsp;
                                            </td>
                                            <td width="25%" align="center" valign="middle">
                                                <a href="${ctx}/template/zhsjhgjjmh/index.jsp" target="_blank" class="blue">芝华数据宏观经济</a>&nbsp;
                                            </td>
                                            <td width="25%" align="center" valign="middle">
                                                <a href="${ctx}/template/zhsjszmh/index.jsp" target="_blank" class="blue">芝华数据生猪数据</a>&nbsp;
                                            </td>
                                            <td width="25%" align="center" valign="middle">
                                                <a href="${ctx}/template/zhsjslmh/index.jsp" target="_blank" class="blue">芝华数据饲料数据</a>&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="menu_bg">
    <tr>
        <td height="50" align="center">
            <table width="1004" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <cms:topMenu channelId="1201308261506190001" width="99" align="center" valign="middle" onmouseover="this.className='menu_show_onclick'" onmouseout="this.className='menu_show'" actClass="menu_show" cssClass="menu_show" picHeight="50" picWidth="2" picPath="/static/zhsjdjmh/images/menu_linen.jpg"></cms:topMenu>
                </tr>
            </table>
        </td>
    </tr>
</table>