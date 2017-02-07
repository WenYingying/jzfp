<%@ WebHandler Language="C#" Class="GetHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using Model;
using BLL;

public class GetHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) && string.IsNullOrEmpty(req.Form["Name"])&& string.IsNullOrEmpty(req.Form["EduLevels"])&& string.IsNullOrEmpty(req.Form["CityID"]) && string.IsNullOrEmpty(req.Form["IsEnable"])&& string.IsNullOrEmpty(req.Form["CountyID"])&& string.IsNullOrEmpty(req.Form["ProvinceID"])&& string.IsNullOrEmpty(req.Form["Grade"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }

            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND Policy.ID={0}", req.Form["ID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["Name"]))
            {
                select_search.AppendFormat(" AND Policy.Name LIKE '{0}'", req.Form["Name"]);
            }
            if (!string.IsNullOrEmpty(req.Form["EduLevels"]))
            {
                select_search.AppendFormat(" AND EduLevels='{0}'", req.Form["EduLevels"]);
            }
            if (!string.IsNullOrEmpty(req.Form["IsEnable"]))
            {
                select_search.AppendFormat(" AND IsEnable='{0}'", req.Form["IsEnable"]);
            }
            if (string.IsNullOrEmpty(req.Form["Area"]))
            {
                if (!string.IsNullOrEmpty(req.Form["ProvinceID"]) || !string.IsNullOrEmpty(req.Form["CityID"]) || !string.IsNullOrEmpty(req.Form["CountyID"]))
                {
                    select_search.Append("AND (");
                    if (!string.IsNullOrEmpty(req.Form["ProvinceID"]) && req.Form["ProvinceID"] != "0")
                    {
                        select_search.AppendFormat(" Policy.ProvinceID={0}", req.Form["ProvinceID"]);
                    }
                    if (!string.IsNullOrEmpty(req.Form["CityID"]) && req.Form["CityID"] != "0")
                    {
                        if (string.IsNullOrEmpty(req.Form["ProvinceID"]) || req.Form["ProvinceID"] == "0")
                        {
                            select_search.AppendFormat(" Policy.CityID={0}", req.Form["CityID"]);
                        }
                        else
                        {
                            select_search.AppendFormat(" OR Policy.CityID={0}", req.Form["CityID"]);

                        }

                    }
                    if (!string.IsNullOrEmpty(req.Form["CountyID"]) && req.Form["CountyID"] != "0")
                    {
                        if (string.IsNullOrEmpty(req.Form["CountyID"]) || req.Form["CountyID"] == "0")
                        {
                            select_search.AppendFormat(" Policy.CountyID={0}", req.Form["CountyID"]);
                        }
                        else
                        {
                            select_search.AppendFormat(" OR Policy.CountyID={0}", req.Form["CountyID"]);
                        }

                    }
                    select_search.Append(")");

                }
            }
            else
            {
                if(req.Form["Area"]=="City")
                {
                    select_search.Append("AND (");
                    select_search.AppendFormat(" Policy.ProvinceID={0}", req.Form["ProvinceID"]);
                    select_search.AppendFormat(" OR Policy.CityID={0}", req.Form["CityID"]);
                    select_search.AppendFormat(" OR Policy.CountyID in (SELECT ID FROM County WHERE CityID={0}))", req.Form["CityID"]);
                }
            }
            if (!string.IsNullOrEmpty(req.Form["Grade"]))
            {
                select_search.AppendFormat(" AND Grade={0}", req.Form["Grade"]);
            }
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.Policy> list = BLL.BLL<Model.Policy>.Creator("Select").Parameter(@"Policy.*,City.Name AS CityName,Province.Name AS ProvinceName,County.Name AS CountyName", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.Policy policy in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", policy.ID);
                sb.AppendFormat("\"UserId\":\"{0}\",", policy.UserId);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(policy.Name) ? string.Empty : policy.Name.Replace("\n", "\\n").Replace("\r", "\\r").Replace("\"", "\\\"").Replace("\\","\\\\").Replace("\"", "\\\"").Trim());
                sb.AppendFormat("\"Detail\":\"{0}\",", string.IsNullOrEmpty(policy.Detail) ? string.Empty : policy.Detail.Replace("\n", "\\n").Replace("\r", "\\r").Replace("\"", "\\\"").Replace("\\","\\\\").Replace("\"", "\\\"").Trim());
                sb.AppendFormat("\"EduLevels\":\"{0}\",", policy.EduLevels);
                sb.AppendFormat("\"CityID\":\"{0}\",", policy.CityID);
                sb.AppendFormat("\"CountyID\":\"{0}\",", policy.CountyID);
                sb.AppendFormat("\"ProvinceID\":\"{0}\",", policy.ProvinceID);
                sb.AppendFormat("\"IsEnable\":\"{0}\",", policy.IsEnable);
                sb.AppendFormat("\"Grade\":\"{0}\",", policy.Grade);
                sb.AppendFormat("\"Amount\":\"{0}\",", string.IsNullOrEmpty(policy.Amount) ? string.Empty : policy.Amount.Replace(".00","").Trim());
                sb.AppendFormat("\"CityName\":\"{0}\",", string.IsNullOrEmpty(policy.CityName) ? string.Empty : policy.CityName.Trim());
                sb.AppendFormat("\"CountyName\":\"{0}\",", string.IsNullOrEmpty(policy.CountyName) ? string.Empty : policy.CountyName.Trim());
                sb.AppendFormat("\"ProvinceName\":\"{0}\",", string.IsNullOrEmpty(policy.ProvinceName) ? string.Empty : policy.ProvinceName.Trim());
                sb.AppendFormat("\"PostTime\":\"{0}\"", string.IsNullOrEmpty(policy.PostTime) ? string.Empty : policy.PostTime.Trim());
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