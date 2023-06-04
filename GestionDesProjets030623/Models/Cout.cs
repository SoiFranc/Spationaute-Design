using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models
{
    public enum CatCout
    {
        Frais, Charges, Divers, Materiaux, RH
    }

    public partial class Cout
    {
        [Key]
        public int IdCout { get; set; }

        [Required]
        public CatCout CatCout { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime DateCout { get; set; }

        [StringLength(250)]
        public string DescriptionCout { get; set; } = null!;

        [Required]
        public decimal MontantCout { get; set; }

        public int? IdProjet { get; set; }

        public virtual Projet? IdProjetNavigation { get; set; }
    }
}


