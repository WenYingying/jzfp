<%@ WebHandler Language="C#" Class="UpadteFamilyDataHandler" %>

using System;
using System.Web;
using Model;

public class UpadteFamilyDataHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["FamilySize"]) || string.IsNullOrEmpty(req.Form["HouseholderId"]) || string.IsNullOrEmpty(req.Form["Address"]) || string.IsNullOrEmpty(req.Form["VillageID"]) || string.IsNullOrEmpty(req.Form["PovertyReason"]) || string.IsNullOrEmpty(req.Form["PovertyProperties"]) || string.IsNullOrEmpty(req.Form["DiscerningStandards"]) || string.IsNullOrEmpty(req.Form["Phone"]) || string.IsNullOrEmpty(req.Form["State"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            PovertyArchives model = new PovertyArchives();
            model.HouseholderId =Convert.ToInt64( req.Form["HouseholderId"]);
            model.FamilySize =Convert.ToInt32(req.Form["FamilySize"].Trim());
            model.Address = req.Form["Address"].Trim();
            model.VillageId = Convert.ToInt64(req.Form["VillageID"].Trim());
            model.PovertyReason = req.Form["PovertyReason"].Trim();
            model.PovertyProperties = req.Form["PovertyProperties"].Trim();
            model.DiscerningStandards = req.Form["DiscerningStandards"].Trim();
            model.Phone = req.Form["Phone"].Trim();
            model.State = Convert.ToBoolean(req.Form["State"]);
            model.OffPovertyTime = string.IsNullOrEmpty(req.Form["OffPovertyTime"]) ? "" : req.Form["OffPovertyTime"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpadteFamilyData").Parameter(model))
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