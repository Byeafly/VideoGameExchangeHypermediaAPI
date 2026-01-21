using VideoGameExchangeHypermediaAPI.Models.UserModels;
using VideoGameExchangeHypermediaAPI.Models.VideoGameModels;
using Microsoft.EntityFrameworkCore;

namespace VideoGameExchangeHypermediaAPI.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options) { }

        public DbSet<User> Users { get; set; } = null!;
        public DbSet<VideoGame> Video_Games { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
                .HasIndex(u => u.Email)
                .IsUnique();

            modelBuilder.Entity<VideoGame>()
                .Property(g => g.Condition)
                .HasConversion<string>();
        }
    }
}
