﻿<%@ WebHandler Language="C#" Class="PagerHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using Model;
using BLL;

public class PagerHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
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
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["UserId"]))
            {
                select_search.AppendFormat(" AND UserId={0}", req.Form["UserId"]);
            }
            if (!string.IsNullOrEmpty(req.Form["Name"]))
            {
                select_search.AppendFormat(" AND Name LIKE '{0}'", req.Form["Name"]);
            }
            if (!string.IsNullOrEmpty(req.Form["ProvinceID"]) || !string.IsNullOrEmpty(req.Form["CityID"]) || !string.IsNullOrEmpty(req.Form["CountyID"]))
            {
                select_search.Append("AND ( 1=1");
                if (!string.IsNullOrEmpty(req.Form["ProvinceID"]) && req.Form["ProvinceID"] != "0")
                {
                    select_search.AppendFormat(" OR ProvinceID={0}", req.Form["ProvinceID"]);
                }
                if (!string.IsNullOrEmpty(req.Form["CityID"]) && req.Form["CityID"] != "0")
                {
                    select_search.AppendFormat(" OR CityID={0}", req.Form["CityID"]);
                }
                if (!string.IsNullOrEmpty(req.Form["CountyID"]) && req.Form["CountyID"] != "0")
                {
                    select_search.AppendFormat(" OR CountyID={0}", req.Form["CountyID"]);
                }
                select_search.Append(")");
            }
            List<Notice> list = BLL<Notice>.Creator("Pager").Parameter(@" * ",
                                                                                      select_search.ToString(), "", Convert.ToInt32(req.Form["pageno"]), Convert.ToInt32(req.Form["pagesize"]), ref pagecount, ref recordcount);
            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"PageCount\":" + pagecount.ToString() + ",\"RecordCount\":" + recordcount + ",\"Data\":[");
            foreach (Model.Notice notice in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", notice.ID);
                sb.AppendFormat("\"UserId\":\"{0}\",", notice.UserId);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(notice.Name) ? string.Empty : notice.Name.Trim());
                sb.AppendFormat("\"Detail\":\"{0}\",", string.IsNullOrEmpty(notice.Detail) ? string.Empty : notice.Detail.Replace("\\n","\\\n").Replace("\\r","\\\r").Replace("\"","\\\"").Replace("\\","\\\\").Replace("\"", "\\\"").Trim());
                sb.AppendFormat("\"ProvinceID\":\"{0}\",", notice.ProvinceID);
                sb.AppendFormat("\"CityID\":\"{0}\",", notice.CityID);
                sb.AppendFormat("\"CountyID\":\"{0}\",", notice.CountyID);
                sb.AppendFormat("\"ProvinceName\":\"{0}\",", string.IsNullOrEmpty(notice.ProvinceName) ? string.Empty : notice.ProvinceName.Trim());
                sb.AppendFormat("\"ProvincePinYin\":\"{0}\",", string.IsNullOrEmpty(notice.ProvincePinYin) ? string.Empty : notice.ProvincePinYin.Trim());
                sb.AppendFormat("\"CityName\":\"{0}\",", string.IsNullOrEmpty(notice.CityName) ? string.Empty : notice.CityName.Trim());
                sb.AppendFormat("\"CityPinYin\":\"{0}\",", string.IsNullOrEmpty(notice.CityPinYin) ? string.Empty : notice.CityPinYin.Trim());
                sb.AppendFormat("\"CountyName\":\"{0}\",", string.IsNullOrEmpty(notice.CountyName) ? string.Empty : notice.CountyName.Trim());
                sb.AppendFormat("\"CountyPinYin\":\"{0}\",", string.IsNullOrEmpty(notice.CountyPinYin) ? string.Empty : notice.CountyPinYin.Trim());
                sb.AppendFormat("\"PostTime\":\"{0}\"", string.IsNullOrEmpty(notice.PostTime) ? string.Empty : notice.PostTime.Trim());
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