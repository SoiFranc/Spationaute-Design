using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models;

public partial class Tva
{
    [Key]
    public int IdTva { get; set; }

    [Required]
    public decimal TauxTva { get; set; }

    public virtual ICollection<Devi> Devis { get; set; } = new List<Devi>();

    public virtual ICollection<Facture> Factures { get; set; } = new List<Facture>();
}
