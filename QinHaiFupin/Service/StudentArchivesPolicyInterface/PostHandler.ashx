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
            if (string.IsNullOrEmpty(req.Form["StudentArchivesID"]) || string.IsNullOrEmpty(req.Form["PolicyID"]) || string.IsNullOrEmpty(req.Form["Amount"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.StudentArchivesPolicy model = new Model.StudentArchivesPolicy();
            model.PolicyID = Convert.ToInt64(req.Form["PolicyID"].Trim());
            model.StudentArchivesID = Convert.ToInt64(req.Form["StudentArchivesID"].Trim());
            model.Amount =Convert.ToDecimal(req.Form["Amount"].Trim()).ToString();
            if (BLL.BLL<Model.StudentArchivesPolicy>.Creator("Insert").Parameter(model))
            {
                res.Write("{\"Result\":true,\"Message\":\"" + model.ID + "\"}");
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