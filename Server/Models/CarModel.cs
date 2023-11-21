using System.ComponentModel.DataAnnotations;

namespace CarVerzel.Models;

public class Carro
{
    [Key]
    public int CarId { get; set; }

    [Required]
    public string Modelo { get; set; } = string.Empty;

    [Required]
    public string Marca { get; set; } = string.Empty;

    [Required]
    public decimal Preco { get; set; }

    [Required]
    
    public string FotoBase64 { get; set; } = string.Empty;
}
