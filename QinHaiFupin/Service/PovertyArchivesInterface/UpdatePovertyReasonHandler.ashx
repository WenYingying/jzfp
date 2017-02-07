<%@ WebHandler Language="C#" Class="UpdatePovertyReasonHandler" %>

using System;
using System.Web;

public class UpdatePovertyReasonHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
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
            if (string.IsNullOrEmpty(req.Form["PovertyReason"]))
            {
                Common.GetInstance.JsonErrorMessage("请输入贫困原因");
                return;
            }

            Model.PovertyArchives model = new Model.PovertyArchives();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.PovertyReason = req.Form["PovertyReason"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdatePovertyReason").Parameter(model))
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