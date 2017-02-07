<%@ WebHandler Language="C#" Class="GetHandler" %>

using System;
using System.Web;

public class GetHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
       context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) && string.IsNullOrEmpty(req.Form["UserID"]) && string.IsNullOrEmpty(req.Form["ProvinceId"]) && string.IsNullOrEmpty(req.Form["CityId"]) && string.IsNullOrEmpty(req.Form["CountyId"]) && string.IsNullOrEmpty(req.Form["CountrysideId"]) && string.IsNullOrEmpty(req.Form["VillageId"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["UserID"]))
            {
                select_search.AppendFormat(" AND UserID={0}", req.Form["UserID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["ProvinceId"]) && req.Form["ProvinceId"] != "0")
            {
                select_search.AppendFormat(" AND ProvinceId={0}", req.Form["ProvinceId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CityId"]) && req.Form["CityId"] != "0")
            {
                select_search.AppendFormat(" AND CityId={0}", req.Form["CityId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountyId"]) && req.Form["CountyId"] != "0")
            {
                select_search.AppendFormat(" AND CountyId={0}", req.Form["CountyId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountrysideId"]) && req.Form["CountrysideId"] != "0")
            {
                select_search.AppendFormat(" AND CountrysideId={0}", req.Form["CountrysideId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["VillageId"]) && req.Form["VillageId"] != "0")
            {
                select_search.AppendFormat(" AND VillageId={0}", req.Form["VillageId"]);
            }
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.School> list = BLL.BLL<Model.School>.Creator("Select").Parameter(@"*", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.School school in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", school.ID);
                sb.AppendFormat("\"UserId\":\"{0}\",", school.UserId);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(school.Name) ? string.Empty : school.Name.Trim());
                sb.AppendFormat("\"Detail\":\"{0}\",", string.IsNullOrEmpty(school.Detail) ? string.Empty : school.Detail.Trim());
                sb.AppendFormat("\"SchoolNature\":\"{0}\",", school.SchoolNature);
                sb.AppendFormat("\"EduLevels\":\"{0}\",", string.IsNullOrEmpty(school.EduLevels) ? string.Empty : school.EduLevels.Trim());
                sb.AppendFormat("\"ProvinceId\":\"{0}\",", school.ProvinceId);
                sb.AppendFormat("\"CityId\":\"{0}\",", school.CityId);
                sb.AppendFormat("\"CountyId\":\"{0}\",", school.CountyId);
                sb.AppendFormat("\"CountrysideId\":\"{0}\",", school.CountrysideId);
                sb.AppendFormat("\"VillageId\":\"{0}\",", school.VillageId);
                sb.AppendFormat("\"Address\":\"{0}\",", string.IsNullOrEmpty(school.Address) ? string.Empty : school.Address.Trim());
                sb.AppendFormat("\"ClassSize\":\"{0}\",", school.ClassSize);
                sb.AppendFormat("\"StuEnrollment\":\"{0}\",", school.StuEnrollment);
                sb.AppendFormat("\"TchEnrollment\":\"{0}\",", school.TchEnrollment);
                sb.AppendFormat("\"SetupTime\":\"{0}\",", string.IsNullOrEmpty(school.SetupTime) ? string.Empty : school.SetupTime.Trim());
                sb.AppendFormat("\"LastModifyTime\":\"{0}\",", string.IsNullOrEmpty(school.LastModifyTime) ? string.Empty : school.LastModifyTime.Trim());
                sb.AppendFormat("\"LastModifyUserId\":\"{0}\",", school.LastModifyUserId);
                sb.AppendFormat("\"ProvinceName\":\"{0}\",", string.IsNullOrEmpty(school.ProvinceName) ? string.Empty : school.ProvinceName.Trim());
                sb.AppendFormat("\"CityName\":\"{0}\",", string.IsNullOrEmpty(school.CityName) ? string.Empty : school.CityName.Trim());
                sb.AppendFormat("\"CountyName\":\"{0}\",", string.IsNullOrEmpty(school.CountyName) ? string.Empty : school.CountyName.Trim());
                sb.AppendFormat("\"CountrySideName\":\"{0}\",", string.IsNullOrEmpty(school.CountrySideName) ? string.Empty : school.PostTime.Trim());
                sb.AppendFormat("\"VillageName\":\"{0}\",", string.IsNullOrEmpty(school.VillageName) ? string.Empty : school.VillageName.Trim());
                sb.AppendFormat("\"PostTime\":\"{0}\"", string.IsNullOrEmpty(school.PostTime) ? string.Empty : school.PostTime.Trim());

                sb.Append("},");
            }
            if (sb[sb.Length - 1] == ',')
            {
                sb.Remove(sb.Length - 1, 1);
            }
            sb.Append("]}");
            res.Write(sb.ToString());
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