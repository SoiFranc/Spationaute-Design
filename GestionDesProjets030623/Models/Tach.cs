using GestionDesProjets.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models
{
    public enum CategoryTache
    {
        Initialisation, Analyse, Conception, Realisation, Exploitation
    }

    public enum PrioTache
    {
        Vitale, Importante, Utile, Confort
    }
    
    public enum StateTache
    {
        Idee, Creer, Encours, ATester, Terminer, Annuler
    }

    public partial class Tach
    {
        [Key]
        public int IdTache { get; set; }

        [Required]
        [StringLength(20)]
        public string NumTache { get; set; } = null!;

        [Required]
        [StringLength(20)]
        public string NameTache { get; set; } = null!;

        [Required]
        public string DescriptionTache { get; set; } = null!;

        [Required]
        public PrioTache PrioTache { get; set; }

        [Required]
        public StateTache StateTache { get; set; }

        [Required]
        public CategoryTache CategoryTache { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime DateCreateTache { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? DateInProgressTache { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? DateToTestTache { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? DateEndThTache { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? DateEndRealTache { get; set; }

        public int? IdProjet { get; set; }

        public virtual Projet? IdProjetNavigation { get; set; }
    }
}


