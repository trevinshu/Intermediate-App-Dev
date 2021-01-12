using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
#region Additional Namespaces
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
#endregion

namespace ChinookSystem.Entities
{
    [Table("Artists")]
    internal class Artist
    {
        private string _Name;

        [Key]
        public int ArtistId { get; set; }

        //[Required(ErrorMessage="Artist Name is Required.")]
        [StringLength(120,ErrorMessage ="Artist Name is limited to 120 Characters.")]
        public string Name
        {
            get { return _Name; }
            set { _Name = string.IsNullOrEmpty(value) ? null : value; }
        }

        //Navigational Properties
        //1 to many relationship; create the many relationship in this entity
        public virtual ICollection<Album> Albums { get; set; }
    }
}
