﻿using System;
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
    }
}
