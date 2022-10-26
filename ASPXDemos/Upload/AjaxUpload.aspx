<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjaxUpload.aspx.cs" Inherits="Upload.AjaxUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-cn">
<head runat="server">
    <meta charset="utf-8" />
    <title>Ajax Upload</title>
    <link rel="stylesheet" type="text/css" href="/Styles/Styles.css" media="screen" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
    <div id="mainContainer">
        <div id="mainContent">
            <form id="uploadForm1" runat="server">
                <label for="<%=UploadId %>">上传 XXXX 文件</label>
                <a id="doUpload" href="javascript:void(0)" class="btn">选择文件</a>
                <div style="display: none">
                    <input id="<%=UploadId %>" name="<%=UploadId %>" type="file" accept="*"" multiple />
                </div>
                <div style="display: inline-block; margin-top: 5px; font-weight: bolder;">
                    <text id="upload-status"></text>
                </div>
            </form>
        </div>
    </div>

    <script type="text/javascript" charset="utf-8" src="/Scripts/jquery-3.6.0.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#doUpload").click(function (e) {
                $("#<%=UploadId %>").click();
            });
            var uploader = $("#<%=UploadId %>");
            uploader.get(0).addEventListener("change",
                function () {
                    if (!FormData) {
                        alert('Sorry, your browser doesn\'t support the File API => falling back to normal form submit');
                        return true;
                    }

                    var formData = new FormData();
                    var uploader = $("#<%=UploadId %>").get(0);
                    for (var i = 0; i < uploader.files.length; i++) {
                        formData.append("uploads", uploader.files[i]);
                    }

                    $.ajax({
                        url: "/Upload/UploadSaver.ashx",
                        type: "POST",
                        contentType: false, // Not to set any content header  
                        processData: false, // Not to process data  
                        data: formData,
                        success: function (result) {
                            if (typeof result !== "string" && result.success) {
                                $("#upload-status").text(result.files.join(" "));
                            } else {
                                alert(result);
                            }
                            $(uploader.form).get(0).reset();
                        },
                        error: function (err) {
                            alert(err.statusText);
                        }
                    });
                });
        });
    </script>
</body>
</html>
