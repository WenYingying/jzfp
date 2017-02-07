<%@ WebHandler Language="C#" Class="PostHandler" %>

using System;
using System.Web;

public class PostHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        HttpRequest req = context.Request;
        HttpResponse res = context.Response;
        HttpServerUtility server = context.Server;
        try
        {
            if (string.IsNullOrEmpty(req.Form["UserId"]) || string.IsNullOrEmpty(req.Form["SortId"]) || string.IsNullOrEmpty(req.Form["HouseholderId"]) || string.IsNullOrEmpty(req.Form["FileName"]) || string.IsNullOrEmpty(req.Form["BatchNumber"]))
            {
                Common.GetInstance.JsonErrorMessage("参数错误");
                return;
            }
            Model.ExportRecord model = new Model.ExportRecord();
            model.UserId = Convert.ToInt64(req.Form["UserId"]);
            model.SortId = Convert.ToInt64(req.Form["SortId"]);
            model.FileName = req.Form["FileName"];
            model.BatchNumber = req.Form["BatchNumber"];
            model.HouseholderId =Convert.ToInt64(req.Form["HouseholderId"]);
            if (BLL.BLL<Model.ExportRecord>.Creator("Insert").Parameter(model))
            {
                res.Write("{\"Result\":true,\"Message\":\"添加成功\"}");
            }
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