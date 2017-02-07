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
            if (string.IsNullOrEmpty(req.Form["StudentArchivesId"]) || string.IsNullOrEmpty(req.Form["UserId"]) || string.IsNullOrEmpty(req.Form["ChangeText"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.StudentArchivesChangeLog model = new Model.StudentArchivesChangeLog();
            model.StudentArchivesId =Convert.ToInt64( req.Form["StudentArchivesId"].Trim());
            model.UserId =Convert.ToInt64( req.Form["UserId"].Trim());
            model.ChangeText = server.HtmlDecode(req.Form["ChangeText"].Trim());
            if (BLL.BLL<Model.StudentArchivesChangeLog>.Creator("Insert").Parameter(model))
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