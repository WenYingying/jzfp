<%@ WebHandler Language="C#" Class="GetHandler" %>

using System;
using System.Web;
using Model;
public class GetHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) && string.IsNullOrEmpty(req.Form["IdCardNo"]) && string.IsNullOrEmpty(req.Form["Name"]) && string.IsNullOrEmpty(req.Form["Phone"]) && string.IsNullOrEmpty(req.Form["ProvinceID"]) && string.IsNullOrEmpty(req.Form["CityID"]) && string.IsNullOrEmpty(req.Form["CountyID"]) && string.IsNullOrEmpty(req.Form["CountrySideID"]) && string.IsNullOrEmpty(req.Form["VillageId"]) && string.IsNullOrEmpty(req.Form["Month"]) && string.IsNullOrEmpty(req.Form["EduLevels"])&& string.IsNullOrEmpty(req.Form["HouseholderId"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            string select_list = "*";
            if (!string.IsNullOrEmpty(req.Form["ID"]) || !string.IsNullOrEmpty(req.Form["IdCardNo"]) || !string.IsNullOrEmpty(req.Form["Name"]) || !string.IsNullOrEmpty(req.Form["Phone"]) || !string.IsNullOrEmpty(req.Form["HouseholderRelation"]) || !string.IsNullOrEmpty(req.Form["HouseholderId"]))
            {
                //查询条件
                if (!string.IsNullOrEmpty(req.Form["ID"]))
                {
                    select_search.AppendFormat(" AND ID={0}", req.Form["ID"]);
                }
                if (!string.IsNullOrEmpty(req.Form["IdCardNo"]))
                {
                    select_search.AppendFormat(" AND IdCardNo='{0}'", req.Form["IdCardNo"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["HouseholderRelation"]))
                {
                    select_search.AppendFormat(" AND HouseholderRelation='{0}'", req.Form["HouseholderRelation"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["HouseholderId"]))
                {
                    select_search.AppendFormat(" AND HouseholderId={0}", req.Form["HouseholderId"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["StudentStatus"]))
                {
                    select_search.Append(" AND StudentStatus!='非在校生'  AND StudentStatus!='' AND StudentStatus IS NOT NULL  AND EduLevels!='文盲或半文盲' AND EduLevels!='非学龄段' AND EduLevels!='适龄未入学或辍学'");
                }
                if (!string.IsNullOrEmpty(req.Form["Name"]))
                {
                    select_search.AppendFormat(" AND Name like '%{0}%'", req.Form["Name"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["Phone"]))
                {
                    select_search.AppendFormat(" AND Phone='{0}'", req.Form["Phone"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["ProvinceID"]) && req.Form["ProvinceID"] != "0")
                {
                    select_search.AppendFormat(" AND ProvinceID={0}", req.Form["ProvinceID"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["CityID"]) && req.Form["CityID"] != "0")
                {
                    select_search.AppendFormat(" AND CityID={0}", req.Form["CityID"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["CountyID"]) && req.Form["CountyID"] != "0")
                {
                    select_search.AppendFormat(" AND CountyID={0}", req.Form["CountyID"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["CountrySideID"]) && req.Form["CountrySideID"] != "0")
                {
                    select_search.AppendFormat(" AND CountrySideID={0}", req.Form["CountrySideID"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["VillageId"]) && req.Form["VillageId"] != "0")
                {
                    select_search.AppendFormat(" AND VillageId={0}", req.Form["VillageId"].Trim());
                }
                select_search.Append(" ORDER BY IsHouseHolder desc,BirthDay");

            }
            else
            {
                if (string.IsNullOrEmpty(req.Form["ProvinceID"]) && string.IsNullOrEmpty(req.Form["CityID"]) && string.IsNullOrEmpty(req.Form["CountyID"]) && string.IsNullOrEmpty(req.Form["CountrySideID"]) && string.IsNullOrEmpty(req.Form["VillageId"]) && string.IsNullOrEmpty(req.Form["Month"]) && string.IsNullOrEmpty(req.Form["EduLevels"])  && string.IsNullOrEmpty(req.Form["StudentStatus"])&& string.IsNullOrEmpty(req.Form["EndMonth"]))
                {
                    Common.GetInstance.JsonErrorMessage("参数错误");
                    return;
                }
                if (!string.IsNullOrEmpty(req.Form["StudentStatus"]))
                {
                    select_search.Append(" AND StudentStatus!='非在校生'  AND StudentStatus!='' AND StudentStatus IS NOT NULL  AND EduLevels!='文盲或半文盲' AND EduLevels!='非学龄段' AND EduLevels!='适龄未入学或辍学'");
                }

                if (!string.IsNullOrEmpty(req.Form["ProvinceID"]) && req.Form["ProvinceID"] != "0")
                {
                    select_search.AppendFormat(" AND ProvinceID={0}", req.Form["ProvinceID"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["CityID"]) && req.Form["CityID"] != "0")
                {
                    select_search.AppendFormat(" AND CityID={0}", req.Form["CityID"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["CountyID"]) && req.Form["CountyID"] != "0")
                {
                    select_search.AppendFormat(" AND CountyID={0}", req.Form["CountyID"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["CountrySideID"]) && req.Form["CountrySideID"] != "0")
                {
                    select_search.AppendFormat(" AND CountrySideID={0}", req.Form["CountrySideID"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["VillageId"]) && req.Form["VillageId"] != "0")
                {
                    select_search.AppendFormat(" AND VillageId={0}", req.Form["VillageId"].Trim());
                }
                if (!string.IsNullOrEmpty(req.Form["EndMonth"]))
                {
                    select_search.AppendFormat(" AND (PostTime IS NULL OR DATEDIFF(mm,cast(year(getdate())-1 as nchar(4))+'-12-31',posttime)>='{0}')", req.Form["EndMonth"].Trim());
                }

                if (!string.IsNullOrEmpty(req.Form["EduLevels"]))
                {
                    if (req.Form["EduLevels"] == "其他")
                    {
                        select_search.AppendFormat(" AND (EduLevels NOT IN ('学前教育','小学','初中','特教学生','高中','高职教育','中职教育','预科','专科','本科','硕士','博士') OR EduLevels IS NULL) ");
                    }
                    else
                    {
                        select_search.AppendFormat(" AND EduLevels='{0}'", req.Form["EduLevels"].Trim());
                    }

                }
                if (!string.IsNullOrEmpty(req.Form["Month"]) && req.Form["Month"] != "0")
                {
                    select_search.AppendFormat(" AND DATEDIFF(mm,cast(year(getdate())-1 as nchar(4))+'-12-31',posttime)={0}", req.Form["Month"].Trim());
                }
                select_search.Append("  GROUP BY  PovertyStates");
                select_list = " PovertyStates,COUNT(*) AS ID";
            }
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Collections.Generic.List<Model.PovertyArchives> list = BLL.BLL<Model.PovertyArchives>.Creator("Select").Parameter(select_list.ToString(), select_search.ToString());

            sb.Append("{\"Result\":true,\"Message\":\"获取成功!\",\"Data\":[");
            foreach (Model.PovertyArchives palist in list)
            {
                if (select_list.IndexOf("COUNT(*)") == -1)
                {


                    System.Collections.Generic.List<Model.StudentArchives> stulist = BLL.BLL<Model.StudentArchives>.Creator("Select").Parameter("TOP 1 ID,StudentNo,UserID,PolicyID,IsLHS,LHSWorkId,OutpreschoolReason,IsProvinceStudy,SchoolNature,DropoutSchool,ReturnSchool,Remark,PostTime,SchoolName", "AND PovertyArchivesID=" + palist.ID + " ORDER BY PostTime desc");
                    if (stulist.Count > 0)
                    {
                        palist.StudentNo = stulist[0].StudentNo;
                        palist.UserID = stulist[0].UserID;
                        palist.studentArchivesID = stulist[0].ID;
                        palist.PolicyID = stulist[0].PolicyID;
                        palist.IsLHS = stulist[0].IsLHS;
                        palist.LHSWorkId = stulist[0].LHSWorkId;
                        palist.OutpreschoolReason = stulist[0].OutpreschoolReason;
                        palist.IsProvinceStudy = stulist[0].IsProvinceStudy;
                        palist.SchoolNature = stulist[0].SchoolNature;
                        palist.DropoutSchool = stulist[0].DropoutSchool;
                        palist.ReturnSchool = stulist[0].ReturnSchool;
                        palist.Remark = stulist[0].Remark;
                        palist.PostTime = stulist[0].PostTime;
                        palist.SchoolName = stulist[0].SchoolName;
                    }
                }
                sb.Append("{");
                sb.AppendFormat("\"ID\":\"{0}\",", palist.ID);
                sb.AppendFormat("\"Name\":\"{0}\",", string.IsNullOrEmpty(palist.Name) ? string.Empty : palist.Name.Trim());
                sb.AppendFormat("\"Gender\":\"{0}\",", palist.Gender);
                sb.AppendFormat("\"Nation\":\"{0}\",", palist.Nation);
                sb.AppendFormat("\"BirthDay\":\"{0}\",", string.IsNullOrEmpty(palist.BirthDay) ? string.Empty : palist.BirthDay.Trim());
                sb.AppendFormat("\"IdCardNo\":\"{0}\",", string.IsNullOrEmpty(palist.IdCardNo) ? string.Empty : palist.IdCardNo.Trim());
                sb.AppendFormat("\"FamilySize\":\"{0}\",", palist.FamilySize);
                sb.AppendFormat("\"VillageId\":\"{0}\",", palist.VillageId);
                sb.AppendFormat("\"Address\":\"{0}\",", string.IsNullOrEmpty(palist.Address) ? string.Empty : palist.Address.Trim());
                sb.AppendFormat("\"HouseholderRelation\":\"{0}\",", string.IsNullOrEmpty(palist.HouseholderRelation) ? string.Empty : palist.HouseholderRelation.Trim());
                sb.AppendFormat("\"EduLevels\":\"{0}\",", string.IsNullOrEmpty(palist.EduLevels) ? string.Empty : palist.EduLevels.Trim());
                sb.AppendFormat("\"StudentStatus\":\"{0}\",", string.IsNullOrEmpty(palist.StudentStatus) ? string.Empty : palist.StudentStatus.Trim());
                sb.AppendFormat("\"StudentNo\":\"{0}\",", string.IsNullOrEmpty(palist.StudentNo) ? string.Empty : palist.StudentNo.Trim());
                sb.AppendFormat("\"DiscerningStandards\":\"{0}\",", string.IsNullOrEmpty(palist.DiscerningStandards) ? string.Empty : palist.DiscerningStandards.Trim());
                sb.AppendFormat("\"PovertyProperties\":\"{0}\",", string.IsNullOrEmpty(palist.PovertyProperties) ? string.Empty : palist.PovertyProperties.Trim());
                sb.AppendFormat("\"PovertyReason\":\"{0}\",", string.IsNullOrEmpty(palist.PovertyReason) ? string.Empty : palist.PovertyReason.Trim());
                sb.AppendFormat("\"Phone\":\"{0}\",", string.IsNullOrEmpty(palist.Phone) ? string.Empty : palist.Phone.Trim());
                sb.AppendFormat("\"State\":\"{0}\",", palist.State);
                sb.AppendFormat("\"OffPovertyTime\":\"{0}\",", string.IsNullOrEmpty(palist.OffPovertyTime) ? string.Empty : palist.OffPovertyTime.Trim());
                sb.AppendFormat("\"HouseholderId\":\"{0}\",", palist.HouseholderId);
                sb.AppendFormat("\"IsHouseHolder\":\"{0}\",", palist.IsHouseHolder);
                sb.AppendFormat("\"studentArchivesID\":\"{0}\",", palist.studentArchivesID);
                sb.AppendFormat("\"UserID\":\"{0}\",", palist.UserID);
                sb.AppendFormat("\"SchoolName\":\"{0}\",", string.IsNullOrEmpty(palist.SchoolName) ? string.Empty : palist.SchoolName.Trim());
                sb.AppendFormat("\"PolicyID\":\"{0}\",", palist.PolicyID);
                sb.AppendFormat("\"IsLHS\":\"{0}\",", palist.IsLHS);
                sb.AppendFormat("\"LHSWorkId\":\"{0}\",", palist.LHSWorkId);
                sb.AppendFormat("\"OutpreschoolReason\":\"{0}\",", string.IsNullOrEmpty(palist.OutpreschoolReason) ? string.Empty : palist.OutpreschoolReason.Trim());
                sb.AppendFormat("\"IsProvinceStudy\":\"{0}\",",palist.studentArchivesID==0?true:palist.IsProvinceStudy);
                sb.AppendFormat("\"SchoolNature\":\"{0}\",", palist.SchoolNature);
                sb.AppendFormat("\"DropoutSchool\":\"{0}\",", string.IsNullOrEmpty(palist.DropoutSchool) ? string.Empty : palist.DropoutSchool.Trim());
                sb.AppendFormat("\"ReturnSchool\":\"{0}\",", palist.ReturnSchool);
                sb.AppendFormat("\"Remark\":\"{0}\",", string.IsNullOrEmpty(palist.Remark) ? string.Empty : palist.Remark.Trim());
                sb.AppendFormat("\"PostTime\":\"{0}\",", string.IsNullOrEmpty(palist.PostTime) ? string.Empty : palist.PostTime.Trim());
                sb.AppendFormat("\"PovertyStates\":\"{0}\",", palist.PovertyStates);
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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}