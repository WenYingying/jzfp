<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using NPOI.SS.UserModel;
using NPOI.HSSF.UserModel;
using NPOI.SS.Util;
using System.IO;

public class Handler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["UserID"]) || string.IsNullOrEmpty(req.Form["ID"]) || string.IsNullOrEmpty(req.Form["SortId"]) || string.IsNullOrEmpty(req.Form["Batchnumber"]) || (string.IsNullOrEmpty(req.Form["CityId"]) && string.IsNullOrEmpty(req.Form["CountyId"]) && string.IsNullOrEmpty(req.Form["CountySideId"]) && string.IsNullOrEmpty(req.Form["VillageId"])))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            //根据参数中的字段拼接查询条件
            System.Text.StringBuilder select_search = new System.Text.StringBuilder();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            if (!string.IsNullOrEmpty(req.Form["ID"]))
            {
                select_search.AppendFormat(" AND ID ={0}", req.Form["ID"]);
            }
            System.Collections.Generic.List<Model.PovertyArchives> Houserholdlist = BLL.BLL<Model.PovertyArchives>.Creator("Select").Parameter(@"*", select_search.ToString());
            if (Houserholdlist.Count < 1)
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            //适龄未入学
            System.Collections.Generic.List<Model.OutPreschoolReason> OutSchoollist = BLL.BLL<Model.OutPreschoolReason>.Creator("Select").Parameter(@"*", "AND IsEnable=1");
            //政策
            System.Text.StringBuilder select_search1 = new System.Text.StringBuilder();
            select_search1.Append("AND (Policy.ProvinceID=29");
            select_search1.AppendFormat(" OR Policy.CityID={0}", req.Form["CityID"]);
            select_search1.AppendFormat(" OR Policy.CountyID={0}", req.Form["CountyID"]);
            select_search1.Append(") AND IsEnable=1");
            System.Collections.Generic.List<Model.Policy> ProvincePolicylist = BLL.BLL<Model.Policy>.Creator("Select").Parameter(@"Policy.*", select_search1.ToString() + "AND Grade=1");
            System.Collections.Generic.List<Model.Policy> CityPolicylist = BLL.BLL<Model.Policy>.Creator("Select").Parameter(@"Policy.*", select_search1.ToString() + "AND Grade=2");
            System.Collections.Generic.List<Model.Policy> CountyPolicylist = BLL.BLL<Model.Policy>.Creator("Select").Parameter(@"Policy.*", select_search1.ToString() + "AND Grade=3");
            //家庭人员信息
            System.Text.StringBuilder select_search2 = new System.Text.StringBuilder();
            select_search2.AppendFormat("AND HouseholderId='{0}'", Houserholdlist[0].ID);
            select_search2.Append("ORDER BY BirthDay");
            System.Collections.Generic.List<Model.PovertyArchives> studentlist = BLL.BLL<Model.PovertyArchives>.Creator("Select").Parameter(@"*", select_search2.ToString());
            int InschoolCount = 0;
            System.Collections.Generic.List<Model.PovertyArchives> newstudentlist = new System.Collections.Generic.List<Model.PovertyArchives>();
            foreach (Model.PovertyArchives palist in studentlist)
            {
                if (palist.HouseholderRelation == "本人或户主")
                {
                    newstudentlist.Add(palist);
                }

            }
            foreach (Model.PovertyArchives palist in studentlist)
            {
                if (palist.HouseholderRelation != "本人或户主")
                {
                    newstudentlist.Add(palist);
                }
                if (palist.StudentStatus != "" && palist.StudentStatus != "非在校生" && palist.StudentStatus != "NULL")
                {
                    InschoolCount++;
                }
            }

            //excel路径
            string filepath = req.Form["UserID"] + @"\" + DateTime.Now.ToString("yyyyMMdd") + @"\";
            string filename = Houserholdlist[0].Name.Trim() + req.Form["BatchNumber"] + Checklength(req.Form["SortId"], 3) + ".xls";
            HSSFWorkbook workbook = new HSSFWorkbook();//创建Workbook对象  
            ISheet sheet = workbook.CreateSheet("Sheet1");//创建工作表
            sheet.SetColumnWidth(0, 15 * 268);
            sheet.SetColumnWidth(1, 21 * 268);
            sheet.SetColumnWidth(2, 19 * 268);
            sheet.SetColumnWidth(3, 25 * 268);
            sheet.SetColumnWidth(4, 16 * 268);
            sheet.SetColumnWidth(5, 20 * 268);
            sheet.SetColumnWidth(6, 20 * 268);
            sheet.SetColumnWidth(7, 23 * 268);
            //标题样式（居中、字号20、加粗）
            ICellStyle title = workbook.CreateCellStyle();
            title.Alignment = HorizontalAlignment.Center;
            title.VerticalAlignment = VerticalAlignment.Center;
            title.SetFont(GetFontStyle(workbook, 20, true));
            //标签样式（居右、字号14、加粗）
            ICellStyle titleleftbold = workbook.CreateCellStyle();
            titleleftbold.Alignment = HorizontalAlignment.Right;
            titleleftbold.VerticalAlignment = VerticalAlignment.Center;
            titleleftbold.SetFont(GetFontStyle(workbook, 14, true));
            //标签样式（居左、字号14）
            ICellStyle textleft = workbook.CreateCellStyle();
            textleft.Alignment = HorizontalAlignment.Left;
            textleft.VerticalAlignment = VerticalAlignment.Center;
            textleft.SetFont(GetFontStyle(workbook, 14, false));
            //标签样式（居右、字号14）
            ICellStyle textright = workbook.CreateCellStyle();
            textright.Alignment = HorizontalAlignment.Right;
            textright.SetFont(GetFontStyle(workbook, 14, false));
            textright.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居右、字号14,上边框）
            ICellStyle textrightboder = workbook.CreateCellStyle();
            textrightboder.Alignment = HorizontalAlignment.Right;
            textrightboder.BorderTop = BorderStyle.Thin;
            textrightboder.SetFont(GetFontStyle(workbook, 14, false));
            textrightboder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居右、字号14,上边框,左边框）
            ICellStyle textrightlefttopboder = workbook.CreateCellStyle();
            textrightlefttopboder.CloneStyleFrom(textrightboder);
            textrightlefttopboder.BorderLeft = BorderStyle.Thin;
            textrightlefttopboder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居右、字号14,下边框,左边框）
            ICellStyle textrightleftbotboder = workbook.CreateCellStyle();
            textrightleftbotboder.CloneStyleFrom(textright);
            textrightleftbotboder.BorderLeft = BorderStyle.Thin;
            textrightleftbotboder.BorderBottom = BorderStyle.Thin;
            textrightleftbotboder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居右、字号14,左边框）
            ICellStyle textrightleftboder = workbook.CreateCellStyle();
            textrightleftboder.Alignment = HorizontalAlignment.Right;
            textrightleftboder.BorderLeft = BorderStyle.Thin;
            textrightleftboder.SetFont(GetFontStyle(workbook, 14, false));
            textrightleftboder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居右、字号14,上边框，右边框）
            ICellStyle textrighttoprightboder = workbook.CreateCellStyle();
            textrighttoprightboder.Alignment = HorizontalAlignment.Right;
            textrighttoprightboder.BorderTop = BorderStyle.Thin;
            textrighttoprightboder.BorderRight = BorderStyle.Thin;
            textrighttoprightboder.SetFont(GetFontStyle(workbook, 14, false));
            textrighttoprightboder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居左、字号14,上边框）
            ICellStyle textlefttopborder = workbook.CreateCellStyle();
            textlefttopborder.Alignment = HorizontalAlignment.Left;
            textlefttopborder.BorderTop = BorderStyle.Thin;
            textlefttopborder.SetFont(GetFontStyle(workbook, 14, false));
            textlefttopborder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居左、字号14,上边框,下边框）
            ICellStyle textlefttopbotborder = workbook.CreateCellStyle();
            textlefttopbotborder.Alignment = HorizontalAlignment.Left;
            textlefttopbotborder.BorderTop = BorderStyle.Thin;
            textlefttopbotborder.BorderBottom = BorderStyle.Thin;
            textlefttopbotborder.SetFont(GetFontStyle(workbook, 14, false));
            textlefttopbotborder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居左、字号14,下边框）
            ICellStyle textleftbottomborder = workbook.CreateCellStyle();
            textleftbottomborder.Alignment = HorizontalAlignment.Left;
            textleftbottomborder.BorderBottom = BorderStyle.Thin;
            textleftbottomborder.SetFont(GetFontStyle(workbook, 14, false));
            textleftbottomborder.WrapText = true;
            textleftbottomborder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居左、字号14,右边框）
            ICellStyle textleftrightborder = workbook.CreateCellStyle();
            textleftrightborder.Alignment = HorizontalAlignment.Left;
            textleftrightborder.BorderRight = BorderStyle.Thin;
            textleftrightborder.WrapText = true;
            textleftrightborder.SetFont(GetFontStyle(workbook, 14, false));
            textleftrightborder.VerticalAlignment = VerticalAlignment.Center;
            //标签样式（居左、字号14,下边框,右边框）
            ICellStyle textleftrightbotborder = workbook.CreateCellStyle();
            textleftrightbotborder.CloneStyleFrom(textleftrightborder);
            textleftrightbotborder.BorderBottom = BorderStyle.Thin;
            textleftrightbotborder.VerticalAlignment = VerticalAlignment.Center;
            //标题
            sheet.AddMergedRegion(new CellRangeAddress(0, 0, 0, 7));
            IRow row = sheet.CreateRow(0);
            row.HeightInPoints = 40;
            ICell icell = row.CreateCell(0);
            icell.SetCellValue("教育精准扶贫信息管理-户级采集表");
            icell.CellStyle = title;
            //批次编号
            row = sheet.CreateRow(1);
            row.HeightInPoints = 22;
            icell = row.CreateCell(0);
            icell.SetCellValue("导出批次：");
            icell.CellStyle = titleleftbold;
            icell = row.CreateCell(1);
            icell.SetCellValue(req.Form["BatchNumber"]);
            icell.CellStyle = textleft;
            icell = row.CreateCell(2);
            icell.SetCellValue("编号：");
            icell.CellStyle = titleleftbold;
            icell = row.CreateCell(3);
            icell.SetCellValue(Checklength(req.Form["SortId"], 3));
            icell.CellStyle = textleft;
            icell = row.CreateCell(4);
            icell.SetCellValue("户主姓名：");
            icell.CellStyle = titleleftbold;
            icell = row.CreateCell(5);
            icell.SetCellValue(Houserholdlist[0].Name);
            icell.CellStyle = textleft;
            icell = row.CreateCell(6);
            icell.SetCellValue("户主证件：");
            icell.CellStyle = titleleftbold;
            icell = row.CreateCell(7);
            icell.SetCellValue(Houserholdlist[0].IdCardNo);
            icell.CellStyle = textleft;
            //户主
            row = sheet.CreateRow(2);
            row.HeightInPoints = 22;

            icell = row.CreateCell(0);
            icell.SetCellValue("家庭人数：");
            icell.CellStyle = titleleftbold;
            icell = row.CreateCell(1);
            icell.SetCellValue(newstudentlist.Count.ToString() + "人");
            icell.CellStyle = textleft;
            icell = row.CreateCell(2);
            icell.SetCellValue("家庭在读人数：");
            icell.CellStyle = titleleftbold;
            icell = row.CreateCell(3);
            icell.SetCellValue(InschoolCount + "人");
            icell.CellStyle = textleft;
            icell = row.CreateCell(4);
            icell.SetCellValue("贫困原因：");
            icell.CellStyle = titleleftbold;
            icell = row.CreateCell(5);
            icell.SetCellValue(Houserholdlist[0].PovertyReason);
            icell.CellStyle = textleft;
            //家庭成员中正在接受情况
            sheet.AddMergedRegion(new CellRangeAddress(3, 3, 0, 7));
            row = sheet.CreateRow(3);
            row.HeightInPoints = 40;
            icell = row.CreateCell(0);
            icell.SetCellValue("家庭成员");
            icell.CellStyle = title;
            int j = 4;
            for (int i = 0; i < newstudentlist.Count; i++)
            {
                System.Collections.Generic.List<Model.StudentArchives> stulist = BLL.BLL<Model.StudentArchives>.Creator("Select").Parameter("TOP 1 *", "AND PovertyArchivesID=" + newstudentlist[i].ID + " ORDER BY PostTime desc");
                if (stulist.Count > 0)
                {
                    newstudentlist[i].StudentNo = stulist[0].StudentNo;
                    newstudentlist[i].UserID = stulist[0].UserID;
                    newstudentlist[i].studentArchivesID = stulist[0].ID;
                    newstudentlist[i].PolicyID = stulist[0].PolicyID;
                    newstudentlist[i].IsLHS = stulist[0].IsLHS;
                    newstudentlist[i].LHSWorkId = stulist[0].LHSWorkId;
                    newstudentlist[i].OutpreschoolReason = stulist[0].OutpreschoolReason;
                    newstudentlist[i].IsProvinceStudy = stulist[0].IsProvinceStudy;
                    newstudentlist[i].SchoolNature = stulist[0].SchoolNature;
                    newstudentlist[i].DropoutSchool = stulist[0].DropoutSchool;
                    newstudentlist[i].ReturnSchool = stulist[0].ReturnSchool;
                    newstudentlist[i].Remark = stulist[0].Remark;
                    newstudentlist[i].PostTime = stulist[0].PostTime;
                }
                row = sheet.CreateRow(j);
                row.HeightInPoints = 22;
                icell = row.CreateCell(0);
                icell.SetCellValue("姓名：");
                icell.CellStyle = textrightlefttopboder;
                icell = row.CreateCell(1);
                icell.SetCellValue(newstudentlist[i].Name);
                icell.CellStyle = textlefttopbotborder;
                icell = row.CreateCell(2);
                icell.SetCellValue("身份证号：");
                icell.CellStyle = textrightboder;
                icell = row.CreateCell(3);
                icell.SetCellValue(newstudentlist[i].IdCardNo);
                icell.CellStyle = textlefttopbotborder;
                icell = row.CreateCell(4);
                icell.SetCellValue("性别：");
                icell.CellStyle = textrightboder;
                icell = row.CreateCell(5);
                icell.CellStyle = textlefttopborder;
                if (newstudentlist[i].Gender)
                {
                    var a = new HSSFRichTextString("✓男 □女");
                    var font1 = (HSSFFont)sheet.Workbook.CreateFont();
                    font1.FontName = "Wingdings 2";
                    font1.FontHeightInPoints = 14;
                    a.ApplyFont(0, 1, font1);
                    icell.SetCellValue(a);
                }
                else
                {
                    var a = new HSSFRichTextString("□男 ✓女");
                    var font1 = (HSSFFont)sheet.Workbook.CreateFont();
                    font1.FontName = "Wingdings 2";
                    font1.FontHeightInPoints = 14;
                    a.ApplyFont(3, 4, font1);
                    icell.SetCellValue(a);
                }
                icell = row.CreateCell(6);
                icell.CellStyle = textrightboder;
                icell = row.CreateCell(7);
                icell.CellStyle = textrighttoprightboder;
                j++;
                row = sheet.CreateRow(j);
                row.HeightInPoints = 22;
                icell = row.CreateCell(0);
                icell.SetCellValue("民族：");
                icell.CellStyle = textrightleftboder;
                icell = row.CreateCell(1);
                icell.SetCellValue(newstudentlist[i].Nation);
                icell.CellStyle = textleftbottomborder;
                icell = row.CreateCell(2);
                icell.SetCellValue("出生日期：");
                icell.CellStyle = textright;
                icell = row.CreateCell(3);
                icell.SetCellValue(string.IsNullOrEmpty(newstudentlist[i].BirthDay) ? "" : Convert.ToDateTime(newstudentlist[i].BirthDay).ToString("yyyy-MM-dd"));
                icell.CellStyle = textleftbottomborder;
                icell = row.CreateCell(4);
                icell.SetCellValue("年龄：");
                icell.CellStyle = textright;
                icell = row.CreateCell(5);
                string age = "";
                if (newstudentlist[i].IdCardNo.Length > 15)
                {
                    age = (DateTime.Now.Year - Convert.ToInt32(newstudentlist[i].IdCardNo.Substring(6, 4))).ToString();
                }
                icell.SetCellValue(age + "岁");
                icell.CellStyle = textleftbottomborder;
                icell = row.CreateCell(6);
                icell.SetCellValue("与户主关系：");
                icell.CellStyle = textright;
                icell = row.CreateCell(7);
                icell.SetCellValue(newstudentlist[i].HouseholderRelation);
                icell.CellStyle = textleftrightbotborder;
                j++;
                row = sheet.CreateRow(j);
                row.HeightInPoints = 22;
                icell = row.CreateCell(0);
                icell.SetCellValue("文化程度：");
                icell.CellStyle = textrightleftboder;
                icell = row.CreateCell(1);
                icell.SetCellValue("□文盲或半文盲 □学龄前儿童 □小学 □初中 □高中 □大专及以上");
                icell.CellStyle = textleft;
                icell = row.CreateCell(2);
                icell.SetCellValue("劝返情况：");
                icell.CellStyle = textright;
                icell = row.CreateCell(3);
                icell.SetCellValue("□未返校 □已返校");
                icell.CellStyle = textleft;
                sheet.AddMergedRegion(new CellRangeAddress(j, j, 3, 7));
                icell = row.CreateCell(7);
                icell.CellStyle = textleftrightborder;
                j++;
                row = sheet.CreateRow(j);
                row.HeightInPoints = 44;
                icell = row.CreateCell(0);
                icell.SetCellValue("教育阶段：");
                icell.CellStyle = textrightleftboder;
                sheet.AddMergedRegion(new CellRangeAddress(j, j, 1, 7));
                icell = row.CreateCell(1);
                icell.CellStyle = textleftrightborder;
                string edulevel = "□非学龄段 □适龄未入学或辍学 □学前教育 □小学 □初中 □特教学生 □高中 □中职教育 □高职教育 □预科 □专科 □本科 □硕士 □博士";
                edulevel = edulevel.Replace("□" + newstudentlist[i].EduLevels, "✓" + newstudentlist[i].EduLevels);
                icell.SetCellValue(edulevel);
                icell = row.CreateCell(7);
                icell.CellStyle = textleftrightborder;
                j++;
                row = sheet.CreateRow(j);
                row.HeightInPoints = 22;
                icell = row.CreateCell(0);
                icell.SetCellValue("学校性质：");
                icell.CellStyle = textrightleftboder;
                icell = row.CreateCell(1);
                icell.SetCellValue("□公办 □民办");
                icell.CellStyle = textleft;
                icell = row.CreateCell(2);
                icell.SetCellValue("就读学校名称：");
                icell.CellStyle = textright;
                icell = row.CreateCell(3);
                icell.SetCellValue(newstudentlist[i].SchoolName);
                icell.CellStyle = textleftbottomborder;
                icell = row.CreateCell(4);
                icell.SetCellValue("年级：");
                icell.CellStyle = textright;
                sheet.AddMergedRegion(new CellRangeAddress(j, j, 5, 7));
                icell = row.CreateCell(5);
                icell.SetCellValue("□学前班□小□中□大□1□2□3□4□5□6□7□8□9");
                icell.CellStyle = textleftrightborder;
                icell = row.CreateCell(7);
                icell.CellStyle = textleftrightborder;
                j++;
                row = sheet.CreateRow(j);
                row.HeightInPoints = 22;
                icell = row.CreateCell(0);
                icell.SetCellValue("就读：");
                icell.CellStyle = textrightleftboder;
                icell = row.CreateCell(1);
                icell.SetCellValue("□省内 □省外");
                icell.CellStyle = textleft;
                icell = row.CreateCell(2);
                icell.SetCellValue("培训需求：");
                icell.CellStyle = textright;
                icell = row.CreateCell(3);
                icell.SetCellValue("□有 □无");
                icell.CellStyle = textleft;
                icell = row.CreateCell(4);
                icell.SetCellValue("备注/培训：");
                icell.CellStyle = textright;
                sheet.AddMergedRegion(new CellRangeAddress(j, j, 5, 7));
                icell = row.CreateCell(7);
                icell.CellStyle = textleftrightborder;
                j++;
                row = sheet.CreateRow(j);
                row.HeightInPoints = 22;
                icell = row.CreateCell(0);
                icell.SetCellValue("未入学原因：");
                icell.CellStyle = textrightleftboder;
                sheet.AddMergedRegion(new CellRangeAddress(j, j, 1, 7));
                string OutSchoolreason = "";
                for (int k = 0; k < OutSchoollist.Count; k++)
                {
                    OutSchoolreason += "□" + OutSchoollist[k].Name + "  ";
                }
                icell = row.CreateCell(1);
                icell.SetCellValue(OutSchoolreason);
                icell.CellStyle = textleftrightborder;
                icell = row.CreateCell(7);
                icell.CellStyle = textleftrightborder;
                j++;
                int checkage = string.IsNullOrEmpty(age) ? 0 : Convert.ToInt32(age);
                if (checkage < 36)
                {
                    row = sheet.CreateRow(j);
                    row.HeightInPoints = 22;
                    icell = row.CreateCell(0);
                    icell.SetCellValue("省级政策：");
                    icell.CellStyle = textrightleftboder;
                    sheet.AddMergedRegion(new CellRangeAddress(j, j, 1, 7));
                    string policy = "";
                    for (int l = 0; l < ProvincePolicylist.Count; l++)
                    {
                        policy += "□" + ProvincePolicylist[l].Name + ProvincePolicylist[l].Amount.Replace(".00","")  + "元  ";
                    }
                    icell = row.CreateCell(1);
                    icell.SetCellValue(policy);
                    icell.CellStyle = textleftrightborder;
                    icell = row.CreateCell(7);
                    icell.CellStyle = textleftrightborder;
                    row.HeightInPoints = Convert.ToInt32(22 * Math.Ceiling((decimal.Round(ProvincePolicylist.Count, 2) / 3)));
                    j++;
                    row = sheet.CreateRow(j);
                    row.HeightInPoints = 22;
                    icell = row.CreateCell(0);
                    icell.SetCellValue("市级政策：");
                    icell.CellStyle = textrightleftboder;
                    sheet.AddMergedRegion(new CellRangeAddress(j, j, 1, 7));
                    string Citypolicy = "";
                    for (int l = 0; l < CityPolicylist.Count; l++)
                    {
                        Citypolicy += "□" + CityPolicylist[l].Name + CityPolicylist[l].Amount.Replace(".00","") + "元  ";
                    }
                    icell = row.CreateCell(1);
                    icell.SetCellValue(Citypolicy);
                    icell.CellStyle = textleftrightborder;
                    icell = row.CreateCell(7);
                    icell.CellStyle = textleftrightborder;
                    row.HeightInPoints = Convert.ToInt32(22 * Math.Ceiling((decimal.Round(CityPolicylist.Count, 2) / 3)));
                    j++;
                    row = sheet.CreateRow(j);
                    row.HeightInPoints = 22;
                    icell = row.CreateCell(0);
                    icell.SetCellValue("县级政策：");
                    icell.CellStyle = textrightleftbotboder;
                    sheet.AddMergedRegion(new CellRangeAddress(j, j, 1, 7));
                    string Countypolicy = "";
                    for (int l = 0; l < CountyPolicylist.Count; l++)
                    {
                        Countypolicy += "□" + CountyPolicylist[l].Name + CountyPolicylist[l].Amount.Replace(".00","")  + "元  ";
                    }
                    icell = row.CreateCell(1);
                    icell.SetCellValue(Countypolicy);
                    icell.CellStyle = textleftbottomborder;
                    icell = row.CreateCell(2);
                    icell.CellStyle = textleftbottomborder;
                    icell = row.CreateCell(3);
                    icell.CellStyle = textleftbottomborder;
                    icell = row.CreateCell(4);
                    icell.CellStyle = textleftbottomborder;
                    icell = row.CreateCell(5);
                    icell.CellStyle = textleftbottomborder;
                    icell = row.CreateCell(6);
                    icell.CellStyle = textleftbottomborder;
                    icell = row.CreateCell(7);
                    icell.CellStyle = textleftrightbotborder;
                    row.HeightInPoints = Convert.ToInt32(22 * Math.Ceiling((decimal.Round(CountyPolicylist.Count, 2) / 3)));
                    j++;
                }


            }
            ///保存,路径一块穿进去。否则回到一个很奇妙的地方，貌似是system32里 temp下....
            if (!Directory.Exists(System.Configuration.ConfigurationManager.AppSettings["ExportFile"] + filepath))
            {
                Directory.CreateDirectory(System.Configuration.ConfigurationManager.AppSettings["ExportFile"] + filepath);
            }
            FileStream fs2 = File.Create(System.Configuration.ConfigurationManager.AppSettings["ExportFile"] + filepath + filename);
            workbook.Write(fs2);
            fs2.Close();
            Model.ExportRecord model = new Model.ExportRecord();
            model.UserId = Convert.ToInt64(req.Form["UserId"]);
            model.SortId = Convert.ToInt64(req.Form["SortId"]);
            model.FileName = filename;
            model.BatchNumber = req.Form["BatchNumber"];
            model.HouseholderId = Houserholdlist[0].ID;
            model.CityId = Convert.ToInt64(req.Form["CityId"]);
            model.CountyId = Convert.ToInt64(req.Form["CountyId"]);
            model.CountrySideId = Convert.ToInt64(req.Form["CountrySideId"]);
            model.VillageId = Convert.ToInt64(req.Form["VillageId"]);
            if (BLL.BLL<Model.ExportRecord>.Creator("Insert").Parameter(model))
            {
                res.Write(string.Format("{{\"Result\":true,\"Message\":\"导出成功\",\"FilePath\":\"{0}\",\"FileName\":\"{1}\",\"HouseholderName\":\"{2}\",\"HouseholderIdCardNo\":\"{3}\"}}", filepath.Replace(@"\", "/"), filename, Houserholdlist[0].Name, Houserholdlist[0].IdCardNo));
            }
        }
        catch (Exception ex)
        {
            Common.GetInstance.JsonErrorMessage(ex.Message);
        }
    }
    /// <summary>
    /// 获取字体样式
    /// </summary>
    /// <param name="hssfworkbook">Excel操作类</param>
    /// <param name="fontsize">字体大小</param>
    /// <param name="Bold">字体加粗</param>
    /// <returns></returns>
    public static IFont GetFontStyle(HSSFWorkbook hssfworkbook, int fontsize,bool Bold)
    {
        IFont font1 = hssfworkbook.CreateFont();
        font1.FontHeightInPoints = (short)fontsize;
        font1.FontName = "宋体";
        if(Bold)
        {
            font1.Boldweight= (short)NPOI.SS.UserModel.FontBoldWeight.Bold;
        }
        return font1;
    }
    public string Checklength(string str,int length)
    {
        for(int i=0;i<length-str.Length+1;i++)
        {
            str = "0" + str;
        }
        return str;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}