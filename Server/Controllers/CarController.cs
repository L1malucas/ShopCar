using Microsoft.AspNetCore.Mvc;
using CarVerzel.Data;
using CarVerzel.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace CarVerzel.Controllers
{
    [Route("api/carros")]
    [ApiController]
    public class CarrosController : ControllerBase
    {
        private readonly CarVerzelContext _context;

        public CarrosController(CarVerzelContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Carro>>> GetCarros()
        {
            var carros = await _context.Carros!.ToListAsync();
            return carros;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Carro>> GetCarro(int id)
        {
            var carro = await _context.Carros!.FindAsync(id);

            if (carro == null)
            {
                return NotFound();
            }

            return carro;
        }

        [HttpGet("preco")]
        public async Task<ActionResult<IEnumerable<Carro>>> GetCarrosOrdenadosPorPreco()
        {
            var carrosOrdenados = await _context.Carros!.OrderBy(c => c.Preco).ToListAsync();
            return carrosOrdenados;
        }

        [HttpPost]
        [Authorize(Roles = "admin")]
        public async Task<ActionResult<Carro>> PostCarro([FromForm] IFormFile file, [FromForm] Carro carro)
        {
            try
            {
                using (var fileStream = new MemoryStream())
                {
                    file.CopyTo(fileStream);
                    var createdCar = new Carro()
                    {
                        Modelo = carro.Modelo,
                        Preco = carro.Preco,
                        Marca = carro.Marca,

                        FotoBase64 = Convert.ToBase64String(fileStream.ToArray()),
                    };
                    _context.Carros!.Add(createdCar);
                }
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao cadastrar o veiculo");
            }


            return CreatedAtAction(nameof(GetCarro), new { id = carro.CarId }, carro);
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "admin")]
        public async Task<IActionResult> PutCarro(int id, Carro carro)
        {
            if (id != carro.CarId)
            {
                return BadRequest();
            }

            _context.Entry(carro).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "admin")]
        public async Task<IActionResult> DeleteCarro(int id)
        {
            var carro = await _context.Carros!.FindAsync(id);

            if (carro == null)
            {
                return NotFound();
            }

            _context.Carros.Remove(carro);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
