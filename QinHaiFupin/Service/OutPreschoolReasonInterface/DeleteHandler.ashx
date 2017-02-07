<%@ WebHandler Language="C#" Class="DeleteHandler" %>

using System;
using System.Web;

public class DeleteHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
      context.Response.ContentType = "text/plain";
         context.Response.AddHeader("Access-Control-Allow-Origin", "*");
       HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.OutPreschoolReason model = new Model.OutPreschoolReason();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            if (BLL.BLL<Model.OutPreschoolReason>.Creator("Delete").Parameter(model))
            {
                res.Write("{\"Result\":true,\"Message\":\"删除成功\"}");
            }
        }
        catch (Exception ex)
        {
            Common.GetInstance.JsonErrorMessage(ex.Message);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}