using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using ChinookSystem.Entities;
using ChinookSystem.DAL;
using ChinookSystem.ViewModels;
using System.ComponentModel; //For ODS
#endregion
namespace ChinookSystem.BLL
{
    [DataObject]
    public class AlbumController
    {
        //Can't use entity class as a return type because entities are internal
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<ArtistAlbums> Albums_GetArtistAlbums()
        {
            using (var context = new ChinookSystemContext())
            {
                //Linq to Entity
                IEnumerable<ArtistAlbums> results = from x in context.Albums
                                                    select new ArtistAlbums
                                                    {
                                                        Title = x.Title,
                                                        ReleaseYear = x.ReleaseYear,
                                                        ArtistName = x.Artist.Name
                                                    };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ArtistAlbums> Albums_GetAlbumsForArtist(int artistid)
        {
            using (var context = new ChinookSystemContext())
            {
                //Linq to entity

                IEnumerable<ArtistAlbums> results = from x in context.Albums
                                                     where x.ArtistId == artistid
                                                     select new ArtistAlbums
                                                     {
                                                         Title = x.Title,
                                                         ReleaseYear = x.ReleaseYear,
                                                         ArtistName = x.Artist.Name,
                                                         ArtistId = x.ArtistId
                                                     };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<AlbumItem> Album_List()
        {
            using (var context = new ChinookSystemContext())
            {
                IEnumerable<AlbumItem> results = from x in context.Albums
                                                    select new AlbumItem
                                                    {
                                                        AlbumId = x.AlbumId,
                                                        Title = x.Title, 
                                                        ArtistId = x.ArtistId,
                                                        ReleaseYear = x.ReleaseYear,
                                                        ReleaseLabel = x.ReleaseLabel
                                                    };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public AlbumItem Albums_FindById(int albumid)
        {
            using (var context = new ChinookSystemContext())
            {
               AlbumItem results = (from x in context.Albums
                                   where x.AlbumId == albumid
                                   select new AlbumItem
                                   {
                                       AlbumId = x.AlbumId,
                                       Title = x.Title,
                                       ArtistId = x.ArtistId,
                                       ReleaseYear = x.ReleaseYear,
                                       ReleaseLabel = x.ReleaseLabel
                                   }).FirstOrDefault();
                return results;
            }
        }

        #region Add, Update, Delete

        [DataObjectMethod(DataObjectMethodType.Insert,false)]
        public int Albums_Add(AlbumItem item)
        {
            using (var context = new ChinookSystemContext())
            {
                //Need to move the data from the viewmodel class into an entity instance befor staging
                //The Primary Key of the Albums table is an identity() Primary Key therefore you do not need to supply it
                Album entityItem = new Album
                {
                    Title = item.Title,
                    ArtistId = item.ArtistId,
                    ReleaseYear = item.ReleaseYear,
                    ReleaseLabel = item.ReleaseLabel
                };
                //Stagging 
                context.Albums.Add(entityItem);
                //Commit
                context.SaveChanges();
                //Since I have an int as the return datatype I will return the new identity value
                return entityItem.AlbumId;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Update, false)]
        public void Albums_Update(AlbumItem item)
        {
            using (var context = new ChinookSystemContext())
            {
                //Need to move the data from the viewmodel class into an entity instance befor staging
                //On updates you need to supply the tables Primary Key value
                Album entityItem = new Album
                {
                    AlbumId = item.AlbumId,
                    Title = item.Title,
                    ArtistId = item.ArtistId,
                    ReleaseYear = item.ReleaseYear,
                    ReleaseLabel = item.ReleaseLabel
                };
                //Stagging 
                context.Entry(entityItem).State = System.Data.Entity.EntityState.Modified;
                //Commit
                context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Delete,false)]
        public void Album_Delete(AlbumItem item)
        {
            //this method will call the actual delete method and pass it
            //the only need piece of data: primary key
            Album_Delete(item.AlbumId);
        }

        public void Album_Delete(int albumid)
        {
            using (var context = new ChinookSystemContext())
            {
                var exists = context.Albums.Find(albumid);
                context.Albums.Remove(exists);
                context.SaveChanges();
            }
        }
        #endregion
    }
}
