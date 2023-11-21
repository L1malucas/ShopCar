using Microsoft.AspNetCore.Mvc;
using CarVerzel.Services;
using CarVerzel.Admin;
using CarVerzel.Repository;

namespace CarVerzel.Controllers;

[Route("api/")]
[ApiController]
public class AdminController : ControllerBase
{
    [HttpPost("login")]
    public IActionResult Login(Adm model)
    {
        var admin = AdminRepository.Get(model.Username, model.Password);
        if (admin == null)
            return NotFound(new
            {
                message = "Usuário ou senha inválidos!"
            });


        var token = TokenService.GenerateToken(admin);

        admin.Password = "";

        return Ok(new
        {
            admin,
            token
        });
    }
}
