<%@ WebHandler Language="C#" Class="UpdatePovertyPropertiesByHolderHandler" %>

using System;
using System.Web;

public class UpdatePovertyPropertiesByHolderHandler : IHttpHandler {
    
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
            if (string.IsNullOrEmpty(req.Form["PovertyProperties"]))
            {
                Common.GetInstance.JsonErrorMessage("请输入贫困属性");
                return;
            }

            Model.PovertyArchives model = new Model.PovertyArchives();
            model.HouseholderId = Convert.ToInt64(req.Form["HouseholderId"]);
            model.PovertyProperties =req.Form["PovertyProperties"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdatePovertyPropertiesByHolder").Parameter(model))
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