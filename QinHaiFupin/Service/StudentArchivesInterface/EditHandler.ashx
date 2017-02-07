<%@ WebHandler Language="C#" Class="EditHandler" %>

using System;
using System.Web;

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
            if (string.IsNullOrEmpty(req.Form["ID"]) || string.IsNullOrEmpty(req.Form["EduLevels"]) || string.IsNullOrEmpty(req.Form["StudentStatus"]) || string.IsNullOrEmpty(req.Form["IsLHS"]) || string.IsNullOrEmpty(req.Form["IsProvinceStudy"]) || string.IsNullOrEmpty(req.Form["SchoolNature"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            if (!string.IsNullOrEmpty(req.Form["DropoutSchool"]) && string.IsNullOrEmpty(req.Form["ReturnSchool"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.StudentArchives model = new Model.StudentArchives();
            model.ID = Convert.ToInt64(req.Form["ID"].Trim());
            model.SchoolName = req.Form["SchoolName"].Trim();
            model.PolicyID = req.Form["PolicyID"].Trim();
            model.EduLevels = req.Form["EduLevels"].Trim();
            model.StudentStatus = req.Form["StudentStatus"].Trim();
            model.IsLHS = Convert.ToBoolean(req.Form["IsLHS"].Trim());
            model.LHSWorkId = string.IsNullOrEmpty(req.Form["LHSWorkId"]) ? 0 : Convert.ToInt64(req.Form["LHSWorkId"]);
            model.OutpreschoolReason = req.Form["OutpreschoolReason"].Trim();
            model.IsProvinceStudy = Convert.ToBoolean(req.Form["IsProvinceStudy"].Trim());
            model.SchoolNature = Convert.ToBoolean(req.Form["SchoolNature"].Trim());
            model.Remark = req.Form["Remark"].Trim();
            model.StudentNo = req.Form["StudentNo"].Trim();
            model.DropoutSchool = req.Form["DropoutSchool"].Trim();
            if (string.IsNullOrEmpty(req.Form["ReturnSchool"]))
            {
                model.ReturnSchool = Convert.ToBoolean(req.Form["ReturnSchool"]);
            }
            else
            {
                model.ReturnSchool = true;
            }
            if (BLL.BLL<Model.StudentArchives>.Creator("Update").Parameter(model))
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