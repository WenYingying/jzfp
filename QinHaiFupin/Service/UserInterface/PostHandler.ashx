<%@ WebHandler Language="C#" Class="PostHandler" %>

using System;
using System.Web;
using BLL;
using Model;

public class PostHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["LoginName"]) || string.IsNullOrEmpty(req.Form["Password"]) || string.IsNullOrEmpty(req.Form["Phone"]) || string.IsNullOrEmpty(req.Form["Name"]) || (string.IsNullOrEmpty(req.Form["ProvinceId"]) && string.IsNullOrEmpty(req.Form["CityId"]) && string.IsNullOrEmpty(req.Form["CountyId"]) && string.IsNullOrEmpty(req.Form["CountrySideId"]) && string.IsNullOrEmpty(req.Form["VillageId"])))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            User model = new User();
            model.LoginName = req.Form["LoginName"];
            model.Password = EncryptUtil.DesEncode(server.UrlDecode(req.Form["Password"]).Trim(), System.Configuration.ConfigurationManager.AppSettings["DES_Key"].ToString());
            model.Phone = req.Form["Phone"];
            model.Name = req.Form["Name"];
            model.IsModify = false;
            if (!string.IsNullOrEmpty(req.Form["ProvinceId"]))
            {
                model.ProvinceId = Convert.ToInt32(req.Form["ProvinceId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CityId"]))
            {
                model.CityId = Convert.ToInt32(req.Form["CityId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountyId"]))
            {
                model.CountyId = Convert.ToInt32(req.Form["CountyId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountrySideId"]))
            {
                model.CountrySideId = Convert.ToInt32(req.Form["CountrySideId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["VillageId"]))
            {
                model.VillageId = Convert.ToInt32(req.Form["VillageId"]);
            }
            System.Collections.Generic.List<Model.User> list = BLL.BLL<Model.User>.Creator("Select").Parameter(@"TOP 1 *","");
            if(list.Count>0)
            {
                model.InputBeginTime = list[0].InputBeginTime;
                model.InputEndTime = list[0].InputEndTime;
            }
            if (BLL<User>.Creator("Insert").Parameter(model))
            {
                res.Write("{\"Result\":true,\"Message\":\"" + model.ID + "\"}");
            }

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