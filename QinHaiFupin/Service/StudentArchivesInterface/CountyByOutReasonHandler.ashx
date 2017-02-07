<%@ WebHandler Language="C#" Class="CountyByOutReasonHandler" %>

using System;
using System.Web;

public class CountyByOutReasonHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["OutpreschoolReason"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误!");
                return;
            }
            System.Text.StringBuilder sbSearch = new System.Text.StringBuilder();
            sbSearch.Append("AND ID IN(SELECT MAX(ID) FROM StudentArchives WHERE 1=1 ");
            sbSearch.AppendFormat(" AND OutpreschoolReason='{0}'", int.Parse(req.Form["OutpreschoolReason"]));

            if (!string.IsNullOrEmpty(req.Form["Area"]) && !string.IsNullOrEmpty(req.Form["AreaID"]))
                sbSearch.AppendFormat(" AND PovertyArchivesID IN(SELECT ID FROM View_PovertyArchives WHERE {0}ID={1})", req.Form["Area"], int.Parse(req.Form["AreaID"]));
            sbSearch.Append(" AND EduLevels='适龄未入学或辍学' GROUP BY PovertyArchivesID)");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Cnt\":");
            foreach (Model.StudentArchives pa in BLL.BLL<Model.StudentArchives>.Creator("select").Parameter(" COUNT(*) AS ID", sbSearch.ToString()))
            {
                sb.AppendFormat("\"{0}\"", pa.ID);
            }
            sb.Append("}");
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