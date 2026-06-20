function responseMessage(data, fallback) {
    if (data && data.message) {
        return data.message;
    }
    return fallback || (window.I18N && window.I18N.requestFailed) || "Request failed.";
}

function showMessage(message, type) {
    notifyApp(message, type);
}

function apiRequest(method, url, data, success, options) {
    var requestOptions = options || {};
    var ajaxOptions = {
        url: url,
        type: method,
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (response) {
            if (response && response.flag === false) {
                showMessage(responseMessage(response), "error");
                if (typeof requestOptions.onFail === "function") {
                    requestOptions.onFail(response);
                }
                return;
            }

            if (!requestOptions.quiet && response && response.message) {
                showMessage(response.message, "success");
            }

            if (typeof success === "function") {
                success(response);
            }
        },
        error: function (xhr) {
            var message = (window.I18N && window.I18N.requestFailed) || "Request failed.";
            if (xhr && xhr.responseJSON && xhr.responseJSON.message) {
                message = xhr.responseJSON.message;
            }
            if (xhr && xhr.status) {
                message = xhr.status + " " + (xhr.statusText || "") + "\n" + message;
            }
            showMessage(message, "error");
            if (typeof requestOptions.onError === "function") {
                requestOptions.onError(xhr);
            }
        }
    };

    if (data !== undefined && data !== null && method !== "get") {
        ajaxOptions.data = JSON.stringify(data);
    }

    return $.ajax(ajaxOptions);
}

function getJson(url, success) {
    return apiRequest("get", url, null, success, { quiet: true });
}

function postRequest(url, data, success, options) {
    return apiRequest("post", url, data, success, options);
}

function putRequest(url, data, success) {
    return apiRequest("put", url, data, success);
}

function deleteRequest(url, data, success) {
    return apiRequest("delete", url, data, success);
}
