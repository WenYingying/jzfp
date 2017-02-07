<%@ WebHandler Language="C#" Class="EditHandler" %>

using System;
using System.Web;
using BLL;
using Model;

public class EditHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
     //context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            User model = new User();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.Phone = req.Form["Phone"];
            model.Name = req.Form["Name"];
            if (BLL.BLL<Model.User>.Creator("Update").Parameter(model))
            {
                res.Write("{\"Result\":true,\"Message\":\"修改成功\"}");
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