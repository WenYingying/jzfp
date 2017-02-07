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
            if (string.IsNullOrEmpty(req.Form["UserId"]) ||string.IsNullOrEmpty(req.Form["Name"]) || string.IsNullOrEmpty(req.Form["Detail"])||(string.IsNullOrEmpty(req.Form["ProvinceID"])&&string.IsNullOrEmpty(req.Form["CityID"])&&string.IsNullOrEmpty(req.Form["CountyID"])))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.Notice model = new Model.Notice();
            model.UserId = Convert.ToInt64(req.Form["UserId"].Trim());
            model.Name = req.Form["Name"].Trim();
            model.Detail =server.UrlDecode(req.Form["Detail"].Trim());
            if(!string.IsNullOrEmpty(req.Form["ProvinceID"]))
            {
                model.ProvinceID= Convert.ToInt64(req.Form["ProvinceID"].Trim());
            }
            if(!string.IsNullOrEmpty(req.Form["CityID"]))
            {
                model.CityID= Convert.ToInt64(req.Form["CityID"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["CountyID"]))
            {
                model.CountyID = Convert.ToInt64(req.Form["CountyID"]);
            }
            if (BLL.BLL<Model.Notice>.Creator("Insert").Parameter(model))
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