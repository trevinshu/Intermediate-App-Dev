using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ChinookSystem.ViewModels
{
    //This class will be used as a generic container for data which will load a DDL (Dropdown List).
    //This value field will represent a integer Primary Key.
    //The Display Field will represent the displayed string of the DDL.
    public class SelectionList
    {
        public int ValueField { get; set; }
        public string DisplayField { get; set; }
    }
}
