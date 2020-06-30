function getSelectedCheckbox(checkboxList) {
    var selectOnes = checkboxList;
    var datas = [];
    for (var i = 0; i < selectOnes.length; i++) {
        if (selectOnes[i].checked) {
            var data = {};
            data.no = parseInt(selectOnes[i].value);
            datas.push(data);
        }
    }
    return datas;
}

function GetRequestParam(interface, startPage, offset, keyword, type) {
    this.interface = interface;
    this.startPage = startPage;
    this.offset = offset;
    this.keyword = keyword;
    this.type = type;

    this.url = function () {
        var keys = Object.keys(this);
        var max = keys.length - 2;
        var str = this[keys[0]] + "?";
        for (let i = 1; i < max; i++) {
            let value = this[keys[i]];
            if (value == undefined) continue;
            str += (keys[i] + "=" + value + "&");
        }
        if (this[keys[max]] != undefined) {
            str += (keys[max] + "=" + this[keys[max]]);
        } else {
            str = str.substring(0, str.length - 1);
        }
        return str;
    }
}

function getSelectedRadio(radioList) {
    var radio = "";
    for (var i = 0; i < radioList.length; i++) {
        if (radioList[i].checked) {
            radio = radioList[i].value;
            break;
        }
    }
    return radio;
}

function getSelectedOption(optionList) {
    var options = optionList;
    var selectedIndex = options.selectedIndex;
    var selectedOption = options[selectedIndex];
    return selectedOption.value;
}

function cancelUpdate() {
    var activeRow = document.getElementById("activeRow");

    var save = document.getElementsByClassName("save")[0];
    var cancel = document.getElementsByClassName("cancel")[0];

    save.style.display = "none";
    cancel.style.display = "none";

    var tds = activeRow.cells;

    for (var i = 2; i < tds.length; i++) {
        var input = tds[i].getElementsByTagName("input")[0];
        removeElement(input);
        var p = tds[i].getElementsByTagName("p")[0];
        p.style.display = "inline";
    }
    activeRow.removeAttribute("id");
}

function preUpdate() {

    var targetName = event.target.nodeName;

    var activeRow = document.getElementById("activeRow");

    if (activeRow == null) {

        var td;

        if (targetName == "P") {
            td = event.target.parentNode;
        } else if (targetName == "TD") {
            td = event.target;
        }

        var tr = td.parentNode;

        var save = document.getElementsByClassName("save")[0];
        var cancel = document.getElementsByClassName("cancel")[0];

        save.style.display = "inline";
        cancel.style.display = "inline";

        tr.setAttribute("id", "activeRow");

        var tds = tr.cells;

        for (var i = 2; i < tds.length; i++) {
            var cell = tds[i];

            var input = document.createElement("input");

            input.setAttribute("value", cell.textContent);
            input.setAttribute("type", "text");
            input.style.border = "none";
            input.style.color = "blue";

            var p = cell.getElementsByTagName("p")[0];

            p.style.display = "none";

            cell.appendChild(input);

        }
    }
}

function removeElement(_element) {

    var _parentElement = _element.parentNode;

    if (_parentElement) {
        _parentElement.removeChild(_element);
    }
}


function selectAll() {

    var selectAll = document.getElementById("selectAll");
    var selectOne = document.getElementsByName("selectOne");

    for (var i = 0; i < selectOne.length; i++) {

        selectOne[i].checked = selectAll.checked;

    }

}

function closePopBox() {

    //SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

    var light = document.getElementsByClassName("light")[0];
    var fade = document.getElementsByClassName("fade")[0];
    light.style.display = "none";
    fade.style.display = "none";
}

function openPopBox() {

    //SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

    var light = document.getElementsByClassName("light")[0];
    var fade = document.getElementsByClassName("fade")[0];
    light.style.display = "block";
    fade.style.display = "block";
}

function drawPageBar(count, startPage, offset) {

    var pageBar = document.getElementsByClassName("pageBar")[0];

    var lis = pageBar.children;

    var prePage = lis[0];

    var nextPage = lis[lis.length - 1];

    var maxPage = 1;

    for (let i = 1, max = lis.length - 1; i < max; i++) {
        removeElement(lis[1]);
    }

    if (count > offset) {
        var tmp = count % offset;
        if (tmp != 0) {
            maxPage = ((count - tmp) / offset) + 1;
        } else {
            maxPage = (count / offset);
        }
    }

    if (startPage == 1) {
        prePage.style.display = "none";
        if (maxPage == 1) {
            nextPage.style.display = "none";
        } else {
            nextPage.style.display = "";
        }
    } else if (startPage == maxPage) {
        prePage.style.display = "";
        nextPage.style.display = "none";
    } else {
        prePage.style.display = "";
        nextPage.style.display = "";
    }

    for (var i = 0; i < maxPage; i++) {
        var a = document.createElement("a");
        var li = document.createElement("li");
        if ((i + 1) == startPage) {
            li.setAttribute("class", "page-item-active");
        } else {
            li.setAttribute("class", "page-item");
        }

        a.textContent = i + 1;
        li.appendChild(a);
        pageBar.insertBefore(li, nextPage);
    }
}

function drawTable(list) {

    var table = document.getElementById("table");
    var tableRowsLength = table.rows.length - 1;

    for (var i = 0; i < tableRowsLength; i++) {
        table.deleteRow(1);
    }

    for (var i = 1; i <= list.length; i++) {
        var row = table.insertRow();
        var cell = row.insertCell();
        var data = list[i - 1];

        var input = document.createElement("input");
        input.setAttribute("name", "selectOne");
        input.setAttribute("type", "checkbox");
        input.setAttribute("value", data.no)

        cell.appendChild(input);

        for (var x in data) {
            var cell = row.insertCell();

            var p = document.createElement("p");

            var text = document.createTextNode(data[x]);

            p.appendChild(text);

            cell.appendChild(p);
        }
    }
    if (list.length != 0) {
        table.style.display = "";
    } else {
        table.style.display = "none";
    }
}

function bindPageBarEventListener(getRequestParam) {

    var pageBar = document.getElementsByClassName("pageBar")[0];

    pageBar.addEventListener("click", function (event) {
        var target = event.target;
        var type = target.nodeName;

        switch (type) {
            case "LI":
                var className = target.className;
                var text = target.children[0].textContent;
                break;
            case "A":
                var className = target.parentNode.className;
                var text = target.textContent;
                break;
        }
        switch (className) {
            default:
                getRequestParam.startPage = text;
                break;
            case "prevPage":
                getRequestParam.startPage -= 1;
                break;
            case "nextPage":
                getRequestParam.startPage += 1;
                break;
        }
        getRequest(getRequestParam);

    });

    pageBar.addEventListener("mouseover", function (event) {
        var target = event.target;

        var type = target.nodeName;

        switch (type) {
            case "LI":
                target.style.borderColor = "rgb(70, 144, 255)";
                break;
            case "A":
                var parent = target.parentNode;
                parent.style.borderColor = "rgb(70, 144, 255)";
                break;
        }

    });
    pageBar.addEventListener("mouseout", function (event) {
        var target = event.target;

        var type = target.nodeName;

        switch (type) {
            case "LI":
                target.style.borderColor = "gray";
                break;
        }
    });
}