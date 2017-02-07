<%@ WebHandler Language="C#" Class="UpateHolderHandler" %>

using System;
using System.Web;
using System.Data;
using Model;

public class UpateHolderHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
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

            PovertyArchives model = new PovertyArchives();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.HouseholderId =  Convert.ToInt64(req.Form["HouseholderId"]);
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdateHolder").Parameter(model))
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