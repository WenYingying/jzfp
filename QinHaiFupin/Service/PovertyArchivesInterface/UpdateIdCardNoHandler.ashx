﻿<%@ WebHandler Language="C#" Class="UpdateIdCardNoHandler" %>

using System;
using System.Web;

public class UpdateIdCardNoHandler : IHttpHandler {
    
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
            if (string.IsNullOrEmpty(req.Form["IdCardNo"]))
            {
                Common.GetInstance.JsonErrorMessage("请输入身份证号");
                return;
            }

            Model.PovertyArchives model = new Model.PovertyArchives();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.IdCardNo = req.Form["IdCardNo"].Trim();
            if (BLL.BLL<Model.PovertyArchives>.Creator("UpdateIdCardNo").Parameter(model))
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