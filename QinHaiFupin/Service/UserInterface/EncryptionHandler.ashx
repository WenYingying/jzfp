<%@ WebHandler Language="C#" Class="EncryptionHandler" %>

using System;
using System.Web;

public class EncryptionHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
     //context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["Password"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            string password = EncryptUtil.DesEncode(server.UrlDecode(req.Form["Password"]).Trim(), System.Configuration.ConfigurationManager.AppSettings["DES_Key"].ToString());

            res.Write(string.Format("{{\"Result\":true,\"Password\":\"{0}\"}}", password));
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