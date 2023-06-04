using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models;

public partial class LigFactForfait
{
    [Key]
    public int IdLigFactForfait { get; set; }

    [DataType(DataType.Date)]
    [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
    public DateTime DateInterventionLigFactForfait { get; set; }

    public int NumLigFactForfait { get; set; }

    [Required]
    [StringLength(255)]
    public string DesignationLigFactForfait { get; set; } = null!;

    [Required]
    public decimal MontantLigFactForfait { get; set; }

    public int? IdFacture { get; set; }

    public virtual Facture? IdFactureNavigation { get; set; }
}
