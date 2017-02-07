<%@ WebHandler Language="C#" Class="UpdateHouseholderIdHandler" %>

using System;
using System.Web;

public class UpdateHouseholderIdHandler : IHttpHandler {

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
            if (string.IsNullOrEmpty(req.Form["HouseholderId"]))
            {
                Common.GetInstance.JsonErrorMessage("请输入户主ID");
                return;
            }

            Model.PovertyArchives model = new Model.PovertyArchives();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.HouseholderId =Convert.ToInt64(req.Form["HouseholderId"]);
            if (model.HouseholderId != 0)
            {
                System.Collections.Generic.List<Model.PovertyArchives> list = BLL.BLL<Model.PovertyArchives>.Creator("Select").Parameter("*", "AND ID=" + model.HouseholderId);
                if(list.Count>0)
                {
                    model.PovertyProperties = list[0].PovertyProperties;
                    model.PovertyReason = list[0].PovertyReason;
                    model.DiscerningStandards = list[0].DiscerningStandards;
                    model.VillageId = list[0].VillageId;
                    model.Address = list[0].Address == null?"":list[0].Address;
                    model.Phone = list[0].Phone;
                    model.FamilySize = list[0].FamilySize;
                }
                if (BLL.BLL<Model.PovertyArchives>.Creator("UpdateEInformation").Parameter(model))
                {
                    res.Write("{\"Result\":true,\"Message\":\"修改成功\"}");
                }
            }
            else
            {
                if (BLL.BLL<Model.PovertyArchives>.Creator("UpdateHouseholderId").Parameter(model))
                {
                    res.Write("{\"Result\":true,\"Message\":\"修改成功\"}");
                }
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