<%@ WebHandler Language="C#" Class="UpdatePhoneByHolderHandler" %>

using System;
using System.Web;

public class UpdatePhoneByHolderHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
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
            if (string.IsNullOrEmpty(req.Form["Phone"]))
            {
                Common.GetInstance.JsonErrorMessage("请输入电话号");
                return;
            }

            Model.PovertyArchives model = new Model.PovertyArchives();
            model.HouseholderId = Convert.ToInt64(req.Form["HouseholderId"]);
            model.Phone =req.Form["Phone"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdatePhoneByHolder").Parameter(model))
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