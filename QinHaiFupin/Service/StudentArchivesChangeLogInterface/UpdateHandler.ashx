<%@ WebHandler Language="C#" Class="UpdateHandler" %>

using System;
using System.Web;

public class UpdateHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
       context.Response.ContentType = "text/plain";
         context.Response.AddHeader("Access-Control-Allow-Origin", "*");
       HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"])|| string.IsNullOrEmpty(req.Form["ChangeText"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.StudentArchivesChangeLog model = new Model.StudentArchivesChangeLog();
            model.ID =Convert.ToInt64( req.Form["ID"].Trim());
            model.ChangeText = req.Form["ChangeText"].Trim();
            if (BLL.BLL<Model.StudentArchivesChangeLog>.Creator("Update").Parameter(model))
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