var sysConfig = {
    serviceUrl: "http://open.joybom.com/"
};

function alert(msg) {
    $("div.alert").remove();
    var cover = $("<div>").appendTo("body").addClass("alert");
    var div = $("<div>").appendTo(cover);
    var ul = $("<ul>").appendTo(div);
    $("<h1>").appendTo($("<li>").appendTo(ul).addClass("alert_tit")).text("提示");
    $("<li>").appendTo(ul).text(msg);
    var tools = $("<li>").appendTo(ul).addClass("confirm");
    $("<a>").appendTo(tools).prop("href", "javascript:void(0)").text("确定").click(function () {
        cover.remove();
    });
}

function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}

function IsLogin(){
    if ((location.href.indexOf("login.html")==-1)&&(localStorage.UserInfo == undefined || localStorage.UserInfo == null))
    {
        location.href = "../login.html";
        return;
    }
}

function loading() {
    closeloading();
    var load = $("<div>").appendTo("body").addClass("load_box").click(function () {
        $(this).remove();
    });
    $("<div>").appendTo($("<div>").appendTo(load).addClass("loading")).addClass("load");
    $("<h1>").appendTo(load).addClass("load_tit").text("数据加载中...");
}

function closeloading() {
    $(".load_box").remove();
}

$(function () {
    var docEl = $("html");
    resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize';
    recalc = function () {
        var clientWidth = $(window).width();
        if (!clientWidth) return;
        if (clientWidth >= 320) {
            docEl.css("font-size", '20px');
        } else {
            docEl.css("font-size", 20 * (clientWidth / 320) + 'px');
        }
    };

    if (!document.addEventListener) return;
    window.addEventListener(resizeEvt, recalc, false);
    recalc();
    // document.addEventListener('DOMContentLoaded', recalc, false);
});
