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
            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["Name"]))
            {
                select_search.AppendFormat(" AND Name LIKE '{0}'", req.Form["Name"]);
            }
             if (!string.IsNullOrEmpty(req.Form["IsEnable"]))
            {
                select_search.AppendFormat(" AND IsEnable='{0}'", req.Form["IsEnable"]);
            }
            
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.OutPreschoolReason> list = BLL.BLL<Model.OutPreschoolReason>.Creator("Select").Parameter(@"*", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.OutPreschoolReason opsr in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", opsr.ID);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(opsr.Name) ? string.Empty : opsr.Name.Trim());
                sb.AppendFormat("\"Detail\":\"{0}\",", string.IsNullOrEmpty(opsr.Detail) ? string.Empty : opsr.Detail.Trim());
                 sb.AppendFormat("\"IsEnable\":\"{0}\",", opsr.IsEnable);
                sb.AppendFormat("\"PostTime\":\"{0}\"", string.IsNullOrEmpty(opsr.PostTime) ? string.Empty : opsr.PostTime.Trim());
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