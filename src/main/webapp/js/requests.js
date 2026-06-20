function responseMessage(data, fallback) {
    if (data && data.message) {
        return data.message;
    }
    return fallback || "Operation failed.";
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
                alert(responseMessage(response));
                return;
            }

            if (!requestOptions.quiet && response && response.message) {
                alert(response.message);
            }

            if (typeof success === "function") {
                success(response);
            }
        },
        error: function (xhr) {
            var message = "Request failed. Please check the server log.";
            if (xhr && xhr.responseJSON && xhr.responseJSON.message) {
                message = xhr.responseJSON.message;
            }
            alert(message);
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

function postRequest(url, data, success) {
    return apiRequest("post", url, data, success);
}

function putRequest(url, data, success) {
    return apiRequest("put", url, data, success);
}

function deleteRequest(url, data, success) {
    return apiRequest("delete", url, data, success);
}
