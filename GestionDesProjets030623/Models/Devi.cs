using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.InteropServices;

namespace GestionDesProjets.Models
{
    public enum Type
    {
        Forfait, QPU
    }

    public partial class Devi
    {
        [Key]
        public int IdDevis { get; set; }

        [Required]
        [StringLength(50)]
        public string NumDev { get; set; } = null!;

        public int NbJourValidity { get; set; }

        [Required]
        [StringLength(255)]
        public string NameDev { get; set; } = null!;

        [DataType(DataType.Date)]
        public DateTime? DateValidationDev { get; set; }

        [Required]
        public Type Type { get; set; }

        [Required]
        public decimal TotalHtdev { get; set; }

        public int? IdClient { get; set; }

        public int? IdTva { get; set; }

        public int? IdDeGeneration { get; set; }

        public virtual Client? IdClientNavigation { get; set; }

        public virtual Generateur? IdDeGenerationNavigation { get; set; }

        public virtual Tva? IdTvaNavigation { get; set; }

        public virtual ICollection<LigDevForfait> LigDevForfaits { get; set; } = new List<LigDevForfait>();

        public virtual ICollection<LigDevQpu> LigDevQpus { get; set; } = new List<LigDevQpu>();

        public virtual ICollection<Projet> Projets { get; set; } = new List<Projet>();
    }
}


