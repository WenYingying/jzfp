<%@ WebHandler Language="C#" Class="GetHandler" %>

using System;
using System.Web;
using System.Text;
using System.Collections.Generic;
using Model;
using BLL;

public class GetHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
       context.Response.AddHeader("Access-Control-Allow-Origin", "*");             
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            StringBuilder select_search = new StringBuilder();
            if (string.IsNullOrEmpty(req.Form["CountyID"]) &&string.IsNullOrEmpty(req.Form["CityID"]) && string.IsNullOrEmpty(req.Form["ID"]) && string.IsNullOrEmpty(req.Form["ProvinceID"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", Convert.ToInt64(req.Form["ID"]));
            }
            if (!string.IsNullOrEmpty(req.Form["Name"]))
            {
                select_search.AppendFormat(" AND Name='{0}' ", req.Form["Name"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CountyID"]))
            {
                select_search.AppendFormat(" AND CountyID={0} ", req.Form["CountyID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["CityID"]))
            {
                select_search.AppendFormat(" AND CityID={0} ", req.Form["CityID"]);
            }
            if (!string.IsNullOrEmpty(req.Form["ProvinceID"]))
            {
                select_search.AppendFormat(" AND ProvinceID={0} ", req.Form["ProvinceID"]);
            }
            StringBuilder sb = new StringBuilder();
            List<Countryside> list = BLL<Countryside>.Creator("Select").Parameter("*", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Countryside countyside in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", countyside.ID);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(countyside.Name) ? string.Empty : countyside.Name.Trim());
                sb.AppendFormat("\"PinYin\":\"{0}\",", string.IsNullOrEmpty(countyside.PinYin) ? string.Empty : countyside.PinYin.Trim());
                sb.AppendFormat("\"CityID\":\"{0}\",", countyside.CityID);
                sb.AppendFormat("\"ProvinceID\":\"{0}\",", countyside.ProvinceID);
                sb.AppendFormat("\"CountyID\":\"{0}\"", countyside.CountyID);
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