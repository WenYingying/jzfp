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
            if (string.IsNullOrEmpty(req.Form["ProvinceID"]) && string.IsNullOrEmpty(req.Form["ID"]))
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
            if (!string.IsNullOrEmpty(req.Form["ProvinceID"]))
            {
                select_search.AppendFormat(" AND ProvinceID={0} ", req.Form["ProvinceID"]);
            }

            StringBuilder sb = new StringBuilder();
            List<City> list = BLL<City>.Creator("Select").Parameter("*", select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (City city in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", city.ID);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(city.Name) ? string.Empty : city.Name.Trim());
                sb.AppendFormat("\"PinYin\":\"{0}\",", string.IsNullOrEmpty(city.PinYin) ? string.Empty : city.PinYin.Trim());
                sb.AppendFormat("\"ProvinceID\":\"{0}\"", city.ProvinceID);
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