<%@ WebHandler Language="C#" Class="UpdatePasswordHandler" %>

using System;
using System.Web;

public class UpdatePasswordHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
      context.Response.ContentType = "text/plain";
    //context.Response.AddHeader("Access-Control-Allow-Origin", "*");         
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"])||string.IsNullOrEmpty(req.Form["Password"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.User model = new Model.User();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.Password =EncryptUtil.DesEncode(server.UrlDecode(req.Form["Password"]).Trim(), System.Configuration.ConfigurationManager.AppSettings["DES_Key"].ToString());
            if (BLL.BLL<Model.User>.Creator("UpdatePassword").Parameter(model))
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