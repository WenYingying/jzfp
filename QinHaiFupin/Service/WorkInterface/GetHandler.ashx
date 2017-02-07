<%@ WebHandler Language="C#" Class="GetHandler" %>

using System;
using System.Web;
using System.Text;
using System.Collections.Generic;
using Model;
using BLL;

public class GetHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
       context.Response.AddHeader("Access-Control-Allow-Origin", "*");           
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            StringBuilder select_search = new StringBuilder();
            if (string.IsNullOrEmpty(req.Form["ID"]) &&string.IsNullOrEmpty(req.Form["Type"]) && string.IsNullOrEmpty(req.Form["Name"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", Convert.ToInt64(req.Form["ID"]));
            }
            if (!string.IsNullOrEmpty(req.Form["Name"]))
            {
                select_search.AppendFormat(" AND Name='{0}' ", req.Form["Name"]);
            }
            if (!string.IsNullOrEmpty(req.Form["Type"]))
            {
                select_search.AppendFormat(" AND Type='{0}' ", req.Form["Type"]);
            }
            StringBuilder sb = new StringBuilder();
            List<Work> list = BLL<Work>.Creator("Select").Parameter("*", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Work work in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", work.ID);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(work.Name) ? string.Empty : work.Name.Trim());
                sb.AppendFormat("\"Type\":\"{0}\",", string.IsNullOrEmpty(work.Type) ? string.Empty : work.Type.Trim().Replace("\"","\\\""));
                sb.AppendFormat("\"ClassHours\":\"{0}\",", work.ClassHours);
                sb.AppendFormat("\"PostTime\":\"{0}\"", string.IsNullOrEmpty(work.PostTime) ? string.Empty : work.PostTime.Trim());
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