<%@ WebHandler Language="C#" Class="CountByWorkHandler" %>

using System;
using System.Web;

public class CountByWorkHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["Type"]) && string.IsNullOrEmpty(req.Form["ID"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误!");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder(" AND IsLHS=1");
            if (!string.IsNullOrEmpty(req.Form["Type"]))
            {
                select_search.AppendFormat(" AND LHSWorkId IN(SELECT ID FROM Work WHERE Type='{0}')", context.Server.UrlDecode(req.Form["Type"]).Trim());
            }

            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND LHSWorkId='{0}'", int.Parse(req.Form["ID"]));
            }
            if (!string.IsNullOrEmpty(req.Form["Area"]) && !string.IsNullOrEmpty(req.Form["AreaID"]))
                select_search.AppendFormat(" AND {0}ID={1}", req.Form["Area"], int.Parse(req.Form["AreaID"]));

            select_search.Append(" GROUP BY PovertyArchivesID");

            System.Collections.Generic.List<Model.StudentArchives> list = BLL.BLL<Model.StudentArchives>.Creator("selectbywork").Parameter("1",select_search.ToString());

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Cnt\":");
            sb.AppendFormat("{0}", list[0].ID);
            sb.Append("}");
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