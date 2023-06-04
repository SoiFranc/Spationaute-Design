using Microsoft.EntityFrameworkCore;

namespace GestionDesProjets.Models
{
    public class GestionDesProjetsContext : DbContext
    {
        public GestionDesProjetsContext(DbContextOptions options) : base(options) 
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder) 
        {
            
        }
    }
}
