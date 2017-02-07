<%@ WebHandler Language="C#" Class="PostHandler" %>

using System;
using System.Web;

public class PostHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["UserID"]) || string.IsNullOrEmpty(req.Form["PovertyArchivesID"]) || string.IsNullOrEmpty(req.Form["EduLevels"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            //if (!string.IsNullOrEmpty(req.Form["DropoutSchool"]) && string.IsNullOrEmpty(req.Form["ReturnSchool"]))
            //{
            //    Common.GetInstance.JsonErrorMessage("参数错误");
            //    return;
            //}
            Model.StudentArchives model = new Model.StudentArchives();
            model.UserID = Convert.ToInt64(req.Form["UserID"].Trim());
            model.PovertyArchivesID = Convert.ToInt64(req.Form["PovertyArchivesID"].Trim());
            model.SchoolName = req.Form["SchoolName"].Trim();
            model.EduLevels = req.Form["EduLevels"].Trim();
            model.StudentStatus = req.Form["StudentStatus"];
            model.IsLHS = string.IsNullOrEmpty(req.Form["IsLHS"]) ? false : Convert.ToBoolean(req.Form["IsLHS"].Trim());
            model.SchoolNature = string.IsNullOrEmpty(req.Form["SchoolNature"]) ? true : Convert.ToBoolean(req.Form["SchoolNature"].Trim());
            model.LHSWorkId = string.IsNullOrEmpty(req.Form["LHSWorkId"]) ? 0 : Convert.ToInt64(req.Form["LHSWorkId"]);
            model.OutpreschoolReason = req.Form["OutpreschoolReason"].Trim();
            model.IsProvinceStudy = string.IsNullOrEmpty(req.Form["IsProvinceStudy"]) ? true : Convert.ToBoolean(req.Form["IsProvinceStudy"].Trim());
            model.SchoolNature = string.IsNullOrEmpty(req.Form["SchoolNature"]) ? false : Convert.ToBoolean(req.Form["SchoolNature"].Trim());
            model.Remark = req.Form["Remark"].Trim();
            //model.StudentNo = req.Form["StudentNo"].Trim();
            model.DropoutSchool = req.Form["DropoutSchool"].Trim();
            model.PolicyID = string.IsNullOrEmpty(req.Form["PolicyID"]) ? "" : req.Form["PolicyID"].Trim();
            if (!string.IsNullOrEmpty(req.Form["ReturnSchool"]))
            {
                model.ReturnSchool = Convert.ToBoolean(req.Form["ReturnSchool"]);
            }
            else
            {
                model.ReturnSchool = true;
            }
            Model.PovertyArchives pamodel = new Model.PovertyArchives();
            pamodel.ID = Convert.ToInt64(req.Form["PovertyArchivesID"].Trim());
            pamodel.EduLevels = req.Form["EduLevels"].Trim();
            pamodel.StudentStatus = req.Form["StudentStatus"].Trim();
            pamodel.PovertyStates = 1;
            if (BLL.BLL<Model.StudentArchives>.Creator("Insert").Parameter(model))
            {
                BLL.BLL<Model.PovertyArchives>.Creator("UpdateStudentEdu").Parameter(pamodel);
                BLL.BLL<Model.PovertyArchives>.Creator("UpdatePovertyStates").Parameter(pamodel);
                res.Write("{\"Result\":true,\"Message\":\"" + model.ID + "\"}");
            }
        }
        catch (Exception ex)
        {
            Common.GetInstance.JsonErrorMessage(ex.Message);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}