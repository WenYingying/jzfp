<%@ WebHandler Language="C#" Class="UpdateInputTimeHandler" %>

using System;
using System.Web;

public class UpdateInputTimeHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["InputBeginTime"]) || string.IsNullOrEmpty(req.Form["InputEndTime"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.User model = new Model.User();
            model.InputBeginTime = req.Form["InputBeginTime"].Trim();
            model.InputEndTime = req.Form["InputEndTime"].Trim();
            if (BLL.BLL<Model.User>.Creator("UpdateInputTime").Parameter(model))
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