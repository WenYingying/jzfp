<%@ WebHandler Language="C#" Class="ExportCompressedHandler" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using System.Diagnostics;
using Newtonsoft.Json;

public class ExportCompressedHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
     context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        string ZipFilename =System.Configuration.ConfigurationManager.AppSettings["ExportFileZip"].ToString() + DateTime.Now.ToString("yyyyMMddHHmmss") + Guid.NewGuid().ToString().Substring(0, 5) + ".zip";
        try
        {
            if (string.IsNullOrEmpty(req.Form["FileName"]) || string.IsNullOrEmpty(req.Form["FilePath"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            List<string> filenamelist = JsonConvert.DeserializeObject<List<string>>(req.Form["FileName"]);
            List<string> filelist = JsonConvert.DeserializeObject<List<string>>(req.Form["FilePath"]);
            Common.ZipFileMain(filelist.ToArray(), filenamelist.ToArray(), ZipFilename, 9);
            System.IO.FileInfo file = new System.IO.FileInfo(ZipFilename);
            res.Clear();
            res.Charset = "GB2312";
            res.ContentEncoding = System.Text.Encoding.UTF8; // 添加头信息，为"文件下载/另存为"对话框指定默认文件名 
            res.AddHeader("Content-Disposition", "attachment; filename=" + HttpContext.Current.Server.UrlEncode(file.Name));
            // 添加头信息，指定文件大小，让浏览器能够显示下载进度
            res.AddHeader("Content-Length", file.Length.ToString());
            // 指定返回的是一个不能被客户端读取的流，必须被下载 Response.ContentType = "application/ms-excel";
            // 把文件流发送到客户端
            res.WriteFile(file.FullName);
            res.Flush();//这个语句必须有，否则就不回弹出保存的对话框，搞了N久
            res.End();

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