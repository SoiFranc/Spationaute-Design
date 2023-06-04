using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models;

public partial class Client
{
    [Key]
    [DisplayName("N° Client")]
    public int IdClient { get; set; }

    [Required]
    [StringLength(20)]
    [DisplayName("Prénom")]
    public string Firstname { get; set; } = null!;

    [Required]
    [StringLength(20)]
    [DisplayName("Nom")]
    public string Name { get; set; } = null!;

    [MinLength(5)]
    [MaxLength(260)]
    [DisplayName("Adresse")]
    public string Adress { get; set; }

    [Phone]
    [StringLength(20)]
    public string Tel { get; set; } = null!;

    [Required]
    [StringLength(100)]
    [EmailAddress]
    public string Mail { get; set; } = null!;

    [DisplayName("Actif")]
    public bool? IsActivate { get; set; }

    public bool? IsPro { get; set; }

    [StringLength(20)]
    public string? NumSiret { get; set; }

    [StringLength(20)]
    public string? TvaIntracom { get; set; }

    [StringLength(10)]
    public string? CodeApe { get; set; }

    [Required]
    [StringLength(30)]
    [DisplayName("Nom Professionnel")]
    public string NomActivitePro { get; set; } = null!;

    [Required]
    [MinLength(5)]
    [MaxLength(260)]
    [DisplayName("Adresse Pro")]
    public string AdrActivitePro { get; set; } = null!;


    [StringLength(1024)]
    public string? Commentaire { get; set; }

    public int? IdUtilisateur { get; set; }

    public virtual ICollection<Devi> Devis { get; set; } = new List<Devi>();

    [DisplayName("Contact")]
    public virtual Utilisateur? IdUtilisateurNavigation { get; set; }

    public int Count { get; }
}