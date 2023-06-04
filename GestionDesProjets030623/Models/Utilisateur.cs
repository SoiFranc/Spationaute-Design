using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GestionDesProjets.Models;

public partial class Utilisateur
{
    [Key]
    public int IdUtilisateur { get; set; }

    [Required]
    [StringLength(20)]
    public string Firstname { get; set; } = null!;

    [Required]
    [StringLength(20)]
    public string Name { get; set; } = null!;

    [Required(ErrorMessage = "Votre Login est requis pour vous connecter.")]
    [StringLength(100)]
    public string Login { get; set; } = null!;

    [Required(ErrorMessage = "Votre Mot de passe est requis, Attention après 3 essais vous serez blocké.")]
    [StringLength(100, MinimumLength = 12)]
    [DataType(DataType.Password)]
    public string Psw { get; set; } = null!;

    [MinLength(5)]
    [MaxLength(260)]
    [DisplayName("Adresse")]
    public string Adress { get; set; } = null!;

    [Phone]
    [StringLength(20)]
    public string Tel { get; set; } = null!;

    [StringLength(100)]
    [EmailAddress]
    public string Mail { get; set; } = null!;

    [DisplayName("Actif")]
    public bool IsActivate { get; set; } = false;

    [Display(Name = "Responsable")]
    public string FullName
    {
        get
        {
            return Firstname + " " + Name;
        }
    }

    public virtual ICollection<Client> Clients { get; set; } = new List<Client>();

    public virtual ICollection<Projet> Projets { get; set; } = new List<Projet>();
}
