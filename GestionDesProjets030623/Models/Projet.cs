using GestionDesProjets.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models
{
    public enum StateAdvancementProj
    {
        Creer, Initialisation, Analyse, Conception, EnCours, Exploitation, Terminer, Cloturer, Annuler
    }


    public partial class Projet
    {
        [Key]
        public int IdProjet { get; set; }

        [Required]
        [StringLength(50)]
        public string NumProj { get; set; } = null!;

        [StringLength(255)]
        public string? NameProj { get; set; }

        [Required]
        public string DescriptionProj { get; set; } = null!;

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime DateStartProj { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime DateEndThProj { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime? DateEndRealProj { get; set; }

        [StringLength(255)]
        public string? PlaceProj { get; set; }

        [Required]
        public StateAdvancementProj StateAdvancementProj { get; set; }

        public decimal Caproj { get; set; }

        public int? IdDevis { get; set; }

        public int? IdUtilisateur { get; set; }

        public virtual ICollection<Cout> Couts { get; set; } = new List<Cout>();

        public virtual ICollection<Document> Documents { get; set; } = new List<Document>();

        public virtual ICollection<Facture> Factures { get; set; } = new List<Facture>();

        public virtual Devi? IdDevisNavigation { get; set; }

        public virtual Utilisateur? IdUtilisateurNavigation { get; set; }

        public virtual ICollection<Tach> Taches { get; set; } = new List<Tach>();
    }
}
