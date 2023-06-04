using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models
{
    public enum TypeFact
    {
        Forfait, QPU
    }

    public partial class Facture
    {
        [Key]
        public int IdFacture { get; set; }

        [Required]
        [StringLength(50)]
        public string NumFact { get; set; } = null!;

        [Required]
        [StringLength(255)]
        public string NameFact { get; set; } = null!;

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime DateAcquittalFact { get; set; }

        [Required]
        [DisplayName("Comptabilisé ?")]
        public bool IsAccount { get; set; } = false;

        [Required]
        public TypeFact TypeFact { get; set; }

        [Required]
        public decimal MontantHtfact { get; set; }

        public int? IdProjet { get; set; }

        public int? IdTva { get; set; }

        public int? IdDeGeneration { get; set; }

        public virtual Generateur? IdDeGenerationNavigation { get; set; }

        public virtual Projet? IdProjetNavigation { get; set; }

        public virtual Tva? IdTvaNavigation { get; set; }

        public virtual ICollection<LigFactForfait> LigFactForfaits { get; set; } = new List<LigFactForfait>();

        public virtual ICollection<LigFactQpu> LigFactQpus { get; set; } = new List<LigFactQpu>();
    }
}


