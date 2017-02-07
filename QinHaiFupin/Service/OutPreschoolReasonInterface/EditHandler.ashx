<%@ WebHandler Language="C#" Class="EditHandler" %>

using System;
using System.Web;

public class EditHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
         context.Response.AddHeader("Access-Control-Allow-Origin", "*");
       HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) || string.IsNullOrEmpty(req.Form["Name"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.OutPreschoolReason model = new Model.OutPreschoolReason();
            model.ID = Convert.ToInt64(req.Form["ID"].Trim());
            model.Name = req.Form["Name"].Trim();
            model.Detail =string.IsNullOrEmpty(req.Form["Detail"])?"":req.Form["Detail"].Trim();
            if (BLL.BLL<Model.OutPreschoolReason>.Creator("Update").Parameter(model))
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