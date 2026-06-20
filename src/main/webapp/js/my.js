var TablePage = {
    activeRow: null,
    activeColumns: null
};

function buildUrl(baseUrl, params) {
    var query = [];
    params = params || {};

    Object.keys(params).forEach(function (key) {
        var value = params[key];
        if (value !== undefined && value !== null) {
            query.push(encodeURIComponent(key) + "=" + encodeURIComponent(value));
        }
    });

    return query.length ? baseUrl + "?" + query.join("&") : baseUrl;
}

function createListState(baseUrl, pageSize, defaults) {
    return {
        baseUrl: baseUrl,
        page: 1,
        pageSize: pageSize || 10,
        params: defaults || {}
    };
}

function tableParams(state) {
    var params = {};
    Object.keys(state.params || {}).forEach(function (key) {
        params[key] = state.params[key];
    });
    params.startPage = state.page;
    params.offset = state.pageSize;
    return params;
}

function displayValue(value) {
    if (value === null || value === undefined || value === "null") {
        return "";
    }
    return value;
}

function loadTable(state, columns, options) {
    options = options || {};
    var url = buildUrl(state.baseUrl, tableParams(state));

    getJson(url, function (data) {
        var successful = data && data.head && data.head.successful;
        var rows = successful ? (data.body || []) : [];
        var count = successful ? (data.head.count || 0) : 0;

        renderTable(rows, columns, options);
        drawPageBar(count, state, columns, options);
        setEmptyState(rows.length === 0, options.emptyText);
        resetEditState();

        if (typeof options.afterLoad === "function") {
            options.afterLoad(rows, data);
        }
    });
}

function renderTable(rows, columns, options) {
    options = options || {};
    var tbody = document.querySelector("#table tbody");
    tbody.innerHTML = "";

    rows.forEach(function (row) {
        var tr = document.createElement("tr");
        $(tr).data("row", row);

        if (options.selectable !== false) {
            var selectCell = document.createElement("td");
            var checkbox = document.createElement("input");
            checkbox.type = "checkbox";
            checkbox.name = "selectOne";
            checkbox.value = row.no;
            selectCell.appendChild(checkbox);
            tr.appendChild(selectCell);
        }

        columns.forEach(function (column) {
            var td = document.createElement("td");
            td.setAttribute("data-key", column.key);
            td.textContent = displayValue(row[column.key]);
            tr.appendChild(td);
        });

        tbody.appendChild(tr);
    });
}

function setEmptyState(isEmpty, text) {
    var empty = document.getElementById("emptyState");
    if (!empty) {
        return;
    }
    empty.textContent = text || "No records found.";
    empty.style.display = isEmpty ? "block" : "none";
}

function drawPageBar(count, state, columns, options) {
    var pageBar = document.querySelector(".pageBar");
    if (!pageBar) {
        return;
    }

    var maxPage = Math.max(1, Math.ceil((count || 0) / state.pageSize));
    pageBar.innerHTML = "";

    function appendButton(label, page, disabled, active) {
        var li = document.createElement("li");
        li.className = active ? "page-item-active" : "page-item";
        if (disabled) {
            li.className += " disabled";
        }
        li.setAttribute("data-page", page);
        li.textContent = label;
        pageBar.appendChild(li);
    }

    appendButton("Previous", Math.max(1, state.page - 1), state.page <= 1, false);
    for (var i = 1; i <= maxPage; i++) {
        appendButton(i, i, false, i === Number(state.page));
    }
    appendButton("Next", Math.min(maxPage, state.page + 1), state.page >= maxPage, false);

    $(pageBar).off("click").on("click", "li", function () {
        if ($(this).hasClass("disabled") || $(this).hasClass("page-item-active")) {
            return;
        }
        state.page = Number($(this).attr("data-page"));
        loadTable(state, columns, options);
    });
}

function bindTableEditing(columns) {
    $("#table tbody").off("dblclick").on("dblclick", "tr", function () {
        beginRowEdit(this, columns);
    });
}

function beginRowEdit(row, columns) {
    if (TablePage.activeRow && TablePage.activeRow !== row) {
        cancelUpdate();
    }

    TablePage.activeRow = row;
    TablePage.activeColumns = columns;
    row.classList.add("editing");

    columns.forEach(function (column) {
        if (!column.editable) {
            return;
        }

        var cell = row.querySelector("td[data-key='" + column.key + "']");
        if (!cell || cell.querySelector("input")) {
            return;
        }

        var input = document.createElement("input");
        input.type = column.inputType || "text";
        input.value = cell.textContent;
        input.setAttribute("data-edit-key", column.key);
        cell.textContent = "";
        cell.appendChild(input);
    });

    $(".save, .cancel").prop("disabled", false).show();
}

function getEditedRowData() {
    if (!TablePage.activeRow) {
        return null;
    }

    var original = $.extend({}, $(TablePage.activeRow).data("row"));
    $(TablePage.activeRow).find("[data-edit-key]").each(function () {
        original[$(this).attr("data-edit-key")] = $(this).val();
    });
    return original;
}

function resetEditState() {
    TablePage.activeRow = null;
    TablePage.activeColumns = null;
    $(".save, .cancel").prop("disabled", true).hide();
}

function cancelUpdate() {
    if (!TablePage.activeRow) {
        resetEditState();
        return;
    }

    var rowData = $(TablePage.activeRow).data("row");
    (TablePage.activeColumns || []).forEach(function (column) {
        if (!column.editable) {
            return;
        }
        var cell = TablePage.activeRow.querySelector("td[data-key='" + column.key + "']");
        if (cell) {
            cell.textContent = displayValue(rowData[column.key]);
        }
    });

    TablePage.activeRow.classList.remove("editing");
    resetEditState();
}

function getSelectedCheckbox(checkboxList) {
    var rows = [];
    for (var i = 0; i < checkboxList.length; i++) {
        if (checkboxList[i].checked) {
            rows.push({ no: parseInt(checkboxList[i].value, 10) });
        }
    }
    return rows;
}

function getSelectedRadio(radioList) {
    for (var i = 0; i < radioList.length; i++) {
        if (radioList[i].checked) {
            return radioList[i].value;
        }
    }
    return "";
}

function getSelectedOption(optionList) {
    return optionList.options[optionList.selectedIndex].value;
}

function selectAll() {
    var selectAllBox = document.getElementById("selectAll");
    var checkboxes = document.getElementsByName("selectOne");
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = selectAllBox.checked;
    }
}

function openPopBox() {
    $(".light, .fade").show();
}

function closePopBox() {
    $(".light, .fade").hide();
}

function clearForm(selector) {
    $(selector).find("input, textarea").val("");
    $(selector).find("select").prop("selectedIndex", 0);
}

function formData(selector) {
    var data = {};
    $(selector).find("[data-field]").each(function () {
        data[$(this).attr("data-field")] = $(this).val();
    });
    return data;
}

function requireSelection(rows, label) {
    if (!rows.length) {
        alert("Please select at least one " + label + ".");
        return false;
    }
    return true;
}
