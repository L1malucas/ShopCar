using CarVerzel.Models;
using Microsoft.EntityFrameworkCore;

namespace CarVerzel.Data;

public class CarVerzelContext : DbContext
{
    public CarVerzelContext(DbContextOptions<CarVerzelContext> options) : base(options)
    {

        if (Database.GetPendingMigrations().Any())
        {
            // Database.Migrate();
        }
        else
        {
            bool hasCarrosTable = Model.FindEntityType(typeof(Carro)) != null;
            if (!hasCarrosTable)
            {
                Database.EnsureCreated();
            }
        }
    }

    public DbSet<Carro>? Carros { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Carro>(entity =>
        {
            entity.Property(e => e.Preco)
                .HasColumnType("decimal(10, 3)");
        });
    }
}
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImJhdG1hbiIsInJvbGUiOiJhZG1pbiIsIm5iZiI6MTY5MDEyMDI0OSwiZXhwIjoxNjkwMTYzNDQ5LCJpYXQiOjE2OTAxMjAyNDl9.JzgiZHRrcyJRY3d8lkmMHRtMm8SEjlKPfnhUHNFKS_g