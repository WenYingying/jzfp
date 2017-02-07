<%@ WebHandler Language="C#" Class="GetHandler" %>

using System;
using System.Web;

public class GetHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) && string.IsNullOrEmpty(req.Form["StudentArchivesID"]) && string.IsNullOrEmpty(req.Form["PolicyID"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["StudentArchivesID"]))
            {
                select_search.AppendFormat(" AND StudentArchivesID={0}", req.Form["StudentArchivesID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["PolicyID"]))
            {
                select_search.AppendFormat(" AND PolicyID={0}", req.Form["PolicyID"]);
            }
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.StudentArchivesPolicy> list = BLL.BLL<Model.StudentArchivesPolicy>.Creator("Select").Parameter(@"*", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.StudentArchivesPolicy salist in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", salist.ID);
                sb.AppendFormat("\"StudentArchivesID\":\"{0}\",", salist.StudentArchivesID);
                sb.AppendFormat("\"PolicyID\":\"{0}\",", salist.PolicyID);
                sb.AppendFormat("\"Amount\":\"{0}\",", string.IsNullOrEmpty(salist.Amount) ? string.Empty : salist.Amount.Trim());
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(salist.Name) ? string.Empty : salist.Name.Trim());
                sb.AppendFormat("\"Detail\":\"{0}\",", string.IsNullOrEmpty(salist.Detail) ? string.Empty : salist.Detail.Replace("\n", "\\n").Replace("\r", "\\r").Replace("\"", "\\\"").Replace("\\","\\\\").Replace("\"", "\\\"").Trim());
                sb.AppendFormat("\"EduLevels\":\"{0}\",", string.IsNullOrEmpty(salist.EduLevels) ? string.Empty : salist.EduLevels.Trim());
                sb.AppendFormat("\"IsEnable\":\"{0}\",", salist.IsEnable);
                sb.AppendFormat("\"PostTime\":\"{0}\"", string.IsNullOrEmpty(salist.PostTime) ? string.Empty : salist.PostTime.Trim());

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