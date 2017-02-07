<%@ WebHandler Language="C#" Class="PagerHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using Model;
using BLL;

public class PagerHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
     context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["pageno"]) || string.IsNullOrEmpty(req.Form["pagesize"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            //根据参数中的字段拼接查询条件
            System.Text.StringBuilder select_search = new System.Text.StringBuilder();

            int pagecount = 0, recordcount = 0;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["UserId"]))
            {
                select_search.AppendFormat(" AND UserId={0}", req.Form["UserId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["BatchNumber"]))
            {
                select_search.AppendFormat(" AND BatchNumber='{0}'", req.Form["BatchNumber"]);
            }
            if (!string.IsNullOrEmpty(req.Form["BeginTime"]) && !string.IsNullOrEmpty(req.Form["EndTime"]))
            {
                select_search.AppendFormat(" AND PostTime BETWEEN '{0}' AND '{1}'", req.Form["BeginTime"], req.Form["EndTime"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CityId"]) && req.Form["CityId"] != "0")
            {
                select_search.AppendFormat(" AND CityId={0}", req.Form["CityId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountyId"]) && req.Form["CountyId"] != "0")
            {
                select_search.AppendFormat(" AND CountyId={0}", req.Form["CountyId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountrySideId"]) && req.Form["CountrySideId"] != "0")
            {
                select_search.AppendFormat(" AND CountrySideId={0}", req.Form["CountrySideId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["VillageId"]) && req.Form["VillageId"] != "0")
            {
                select_search.AppendFormat(" AND VillageId={0}", req.Form["VillageId"]);
            }
            List<ExportRecord> list = BLL<ExportRecord>.Creator("Pager").Parameter(@" * ",
                                                                                      select_search.ToString(), "", Convert.ToInt32(req.Form["pageno"]), Convert.ToInt32(req.Form["pagesize"]), ref pagecount, ref recordcount);

            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            jss.Serialize(list, sb);
            res.Write("{\"Result\":true,\"Message\":\"获取成功!\",\"PageCount\":" + pagecount.ToString() + ",\"RecordCount\":" + recordcount + ",\"Data\":" + sb.ToString() + "}");
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