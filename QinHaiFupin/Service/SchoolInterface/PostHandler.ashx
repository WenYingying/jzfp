<%@ WebHandler Language="C#" Class="PostHandler" %>

using System;
using System.Web;

public class PostHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
       context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["Name"]) || string.IsNullOrEmpty(req.Form["Detail"]) || string.IsNullOrEmpty(req.Form["EduLevels"]) || string.IsNullOrEmpty(req.Form["EduLevels"]) || (string.IsNullOrEmpty(req.Form["ProvinceId"]) && string.IsNullOrEmpty(req.Form["CityId"]) && string.IsNullOrEmpty(req.Form["CountyId"]) && string.IsNullOrEmpty(req.Form["CountrysideId"]) && string.IsNullOrEmpty(req.Form["VillageId"])) || string.IsNullOrEmpty(req.Form["UserId"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.School model = new Model.School();
            model.Name = req.Form["Name"];
            model.Detail =server.HtmlDecode(req.Form["Detail"]);
            if(!string.IsNullOrEmpty(req.Form["SchoolNature"]))
            {
                model.SchoolNature =Convert.ToBoolean(req.Form["SchoolNature"]);
            }

            model.EduLevels = req.Form["EduLevels"];
            model.ProvinceId =string.IsNullOrEmpty(req.Form["ProvinceId"])?0:Convert.ToInt64(req.Form["ProvinceId"]) ;
            model.CityId = string.IsNullOrEmpty(req.Form["CityId"])?0:Convert.ToInt64(req.Form["CityId"]) ;
            model.CountyId = string.IsNullOrEmpty(req.Form["CountyId"])?0:Convert.ToInt64(req.Form["CountyId"]) ;
            model.CountrysideId = string.IsNullOrEmpty(req.Form["CountrysideId"])?0:Convert.ToInt64(req.Form["CountrysideId"]) ;
            model.VillageId =string.IsNullOrEmpty(req.Form["VillageId"])?0:Convert.ToInt64(req.Form["VillageId"]) ;
            model.Address = req.Form["Address"];
            model.ClassSize =string.IsNullOrEmpty(req.Form["ClassSize"])?0:Convert.ToInt32(req.Form["ClassSize"]) ;
            model.StuEnrollment = string.IsNullOrEmpty(req.Form["StuEnrollment"])?0:Convert.ToInt32(req.Form["StuEnrollment"]) ;
            model.TchEnrollment = string.IsNullOrEmpty(req.Form["TchEnrollment"])?0:Convert.ToInt32(req.Form["TchEnrollment"]) ;
            model.SetupTime = req.Form["SetupTime"];
            model.UserId =Convert.ToInt64(req.Form["UserId"]) ;
            model.LastModifyTime = DateTime.Now.ToString();
            model.LastModifyUserId =Convert.ToInt64(req.Form["UserId"]) ;
            if (BLL.BLL<Model.School>.Creator("Insert").Parameter(model))
            {
                res.Write("{\"Result\":true,\"Message\":\"" + model.ID + "\"}");
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