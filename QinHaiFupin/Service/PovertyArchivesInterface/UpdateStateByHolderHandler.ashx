<%@ WebHandler Language="C#" Class="UpdateStateByHolderHandler" %>

using System;
using System.Web;

public class UpdateStateByHolderHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["HouseholderId"]) || string.IsNullOrEmpty(req.Form["State"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            Model.PovertyArchives model = new Model.PovertyArchives();
            model.HouseholderId = Convert.ToInt64(req.Form["HouseholderId"]);
            model.State = Convert.ToBoolean(req.Form["State"].Trim());
            model.OffPovertyTime = string.IsNullOrEmpty(req.Form["OffPovertyTime"]) ? "" : req.Form["OffPovertyTime"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdateStateByHolder").Parameter(model))
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