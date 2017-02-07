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
            if (string.IsNullOrEmpty(req.Form["ID"]) && string.IsNullOrEmpty(req.Form["PovertyArchivesId"]) && string.IsNullOrEmpty(req.Form["UserId"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["PovertyArchivesId"]))
            {
                select_search.AppendFormat(" AND PovertyArchivesId={0}", req.Form["PovertyArchivesId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["UserId"]))
            {
                select_search.AppendFormat(" AND UserId={0}", req.Form["UserId"]);
            }
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.PovertyArchivesChangeLog> list = BLL.BLL<Model.PovertyArchivesChangeLog>.Creator("Select").Parameter(@"*", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.PovertyArchivesChangeLog sacl in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", sacl.ID);
                sb.AppendFormat("\"PovertyArchivesId\":\"{0}\",", sacl.PovertyArchivesId);
                sb.AppendFormat("\"UserId\":\"{0}\",", sacl.UserId);
                sb.AppendFormat("\"ChangeText\":\"{0}\",", string.IsNullOrEmpty(sacl.ChangeText) ? string.Empty : sacl.ChangeText.Trim());
                sb.AppendFormat("\"PostTime\":\"{0}\"", string.IsNullOrEmpty(sacl.PostTime) ? string.Empty : sacl.PostTime.Trim());
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