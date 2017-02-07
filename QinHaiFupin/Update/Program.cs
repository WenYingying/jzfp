using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using Model;
using BLL;

namespace Update
{
    public class Program
    {
        public static void Main(string[] args)
        {
            //更新贫困数据
            #region
            
                DataTable dt = ExcelToDataTable(@"E:\fupinshuju.xlsx", "Sheet1");
                long householderid = 0;
            #region
            foreach (DataRow item in dt.Rows)
            {
                Console.WriteLine("开始导入...");
                System.Collections.Generic.List<Model.PovertyArchives> list = BLL.BLL<Model.PovertyArchives>.Creator("Select").Parameter("ID", "AND IdCardNo='" + item["证件号码"].ToString() + "'");
                if (list.Count > 0)
                {
                    PovertyArchives model = new PovertyArchives();
                    model.ID = list[0].ID;
                    model.HouseStates = false;
                    if (item["与户主关系"].ToString() == "本人或户主")
                    {
                        householderid = list[0].ID;
                        model.HouseholderId = list[0].ID;
                        model.IsHouseHolder = true;
                    }
                    else
                    {
                        model.HouseholderId = householderid;
                    }
                    model.FamilySize = item["家庭人数"].ToString().Trim().Length > 0 ? int.Parse(item["家庭人数"].ToString()) : 1;
                    model.StudentStatus = item["在校生状况"].ToString();
                    model.PovertyProperties = item["贫困户属性"].ToString();
                    model.PovertyReason = item["最主要致贫原因"].ToString();
                    model.Phone = item["联系电话"].ToString();
                    model.Nation = item["民族"].ToString();
                    BLL.BLL<Model.PovertyArchives>.Creator("UpdateFromExcel").Parameter(model);
                }
                else
                {
                    PovertyArchives model = new PovertyArchives();
                    model.Name = item["姓名"].ToString();
                    model.Nation = item["民族"].ToString();
                    model.IdCardNo = item["证件号码"].ToString();
                    model.Phone = item["联系电话"].ToString();
                    model.PovertyProperties = item["贫困户属性"].ToString();
                    model.PovertyReason = item["最主要致贫原因"].ToString();
                    model.StudentStatus = item["在校生状况"].ToString();
                    model.DropoutSchool = item["文化程度"].ToString();
                    System.Collections.Generic.List<Model.Village> villagelist = BLL.BLL<Model.Village>.Creator("SelectAll").Parameter("ID", "AND CityName='" + item["市"].ToString() + "' AND CountyName='" + item["县"].ToString() + "' AND CountrysideName LIKE '%" + item["乡"].ToString() + "%' AND Name LIKE '%" + item["村"].ToString() + "%'");
                    if (villagelist.Count > 0)
                    {
                        model.VillageId = villagelist[0].ID;
                    }
                    if (item["证件号码"].ToString().Length > 15)
                    {
                        DateTime birthday;
                        DateTime.TryParse(item["证件号码"].ToString().Substring(6, 4) + "-" + item["证件号码"].ToString().Substring(10, 2) + "-" + item["证件号码"].ToString().Substring(12, 2), out birthday);
                        if (birthday > Convert.ToDateTime("1800-01-01"))
                        {
                            model.BirthDay = birthday.ToString();
                        }
                        else
                        {
                            model.BirthDay ="1900-01-01";
                        }

                    }

                    model.DiscerningStandards = "国家标准";
                    model.FamilySize = item["家庭人数"].ToString().Trim().Length > 0 ? Convert.ToInt32(item["家庭人数"].ToString()) : 1;
                    model.Gender = item["性别"].ToString() == "男" ? true : false;
                    model.HouseholderId = item["与户主关系"].ToString() == "本人或户主" ? 0 : householderid;
                    model.IsHouseHolder = item["与户主关系"].ToString() == "本人或户主";
                    model.HouseholderRelation = item["与户主关系"].ToString();
                    model.HouseStates = false;
                    if (BLL.BLL<Model.PovertyArchives>.Creator("Insert").Parameter(model))
                    {
                        if (item["与户主关系"].ToString() == "本人或户主")
                            householderid = model.ID;
                    }
                }
                Console.WriteLine("{0}导入完毕", item["证件号码"]);
                #endregion
            }
            Console.Read();

            #endregion
            //更新学籍信息
            #region


            //DataTable studt = ExcelToDataTable(@"E:\fupin.xlsx", "导出工作表");
            //Dictionary<string, string> nianji = new Dictionary<string, string>();
            //nianji.Add("初中2014级", "九年级");
            //nianji.Add("初中2015级", "八年级");
            //nianji.Add("初中2016级", "七年级");
            //nianji.Add("高中2014级", "三年级");
            //nianji.Add("高中2015级", "二年级");
            //nianji.Add("高中2016级", "一年级");
            //nianji.Add("小学2011级", "六年级");
            //nianji.Add("小学2012级", "五年级");
            //nianji.Add("小学2013级", "四年级");
            //nianji.Add("小学2014级", "三年级");
            //nianji.Add("小学2015级", "二年级");
            //nianji.Add("小学2016级", "一年级");
            //foreach (DataRow item in studt.Rows)
            //{
            //    System.Collections.Generic.List<Model.PovertyArchives> list = BLL.BLL<Model.PovertyArchives>.Creator("Select").Parameter("ID", "AND IdCardNo='" + item["身份证号"].ToString() + "'");
            //    if (list.Count > 0)
            //    {
            //        PovertyArchives pa = new PovertyArchives();
            //        pa.ID = list[0].ID;
            //        pa.StudentStatus = nianji[item["年级"].ToString()];
            //        pa.EduLevels = item["年级"].ToString().Substring(0, 2);
            //        pa.Name = item["姓名"].ToString();
            //        BLL.BLL<Model.PovertyArchives>.Creator("UpdateStudentEdu").Parameter(pa);
            //        BLL.BLL<Model.PovertyArchives>.Creator("UpdateName").Parameter(pa);
            //        Model.StudentArchives model = new Model.StudentArchives();
            //        model.UserID = 20010;
            //        model.PovertyArchivesID = list[0].ID;
            //        model.SchoolName = item["学校名称"].ToString();
            //        model.EduLevels = item["年级"].ToString().Substring(0, 2);
            //        model.StudentStatus = nianji[item["年级"].ToString()];
            //        model.Remark = "学籍信息更新";
            //        BLL.BLL<Model.StudentArchives>.Creator("Insert").Parameter(model);
            //    }
            //}
            #endregion

            //添加用户
            #region
            //DataTable userdt = ExcelToDataTable(@"E:\zhanghao.xls", "Sheet2");
            //foreach (DataRow item in userdt.Rows)
            //{
            //    User umodel = new User();
            //    umodel.LoginName = item["用户名"].ToString();
            //    umodel.Name = "";
            //    umodel.Password = "DC7FA85B278950BD";
            //    umodel.ProvinceId = Convert.ToInt32(item["省"].ToString());
            //    umodel.CityId = Convert.ToInt32(item["市"].ToString());
            //    umodel.CountyId = Convert.ToInt32(item["县"].ToString());
            //    umodel.InputBeginTime = "2016-10-01";
            //    umodel.InputEndTime = "2016-10-31";
            //    BLL<User>.Creator("Insert").Parameter(umodel);
            //}
            #endregion
        }

        /// <summary>    
        /// 把数据从Excel装载到DataTable    
        /// </summary>    
        /// <param name="pathName">带路径的Excel文件名</param>    
        /// <param name="sheetName">工作表名</param>
        /// <param name="tbContainer">将数据存入的DataTable</param>
        /// <returns></returns> 
        public static System.Data.DataTable ExcelToDataTable(string pathName, string sheetName)
        {
            System.Data.DataTable tbContainer = new System.Data.DataTable();
            string strConn = string.Empty;
            if (string.IsNullOrEmpty(sheetName))
            {
                sheetName = "Sheet1";
            }
            FileInfo file = new FileInfo(pathName);
            if (!file.Exists)
            {
                throw new Exception("文件不存在");
            }
            string extension = file.Extension;
            switch (extension)
            {
                case ".xls":
                    strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathName + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1;'";
                    break;
                case ".xlsx":
                    strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + pathName + ";Extended Properties='Excel 12.0;HDR=Yes;IMEX=1;'";
                    break;
                default:
                    strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathName + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1;'";
                    break;
            }
            //链接Excel
            OleDbConnection cnnxls = new OleDbConnection(strConn);
            //读取Excel里面有 表Sheet1
            OleDbDataAdapter oda = new OleDbDataAdapter(string.Format("select * from [{0}$]", sheetName), cnnxls);
            DataSet ds = new DataSet();
            //将Excel里面有表内容装载到内存表中！
            oda.Fill(tbContainer);
            return tbContainer;
        }
    }
}
