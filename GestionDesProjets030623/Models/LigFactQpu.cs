using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models;

public partial class LigFactQpu
{
    [Key]
    public int IdLigFactQpu { get; set; }

    [DataType(DataType.Date)]
    [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
    public DateTime DateInterventionLigFactQpu { get; set; }

    public int NumLigFactQpu { get; set; }

    [Required]
    [StringLength(255)]
    public string DesignationLigFactQpu { get; set; } = null!;

    [Required]
    public byte QLigFactQpu { get; set; }

    [Required]
    public decimal MontantLigFactQpu { get; set; }

    public int? IdFacture { get; set; }

    public virtual Facture? IdFactureNavigation { get; set; }
}
