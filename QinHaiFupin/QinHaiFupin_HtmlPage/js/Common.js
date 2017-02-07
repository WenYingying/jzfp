//接口地址
var ServiceUrl = "http://open.joybom.com/";
var ServiceUrl = "http://localhost:11464/";
var UserList = {};
// Extend the default Number object with a formatMoney() method:
// usage: someVar.formatMoney(decimalPlaces, symbol, thousandsSeparator, decimalSeparator)
// defaults: (2, "$", ",", ".")
Number.prototype.formatMoney = function (places, symbol, thousand, decimal) {
    places = !isNaN(places = Math.abs(places)) ? places : 2;
    symbol = symbol !== undefined ? symbol : "$";
    thousand = thousand || ",";
    decimal = decimal || ".";
    var number = this,
        negative = number < 0 ? "-" : "",
        i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
        j = (j = i.length) > 3 ? j % 3 : 0;
    return symbol + negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");
};
$(document).ready(function () {

    var str = localStorage.getItem("qhfp_user");
    if (str != "" && str != null && str != undefined && str != "null") {
        UserList = str = JSON.parse(str);
        var d = new Date(str.LoginTime);
        d.setDate(d.getDate() + 1);
        var nowdate = new Date();
        if (window.location.pathname.indexOf("login.html") > -1) {
            if (d < nowdate) {
                return;
            }
            else {
                window.location.href = "../Index.html";
            }
        }
        else {
            if (window.location.pathname.indexOf("login.html") > -1) {
                return;
            }
            else {
                if (d < nowdate) {
                    window.location.href = "../login.html";
                }
                else
                {
                    $.post(ServiceUrl + "UserInterface/PostJournalHandler.ashx", { UserId: UserList.ID, PageName: window.location.pathname }, function (data) { });
                }
            }
        }

    }
    else {
        if (window.location.pathname.indexOf("login.html") > -1) {
            return;
        }
        else {
            window.location.href = "../login.html";
        }
    }

});
function getCookie(name) {
    var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
    if (arr != null)
        return unescape(arr[2]);
    return null;
}
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}
function checklength(str) {
    if (str.toString().length < 2) {
        return "0" + str;
    }
    else {
        return str;
    }
}


function PaiXu(data) {
    var returndata = [];
    var temp = {};
    for (var i = 0; i < data.length; i++) {
        for (var j = i + 1 ; j < data.length ; j++) {
            var beforeage = parseInt(new Date().getFullYear()) - parseInt(data[i].IdCardNo.substr(6, 4));
            var afterage = parseInt(new Date().getFullYear()) - parseInt(data[j].IdCardNo.substr(6, 4));
            if (afterage > beforeage) {
                temp = data[i];
                data[i] = data[j];
                data[j] = temp;
            }
        }
    }
    $(data).each(function () {
        if (this.HouseholderRelation == "本人或户主") {
            returndata.push(this);
        }
    });
    $(data).each(function () {
        if (this.HouseholderRelation != "本人或户主") {
            returndata.push(this);
        }

    });
    return returndata;
}




