<%@ WebHandler Language="C#" Class="LoginHandler" %>

using System;
using System.Web;
using System.Xml;

public class LoginHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["LoginName"]) &&string.IsNullOrEmpty(req.Form["Password"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["LoginName"]))
            {
                select_search.AppendFormat(" AND (LoginName='{0}' OR Phone='{0}')", req.Form["LoginName"]);
            }
            if (!string.IsNullOrEmpty(req.Form["Password"]))
            {
                select_search.AppendFormat(" AND Password='{0}'", EncryptUtil.DesEncode(server.UrlDecode(req.Form["Password"]).Trim(), System.Configuration.ConfigurationManager.AppSettings["DES_Key"].ToString()));
            }
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.User> list = BLL.BLL<Model.User>.Creator("Select").Parameter(@"*", select_search.ToString());
            if (list.Count == 0)
            {
                Common.GetInstance.JsonErrorMessage("用户名或密码错误！");
                return;
            }
            Common.AddLog(list[0].ID, req.Form["Lng"], req.Form["Lat"]);
            string _userIP;
            if (req.ServerVariables["HTTP_VIA"] == null)//未使用代理
            {
                _userIP = req.UserHostAddress;
            }
            else//使用代理服务器
            {
                _userIP = req.ServerVariables["HTTP_X_FORWARDED_FOR"];
            }
            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.User user in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", user.ID);
                sb.AppendFormat("\"LoginName\":\"{0}\",", string.IsNullOrEmpty(user.LoginName) ? string.Empty : user.LoginName.Trim());
                sb.AppendFormat("\"Password\":\"{0}\",", string.IsNullOrEmpty(user.Password) ? string.Empty : user.Password.Trim());
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(user.Name) ? string.Empty : user.Name.Trim());
                sb.AppendFormat("\"Phone\":\"{0}\",", string.IsNullOrEmpty(user.Phone) ? string.Empty : user.Phone.Trim());
                sb.AppendFormat("\"ProvinceId\":\"{0}\",", user.ProvinceId);
                sb.AppendFormat("\"CityId\":\"{0}\",", user.CityId);
                sb.AppendFormat("\"CountyId\":\"{0}\",", user.CountyId);
                sb.AppendFormat("\"CountrySideId\":\"{0}\",", user.CountrySideId);
                sb.AppendFormat("\"VillageId\":\"{0}\",", user.VillageId);
                sb.AppendFormat("\"IsModify\":\"{0}\",", user.IsModify);
                sb.AppendFormat("\"LastLoginIp\":\"{0}\",", string.IsNullOrEmpty(user.LastLoginIp) ? string.Empty : user.LastLoginIp.Trim());
                sb.AppendFormat("\"LastLoginTime\":\"{0}\",", string.IsNullOrEmpty(user.LastLoginTime) ? string.Empty : user.LastLoginTime.Trim());
                sb.AppendFormat("\"InputBeginTime\":\"{0}\",", string.IsNullOrEmpty(user.InputBeginTime) ? string.Empty : user.InputBeginTime.Trim());
                sb.AppendFormat("\"InputEndTime\":\"{0}\",", string.IsNullOrEmpty(user.InputEndTime) ? string.Empty : user.InputEndTime.Trim());
                sb.AppendFormat("\"Lng\":\"{0}\",",req.Form["Lng"]);
                sb.AppendFormat("\"Lat\":\"{0}\",", req.Form["Lat"]);
                sb.AppendFormat("\"PostTime\":\"{0}\",", string.IsNullOrEmpty(user.PostTime) ? string.Empty : user.PostTime.Trim());
                sb.AppendFormat("\"ProvinceName\":\"{0}\",", string.IsNullOrEmpty(user.ProvinceName) ? string.Empty : user.ProvinceName.Trim());
                sb.AppendFormat("\"CityName\":\"{0}\",", string.IsNullOrEmpty(user.CityName) ? string.Empty : user.CityName.Trim());
                sb.AppendFormat("\"CountyName\":\"{0}\",", string.IsNullOrEmpty(user.CountyName) ? string.Empty : user.CountyName.Trim());
                sb.AppendFormat("\"CountrySideName\":\"{0}\",", string.IsNullOrEmpty(user.CountrySideName) ? string.Empty : user.CountrySideName.Trim());
                sb.AppendFormat("\"VillageName\":\"{0}\"", string.IsNullOrEmpty(user.VillageName) ? string.Empty : user.VillageName.Trim());
                sb.Append("},");
            }
            if (sb[sb.Length - 1] == ',')
            {
                sb.Remove(sb.Length - 1, 1);
            }
            sb.Append("]}");
            res.Write(sb.ToString());
        }
        catch (Exception ex)
        {
            Common.GetInstance.JsonErrorMessage(ex.Message);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}