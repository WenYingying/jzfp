<%@ WebHandler Language="C#" Class="PostHandler" %>

using System;
using System.Web;

public class PostHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["Name"]) || string.IsNullOrEmpty(req.Form["Detail"])|| string.IsNullOrEmpty(req.Form["UserId"]) || string.IsNullOrEmpty(req.Form["EduLevels"]) ||( string.IsNullOrEmpty(req.Form["CityID"])&&string.IsNullOrEmpty(req.Form["ProvinceID"])&&string.IsNullOrEmpty(req.Form["CountyID"]))|| string.IsNullOrEmpty(req.Form["Amount"])|| string.IsNullOrEmpty(req.Form["Grade"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.Policy model = new Model.Policy();
            model.Name = req.Form["Name"].Trim();
            model.Detail = server.UrlDecode(req.Form["Detail"].Trim());
            model.EduLevels = req.Form["EduLevels"].Trim();
            model.CityID = string.IsNullOrEmpty(req.Form["CityID"])?0:Convert.ToInt64(req.Form["CityID"].Trim());
            model.ProvinceID= string.IsNullOrEmpty(req.Form["ProvinceID"])?0:Convert.ToInt64(req.Form["ProvinceID"].Trim());
            model.CountyID= string.IsNullOrEmpty(req.Form["CountyID"])?0:Convert.ToInt64(req.Form["CountyID"].Trim());
            model.IsEnable = true;
            model.UserId = Convert.ToInt64(req.Form["UserId"].Trim());
            model.Amount = req.Form["Amount"].Trim();
            model.Grade = Convert.ToInt32(req.Form["Grade"]);
            if (BLL.BLL<Model.Policy>.Creator("Insert").Parameter(model))
            {
                res.Write("{\"Result\":true,\"Message\":\"添加成功\"}");
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