<%@ WebHandler Language="C#" Class="UpdateStateHandler" %>

using System;
using System.Web;

public class UpdateStateHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
         context.Response.AddHeader("Access-Control-Allow-Origin", "*");
       HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) || string.IsNullOrEmpty(req.Form["IsEnable"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.Policy model = new Model.Policy();
            model.ID = Convert.ToInt64(req.Form["ID"].Trim());
            model.IsEnable = Convert.ToBoolean(req.Form["IsEnable"].Trim());
            if (BLL.BLL<Model.Policy>.Creator("UpdateState").Parameter(model))
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