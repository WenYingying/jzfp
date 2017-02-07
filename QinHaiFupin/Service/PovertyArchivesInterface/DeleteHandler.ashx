<%@ WebHandler Language="C#" Class="DeleteHandler" %>

using System;
using System.Web;

public class DeleteHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        try
        {
            if (string.IsNullOrEmpty(req.Form["ID"]) || string.IsNullOrEmpty(req.Form["StudentArchivesId"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.PovertyArchivesChangeLog pcl = new Model.PovertyArchivesChangeLog();
            pcl.PovertyArchivesId = Convert.ToInt64(req.Form["ID"]);
            BLL.BLL<Model.PovertyArchivesChangeLog>.Creator("Delete").Parameter(pcl);
            Model.StudentArchivesChangeLog scl = new Model.StudentArchivesChangeLog();
            scl.StudentArchivesId = Convert.ToInt64(req.Form["StudentArchivesId"]);
            BLL.BLL<Model.StudentArchivesChangeLog>.Creator("Delete").Parameter(scl);
            Model.StudentArchives stc = new Model.StudentArchives();
            stc.PovertyArchivesID = Convert.ToInt64(req.Form["ID"]);
            BLL.BLL<Model.StudentArchives>.Creator("Delete").Parameter(stc);
            Model.PovertyArchives model = new Model.PovertyArchives();
            model.ID = Convert.ToInt64(req.Form["ID"]);
            BLL.BLL<Model.PovertyArchives>.Creator("Delete").Parameter(model);
            res.Write("{\"Result\":true,\"Message\":\"删除成功\"}");

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