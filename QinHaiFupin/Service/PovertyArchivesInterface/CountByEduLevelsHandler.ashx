<%@ WebHandler Language="C#" Class="CountByEduLevelsHandler" %>

using System;
using System.Web;

public class CountByEduLevelsHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        //if (string.IsNullOrEmpty(req.Form["MinAge"]) || string.IsNullOrEmpty(req.Form["MaxAge"]))
        //{
        //    Common.GetInstance.JsonErrorMessage("参数错误!");
        //    return;
        //}
        try
        {
            string select_search = " AND LEN(EduLevels)>0";
            if (!string.IsNullOrEmpty(req.Form["EduLevels"]))
                select_search = string.Format(" AND EduLevels='{0}'", context.Server.UrlDecode(req.Form["EduLevels"]).Trim());
            if (!string.IsNullOrEmpty(req.Form["Area"]) && !string.IsNullOrEmpty(req.Form["AreaID"]))
                select_search = string.Format("{0} AND {1}ID={2}", select_search, req.Form["Area"], int.Parse(req.Form["AreaID"]));
            select_search = string.Format("{0} AND StudentStatus!='非在校生' AND LEN(StudentStatus)>0 GROUP BY EduLevels",select_search);
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.PovertyArchives pa in BLL.BLL<Model.PovertyArchives>.Creator("select").Parameter(" COUNT(ID) AS ID,EduLevels", select_search))
            {
                sb.Append("{");
                sb.AppendFormat("\"EduLevels\":\"{0}\",", pa.EduLevels.Trim());
                sb.AppendFormat("\"Count\":{0}", pa.ID);
                sb.Append("},");
            }
            if (sb[sb.Length-1] == ',')
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

    public bool IsReusable {
        get {
            return false;
        }
    }

}