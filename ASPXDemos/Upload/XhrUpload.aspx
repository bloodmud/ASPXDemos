<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="XhrUpload.aspx.cs" Inherits="Upload.XhrUpload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-cn">
<head runat="server">
    <meta charset="utf-8" />
    <title>XHR Upload</title>
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

        <div id="footer">
            <div style="margin: 10px 0d">
                <a href="https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Using_XMLHttpRequest">Using XMLHttpRequest</a>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="/Scripts/jquery-3.6.0.js"></script>
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
                    var uploader = document.getElementById("<%=UploadId %>");
                    for (var i = 0; i < uploader.files.length; i++) {
                        formData.append("<%=UploadId %>", uploader.files[i]);
                    }

                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "/Upload/UploadSaver.ashx", true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            try {
                                var result = JSON.parse(xhr.response);
                                if (result.success) {
                                    $("#upload-status").text(result.files.join(" "));
                                } else {
                                    alert(xhr.responseText);
                                }
                            }
                            catch (e) {
                                alert(xhr.responseText);
                            }
                            $(uploader.form).get(0).reset();
                            // alert(xhr.responseText);
                        }
                    };
                    xhr.send(formData);

                    return false;
                });
        });
    </script>
</body>
</html>
