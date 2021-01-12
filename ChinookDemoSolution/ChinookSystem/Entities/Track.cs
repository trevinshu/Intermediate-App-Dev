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
    internal class Track
    {
        private string _Composer;

        public int TrackId { get; set; }

        [Required(ErrorMessage ="Track Name is Required.")]
        [StringLength(200,ErrorMessage ="Track Name is limited to 200 Characters")]
        public string Name { get; set; }

        public int? AlbumId { get; set; }

        public int MediaTypeId { get; set; }

        public int? GenreId { get; set; }

        public string Composer
        {
            get { return _Composer; }
            set { _Composer = string.IsNullOrEmpty(value) ? null : value; }
        }

        public int Milliseconds { get; set; }

        public int? Bytes { get; set; }

        [Range(0.00, int.MaxValue, ErrorMessage = "Units Price  must be 0 or greater")]
        public decimal UnitPrice { get; set; }
    }
}
