using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.Zip;
using System;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Xml;

/// <summary>
/// Common 的摘要说明
/// </summary>
public class Common
{
    private static readonly Common Instance = new Common();
    private Common()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    public static Common GetInstance
    {
        get { return Instance; }
    }

    public void JsonErrorMessage(string exMessage)
    {
        HttpContext.Current.Response.Write(string.Format("{{\"Result\":false,\"Message\":\"{0}\"}}", new System.Text.RegularExpressions.Regex("\\n|\\r|\\(|\\)| |\"|\\\\").Replace(exMessage, "")));
    }

    public bool IsMobilePhone(string phoneNum)
    {
        return System.Text.RegularExpressions.Regex.IsMatch(phoneNum, @"^1([3,5]|7|8)\d{9}$");
    }
    public int GenerateCode()
    {
        long t = DateTime.Now.Ticks;
        Random rnd = new Random((int)(t & 0xffffffffL) | (int)(t >> 32));
        int result = rnd.Next(999999);
        if (result < 100000) return GenerateCode();
        return result;
    }

    public byte[] CreateCheckCodeImage(string checkCode, HttpResponse res)
    {
        if (checkCode == null || checkCode.Trim() == String.Empty)
            return null;

        System.Drawing.Bitmap image = new System.Drawing.Bitmap((int)Math.Ceiling((checkCode.Length * 13.5)), 31);
        System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(image);

        try
        {
            //生成随机生成器
            Random random = new Random();

            //清空图片背景色
            g.Clear(System.Drawing.Color.White);

            //画图片的背景噪音线
            //for (int i = 0; i < 25; i++)
            //{
            //    int x1 = random.Next(image.Width);
            //    int x2 = random.Next(image.Width);
            //    int y1 = random.Next(image.Height);
            //    int y2 = random.Next(image.Height);

            //    g.DrawLine(new System.Drawing.Pen(System.Drawing.Color.Silver), x1, y1, x2, y2);
            //}

            System.Drawing.Font font = new System.Drawing.Font("Arial", 16, (System.Drawing.FontStyle.Bold));
            System.Drawing.Drawing2D.LinearGradientBrush brush = new System.Drawing.Drawing2D.LinearGradientBrush(new System.Drawing.Rectangle(0, 0, image.Width, image.Height), System.Drawing.Color.Blue, System.Drawing.Color.DarkRed, 1.2f, true);
            g.DrawString(checkCode, font, brush, 1, 1);

            //画图片的前景噪音点
            //for (int i = 0; i < 100; i++)
            //{
            //    int x = random.Next(image.Width);
            //    int y = random.Next(image.Height);

            //    image.SetPixel(x, y, System.Drawing.Color.FromArgb(random.Next()));
            //}

            //画图片的边框线
            g.DrawRectangle(new System.Drawing.Pen(System.Drawing.Color.Silver), 0, 0, image.Width - 1, image.Height - 1);

            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            image.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
            return ms.ToArray();

            //res.ClearContent();
            //res.ContentType = "image/Gif";
            //res.BinaryWrite(ms.ToArray());
        }
        finally
        {
            g.Dispose();
            image.Dispose();
        }
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
    public static void CreateXml(string path)
    {
        XmlDocument xmldoc = new XmlDocument();
        //加入XML的声明段落,<?xml version="1.0" encoding="gb2312"?>
        XmlDeclaration xmldecl;
        xmldecl = xmldoc.CreateXmlDeclaration("1.0", "gb2312", null);
        xmldoc.AppendChild(xmldecl);
        //加入一个根元素
        XmlNode xmlelem = xmldoc.CreateElement("", "Operating", "");
        xmldoc.AppendChild(xmlelem);
        //保存创建好的XML文档
        xmldoc.Save(path);
    }

    /// <summary>
    /// 压缩文件
    /// </summary>
    /// <param name="fileName">要压缩的所有文件（完全路径)</param>
    /// <param name="fileName">文件名称</param>
    /// <param name="name">压缩后文件路径</param>
    /// <param name="Level">压缩级别</param>
    public static void ZipFileMain(string[] filenames, string[] fileName, string name, int Level)
    {
        ZipOutputStream s = new ZipOutputStream(File.Create(name));
        Crc32 crc = new Crc32();
        //压缩级别
        s.SetLevel(Level); // 0 - store only to 9 - means best compression
        try
        {
            int m = 0;
            foreach (string file in filenames)
            {
                //打开压缩文件
                HttpContext.Current.Response.Write(System.Configuration.ConfigurationManager.AppSettings["ExportFile"].ToString() + file.Replace("/", "\\") + fileName[m]);
                FileStream fs = File.OpenRead(System.Configuration.ConfigurationManager.AppSettings["ExportFile"].ToString() + file.Replace("/","\\")+ fileName[m]);//文件地址
                byte[] buffer = new byte[fs.Length];
                fs.Read(buffer, 0, buffer.Length);
                //建立压缩实体
                ZipEntry entry = new ZipEntry(fileName[m].ToString());//原文件名
                //时间
                entry.DateTime = DateTime.Now;
                //空间大小
                entry.Size = fs.Length;
                fs.Close();
                crc.Reset();
                crc.Update(buffer);
                entry.Crc = crc.Value;
                s.PutNextEntry(entry);
                s.Write(buffer, 0, buffer.Length);
                m++;
            }
        }
        catch
        {
            throw;
        }
        finally
        {
            s.Finish();
            s.Close();
        }
    }


    public static void AddLog(long ID, string Lng, string Lat)
    {
        string path = System.Configuration.ConfigurationManager.AppSettings["XMLFile"] + ID.ToString() + ".xml";
        if (!System.IO.File.Exists(path))
        {
            CreateXml(path);
        }
        XmlDocument xmldoc = new XmlDocument();
        xmldoc.Load(path);
        int nodeList = xmldoc.SelectSingleNode("Operating").ChildNodes.Count;
        XmlNode root = xmldoc.SelectSingleNode("Operating");
        XmlNode elemList = xmldoc.SelectSingleNode("/Operating/Date[@Time='" + DateTime.Now.ToString("yyyy-MM-dd") + "']");
        if (elemList == null)
        {
            XmlElement datexml = xmldoc.CreateElement("Date");//创建一个<team>节点
            datexml.SetAttribute("Time", DateTime.Now.ToString("yyyy-MM-dd"));
            root.AppendChild(datexml);
            xmldoc.Save(path);
            xmldoc.Load(path);
            elemList = xmldoc.SelectSingleNode("/Operating/Date[@Time='" + DateTime.Now.ToString("yyyy-MM-dd") + "']");
        }
        XmlElement xe1 = xmldoc.CreateElement("Login");
        XmlElement UserId = xmldoc.CreateElement("UserId");
        UserId.InnerText = ID.ToString();
        xe1.AppendChild(UserId);
        string _userIP;
        if (HttpContext.Current.Request.ServerVariables["HTTP_VIA"] == null)//未使用代理
        {
            _userIP = HttpContext.Current.Request.UserHostAddress;
        }
        else//使用代理服务器
        {
            _userIP = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        }
        XmlElement LoginIp = xmldoc.CreateElement("LoginIp");
        LoginIp.InnerText = _userIP;
        xe1.AppendChild(LoginIp);
        //经度
        XmlElement Longitudexml = xmldoc.CreateElement("Lng");
        Longitudexml.InnerText = Lng;
        xe1.AppendChild(Longitudexml);
        //纬度
        XmlElement Latitudexml = xmldoc.CreateElement("Lat");
        Latitudexml.InnerText = Lat;
        xe1.AppendChild(Latitudexml);
        //登录时间
        XmlElement PostTime = xmldoc.CreateElement("PostTime");
        PostTime.InnerText = DateTime.Now.ToString();
        xe1.AppendChild(PostTime);
        elemList.AppendChild(xe1);
        xmldoc.Save(path);
        //更新记录
        Model.User model = new Model.User();
        model.ID = ID;
        model.LastLoginIp = _userIP;
        model.LastLoginTime = DateTime.Now.ToString();
        //经度
        model.Lng = Lng;
        //纬度
        model.Lat = Lat;
        BLL.BLL<Model.User>.Creator("UpdateTimePlace").Parameter(model);
    }

}