using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace GestionDesProjets.Models;

public partial class SpationauteDesignBddContext : DbContext
{
    public SpationauteDesignBddContext()
    {
    }

    public SpationauteDesignBddContext(DbContextOptions<SpationauteDesignBddContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Client> Clients { get; set; }

    public virtual DbSet<Cout> Couts { get; set; }

    public virtual DbSet<Devi> Devis { get; set; }

    public virtual DbSet<Document> Documents { get; set; }

    public virtual DbSet<Facture> Factures { get; set; }

    public virtual DbSet<Generateur> Generateurs { get; set; }

    public virtual DbSet<LigDevForfait> LigDevForfaits { get; set; }

    public virtual DbSet<LigDevQpu> LigDevQpus { get; set; }

    public virtual DbSet<LigFactForfait> LigFactForfaits { get; set; }

    public virtual DbSet<LigFactQpu> LigFactQpus { get; set; }

    public virtual DbSet<Projet> Projets { get; set; }

    public virtual DbSet<Tach> Taches { get; set; }

    public virtual DbSet<Tva> Tvas { get; set; }

    public virtual DbSet<Utilisateur> Utilisateurs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConnectSDBDD");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Client>(entity =>
        {
            entity.HasKey(e => e.IdClient).HasName("PK__Clients__A6A610D41AC1879C");

            entity.Property(e => e.IdClient).HasColumnName("idClient");
            entity.Property(e => e.AdrActivitePro)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("adrActivitePro");
            entity.Property(e => e.Adress)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("adress");
            entity.Property(e => e.CodeApe)
                .HasMaxLength(10)
                .IsUnicode(false)
                .HasColumnName("codeAPE");
            entity.Property(e => e.Commentaire)
                .HasMaxLength(1024)
                .IsUnicode(false)
                .HasColumnName("commentaire");
            entity.Property(e => e.Firstname)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("firstname");
            entity.Property(e => e.IdUtilisateur).HasColumnName("idUtilisateur");
            entity.Property(e => e.IsActivate)
                .HasDefaultValueSql("((0))")
                .HasColumnName("isActivate");
            entity.Property(e => e.IsPro)
                .HasDefaultValueSql("((1))")
                .HasColumnName("isPro");
            entity.Property(e => e.Mail)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("mail");
            entity.Property(e => e.Name)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.NomActivitePro)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasColumnName("nomActivitePro");
            entity.Property(e => e.NumSiret)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("numSiret");
            entity.Property(e => e.TvaIntracom)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("TvaIntracom");
            entity.Property(e => e.Tel)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("tel");

            entity.HasOne(d => d.IdUtilisateurNavigation).WithMany(p => p.Clients)
                .HasForeignKey(d => d.IdUtilisateur)
                .HasConstraintName("FK_Clients_Utilisateurs");
        });

        modelBuilder.Entity<Cout>(entity =>
        {
            entity.HasKey(e => e.IdCout).HasName("PK__Couts__80B36506F98F0E01");

            entity.Property(e => e.IdCout).HasColumnName("idCout");
            entity.Property(e => e.CatCout)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValueSql("('RH')")
                .HasColumnName("catCout");
            entity.Property(e => e.DateCout)
                .HasColumnType("date")
                .HasColumnName("dateCout");
            entity.Property(e => e.DescriptionCout)
                .HasMaxLength(250)
                .IsUnicode(false)
                .HasColumnName("descriptionCout");
            entity.Property(e => e.IdProjet).HasColumnName("idProjet");
            entity.Property(e => e.MontantCout).HasColumnType("money");

            entity.HasOne(d => d.IdProjetNavigation).WithMany(p => p.Couts)
                .HasForeignKey(d => d.IdProjet)
                .HasConstraintName("FK_Couts_Projets");
        });

        modelBuilder.Entity<Devi>(entity =>
        {
            entity.HasKey(e => e.IdDevis).HasName("PK__Devis__876D947C5C41EA90");

            entity.HasIndex(e => e.NumDev, "UQ__Devis__F3BBD506F9D73175").IsUnique();

            entity.Property(e => e.IdDevis).HasColumnName("idDevis");
            entity.Property(e => e.DateValidationDev)
                .HasColumnType("date")
                .HasColumnName("dateValidationDev");
            entity.Property(e => e.IdClient).HasColumnName("idClient");
            entity.Property(e => e.IdDeGeneration).HasColumnName("idDeGeneration");
            entity.Property(e => e.IdTva).HasColumnName("idTVA");
            entity.Property(e => e.NameDev)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("nameDev");
            entity.Property(e => e.NbJourValidity).HasColumnName("nbJourValidity");
            entity.Property(e => e.NumDev)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("numDev");
            entity.Property(e => e.TotalHtdev)
                .HasColumnType("money")
                .HasColumnName("totalHTDev");
            entity.Property(e => e.Type)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValueSql("('Forfait')")
                .HasColumnName("type");

            entity.HasOne(d => d.IdClientNavigation).WithMany(p => p.Devis)
                .HasForeignKey(d => d.IdClient)
                .HasConstraintName("FK_Devis_Clients");

            entity.HasOne(d => d.IdDeGenerationNavigation).WithMany(p => p.Devis)
                .HasForeignKey(d => d.IdDeGeneration)
                .HasConstraintName("FK_Devis_Generateur");

            entity.HasOne(d => d.IdTvaNavigation).WithMany(p => p.Devis)
                .HasForeignKey(d => d.IdTva)
                .HasConstraintName("FK_Devis_TVA");
        });

        modelBuilder.Entity<Document>(entity =>
        {
            entity.HasKey(e => e.IdDocument).HasName("PK__Document__E3A0F08E12736EF8");

            entity.Property(e => e.IdDocument).HasColumnName("idDocument");
            entity.Property(e => e.CatDoc)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValueSql("('Devis')")
                .HasColumnName("catDoc");
            entity.Property(e => e.DateDoc)
                .HasColumnType("date")
                .HasColumnName("dateDoc");
            entity.Property(e => e.DescriptionDoc)
                .HasColumnType("text")
                .HasColumnName("descriptionDoc");
            entity.Property(e => e.IdDeGeneration)
                .HasDefaultValueSql("((0))")
                .HasColumnName("idDeGeneration");
            entity.Property(e => e.IdProjet).HasColumnName("idProjet");
            entity.Property(e => e.NameDoc)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("nameDoc");
            entity.Property(e => e.PathDoc)
                .HasMaxLength(256)
                .IsUnicode(false)
                .HasColumnName("pathDoc");

            entity.HasOne(d => d.IdDeGenerationNavigation).WithMany(p => p.Documents)
                .HasForeignKey(d => d.IdDeGeneration)
                .HasConstraintName("FK_Documents_Generateur");

            entity.HasOne(d => d.IdProjetNavigation).WithMany(p => p.Documents)
                .HasForeignKey(d => d.IdProjet)
                .HasConstraintName("FK_Documents_Projets");
        });

        modelBuilder.Entity<Facture>(entity =>
        {
            entity.HasKey(e => e.IdFacture).HasName("PK__Factures__3CD5687A32D12C1D");

            entity.Property(e => e.IdFacture).HasColumnName("idFacture");
            entity.Property(e => e.DateAcquittalFact)
                .HasColumnType("date")
                .HasColumnName("dateAcquittalFact");
            entity.Property(e => e.IdDeGeneration).HasColumnName("idDeGeneration");
            entity.Property(e => e.IdProjet).HasColumnName("idProjet");
            entity.Property(e => e.IdTva).HasColumnName("idTVA");
            entity.Property(e => e.IsAccount).HasColumnName("isAccount");
            entity.Property(e => e.MontantHtfact)
                .HasColumnType("money")
                .HasColumnName("montantHTFact");
            entity.Property(e => e.NameFact)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("nameFact");
            entity.Property(e => e.NumFact)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("numFact");
            entity.Property(e => e.TypeFact)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValueSql("('Forfait')")
                .HasColumnName("typeFact");

            entity.HasOne(d => d.IdDeGenerationNavigation).WithMany(p => p.Factures)
                .HasForeignKey(d => d.IdDeGeneration)
                .HasConstraintName("FK_Factures_Generateur");

            entity.HasOne(d => d.IdProjetNavigation).WithMany(p => p.Factures)
                .HasForeignKey(d => d.IdProjet)
                .HasConstraintName("FK_Factures_Projets");

            entity.HasOne(d => d.IdTvaNavigation).WithMany(p => p.Factures)
                .HasForeignKey(d => d.IdTva)
                .HasConstraintName("FK_Factures_TVA");
        });

        modelBuilder.Entity<Generateur>(entity =>
        {
            entity.HasKey(e => e.IdDeGeneration).HasName("PK__Generate__CC119B4F84B2E5A2");

            entity.ToTable("Generateur");

            entity.Property(e => e.IdDeGeneration).HasColumnName("idDeGeneration");
            entity.Property(e => e.CatDocGen)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValueSql("('Devis')")
                .HasColumnName("catDoc");
            entity.Property(e => e.DateGenerationDoc)
                .HasColumnType("date")
                .HasColumnName("dateGenerationDoc");
        });

        modelBuilder.Entity<LigDevForfait>(entity =>
        {
            entity.HasKey(e => e.IdLigDevForfait).HasName("PK__LigDevFo__1607CDFA47F2698D");

            entity.ToTable("LigDevForfait");

            entity.Property(e => e.IdLigDevForfait).HasColumnName("idLigDevForfait");
            entity.Property(e => e.DesignationLigDevForfait)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("designationLigDevForfait");
            entity.Property(e => e.IdDevis).HasColumnName("idDevis");
            entity.Property(e => e.MontantLigDevForfait)
                .HasColumnType("money")
                .HasColumnName("montantLigDevForfait");
            entity.Property(e => e.NumLigDevForfait).HasColumnName("numLigDevForfait");

            entity.HasOne(d => d.IdDevisNavigation).WithMany(p => p.LigDevForfaits)
                .HasForeignKey(d => d.IdDevis)
                .HasConstraintName("FK_ligDevForfait_Devis");
        });

        modelBuilder.Entity<LigDevQpu>(entity =>
        {
            entity.HasKey(e => e.IdLigDevQpu).HasName("PK__LigDevQP__898300329AE18BA9");

            entity.ToTable("LigDevQPU");

            entity.Property(e => e.IdLigDevQpu).HasColumnName("idLigDevQPU");
            entity.Property(e => e.DesignationLigDevQpu)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("designationLigDevQPU");
            entity.Property(e => e.IdDevis).HasColumnName("idDevis");
            entity.Property(e => e.MontantLigDevQpu)
                .HasColumnType("money")
                .HasColumnName("montantLigDevQPU");
            entity.Property(e => e.NumLigDevQpu).HasColumnName("numLigDevQPU");
            entity.Property(e => e.QLigDevQpu).HasColumnName("qLigDevQPU");

            entity.HasOne(d => d.IdDevisNavigation).WithMany(p => p.LigDevQpus)
                .HasForeignKey(d => d.IdDevis)
                .HasConstraintName("FK_ligDevQPU_Devis");
        });

        modelBuilder.Entity<LigFactForfait>(entity =>
        {
            entity.HasKey(e => e.IdLigFactForfait).HasName("PK__LigFactF__030647B9BF4BF643");

            entity.ToTable("LigFactForfait");

            entity.Property(e => e.IdLigFactForfait).HasColumnName("idLigFactForfait");
            entity.Property(e => e.DateInterventionLigFactForfait)
                .HasColumnType("date")
                .HasColumnName("dateInterventionLigFactForfait");
            entity.Property(e => e.DesignationLigFactForfait)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("designationLigFactForfait");
            entity.Property(e => e.IdFacture).HasColumnName("idFacture");
            entity.Property(e => e.MontantLigFactForfait)
                .HasColumnType("money")
                .HasColumnName("montantLigFactForfait");
            entity.Property(e => e.NumLigFactForfait).HasColumnName("numLigFactForfait");

            entity.HasOne(d => d.IdFactureNavigation).WithMany(p => p.LigFactForfaits)
                .HasForeignKey(d => d.IdFacture)
                .HasConstraintName("FK_ligFactForfait_Factures");
        });

        modelBuilder.Entity<LigFactQpu>(entity =>
        {
            entity.HasKey(e => e.IdLigFactQpu).HasName("PK__LigFactQ__38B536088E808ED0");

            entity.ToTable("LigFactQPU");

            entity.Property(e => e.IdLigFactQpu).HasColumnName("idLigFactQPU");
            entity.Property(e => e.DateInterventionLigFactQpu)
                .HasColumnType("date")
                .HasColumnName("dateInterventionLigFactQPU");
            entity.Property(e => e.DesignationLigFactQpu)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("designationLigFactQPU");
            entity.Property(e => e.IdFacture).HasColumnName("idFacture");
            entity.Property(e => e.MontantLigFactQpu)
                .HasColumnType("money")
                .HasColumnName("montantLigFactQPU");
            entity.Property(e => e.NumLigFactQpu).HasColumnName("numLigFactQPU");
            entity.Property(e => e.QLigFactQpu).HasColumnName("qLigFactQPU");

            entity.HasOne(d => d.IdFactureNavigation).WithMany(p => p.LigFactQpus)
                .HasForeignKey(d => d.IdFacture)
                .HasConstraintName("FK_ligFactQPU_Factures");
        });

        modelBuilder.Entity<Projet>(entity =>
        {
            entity.HasKey(e => e.IdProjet).HasName("PK__Projets__289161A1187369E7");

            entity.HasIndex(e => e.NumProj, "UQ__Projets__7A8D83CFC0D779CD").IsUnique();

            entity.Property(e => e.IdProjet).HasColumnName("idProjet");
            entity.Property(e => e.Caproj)
                .HasColumnType("money")
                .HasColumnName("CAProj");
            entity.Property(e => e.DateEndRealProj)
                .HasColumnType("date")
                .HasColumnName("dateEndRealProj");
            entity.Property(e => e.DateEndThProj)
                .HasColumnType("date")
                .HasColumnName("dateEndThProj");
            entity.Property(e => e.DateStartProj)
                .HasColumnType("date")
                .HasColumnName("dateStartProj");
            entity.Property(e => e.DescriptionProj)
                .HasColumnType("text")
                .HasColumnName("descriptionProj");
            entity.Property(e => e.IdDevis).HasColumnName("idDevis");
            entity.Property(e => e.IdUtilisateur).HasColumnName("idUtilisateur");
            entity.Property(e => e.NameProj)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("nameProj");
            entity.Property(e => e.NumProj)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("numProj");
            entity.Property(e => e.PlaceProj)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("placeProj");
            entity.Property(e => e.StateAdvancementProj)
                .HasMaxLength(30)
                .IsUnicode(false)
                .HasDefaultValueSql("('Creer')")
                .HasColumnName("stateAdvancementProj");

            entity.HasOne(d => d.IdDevisNavigation).WithMany(p => p.Projets)
                .HasForeignKey(d => d.IdDevis)
                .HasConstraintName("FK_Projets_Devis");

            entity.HasOne(d => d.IdUtilisateurNavigation).WithMany(p => p.Projets)
                .HasForeignKey(d => d.IdUtilisateur)
                .HasConstraintName("FK_Projets_Utilisateurs");
        });

        modelBuilder.Entity<Tach>(entity =>
        {
            entity.HasKey(e => e.IdTache).HasName("PK__Taches__735D319C52B48FE1");

            entity.Property(e => e.IdTache).HasColumnName("idTache");
            entity.Property(e => e.CategoryTache)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValueSql("('Initialisation')")
                .HasColumnName("categoryTache");
            entity.Property(e => e.DateCreateTache)
                .HasColumnType("date")
                .HasColumnName("dateCreateTache");
            entity.Property(e => e.DateEndRealTache)
                .HasColumnType("date")
                .HasColumnName("dateEndRealTache");
            entity.Property(e => e.DateEndThTache)
                .HasColumnType("date")
                .HasColumnName("dateEndThTache");
            entity.Property(e => e.DateInProgressTache)
                .HasColumnType("date")
                .HasColumnName("dateInProgressTache");
            entity.Property(e => e.DateToTestTache)
                .HasColumnType("date")
                .HasColumnName("dateToTestTache");
            entity.Property(e => e.DescriptionTache)
                .HasMaxLength(1500)
                .IsUnicode(false)
                .HasColumnName("descriptionTache");
            entity.Property(e => e.IdProjet).HasColumnName("idProjet");
            entity.Property(e => e.NameTache)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("nameTache");
            entity.Property(e => e.NumTache)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("numTache");
            entity.Property(e => e.PrioTache)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValueSql("('Vitale')")
                .HasColumnName("prioTache");
            entity.Property(e => e.StateTache)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasDefaultValueSql("('Idee')")
                .HasColumnName("stateTache");

            entity.HasOne(d => d.IdProjetNavigation).WithMany(p => p.Taches)
                .HasForeignKey(d => d.IdProjet)
                .HasConstraintName("FK_Taches_Projets");
        });

        modelBuilder.Entity<Tva>(entity =>
        {
            entity.HasKey(e => e.IdTva).HasName("PK__TVA__020E3E38501AB55D");

            entity.ToTable("TVA");

            entity.Property(e => e.IdTva).HasColumnName("idTVA");
            entity.Property(e => e.TauxTva)
                .HasColumnType("decimal(5, 2)")
                .HasColumnName("tauxTVA");
        });

        modelBuilder.Entity<Utilisateur>(entity =>
        {
            entity.HasKey(e => e.IdUtilisateur).HasName("PK__Utilisat__5366DB191B4D64A2");

            entity.HasIndex(e => e.Psw, "UQ__Utilisat__DD37A9EE6537783C").IsUnique();

            entity.Property(e => e.IdUtilisateur).HasColumnName("idUtilisateur");
            entity.Property(e => e.Adress)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("adress");
            entity.Property(e => e.Firstname)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("firstname");
            entity.Property(e => e.IsActivate)
                .HasDefaultValueSql("((0))")
                .HasColumnName("isActivate");
            entity.Property(e => e.Login)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("login");
            entity.Property(e => e.Mail)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("mail");
            entity.Property(e => e.Name)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.Psw)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("psw");
            entity.Property(e => e.Tel)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("tel");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
