/**
 * Title   : iframe高度自动调整，适应各个浏览器（IE、Firefox、Chrome等）.需要注意的是在chrome下测试时必须在web容器中测试
 * Author  : 铁木箱子
 * Site    : http://www.mzone.cc
 * Date    : 2010-10-14
 * Version : 0.1
 */

/**
 * Desc   : 创建mzone.cc.iframe对象
 */
mzone.createObject("mzone.cc.iframe");

/**
 * Desc   : 定义对象mzone.cc.iframe的静态方法实现iframe动态调整
 * Para   : iframe - 要调整的iframe对象，DOM对象
 *          extHeight - 自动计算iframe的高度后额外增加的高度值，数字型
 *          minHeight - iframe的最小高度，数字型
 * Return : 没有返回值
 */
mzone.cc.iframe.autoHeight = function(/*object*/iframe, /*int*/extHeight, /*int*/minHeight) {
	iframe.style.display = "block";
	if (iframe.contentDocument && iframe.contentDocument.body.offsetHeight) { // ff,chrome等
		var h = parseInt(iframe.contentDocument.body.offsetHeight) + 50;
		h += extHeight;
		if (h < minHeight) h = minHeight;
		iframe.height = h + "px";
	} else if (iframe.Document && iframe.Document.body.scrollHeight) { // IE
		var h = parseInt(iframe.Document.body.scrollHeight) + 35;
		h += extHeight;
		if (h < minHeight) h = minHeight;
		iframe.height = h + "px";
	} else {
		var h = parseInt(iframe.contentWindow.document.documentElement.scrollHeight) + 35;
		h += extHeight;
		if (h < minHeight) h = minHeight;
		iframe.height = h + "px";
	}
}