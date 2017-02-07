<%@ WebHandler Language="C#" Class="CountByAgeHandler" %>

using System;
using System.Web;

public class CountByAgeHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        if (string.IsNullOrEmpty(req.Form["MinAge"]) || string.IsNullOrEmpty(req.Form["MaxAge"]))
        {
            Common.GetInstance.JsonErrorMessage("参数错误!");
            return;
        }
        try
        {
            string select_search = string.Format(" AND LEN(BirthDay) IS NOT NULL AND DATEDIFF(YY,BirthDay,GETDATE()) BETWEEN {0} AND {1}", int.Parse(req.Form["MinAge"]), int.Parse(req.Form["MaxAge"]));
            //update by cfe 20170113 在原有的镇得基础上，增加了县这个维度
            if (!string.IsNullOrEmpty(req.Form["area"]) && !string.IsNullOrEmpty(req.Form["areaid"]))
                select_search = string.Format("{0} AND {1}ID={2}", select_search, req.Form["area"], int.Parse(req.Form["areaid"]));
            if (!string.IsNullOrEmpty(req.Form["county"]) && !string.IsNullOrEmpty(req.Form["countyid"]))
                select_search = string.Format("{0} AND {1}ID={2}", select_search, req.Form["county"], int.Parse(req.Form["countyid"]));
            if (!string.IsNullOrEmpty(req.Form["countryside"]) && !string.IsNullOrEmpty(req.Form["countrysideid"]))
                select_search = string.Format("{0} AND {1}ID={2}", select_search, req.Form["countryside"], int.Parse(req.Form["countrysideid"]));
            if (!string.IsNullOrEmpty(req.Form["OutSchool"]))
                select_search = string.Format("{0} AND (EduLevels='适龄未入学或辍学' OR StudentStatus='非在校生' OR LEN(EduLevels)=0 OR LEN(StudentStatus)=0)", select_search);

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[{");
            foreach (Model.PovertyArchives pa in BLL.BLL<Model.PovertyArchives>.Creator("select").Parameter(" COUNT(*) AS ID", select_search))
            {
                sb.AppendFormat("\"Count\":{0}", pa.ID);
            }
            sb.Append("}]}");
            res.Write(sb.ToString());
        }
        catch (Exception ex)
        {
            Common.GetInstance.JsonErrorMessage(ex.Message);
            return;
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