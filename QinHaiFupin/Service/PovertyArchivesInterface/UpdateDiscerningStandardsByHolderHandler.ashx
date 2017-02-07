<%@ WebHandler Language="C#" Class="UpdateDiscerningStandardsByHolderHandler" %>

using System;
using System.Web;

public class UpdateDiscerningStandardsByHolderHandler : IHttpHandler {

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
            if (string.IsNullOrEmpty(req.Form["DiscerningStandards"]))
            {
                Common.GetInstance.JsonErrorMessage("请输入识别标准");
                return;
            }

            Model.PovertyArchives model = new Model.PovertyArchives();
            model.HouseholderId = Convert.ToInt64(req.Form["HouseholderId"]);
            model.DiscerningStandards =req.Form["DiscerningStandards"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdateDiscerningStandardsByHolder").Parameter(model))
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