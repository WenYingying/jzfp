<%@ WebHandler Language="C#" Class="EditHandler" %>

using System;
using System.Web;

public class EditHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) || string.IsNullOrEmpty(req.Form["Name"]) || string.IsNullOrEmpty(req.Form["Detail"])|| string.IsNullOrEmpty(req.Form["Detail"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.Policy model = new Model.Policy();
            model.ID = Convert.ToInt64(req.Form["ID"].Trim());
            model.Name = req.Form["Name"].Trim();
            model.Detail =server.UrlDecode(req.Form["Detail"].Trim());
            model.Amount = req.Form["Amount"].Trim();
            if (BLL.BLL<Model.Policy>.Creator("Update").Parameter(model))
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