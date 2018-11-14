/**
 * 打开弹出框
 */
function openDialog(div, title, w, h) {
    if (w == null) {
        w = 600;
    }
    if (h == null) {
        h = 500;
    }

    $("#" + div).dialog({
        title: title,
        width: w,
        height: h,
        modal: true
    });
}

/**
 * 关闭弹出框
 */
function closeDialog(div) {
    $("#" + div).dialog("close");
}


/**
 * 创建树形结构
 */
function createZtree(divid, data, param, did) {
    //生成Ztree
    var setting = {
        data: {
            key: {
                name: param.name
            },
            simpleData: {
                enable: true,
                pIdKey: param.pid
            }
        },
        view: {
            showIcon: param.icon
        },
        callback: {
            onClick: param.onclick
        }, check: {
            enable: param.check != null ? param.check : false,
            chkboxType: param.checkType != null ? param.checkType : {"Y": "ps", "N": "ps"}
        }

    };
    var zNodes = data;

    //初始化zTree
    var ztreeObj = $.fn.zTree.init($("#" + divid), setting, zNodes);
    ztreeObj.expandAll(param.expand); // 全部展开

    // 若did不为空，则表示did所对应的树形节点高亮
    if (did != null) {
        var nodes = ztreeObj.getNodesByParam("id", did, null);
        ztreeObj.selectNode(nodes[0]);
    }
    return ztreeObj;
}
