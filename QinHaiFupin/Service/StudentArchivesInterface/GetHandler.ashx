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
            if (string.IsNullOrEmpty(req.Form["ID"]) && string.IsNullOrEmpty(req.Form["UserID"]) && string.IsNullOrEmpty(req.Form["PersonnelID"])&& string.IsNullOrEmpty(req.Form["PovertyArchivesID"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["PovertyArchivesID"]))
            {
                select_search.AppendFormat(" AND PovertyArchivesID={0}", req.Form["PovertyArchivesID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["UserID"]))
            {
                select_search.AppendFormat(" AND UserID={0}", req.Form["UserID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["PersonnelID"]))
            {
                select_search.AppendFormat(" AND PersonnelID={0}", req.Form["PersonnelID"]);
            }
            string selectname = "*";
            if (!string.IsNullOrEmpty(req.Form["Count"]) && req.Form["Count"] == "1")
            {
                selectname = "TOP 1 *";
            }
            select_search.Append(" ORDER BY PostTime desc");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.StudentArchives> list = BLL.BLL<Model.StudentArchives>.Creator("Select").Parameter(selectname, select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.StudentArchives salist in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", salist.ID);
                sb.AppendFormat("\"UserID\":\"{0}\",", salist.UserID);
                sb.AppendFormat("\"PovertyArchivesID\":\"{0}\",", salist.PovertyArchivesID);
                sb.AppendFormat("\"StudentNo\":\"{0}\",", string.IsNullOrEmpty(salist.StudentNo) ? string.Empty : salist.StudentNo.Trim());
                sb.AppendFormat("\"SchoolName\":\"{0}\",", string.IsNullOrEmpty(salist.SchoolName) ? string.Empty : salist.SchoolName.Trim());
                sb.AppendFormat("\"PolicyID\":\"{0}\",", salist.PolicyID);
                sb.AppendFormat("\"EduLevels\":\"{0}\",", string.IsNullOrEmpty(salist.EduLevels) ? string.Empty : salist.EduLevels.Trim());
                sb.AppendFormat("\"IsLHS\":\"{0}\",", salist.IsLHS);
                sb.AppendFormat("\"LHSWorkId\":\"{0}\",", salist.LHSWorkId);
                sb.AppendFormat("\"StudentStatus\":\"{0}\",", salist.StudentStatus);
                sb.AppendFormat("\"OutpreschoolReason\":\"{0}\",", string.IsNullOrEmpty(salist.OutpreschoolReason) ? string.Empty : salist.OutpreschoolReason.Trim());
                sb.AppendFormat("\"IsProvinceStudy\":\"{0}\",", salist.IsProvinceStudy);
                sb.AppendFormat("\"SchoolNature\":\"{0}\",", salist.SchoolNature);
                sb.AppendFormat("\"Remark\":\"{0}\",", string.IsNullOrEmpty(salist.Remark) ? string.Empty : salist.Remark.Trim());
                sb.AppendFormat("\"DropoutSchool\":\"{0}\",", string.IsNullOrEmpty(salist.DropoutSchool) ? string.Empty : salist.DropoutSchool.Trim());
                sb.AppendFormat("\"ReturnSchool\":\"{0}\",", salist.ReturnSchool);
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