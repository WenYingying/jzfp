﻿<%@ WebHandler Language="C#" Class="PagerByHouseHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using Model;
using BLL;
using System.Text.RegularExpressions;

public class PagerByHouseHandler : IHttpHandler {

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
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID={0}", Convert.ToInt64(req.Form["ID"]));
            }
            if (!string.IsNullOrEmpty(req.Form["Keyword"]))
            {
                if (Regex.IsMatch(req.Form["Keyword"], @"/[\u4e00-\u9fa5]/g"))
                {
                    select_search.AppendFormat(" AND Name LIKE '%{0}%'", req.Form["Keyword"].Trim());
                }
                else
                {
                    select_search.AppendFormat(" AND IdCardNo LIKE '%{0}%'", req.Form["Keyword"].Trim());
                }
            }
            if (!string.IsNullOrEmpty(req.Form["IdCardNo"]))
            {
                select_search.AppendFormat(" AND IdCardNo LIKE '%{0}%'", req.Form["IdCardNo"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["Name"]))
            {
                select_search.AppendFormat(" AND Name LIKE '%{0}%'", req.Form["Name"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["Phone"]))
            {
                select_search.AppendFormat(" AND Phone LIKE '%{0}%'", req.Form["Phone"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["PovertyStates"]))
            {
                select_search.AppendFormat(" AND PovertyStates={0}", req.Form["PovertyStates"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["VillageId"]) && req.Form["VillageId"] != "0")
            {
                select_search.AppendFormat(" AND VillageId={0}", req.Form["VillageId"].Trim());
            }
            if ((string.IsNullOrEmpty(req.Form["VillageId"]) || req.Form["VillageId"] == "0")&&!string.IsNullOrEmpty(req.Form["CountrysideID"]) && req.Form["CountrysideID"] != "0")
            {
                select_search.AppendFormat(" AND CountrysideID={0}", req.Form["CountrysideID"].Trim());
            }
            if ((string.IsNullOrEmpty(req.Form["VillageId"]) ||  req.Form["VillageId"] == "0")&&(string.IsNullOrEmpty(req.Form["CountrysideID"]) ||  req.Form["CountrysideID"] == "0") && !string.IsNullOrEmpty(req.Form["CountyID"]) && req.Form["CountyID"] != "0")
            {
                select_search.AppendFormat(" AND CountyID={0}", req.Form["CountyID"].Trim());
            }
            if ((string.IsNullOrEmpty(req.Form["VillageId"]) ||  req.Form["VillageId"] == "0")&&(string.IsNullOrEmpty(req.Form["CountrysideID"]) ||  req.Form["CountrysideID"] == "0") &&(string.IsNullOrEmpty(req.Form["CountyID"]) ||  req.Form["CountyID"] == "0") &&!string.IsNullOrEmpty(req.Form["CityID"]) && req.Form["CityID"] != "0")
            {
                select_search.AppendFormat(" AND CityID={0}", req.Form["CityID"].Trim());
            }
            if ((string.IsNullOrEmpty(req.Form["VillageId"]) ||  req.Form["VillageId"] == "0")&&(string.IsNullOrEmpty(req.Form["CountrysideID"]) ||  req.Form["CountrysideID"] == "0") &&(string.IsNullOrEmpty(req.Form["CountyID"]) ||  req.Form["CountyID"] == "0") &&(string.IsNullOrEmpty(req.Form["CityID"]) ||  req.Form["CityID"] == "0") && !string.IsNullOrEmpty(req.Form["ProvinceID"]) && req.Form["ProvinceID"] != "0")
            {
                select_search.AppendFormat(" AND ProvinceID={0}", req.Form["ProvinceID"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["DiscerningStandards"]))
            {
                select_search.AppendFormat(" AND DiscerningStandards='{0}'", req.Form["DiscerningStandards"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["PovertyProperties"]))
            {
                select_search.AppendFormat(" AND PovertyProperties='{0}'", req.Form["PovertyProperties"].Trim());
            }
            if (!string.IsNullOrEmpty(req.Form["PovertyReason"]))
            {
                select_search.AppendFormat(" AND PovertyReason='{0}'", req.Form["PovertyReason"].Trim());
            }
            List<PovertyArchives> list = null;
            if (!string.IsNullOrEmpty(req.Form["Name"]) || !string.IsNullOrEmpty(req.Form["IdCardNo"]))
            {
                      list= BLL<PovertyArchives>.Creator("Pager").Parameter(@"ID,Name,IdCardNo,Phone,FamilySize,State,OffPovertyTime,ProvinceName,ProvincePinYin,CityName,CountyName,CountyID,CountrySideName,VillageName,Address,PovertyStates,PovertyReason,PovertyProperties,DiscerningStandards", select_search.ToString(), "", Convert.ToInt32(req.Form["pageno"]), Convert.ToInt32(req.Form["pagesize"]), ref pagecount, ref recordcount);
            }else
            {
                  list = BLL<PovertyArchives>.Creator("PagerByHouse").Parameter(@"ID,Name,IdCardNo,Phone,FamilySize,State,OffPovertyTime,ProvinceName,ProvincePinYin,CityName,CountyName,CountyID,CountrySideName,VillageName,Address,PovertyStates,InSchoolCount,PovertyReason,PovertyProperties,DiscerningStandards", select_search.ToString(), "", Convert.ToInt32(req.Form["pageno"]), Convert.ToInt32(req.Form["pagesize"]), ref pagecount, ref recordcount);
            }



            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"PageCount\":" + pagecount.ToString() + ",\"RecordCount\":" + recordcount + ",\"Data\":[");
            foreach (Model.PovertyArchives palist in list)
            {
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", palist.ID);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(palist.Name) ? string.Empty : palist.Name.Trim());
                sb.AppendFormat("\"IdCardNo\":\"{0}\",", string.IsNullOrEmpty(palist.IdCardNo) ? string.Empty : palist.IdCardNo.Trim());
                sb.AppendFormat("\"FamilySize\":\"{0}\",", palist.FamilySize);
                sb.AppendFormat("\"VillageId\":\"{0}\",", palist.VillageId);
                sb.AppendFormat("\"Address\":\"{0}\",", string.IsNullOrEmpty(palist.Address) ? string.Empty : palist.Address.Trim());
                sb.AppendFormat("\"DiscerningStandards\":\"{0}\",", string.IsNullOrEmpty(palist.DiscerningStandards) ? string.Empty : palist.DiscerningStandards.Trim());
                sb.AppendFormat("\"PovertyProperties\":\"{0}\",", string.IsNullOrEmpty(palist.PovertyProperties) ? string.Empty : palist.PovertyProperties.Trim());
                sb.AppendFormat("\"PovertyReason\":\"{0}\",", string.IsNullOrEmpty(palist.PovertyReason) ? string.Empty : palist.PovertyReason.Trim());
                sb.AppendFormat("\"Phone\":\"{0}\",", string.IsNullOrEmpty(palist.Phone) ? string.Empty : palist.Phone.Trim());
                sb.AppendFormat("\"PovertyStates\":\"{0}\",",palist.PovertyStates);
                sb.AppendFormat("\"InSchoolCount\":\"{0}\",", palist.InSchoolCount);
                sb.AppendFormat("\"State\":\"{0}\",", palist.State);
                sb.AppendFormat("\"OffPovertyTime\":\"{0}\",", string.IsNullOrEmpty(palist.OffPovertyTime) ? string.Empty : palist.OffPovertyTime.Trim());
                sb.AppendFormat("\"ProvinceID\":\"{0}\",", palist.ProvinceID);
                sb.AppendFormat("\"CityID\":\"{0}\",", palist.CityID);
                sb.AppendFormat("\"CountrySideID\":\"{0}\",", palist.CountrySideID);
                sb.AppendFormat("\"CountyID\":\"{0}\",", palist.CountyID);
                sb.AppendFormat("\"ProvinceName\":\"{0}\",", string.IsNullOrEmpty(palist.ProvinceName) ? string.Empty : palist.ProvinceName.Trim());
                sb.AppendFormat("\"CityName\":\"{0}\",", string.IsNullOrEmpty(palist.CityName) ? string.Empty : palist.CityName.Trim());
                sb.AppendFormat("\"CountyName\":\"{0}\",", string.IsNullOrEmpty(palist.CountyName) ? string.Empty : palist.CountyName.Trim());
                sb.AppendFormat("\"CountrySideName\":\"{0}\",", string.IsNullOrEmpty(palist.CountrySideName) ? string.Empty : palist.CountrySideName.Trim());
                sb.AppendFormat("\"VillageName\":\"{0}\",", string.IsNullOrEmpty(palist.VillageName) ? string.Empty : palist.VillageName.Trim());
                sb.AppendFormat("\"ProvincePinYin\":\"{0}\",", string.IsNullOrEmpty(palist.ProvincePinYin) ? string.Empty : palist.ProvincePinYin.Trim());
                sb.AppendFormat("\"CityPinYin\":\"{0}\",", string.IsNullOrEmpty(palist.CityPinYin) ? string.Empty : palist.CityPinYin.Trim());
                sb.AppendFormat("\"CountyPinYin\":\"{0}\",", string.IsNullOrEmpty(palist.CountyPinYin) ? string.Empty : palist.CountyPinYin.Trim());
                sb.AppendFormat("\"CountrySidePinYin\":\"{0}\"", string.IsNullOrEmpty(palist.CountrySidePinYin) ? string.Empty : palist.CountrySidePinYin.Trim());
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