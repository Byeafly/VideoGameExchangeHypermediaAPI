using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VideoGameExchangeHypermediaAPI.Models.VideoGameModels;

namespace VideoGameExchangeHypermediaAPI.Models.UserModels
{
    public class User
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("user_id")]
        public int UserId { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("name")]
        public string Name { get; set; } = null!;

        [Required]
        [MaxLength(255)]
        [EmailAddress]
        [Column("email")]
        public string Email { get; set; } = null!;

        [Required]
        [MaxLength(255)]
        [Column("password_hash")]
        public string PasswordHash { get; set; } = null!;

        [Required]
        [MaxLength(255)]
        [Column("street_address")]
        public string StreetAddress { get; set; } = null!;

        // Navigation property
        public ICollection<VideoGame> VideoGames { get; set; } = new List<VideoGame>();
    }
}
