<%@ WebHandler Language="C#" Class="UpdatePovertyHandler" %>

using System;
using System.Web;
using Model;

public class UpdatePovertyHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["HouseholderId"]) || string.IsNullOrEmpty(req.Form["PovertyReason"]) || string.IsNullOrEmpty(req.Form["PovertyProperties"]) || string.IsNullOrEmpty(req.Form["DiscerningStandards"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            PovertyArchives model = new PovertyArchives();
            model.HouseholderId = Convert.ToInt64(req.Form["HouseholderId"]);
            model.PovertyReason = req.Form["PovertyReason"].Trim();
            model.PovertyProperties = req.Form["PovertyProperties"].Trim();
            model.DiscerningStandards = req.Form["DiscerningStandards"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdatePoverty").Parameter(model))
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