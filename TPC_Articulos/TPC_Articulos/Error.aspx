<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="TPC_Articulos.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <html>
<head>
    <title>Error</title>
</head>
<body>

    <h1 style="color:red">Ocurrió un error</h1>

    <%
        if (Session["Error"] != null)
        {
            Exception ex = (Exception)Session["Error"];
    %>

        <h3><%= ex.Message %></h3>
        <pre><%= ex.StackTrace %></pre>

    <%
        }
    %>

    <br />
    <a href="Administracion.aspx">Volver al panel</a>

</body>
</html>
</asp:Content>
