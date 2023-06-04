using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models
{
    public enum CatDoc
    {
        Devis, Divers, Couts, Schema, Plan, ImgPhoto, Facture
    }

    public partial class Document
    {
        [Key]
        public int IdDocument { get; set; }

        [Required]
        public CatDoc CatDoc { get; set; }
        
        [Required]
        [StringLength(50)]
        public string NameDoc { get; set; } = null!;

        public string? DescriptionDoc { get; set; }

        [DataType(DataType.Date)]
        public DateTime DateDoc { get; set; }

        [Required]
        public string PathDoc { get; set; } = null!;

        public int? IdProjet { get; set; }

        public int? IdDeGeneration { get; set; }

        public virtual Generateur? IdDeGenerationNavigation { get; set; }

        public virtual Projet? IdProjetNavigation { get; set; }
    }
}


