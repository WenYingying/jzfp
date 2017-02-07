<%@ WebHandler Language="C#" Class="PostHandler" %>

using System;
using System.Web;
using Model;

public class PostHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["Name"]) || string.IsNullOrEmpty(req.Form["Nation"]) || string.IsNullOrEmpty(req.Form["Phone"]) || string.IsNullOrEmpty(req.Form["VillageId"]) || string.IsNullOrEmpty(req.Form["BirthDay"]) || string.IsNullOrEmpty(req.Form["FamilySize"]) || string.IsNullOrEmpty(req.Form["Gender"]) || string.IsNullOrEmpty(req.Form["IdCardNo"]) || string.IsNullOrEmpty(req.Form["HouseholderId"]) || string.IsNullOrEmpty(req.Form["PovertyProperties"]) || string.IsNullOrEmpty(req.Form["PovertyReason"]) ||  string.IsNullOrEmpty(req.Form["DiscerningStandards"]) || string.IsNullOrEmpty(req.Form["EduLevels"]) || string.IsNullOrEmpty(req.Form["HouseholderRelation"]) || string.IsNullOrEmpty(req.Form["State"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            PovertyArchives model = new PovertyArchives();
            model.Name = req.Form["Name"].Trim();
            model.Nation = req.Form["Nation"].Trim();
            model.IdCardNo = req.Form["IdCardNo"].Trim();
            model.Phone = req.Form["Phone"].Trim();
            model.PovertyProperties = req.Form["PovertyProperties"].Trim();
            model.PovertyReason = req.Form["PovertyReason"].Trim();
            model.VillageId = Convert.ToInt32(req.Form["VillageId"]);
            model.BirthDay = req.Form["BirthDay"].Trim();
            model.DiscerningStandards = req.Form["DiscerningStandards"].Trim();
            model.EduLevels = req.Form["EduLevels"].Trim();
            model.StudentStatus = req.Form["StudentStatus"];
            model.FamilySize = Convert.ToInt32(req.Form["FamilySize"]);
            model.Gender = Convert.ToBoolean(req.Form["Gender"]);
            model.HouseholderId = Convert.ToInt64(req.Form["HouseholderId"]);
            model.HouseholderRelation = req.Form["HouseholderRelation"].Trim();
            if (req.Form["HouseholderRelation"].Trim() == "本人或户主")
            {
                model.IsHouseHolder = true;
            }
            else
            {
                model.IsHouseHolder = false;
            }
            model.State = Convert.ToBoolean(req.Form["State"]);
            model.OffPovertyTime = string.IsNullOrEmpty(req.Form["OffPovertyTime"]) ? "" : req.Form["OffPovertyTime"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("Insert").Parameter(model))
            {
                if (model.HouseholderId == 0)
                {
                    model.HouseholderId = model.ID;
                    BLL.BLL<Model.PovertyArchives>.Creator("UpdateHouseholderId").Parameter(model);

                }
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