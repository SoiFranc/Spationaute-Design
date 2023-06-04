using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models;

public partial class LigDevForfait
{
    [Key]
    public int IdLigDevForfait { get; set; }

    public int NumLigDevForfait { get; set; }

    [Required]
    [StringLength(255)]
    public string DesignationLigDevForfait { get; set; } = null!;

    [Required]
    public decimal MontantLigDevForfait { get; set; }

    public int? IdDevis { get; set; }

    public virtual Devi? IdDevisNavigation { get; set; }
}
