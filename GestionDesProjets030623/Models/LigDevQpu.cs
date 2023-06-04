using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models;

public partial class LigDevQpu
{
    [Key]
    public int IdLigDevQpu { get; set; }

    public int NumLigDevQpu { get; set; }

    [Required]
    [StringLength(255)]
    public string DesignationLigDevQpu { get; set; } = null!;

    [Required]
    public byte QLigDevQpu { get; set; }

    [Required]
    public decimal MontantLigDevQpu { get; set; }

    public int? IdDevis { get; set; }

    public virtual Devi? IdDevisNavigation { get; set; }
}
