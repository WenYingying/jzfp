<%@ WebHandler Language="C#" Class="PagerHandler" %>

using System;
using System.Web;

public class PagerHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
       context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["pageno"]) || string.IsNullOrEmpty(req.Form["pagesize"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            int pagecount = 0, recordcount = 0;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["UserID"]))
            {
                select_search.AppendFormat(" AND UserID={0}", req.Form["UserID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["ProvinceId"]) && req.Form["ProvinceId"] != "0")
            {
                select_search.AppendFormat(" AND ProvinceId={0}", req.Form["ProvinceId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CityId"]) && req.Form["CityId"] != "0")
            {
                select_search.AppendFormat(" AND CityId={0}", req.Form["CityId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountyId"]) && req.Form["CountyId"] != "0")
            {
                select_search.AppendFormat(" AND CountyId={0}", req.Form["CountyId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountrysideId"]) && req.Form["CountrysideId"] != "0")
            {
                select_search.AppendFormat(" AND CountrysideId={0}", req.Form["CountrysideId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["VillageId"]) && req.Form["VillageId"] != "0")
            {
                select_search.AppendFormat(" AND VillageId={0}", req.Form["VillageId"]);
            }

            System.Collections.Generic.List<Model.School> list = BLL.BLL<Model.School>.Creator("Pager").Parameter(@" * ",
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