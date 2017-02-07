<%@ WebHandler Language="C#" Class="PostJournalHandler" %>

using System;
using System.Web;
using System.Xml;


public class PostJournalHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["UserId"]) || string.IsNullOrEmpty(req.Form["PageName"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            string path =System.Configuration.ConfigurationManager.AppSettings["XMLFile"] + DateTime.Now.ToString("yyyyMMdd") + ".xml";
            if (!System.IO.File.Exists(path))
            {
                Common.CreateXml(path);
            }
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(path);
            int nodeList = xmldoc.SelectSingleNode("Operating").ChildNodes.Count;
            XmlNode root = xmldoc.SelectSingleNode("Operating");
            XmlElement xe1 = xmldoc.CreateElement("User");//创建一个<team>节点
            xe1.SetAttribute("id", req.Form["UserId"]);//设置该节点genre属性
            XmlElement UserId = xmldoc.CreateElement("UserId");
            UserId.InnerText = req.Form["UserId"];
            xe1.AppendChild(UserId);
            XmlElement PageName = xmldoc.CreateElement("PageName");
            PageName.InnerText = req.Form["PageName"];
            xe1.AppendChild(PageName);
            string _userIP;
            if (req.ServerVariables["HTTP_VIA"] == null)//未使用代理
            {
                _userIP = req.UserHostAddress;
            }
            else//使用代理服务器
            {
                _userIP = req.ServerVariables["HTTP_X_FORWARDED_FOR"];
            }
            XmlElement LoginIp = xmldoc.CreateElement("LoginIp");
            LoginIp.InnerText = _userIP;
            xe1.AppendChild(LoginIp);
            //经度
            XmlElement Longitudexml = xmldoc.CreateElement("Lng");
            Longitudexml.InnerText = string.IsNullOrEmpty(req.Form["Lng"])?"": req.Form["Lng"];
            xe1.AppendChild(Longitudexml);
            //纬度
            XmlElement Latitudexml = xmldoc.CreateElement("Lat");
            Latitudexml.InnerText = string.IsNullOrEmpty(req.Form["Lat"])?"": req.Form["Lat"];
            xe1.AppendChild(Latitudexml);
            //登录时间
            XmlElement PostTime = xmldoc.CreateElement("PostTime");
            PostTime.InnerText = DateTime.Now.ToString();
            xe1.AppendChild(PostTime);
            root.AppendChild(xe1);
            xmldoc.Save(path);
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