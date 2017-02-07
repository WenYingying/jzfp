<%@ WebHandler Language="C#" Class="PagerListHandler" %>

using System;
using System.Web;

public class PagerListHandler : IHttpHandler
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
            if (string.IsNullOrEmpty(req.Form["PageNo"]) || string.IsNullOrEmpty(req.Form["PageSize"]) || string.IsNullOrEmpty(req.Form["Area"]) || string.IsNullOrEmpty(req.Form["AreaId"]) || string.IsNullOrEmpty(req.Form["RequestType"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误！");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder();

            select_search.AppendFormat(" AND {0}ID={1}", req.Form["Area"], int.Parse(req.Form["AreaId"]));

            switch (req.Form["RequestType"].ToLower().Trim())
            {
                case "age":
                    if (string.IsNullOrEmpty(req.Form["MinAge"]) || string.IsNullOrEmpty(req.Form["MaxAge"]))
                    {
                        Common.GetInstance.JsonErrorMessage("参数错误!");
                        return;
                    }
                    select_search.AppendFormat(" AND LEN(BirthDay) IS NOT NULL AND DATEDIFF(YY,BirthDay,GETDATE()) BETWEEN {0} AND {1}", int.Parse(req.Form["MinAge"]), int.Parse(req.Form["MaxAge"]));
                    break;
                case "edulevels":
                    if (string.IsNullOrEmpty(req.Form["EduLevels"]))
                    {
                        Common.GetInstance.JsonErrorMessage("参数错误!");
                        return;
                    }
                    select_search.AppendFormat(" AND EduLevels='{0}' AND StudentStatus!='非在校生' AND LEN(StudentStatus)>0 ", context.Server.UrlDecode(req.Form["EduLevels"]).Trim());
                    break;
                case "policy":
                    if (string.IsNullOrEmpty(req.Form["EduLevels"]))
                    {
                        Common.GetInstance.JsonErrorMessage("参数错误!");
                        return;
                    }
                    select_search.Append(" AND ID IN(SELECT PovertyArchivesID FROM View_StudentArchivesPolicy WHERE 1=1 AND (1!=1 ");
                    System.Collections.Generic.List<Model.Policy> policyList = BLL.BLL<Model.Policy>.Creator("SelectPolicy").Parameter("ID", string.Format(" AND EduLevels='{0}'", server.UrlDecode(req.Form["EduLevels"])).Trim());
                    foreach(Model.Policy p in policyList) {
                            select_search.AppendFormat(" OR PolicyID LIKE '%{0}%'",p.ID);
                    }
                    select_search.Append(") GROUP BY PovertyArchivesID)");
                    break;
                case "outreason":
                    if (string.IsNullOrEmpty(req.Form["OutpreschoolReason"]))
                    {
                        Common.GetInstance.JsonErrorMessage("参数错误!");
                        return;
                    }
                    select_search.AppendFormat(" AND ID IN(SELECT PovertyArchivesID FROM StudentArchives WHERE OutpreschoolReason={0} AND ID IN(SELECT MAX(ID) FROM StudentArchives WHERE EduLevels='适龄未入学或辍学' GROUP BY PovertyArchivesID))", int.Parse(req.Form["OutpreschoolReason"]));
                    break;
                case "outschool":
                    if (string.IsNullOrEmpty(req.Form["MinAge"]) || string.IsNullOrEmpty(req.Form["MaxAge"]))
                    {
                        Common.GetInstance.JsonErrorMessage("参数错误!");
                        return;
                    }
                    select_search.AppendFormat(" AND LEN(BirthDay) IS NOT NULL AND DATEDIFF(YY,BirthDay,GETDATE()) BETWEEN {0} AND {1}", int.Parse(req.Form["MinAge"]), int.Parse(req.Form["MaxAge"]));
                    select_search.Append(" AND (EduLevels='适龄未入学或辍学' OR StudentStatus='非在校生' OR LEN(EduLevels)=0 OR LEN(StudentStatus)=0)");
                    break;
                case "work":
                    if (string.IsNullOrEmpty(req.Form["WorkType"]))
                    {
                        Common.GetInstance.JsonErrorMessage("参数错误!");
                        return;
                    }

                    select_search.AppendFormat(" AND ID IN(SELECT PovertyArchivesID FROM View_StudentArchivesWork WHERE LHSWorkId IN(SELECT ID FROM Work WHERE Type='{0}') AND ID IN(SELECT MAX(ID) FROM StudentArchives WHERE IsLHS=1 AND LEN(LHSWorkId)>0 GROUP BY PovertyArchivesID ))", server.UrlDecode(req.Form["WorkType"]));
                    break;
            }
            int pagecount = 0, recordcount = 0;
            System.Collections.Generic.List<Model.PovertyArchives> povertyList = BLL.BLL<Model.PovertyArchives>.Creator("pager").Parameter(@"ID,Name,BirthDay,IdCardNo,ProvinceName,CityName,CountyName,CountrySideName,VillageName,PovertyStates,HouseholderId,EduLevels", select_search.ToString(), "", Convert.ToInt32(req.Form["pageno"]), Convert.ToInt32(req.Form["pagesize"]), ref pagecount, ref recordcount);
            if (povertyList.Count > 0)
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
                foreach (Model.PovertyArchives pa in povertyList)
                {
                    sb.Append("{");
                    sb.AppendFormat("\"ID\":\"{0}\",", pa.ID);
                    sb.AppendFormat("\"Name\":\"{0}\",", !string.IsNullOrEmpty(pa.Name) ? pa.Name.Trim() : string.Empty);
                    sb.AppendFormat("\"BirthDay\":\"{0}\",", !string.IsNullOrEmpty(pa.BirthDay) ? pa.BirthDay.Trim() : string.Empty);
                    sb.AppendFormat("\"IdCardNo\":\"{0}\",", !string.IsNullOrEmpty(pa.IdCardNo) ? pa.IdCardNo.Trim() : string.Empty);
                    sb.AppendFormat("\"ProvinceName\":\"{0}\",", !string.IsNullOrEmpty(pa.ProvinceName) ? pa.ProvinceName.Trim() : string.Empty);
                    sb.AppendFormat("\"CityName\":\"{0}\",", !string.IsNullOrEmpty(pa.CityName) ? pa.CityName.Trim() : string.Empty);
                    sb.AppendFormat("\"CountyName\":\"{0}\",", !string.IsNullOrEmpty(pa.CountyName) ? pa.CountyName.Trim() : string.Empty);
                    sb.AppendFormat("\"CountrySideName\":\"{0}\",", !string.IsNullOrEmpty(pa.CountrySideName) ? pa.CountrySideName.Trim() : string.Empty);
                    sb.AppendFormat("\"VillageName\":\"{0}\",", !string.IsNullOrEmpty(pa.VillageName) ? pa.VillageName.Trim() : string.Empty);
                    sb.AppendFormat("\"PovertyStates\":\"{0}\",", pa.PovertyStates);
                    sb.AppendFormat("\"HouseholderId\":\"{0}\",", pa.HouseholderId);
                    sb.AppendFormat("\"EduLevels\":\"{0}\"", !string.IsNullOrEmpty(pa.EduLevels) ? pa.EduLevels.Trim() : string.Empty);
                    sb.Append("},");
                }
                if (sb[sb.Length - 1] == ',')
                    sb.Remove(sb.Length - 1, 1);
                sb.Append("],");
                sb.AppendFormat("\"PageCnt\":{0},", pagecount);
                sb.AppendFormat("\"RecordCnt\":{0}", recordcount);
                sb.Append("}");
                res.Write(sb.ToString());
                return;
            }
            Common.GetInstance.JsonErrorMessage("获取数据失败");
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