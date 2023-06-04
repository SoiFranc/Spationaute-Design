using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models
{
    public enum CatDocGen
    {
        Devis, Facture
    }

    public partial class Generateur
    {
        [Key]
        public int IdDeGeneration { get; set; }

        [DataType(DataType.Date)]
        public DateTime DateGenerationDoc { get; set; }

        [Required]
        [StringLength(20)]
        public CatDocGen CatDocGen { get; set; }

        public virtual ICollection<Devi> Devis { get; set; } = new List<Devi>();

        public virtual ICollection<Document> Documents { get; set; } = new List<Document>();

        public virtual ICollection<Facture> Factures { get; set; } = new List<Facture>();
    }
}


