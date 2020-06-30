function getRequest(getRequestParam) {

    $.ajax({
        url: getRequestParam.url(),
        type: "get",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (data) {
            if (data.head.successful == false) {
                alert("啥都没有,或许你该回去看看你马几点死");
            } else {
                drawTable(data.body);
                drawPageBar(data.head.count, getRequestParam.startPage, getRequestParam.offset);
            }
        },
        erorr: function () {
            alert("傻逼");
        }
    });
}

function postRequest(url, data, success) {
    $.ajax({
        url: url,
        type: "post",
        data: JSON.stringify(data),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (data) {
            alert(data.message);
            if (data.flag == true) {
                success();
            } else {}
        },
        erorr: function () {
            alert("傻逼");
        }
    });
}

function putRequest(url, data, success) {
    $.ajax({
        url: url,
        type: "put",
        data: JSON.stringify(data),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (data) {
            alert(data.message);
            if (data.type == true) {
                success();
            } else {}
        },
        erorr: function () {
            alert("傻逼");
        }
    });
}

function deleteRequest(url, data, success) {
    $.ajax({
        url: url,
        type: "delete",
        data: JSON.stringify(data),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (data) {
            alert(data.message);
            if (data.type == true) {
                success();
            } else {}
        },
        erorr: function () {
            alert("傻逼");
        }
    });
}