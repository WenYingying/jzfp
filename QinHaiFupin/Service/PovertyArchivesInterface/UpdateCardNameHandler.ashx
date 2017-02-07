<%@ WebHandler Language="C#" Class="UpdateCardNameHandler" %>

using System;
using System.Web;
using Model;

public class UpdateCardNameHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
          context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) || string.IsNullOrEmpty(req.Form["IdCardNo"])|| string.IsNullOrEmpty(req.Form["Name"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            PovertyArchives model = new PovertyArchives();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.IdCardNo = req.Form["IdCardNo"].Trim();
            model.Name = req.Form["Name"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdateCardName").Parameter(model))
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