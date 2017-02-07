<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server"  method = "post" action = "PovertyArchivesInterface/PagerListHandler.ashx">
    <div>
                 <input type="text" name="areaid" value="2437" />
                 <input type="text" name="area" value="county" />
                 <input type="text" name="pageno" value="1" />
                 <input type="text" name="pagesize" value="10" />
                 <input type="text" name="requesttype" value="outschool" />
                 <input type="text" name="minage" value="0" />
                 <input type="text" name="maxage" value="3" />


           <input type="submit" value="提交" />
    </div>

    </form>
</body>
</html>
