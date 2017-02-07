<%@ WebHandler Language="C#" Class="PagerHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using Model;
using BLL;

public class PagerHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
       //context.Response.AddHeader("Access-Control-Allow-Origin", "*");       
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
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", Convert.ToInt64(req.Form["ID"]));
            }
              if (!string.IsNullOrEmpty(req.Form["SearchAll"]))
            {
                select_search.AppendFormat(" AND ( LoginName LIKE '{0}' OR Name LIKE '%{0}%' OR Phone LIKE '%{0}%')", req.Form["SearchAll"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["LoginName"]))
            {
                select_search.AppendFormat(" AND LoginName LIKE '{0}'", req.Form["LoginName"].Trim());
            }
               if (!string.IsNullOrEmpty(req.Form["Name"]))
            {
                select_search.AppendFormat(" AND Name LIKE '%{0}%'", req.Form["Name"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["Phone"]))
            {
                select_search.AppendFormat(" AND Phone LIKE '%{0}%'", req.Form["Phone"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["ProvinceId"]))
            {
                select_search.AppendFormat(" AND ProvinceId ={0}", req.Form["ProvinceId"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["CityId"]))
            {
                select_search.AppendFormat(" AND CityId ={0}", req.Form["CityId"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["CountyId"]))
            {
                select_search.AppendFormat(" AND CountyId ={0}", req.Form["CountyId"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["CountrySideId"]))
            {
                select_search.AppendFormat(" AND CountrySideId ={0}", req.Form["CountrySideId"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["VillageId"]))
            {
                select_search.AppendFormat(" AND VillageId ={0}", req.Form["VillageId"].Trim());
            }
            List<User> list = BLL<User>.Creator("Pager").Parameter(@" * ",
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