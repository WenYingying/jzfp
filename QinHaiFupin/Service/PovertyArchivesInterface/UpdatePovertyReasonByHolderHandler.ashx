<%@ WebHandler Language="C#" Class="UpdatePovertyReasonByHolderHandler" %>

using System;
using System.Web;

public class UpdatePovertyReasonByHolderHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
         context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["HouseholderId"]))
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
            model.HouseholderId = Convert.ToInt64(req.Form["HouseholderId"]);
            model.PovertyReason =req.Form["PovertyReason"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdatePovertyReasonByHolder").Parameter(model))
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