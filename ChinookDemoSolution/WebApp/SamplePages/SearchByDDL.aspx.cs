using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region Additional Namespaces 
using ChinookSystem.BLL;
using ChinookSystem.ViewModels;
#endregion
namespace WebApp.SamplePages
{
    public partial class SearchByDDL : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                //This is first time
                LoadArtistList();
            }
        }

        protected void LoadArtistList()
        {
            //User friendly error handling (aka try/catch)
            //Use the usercontrol MessageUserControl to manage the error handling for the webpage when control leaves the webpage & goes to the class library
            MessageUserControl.TryRun(() => { 
            //What goes inside the coding block?
            //Your code that would normally be inside the try portion of a try/catch
            },"Success title message", "The success title & body message are optional");
            ArtistController sysmgr = new ArtistController();
            List<SelectionList> info = sysmgr.Artists_DDLList();

            //Let's assume that the data collection needs to be sorted
            info.Sort((x,y) => x.DisplayField.CompareTo(y.DisplayField));

            //Setup DDL
            ArtistList.DataSource = info;
            ArtistList.DataTextField = nameof(SelectionList.DisplayField);
            ArtistList.DataValueField = nameof(SelectionList.ValueField);
            ArtistList.DataBind();

            //Setup Prompt Line
            ArtistList.Items.Insert(0, new ListItem("Select...", "0"));
        }

        #region Error Handling Methods For ODS
        protected void SelectCheckForException(object sender, ObjectDataSourceStatusEventArgs e)
        {
            MessageUserControl.HandleDataBoundException(e);
        }
        #endregion
        protected void SearchAlbums_Click(object sender, EventArgs e)
        {
            if(ArtistList.SelectedIndex == 0)
            {
                //Am I on the first line (prompt line) of the DDL
                MessageUserControl.ShowInfo("Search Selection Concern","Select an artist for the search");
                ArtistAlbumList.DataSource = null;
                ArtistAlbumList.DataBind();
            }

            else
            {
                MessageUserControl.TryRun(() => {
                    AlbumController sysmgr = new AlbumController();
                    List<ChinookSystem.ViewModels.ArtistAlbums> info = sysmgr.Albums_GetAlbumsForArtist(int.Parse(ArtistList.SelectedValue));
                    ArtistAlbumList.DataSource = info;
                    ArtistAlbumList.DataBind();
                }, "Search Results","The list of albums for the selected artist.");
            }
        }
    }
}