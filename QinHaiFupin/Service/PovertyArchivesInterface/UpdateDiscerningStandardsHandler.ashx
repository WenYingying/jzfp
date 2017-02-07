<%@ WebHandler Language="C#" Class="UpdateDiscerningStandardsHandler" %>

using System;
using System.Web;

public class UpdateDiscerningStandardsHandler : IHttpHandler {
    
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
            if (string.IsNullOrEmpty(req.Form["Address"]))
            {
                Common.GetInstance.JsonErrorMessage("请输入识别标准");
                return;
            }

            Model.PovertyArchives model = new Model.PovertyArchives();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.DiscerningStandards = req.Form["DiscerningStandards"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdateDiscerningStandards").Parameter(model))
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