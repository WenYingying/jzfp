<%@ WebHandler Language="C#" Class="EditHandler" %>

using System;
using System.Web;
using Model;

public class EditHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) || string.IsNullOrEmpty(req.Form["Name"]) || string.IsNullOrEmpty(req.Form["IdCardNo"]) || string.IsNullOrEmpty(req.Form["Nation"]) || string.IsNullOrEmpty(req.Form["BirthDay"]) || string.IsNullOrEmpty(req.Form["Gender"]) || string.IsNullOrEmpty(req.Form["HouseholderRelation"]) || string.IsNullOrEmpty(req.Form["HouseholderId"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            PovertyArchives model = new PovertyArchives();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            model.Name = string.IsNullOrEmpty(req.Form["Name"]) ? "" : req.Form["Name"].Trim();
            model.IdCardNo = string.IsNullOrEmpty(req.Form["IdCardNo"]) ? "" : req.Form["IdCardNo"].Trim();
            model.Nation = string.IsNullOrEmpty(req.Form["Nation"]) ? "" : req.Form["Nation"].Trim();
            model.Phone = string.IsNullOrEmpty(req.Form["Phone"]) ? "" : req.Form["Phone"].Trim();
            model.BirthDay = req.Form["BirthDay"].Trim();
            model.Gender = Convert.ToBoolean(req.Form["Gender"]);
            model.HouseholderRelation = string.IsNullOrEmpty(req.Form["HouseholderRelation"]) ? "" : req.Form["HouseholderRelation"].Trim();
            model.HouseholderId =Convert.ToInt64(req.Form["HouseholderId"]);
            model.EduLevels = req.Form["EduLevels"].Trim();
            model.StudentStatus = req.Form["StudentStatus"];

            if (BLL.BLL<Model.PovertyArchives>.Creator("NewUpdate").Parameter(model))
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