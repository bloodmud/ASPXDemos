using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Helpers;

namespace Upload
{
    /// <summary>
    /// Summary description for UploadSaver
    /// </summary>
    public class UploadSaver : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            var names = new List<string>(8);
            var savePath = context.Server.MapPath("~/Data/Uploads");

            try
            {
                var files = context.Request.Files;
                for (var i = 0; i < files.Count; ++i)
                {
                    var file = files[i];
                    names.Add(file.FileName);
                    file.SaveAs(Path.Combine(savePath, file.FileName));
                }

                context.Response.ContentType = "text/json";
                var result = new { success = true, files = names };
                context.Response.Write(Json.Encode(result));
            }
            catch (Exception ex)
            {
                context.Response.ContentType = "text/plain";
                context.Response.Write(ex.Message);
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
}