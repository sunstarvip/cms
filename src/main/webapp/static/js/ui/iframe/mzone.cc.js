/**
 * Title   : 基于命名空间的js对象创建
 * Author  : 铁木箱子
 * Site    : http://www.mzone.cc
 * Date    : 2010-10-14
 * Version : 0.1
 */

function mzone(){};

/**
 * Desc   : 使用给定的对象路径进行对象的创建
 * Para   : objPath - 对象路径，字符串类型，格式为：xx.yy.zz
 * Return : 没有返回值,创建成功后直接使用对象路径即可
 */
mzone.createObject = function(/*string*/objPath) {
	if (!objPath || typeof(objPath) != 'string') return;
	var root = window;
	var parts = objPath.split('.');
	for (var i = 0; i < parts.length; i ++) {
		if (typeof(root[parts[i]]) == 'undefined') root[parts[i]] = {};
		root = root[parts[i]];
	}
};