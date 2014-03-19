var leftNavTree_ztree;
$(function () {
    var leftNavTree_settings = {
        view: {
            showLine: false,
            showIcon: false,
            addDiyDom: function (treeId, treeNode) {
                var spaceWidth = 5;
                var switchObj = $("#" + treeNode.tId + "_switch"),
                    icoObj = $("#" + treeNode.tId + "_ico");
                switchObj.remove();
                icoObj.before(switchObj);
                if (treeNode.level > 1) {
                    var spaceStr = "<span style='display: inline-block; width: " + (spaceWidth * treeNode.level) + "px'></span>";
                    switchObj.before(spaceStr);
                }
            },
            'empty': 'empty'
        },

        callback: {
            onClick: nodeClick,
            beforeClick: beforeClick,
            'empty': 'empty'
        }
    };
    var leftNavTree_zNode = [
        {
            "id": "root",
            "name": "UI标准组件库",
            "isParent": null,
            "link": "",
            "entity": {
                "id": "root",
                "createTime": null,
                "zh": null,
                "sort": null,
                "updateTime": null,
                "description": null,
                "name": "UI标准组件库",
                "permission": 1,
                "en": null
            },
            "children": [
                {
                    "id": "base",
                    "name": "基本UI元素",
                    "isParent": null,
                    "link": "base-UIElements.html",
                    "entity": {
                        "id": "base",
                        "createTime": null,
                        "zh": null,
                        "sort": null,
                        "updateTime": null,
                        "description": null,
                        "name": "基本UI元素",
                        "permission": 1,
                        "en": null
                    },
                    "children": [
                        {
                            "id": "base-UIElements",
                            "name": "基础布局容器样式",
                            "isParent": null,
                            "link": "base-UIElements.html",
                            "entity": {
                                "id": "base-UIElements",
                                "createTime": null,
                                "zh": null,
                                "sort": null,
                                "updateTime": null,
                                "description": null,
                                "name": "内容块头部样式",
                                "permission": 1,
                                "en": null
                            },
                            "children": [

                            ]
                        },
                        {
                            "id": "base-block",
                            "name": "内容块样式",
                            "isParent": null,
                            "link": "base-block.html",
                            "entity": {
                                "id": "base-block",
                                "createTime": null,
                                "zh": null,
                                "sort": null,
                                "updateTime": null,
                                "description": null,
                                "name": "内容块样式",
                                "permission": 1,
                                "en": null
                            },
                            "children": [

                            ]
                        }
                    ]
                },
                {
                    "id": "form",
                    "name": "表单",
                    "isParent": null,
                    "link": "Asingle.html",
                    "entity": {
                        "id": "form",
                        "createTime": null,
                        "zh": null,
                        "sort": null,
                        "updateTime": null,
                        "description": null,
                        "name": "表单",
                        "permission": 1,
                        "en": null
                    },
                    "children": [
                        {
                            "id": "form",
                            "name": "单列表单",
                            "isParent": null,
                            "link": "Asingle.html",
                            "entity": {
                                "id": "单列表单",
                                "createTime": null,
                                "zh": null,
                                "sort": null,
                                "updateTime": null,
                                "description": null,
                                "name": "单列表单",
                                "permission": 1,
                                "en": null
                            },
                            "children": [

                            ]
                        },
                        {
                            "id": "dbform",
                            "name": "双列表单",
                            "isParent": null,
                            "link": "Doublerowform.html",
                            "entity": {
                                "id": "dbform",
                                "createTime": null,
                                "zh": null,
                                "sort": null,
                                "updateTime": null,
                                "description": null,
                                "name": "双列表单",
                                "permission": 1,
                                "en": null
                            },
                            "children": [

                            ]
                        }
                    ]
                }
            ]
        },
    ];
    leftNavTree_ztree = $.fn.zTree.init($('#' + 'leftNavTree'), leftNavTree_settings, leftNavTree_zNode);


    var leftNavTree_checkNodes = eval('null');
    if (leftNavTree_checkNodes != null && leftNavTree_checkNodes.length > 0) {
        for (var i = 0, checkNodes = leftNavTree_checkNodes; i < checkNodes.length; i++) {
            leftNavTree_ztree.checkNode(leftNavTree_ztree.getNodeByParam('id', checkNodes[i].id), true, true);
        }
        ;
    }

    leftNavTree_ztree.selectNode(leftNavTree_ztree.getNodeByParam('id', 'd7ab25a5-549a-453e-904d-b266b8e05c84', null));
});

function beforeClick(treeId, treeNode) {
    if (treeNode.level == 0) {
        var zTree = $.fn.zTree.getZTreeObj('leftNavTree');
        zTree.expandNode(treeNode);
        return false;
    }
    return true;
}
function nodeClick(event, treeId, treeNode) {
    window.location = treeNode.link;
}
$(function () {
    $("#leftNavTree").hover(function () {
        if (!$("#leftNavTree").hasClass("showIcon")) {
            $("#leftNavTree").addClass("showIcon");
        }
    }, function () {
        $("#leftNavTree").removeClass("showIcon");
    })
})

