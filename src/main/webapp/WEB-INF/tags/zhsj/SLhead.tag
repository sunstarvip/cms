<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.xqlc-cms.com/cms"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e8e9eb">
    <tr>
        <td>
            <table width="1004" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="457" height="100" align="left" valign="middle">
                      <img src="${ctx }/static/zhsjslmh/images/logo_sl.jpg" width="445" height="82" />
                    </td>
                    <td width="547" align="center" valign="middle">
                      <table width="100%" border="0" cellpadding="0" cellspacing="">
                        <tr>
                          <td width="61%" class="text_biaoti">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td width="89%" align="right"><label for="textfield"></label>
                                 <input name="textfield" type="text" id="textfield" style="height:30px;" value="输入您想查找的信息" size="40" /></td>
                                <td width="11%" align="left"><img src="${ctx }/static/zhsjslmh/images/ssss.jpg" width="35" height="35" /></td>
                              </tr>
                           </table>
                          </td>
                        </tr>
                        <tr>
                          <td height="20">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                              <tr class="bottomline">
                                <td width="25%" height="28" align="center" valign="middle"><a href="${ctx}/template/zhsjdjmh/index.jsp" target="_blank" class="blue">芝华数据蛋鸡数据</a>&nbsp;</td>
                                <td width="25%" align="center" valign="middle"><a href="${ctx}/template/zhsjhgjjmh/index.jsp" target="_blank" class="blue">芝华数据宏观经济</a>&nbsp;</td>
                                <td width="25%" align="center" valign="middle"><a href="${ctx}/template/zhsjszmh/index.jsp" target="_blank" class="blue">芝华数据生猪数据</a>&nbsp;</td>
                                <td width="25%" align="center" valign="middle"><a href="${ctx}/template/zhsjslmh/index.jsp" target="_blank" class="blue">芝华数据饲料数据</a>&nbsp;</td>
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
        </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="menu_bg">
    <tr>
        <td height="50" align="center">
            <table width="1004" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <cms:topMenu channelId="1201308261514470004" width="99" align="center" valign="middle" onmouseover="this.className='menu_show_onclick'" onmouseout="this.className='menu_show'" actClass="menu_show" cssClass="menu_show" picHeight="50" picWidth="2" picPath="/static/zhsjdjmh/images/menu_linen.jpg"></cms:topMenu>
                </tr>
            </table>
        </td>
    </tr>
</table>