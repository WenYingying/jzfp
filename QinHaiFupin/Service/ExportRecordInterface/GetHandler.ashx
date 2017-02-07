<%@ WebHandler Language="C#" Class="GetHandler" %>

using System;
using System.Web;

public class GetHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
      context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if(string.IsNullOrEmpty(req.Form["ID"])&&string.IsNullOrEmpty(req.Form["UserId"])&&string.IsNullOrEmpty(req.Form["HouseholderId"])&&string.IsNullOrEmpty(req.Form["BatchNumber"]))
            {
                    Common.GetInstance.JsonErrorMessage("参数错误");
                    return;
            }
            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["UserId"]))
            {
                select_search.AppendFormat(" AND UserId={0}", req.Form["UserId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["HouseholderId"]))
            {
                select_search.AppendFormat(" AND HouseholderId={0}", req.Form["HouseholderId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["BatchNumber"]))
            {
                select_search.AppendFormat(" AND BatchNumber={0}", req.Form["BatchNumber"]);
            }
            select_search.Append(" ORDER BY SortId");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.ExportRecord> list = BLL.BLL<Model.ExportRecord>.Creator("Select").Parameter(@"*", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.ExportRecord epr in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", epr.ID);
                sb.AppendFormat("\"UserId\":\"{0}\",", epr.UserId);
                sb.AppendFormat("\"SortId\":\"{0}\",", epr.SortId);
                sb.AppendFormat("\"HouseholderId\":\"{0}\",",epr.HouseholderId);
                sb.AppendFormat("\"FileName\":\"{0}\",", string.IsNullOrEmpty(epr.FileName) ? string.Empty : epr.FileName.Trim());
                sb.AppendFormat("\"BatchNumber\":\"{0}\",", string.IsNullOrEmpty(epr.BatchNumber) ? string.Empty : epr.BatchNumber.Trim());
                sb.AppendFormat("\"CityId\":\"{0}\",", epr.CityId);
                sb.AppendFormat("\"CountrySideId\":\"{0}\",", epr.CountrySideId);
                sb.AppendFormat("\"CountyId\":\"{0}\",", epr.CountyId);
                sb.AppendFormat("\"VillageId\":\"{0}\",", epr.VillageId);
                sb.AppendFormat("\"PostTime\":\"{0}\"", string.IsNullOrEmpty(epr.PostTime) ? string.Empty : epr.PostTime.Trim());
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

    public bool IsReusable {
        get {
            return false;
        }
    }

}