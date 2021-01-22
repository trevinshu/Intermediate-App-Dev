<%@ Page Title="ListView ODS CRUD" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListViewODSCRUD.aspx.cs" Inherits="WebApp.SamplePages.ListViewODSCRUD" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Single Control ODS CRUD : ListView</h1>

    <div class="row">
        <div class="offset-2">
            <blockquote class="alert alert-info">
                This page will use the ListView control<br />
                This page will use ObjectDataSource with the ListView control<br />
                This page will use minimum code behind<br />
                This page will use the MessageUserControl for error handling<br />
                This page will demonstrate validation on the asp:Listview control<br />
            </blockquote>
        </div>
    </div>

    <div class="row">
        <div class="offset-1">
            <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
            <asp:ValidationSummary ID="ValidationSummaryEdit" runat="server" HeaderText="Following are concerns with your data" ValidationGroup="egroup"/>
            <asp:ValidationSummary ID="ValidationSummaryInsert" runat="server" HeaderText="Following are concerns with your data" ValidationGroup="igroup"/>
        </div>
    </div>

    <div class="row">
        <div class="offset-2">
            <%-- REMINDER: to use the attribute DataKeyNames to get the Delete function of your ListView CRUD to work 
             The DataKeyNames attribute is set to your Primary Key field--%>
            <asp:ListView ID="AlbumList" runat="server" DataSourceID="AlbumListODS" InsertItemPosition="FirstItem" DataKeyNames="AlbumId">
                <AlternatingItemTemplate>
                    <tr style="background-color: #FFF8DC;">
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" OnClientClick="return confirm('Are you sure you wish to delete this album?')" />
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                        <td>
                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel" Width="50px" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                        <td>
                            <asp:DropDownList ID="ArtistList" runat="server" DataSourceID="ArtistListODS" DataTextField="DisplayField" DataValueField="ValueField" SelectedValue='<%# Eval("ArtistId") %>' Enabled="false" Width="300px"></asp:DropDownList>
                        <td>
                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
                    </tr>
                </AlternatingItemTemplate>

                <EditItemTemplate>
                    <%-- Validation controls will be placed inside the associate template. 
                        The ID of the validated control needs to be unique. 
                        The validation contols for a particular template needs to be grouped.  
                        
                        The validation executes ONLY on the use of the template by the user--%>
                    <asp:RequiredFieldValidator ID="RequiredTitleE" runat="server" ErrorMessage="Album Title is required on edit" ControlToValidate="TitleTextBoxE" Display="None" ValidationGroup="egroup"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredReleaseYearE" runat="server" ErrorMessage="Album Year is required on edit" ControlToValidate="ReleaseYearTextBoxE" Display="None" ValidationGroup="egroup"></asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="RegularExTitleE" runat="server" ErrorMessage="Album title is limited to 160 characters" ControlToValidate="TitleTextBoxE" 
                        Display="None" ValidationGroup="egroup" ValidationExpression="^.{1,160}$"></asp:RegularExpressionValidator>

                    <asp:RegularExpressionValidator ID="RegularExReleaseLabelE" runat="server" ErrorMessage="Album Label is limited to 50 characters" ControlToValidate="ReleaseLabelTextBoxE" 
                        Display="None" ValidationGroup="egroup" ValidationExpression="^.{1,50}$"></asp:RegularExpressionValidator>

                    <asp:CompareValidator ID="CompareReleaseYearE" runat="server" ErrorMessage="Year must be a number" ControlToValidate="ReleaseYearTextBoxE" Display="None" Operator="DataTypeCheck" Type="Integer"
                        ValidationGroup="egroup"></asp:CompareValidator>

                    <asp:RangeValidator ID="RangeReleaseYearE" runat="server" ErrorMessage="Year must be between 1950 & this year." ControlToValidate="ReleaseYearTextBoxE" Display="None" ValidationGroup="egroup"
                        MinimumValue="1950" MaximumValue="<%# DateTime.Today.Year %>"></asp:RangeValidator>

                    <tr style="background-color: #008A8C; color: #FFFFFF;">
                        <td>
                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" ValidationGroup="egroup" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                        </td>
                        <td>
                            <asp:TextBox Text='<%# Bind("AlbumId") %>' runat="server" ID="AlbumIdTextBox" Width="50px" Enabled="false" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBoxE" /></td>
                        <td>
                            <asp:DropDownList ID="ArtistList" runat="server" DataSourceID="ArtistListODS" DataTextField="DisplayField" DataValueField="ValueField" SelectedValue='<%# Bind("ArtistId") %>' Width="300px"></asp:DropDownList>
                        <td>
                            <asp:TextBox Text='<%# Bind("ReleaseYear") %>' runat="server" ID="ReleaseYearTextBoxE"  Width="70px"/></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ReleaseLabel") %>' runat="server" ID="ReleaseLabelTextBoxE" /></td>
                    </tr>
                </EditItemTemplate>

                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>

                <InsertItemTemplate>
                    <asp:RequiredFieldValidator ID="RequiredTitleI" runat="server" ErrorMessage="Album Title is required on insert" ControlToValidate="TitleTextBoxI" Display="None" ValidationGroup="igroup"></asp:RequiredFieldValidator>

                    <asp:RequiredFieldValidator ID="RequiredReleaseYearI" runat="server" ErrorMessage="Album Year is required on insert" ControlToValidate="ReleaseYearTextBoxI" Display="None" ValidationGroup="igroup"></asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="RegularExReleaseLabelI" runat="server" ErrorMessage="Album Label is limited to 50 characters" ControlToValidate="ReleaseLabelTextBoxI" 
                        Display="None" ValidationGroup="igroup" ValidationExpression="^.{1,50}$"></asp:RegularExpressionValidator>

                    <asp:CompareValidator ID="CompareReleaseYearI" runat="server" ErrorMessage="Year must be a number" ControlToValidate="ReleaseYearTextBoxI" Display="None" Operator="DataTypeCheck" Type="Integer"
                        ValidationGroup="igroup"></asp:CompareValidator>

                    <asp:RangeValidator ID="RangeReleaseYearI" runat="server" ErrorMessage="Year must be between 1950 & this year." ControlToValidate="ReleaseYearTextBoxI" Display="None" ValidationGroup="igroup"
                        MinimumValue="1950" MaximumValue="<%# DateTime.Today.Year %>"></asp:RangeValidator>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" ValidationGroup="igroup" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                        </td>
                        <td>
                            <asp:TextBox Text='<%# Bind("AlbumId") %>' runat="server" ID="AlbumIdTextBox" Width="50px" Enabled="false"/></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBoxI" /></td>
                        <td>
                            <asp:DropDownList ID="ArtistList" runat="server" DataSourceID="ArtistListODS" DataTextField="DisplayField" DataValueField="ValueField" SelectedValue='<%# Bind("ArtistId") %>' Width="300px"></asp:DropDownList>
                        <td>
                            <asp:TextBox Text='<%# Bind("ReleaseYear") %>' runat="server" ID="ReleaseYearTextBoxI" Width="70px"/></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ReleaseLabel") %>' runat="server" ID="ReleaseLabelTextBoxI"/></td>
                    </tr>
                </InsertItemTemplate>

                <ItemTemplate>
                    <tr style="background-color: #DCDCDC; color: #000000;">
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" OnClientClick="return confirm('Are you sure you wish to delete this album?')" />
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                        <td>
                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                        <td>
                            <asp:DropDownList ID="ArtistList" runat="server" DataSourceID="ArtistListODS" DataTextField="DisplayField" DataValueField="ValueField" SelectedValue='<%# Eval("ArtistId") %>' Enabled="false" Width="300px"></asp:DropDownList>
                        <td>
                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                    <tr runat="server" style="background-color: #DCDCDC; color: #000000;">
                                        <th runat="server"></th>
                                        <th runat="server">Id</th>
                                        <th runat="server">Title</th>
                                        <th runat="server">Artist</th>
                                        <th runat="server">Year</th>
                                        <th runat="server">Label</th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                                <asp:DataPager runat="server" ID="DataPager1">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                        <asp:NumericPagerField></asp:NumericPagerField>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" OnClientClick="return confirm('Are you sure you wish to delete this album?')" />
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                        <td>
                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel"  /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                        <td>
                            <asp:DropDownList ID="ArtistList" runat="server" DataSourceID="ArtistListODS" DataTextField="DisplayField" DataValueField="ValueField" SelectedValue='<%# Eval("ArtistId") %>' Width="300px" Enabled="false"></asp:DropDownList>
                        <td>
                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
            <asp:ObjectDataSource ID="AlbumListODS" runat="server" DataObjectTypeName="ChinookSystem.ViewModels.AlbumItem"
                DeleteMethod="Album_Delete"
                InsertMethod="Albums_Add" OldValuesParameterFormatString="original_{0}"
                SelectMethod="Album_List" TypeName="ChinookSystem.BLL.AlbumController"
                UpdateMethod="Albums_Update"
                OnDeleted="DeleteCheckForException"
                OnInserted="InsertCheckForException"
                OnSelected="SelectCheckForException"
                OnUpdated="UpdateCheckForException"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ArtistListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Artists_DDLList" OnSelected="SelectCheckForException" TypeName="ChinookSystem.BLL.ArtistController"></asp:ObjectDataSource>
        </div>
    </div>

</asp:Content>
