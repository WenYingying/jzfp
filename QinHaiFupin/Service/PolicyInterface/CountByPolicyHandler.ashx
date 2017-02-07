<%@ WebHandler Language="C#" Class="CountByPolicyHandler" %>

using System;
using System.Web;

public class CountByPolicyHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["EduLevels"]) && string.IsNullOrEmpty(req.Form["ID"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误!");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder(" AND Policy.IsEnable=1");
            if (!string.IsNullOrEmpty(req.Form["EduLevels"]))
            {
                select_search.AppendFormat(" AND Policy.EduLevels='{0}'", context.Server.UrlDecode(req.Form["EduLevels"]).Trim());
            }

            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND Policy.ID='{0}'", int.Parse(req.Form["ID"]));
            }

            if (!string.IsNullOrEmpty(req.Form["Area"]) && !string.IsNullOrEmpty(req.Form["AreaID"]) && req.Form["Area"].Trim() == "Province")
            {
                select_search.Append(" AND Policy.Grade=1");
            }

            if (!string.IsNullOrEmpty(req.Form["Area"]) && !string.IsNullOrEmpty(req.Form["AreaID"]) && req.Form["Area"].Trim() == "City")
            {
                select_search.AppendFormat(" AND (Policy.CityID={0} OR Policy.CountyID IN(SELECT ID FROM County WHERE CityID={0}))", int.Parse(req.Form["AreaID"]));
            }

            if (!string.IsNullOrEmpty(req.Form["Area"]) && !string.IsNullOrEmpty(req.Form["AreaID"]) && req.Form["Area"].Trim() == "County")
            {
                select_search.AppendFormat(" AND (Policy.CountyID={0} OR Policy.CityID IN(SELECT CityID FROM County WHERE ID={0}))", int.Parse(req.Form["AreaID"]));
            }

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.Policy p in BLL.BLL<Model.Policy>.Creator("SelectPolicy").Parameter("ID,Name,Amount", select_search.ToString()))
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":{0},", p.ID);
                sb.AppendFormat("\"Name\":\"{0}\",", p.Name.Trim().Replace("\"", "\\\""));
                sb.AppendFormat("\"Amount\":\"{0}\",", p.Amount);
                //受益人数
                System.Collections.Generic.List<Model.StudentArchives> list = BLL.BLL<Model.StudentArchives>.Creator("selectbypolicy").Parameter("1", string.Format(" AND PolicyID LIKE '%{0}%' {1} GROUP BY PovertyArchivesID ", p.ID, !string.IsNullOrEmpty(req.Form["Area"]) ? string.Format(" AND {0}ID={1}", req.Form["Area"], req.Form["AreaID"]) : string.Empty));
                sb.AppendFormat("\"UserCnt\":{0}", list[0].ID);
                sb.Append("},");
            }
            if (sb[sb.Length - 1] == ',')
                sb.Remove(sb.Length - 1, 1);
            sb.Append("]}");
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