//接口地址
var ServiceUrl = "http://101.201.113.251:8080/";
//var ServiceUrl = "http://localhost:11464/";
var UserList = {};
$(document).ready(function () {
//  if (window.location.pathname.indexOf("Login.html") > -1) {
//      return;
//  }
//  var str = localStorage.getItem("qhfp_user");
//  if (str != "" && str != null && str != undefined) {
//      UserList = str = JSON.parse(str);
//      var d = new Date(str.LastLoginTime);
//      d.setDate(d.getDate() + 1);
//      var nowdate = new Date();
//      if (d < nowdate) {
//          window.location.href = "../Login.html";
//      }
//  }
//  else {
//      window.location.href = "../Login.html";
//  }
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
function GePovertyMessage(ID, DOM) {
    $.post(ServiceUrl + "PovertyArchivesInterface/GetHandler.ashx", { Tag: 'ID', ID: ID }, function (data) {
        var result = JSON.parse(data)
        {
            if (result != null) {
                if (result.Result) {
                    $(result.Data).each(function () {

                        var poverty_alert = $("<div>").appendTo(DOM).addClass("poverty_alert");
                        var poverty_info = $("<div>").appendTo(poverty_alert).addClass("poverty_info");
                        var titleh3 = $("<h3>").appendTo(poverty_info);
                        $("<text>").appendTo(titleh3).text("贫困信息");
                        $("<a>").appendTo(titleh3).addClass("close").click(function () {
                            poverty_alert.remove();
                        }).attr("href", "javascript:void(0)");
                        var poverty_top = $("<div>").appendTo(poverty_info).addClass("poverty_top");
                        var poverty_top_left = $("<div>").appendTo(poverty_top).addClass("poverty_top_left");
                        $("<h3>").appendTo(poverty_top_left).text("基本信息");
                        var Basicul = $("<ul>").appendTo(poverty_top_left);
                        var Nameli = $("<li>").appendTo(Basicul);
                        $("<span>").appendTo(Nameli).html("姓　　名:");
                        $("<label>").appendTo(Nameli).text(this.Name);
                        if (this.PovertyStates == "0") {
                            $("<a>").appendTo(Nameli).text("有需求").attr("href", "javascript:void(0)");
                        }
                        else {
                            $("<a>").appendTo(Nameli).text("无需求").attr("href", "javascript:void(0)");
                        }
                        //性别
                        var Genderli = $("<li>").appendTo(Basicul);
                        $("<span>").appendTo(Genderli).html("性&emsp;&emsp;别:");
                        $("<label>").appendTo(Genderli).addClass("modify").text(this.Gender == "True" ? "男" : "女");
                        //民族
                        var Nationli = $("<li>").appendTo(Basicul);
                        $("<span>").appendTo(Nationli).html("民&emsp;&emsp;族:");
                        $("<label>").appendTo(Nationli).addClass("modify").text(this.Nation);
                        //出生日期
                        var Birthdayli = $("<li>").appendTo(Basicul);
                        $("<span>").appendTo(Birthdayli).html("出生日期:");
                        var Birthday = new Date(this.BirthDay).getFullYear() + "-" + checklength(new Date(this.BirthDay).getMonth() + 1) + "-" + checklength(new Date(this.BirthDay).getDate());
                        $("<label>").appendTo(Birthdayli).addClass("modify").text(Birthday);
                        //联系电话
                        var Phoneli = $("<li>").appendTo(Basicul);
                        $("<span>").appendTo(Phoneli).html("联系电话:");
                        $("<label>").appendTo(Phoneli).addClass("modify").text(this.Phone);
                        //家庭住址
                        var Addressli = $("<li>").appendTo(Basicul);
                        var Region = (this.CityName == null ? "" : this.CityName) + (this.CountyName == null ? "" : this.CountyName) + (this.CounSideName == null ? "" : this.CounSideName) + (this.VillageName == null ? "" : this.VillageName) + (this.Address == null ? "" : this.Address);
                        $("<span>").appendTo(Addressli).html("家庭住址:");
                        $("<label>").appendTo(Addressli).addClass("modify").text(Region);
                        //身份证号
                        var IdCardNoli = $("<li>").appendTo(Basicul);
                        $("<span>").appendTo(IdCardNoli).html("身份证号:");
                        $("<label>").appendTo(IdCardNoli).addClass("modify").text(this.IdCardNo);
                        //扶贫时间
                        var PostTimeli = $("<li>").appendTo(Basicul);
                        var PostTime = "";
                        if (this.PostTime != "" && this.PostTime != null && this.PostTime != undefined) {
                            PostTime = new Date(this.PostTime).getFullYear() + "-" + checklength(new Date(this.PostTime).getMonth() + 1) + "-" + checklength(new Date(this.PostTime).getDate());
                        }
                        $("<span>").appendTo(PostTimeli).html("扶贫时间:");
                        $("<label>").appendTo(PostTimeli).addClass("modify").text(PostTime);
                        //扶贫原因
                        var PovertyReasonli = $("<li>").appendTo(Basicul);
                        $("<span>").appendTo(PovertyReasonli).html("扶贫原因:");
                        $("<label>").appendTo(PovertyReasonli).addClass("modify").text(this.PovertyReason);
                        //贫困户属性
                        var PovertyPropertiesli = $("<li>").appendTo(Basicul);
                        $("<span>").appendTo(PovertyPropertiesli).html("贫困户属性:");
                        $("<label>").appendTo(PovertyPropertiesli).addClass("modify").text(this.PovertyProperties);
                        //户主信息
                        var poverty_top_left1 = $("<div>").appendTo(poverty_top).addClass("poverty_top_left");
                        $("<h3>").appendTo(poverty_top_left1).text("户口信息");
                        var Householderul = $("<ul>").appendTo(poverty_top_left1);
                        //户主姓名
                        var HouseholderNameli = $("<li>").appendTo(Householderul);
                        $("<span>").appendTo(HouseholderNameli).html("户主姓名:");
                        $("<label>").appendTo(HouseholderNameli).addClass("modify").text(this.HouseholderName);
                        //户主证件
                        var HouseholderIdCardNoli = $("<li>").appendTo(Householderul);
                        $("<span>").appendTo(HouseholderIdCardNoli).html("户主证件:");
                        $("<label>").appendTo(HouseholderIdCardNoli).addClass("modify").text(this.HouseholderIdCardNo);
                        //与户主关系
                        var HouseholderRelationli = $("<li>").appendTo(Householderul);
                        $("<span>").appendTo(HouseholderRelationli).html("与户主关系:");
                        $("<label>").appendTo(HouseholderRelationli).addClass("modify").text(this.HouseholderRelation);
                        //家庭人数
                        var FamilySizeli = $("<li>").appendTo(Householderul);
                        $("<span>").appendTo(FamilySizeli).html("家庭人数:");
                        $("<label>").appendTo(FamilySizeli).addClass("modify").text(this.FamilySize);
                        //教育信息
                        var poverty_top_left2 = $("<div>").appendTo(poverty_top).addClass("poverty_top_left").css("width","100%");
                        $("<h3>").appendTo(poverty_top_left2).text("教育信息");
                        var Eduul = $("<ul>").appendTo(poverty_top_left2);
                        //教育阶段
                        var EduLevelsli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(EduLevelsli).html("教育阶段:");
                        $("<label>").appendTo(EduLevelsli).addClass("modify").text(this.EduLevels);
                        //学校名称
                        var SchoolNameli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(SchoolNameli).html("学校名称:");
                        $("<label>").appendTo(SchoolNameli).addClass("modify").text(this.SchoolName);
                        //入学时间
                        var EnrollmentTimeli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        var EnrollmentTime = ""
                        if (this.EnrollmentTime != "" && this.EnrollmentTime != null && this.EnrollmentTime != undefined)
                        {
                            EnrollmentTime = new Date(this.EnrollmentTime).getFullYear() + "-" + checklength(new Date(this.EnrollmentTime).getMonth() + 1) + "-" + checklength(new Date(this.EnrollmentTime).getDate());
                        }
                        $("<span>").appendTo(EnrollmentTimeli).html("入学时间:");
                        $("<label>").appendTo(EnrollmentTimeli).addClass("modify").text(EnrollmentTime);
                        //助学贷款
                        var LoanAmountli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(LoanAmountli).html("助学贷款:");
                        $("<label>").appendTo(LoanAmountli).addClass("modify").text(this.LoanAmount == 0 ? "无" : this.LoanAmount.toString());
                        //在校状况
                        var StudentStatusli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(StudentStatusli).html("在校状况:");
                        $("<label>").appendTo(StudentStatusli).addClass("modify").text(this.StudentStatus);
                        //学校性质
                        var SchoolNatureli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(SchoolNatureli).html("学校性质:");
                        $("<label>").appendTo(SchoolNatureli).addClass("modify").text(this.SchoolNature == "True" ? "公办" : "民办");
                        //省内就读
                        var IsProvinceStudyli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(IsProvinceStudyli).html("省内就读:");
                        $("<label>").appendTo(IsProvinceStudyli).addClass("modify").text(this.IsProvinceStudy == "True" ? "是" : "否");
                        //学号
                        var StudentNoli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(StudentNoli).html("学&emsp;&emsp;号:");
                        $("<label>").appendTo(StudentNoli).addClass("modify").text(this.StudentNo);
                        //两后生
                        var IsLHSli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(IsLHSli).html("两后生:");
                        $("<label>").appendTo(IsLHSli).addClass("modify").text(this.IsLHS == "True" ? "是" : "否");
                        //两后生情况
                        var LHSOpResultli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(LHSOpResultli).html("两后生情况:");
                        $("<label>").appendTo(LHSOpResultli).addClass("modify").text(this.LHSOpResult == "True" ? "已解决" : "未解决");
                        $("<br>").appendTo(Eduul);
                        //备注
                        var Remarkli = $("<li>").appendTo(Eduul).addClass("top_left2");
                        $("<span>").appendTo(Remarkli).html("备&emsp;&emsp;注:");
                        $("<label>").appendTo(Remarkli).addClass("modify").text(this.Remark);
                    });
                }
            }
        }

    });
}

function CheckNull(str)
{
    if(str==null||str==undefined||str==""||str==NaN||str=="undefined")
        {}
}




