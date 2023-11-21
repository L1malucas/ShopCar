using CarVerzel.Data;
using JwtSettings;
using Microsoft.EntityFrameworkCore;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

// secret key config as byte array
var key = Encoding.ASCII.GetBytes(Settings.Secret);

// authentication settings
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    // validation api setup
}).AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false,
    };
});

// create policy of authorization (role admin)
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("Admin", policy => policy.RequireRole("admin"));
});

builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo { Title = "CarVerzel API", Version = "v1" });

    // Configuração para autenticação via JWT
    var securityScheme = new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Name = "Authorization",
        Description = "JWT Authorization header using the Bearer scheme.",
        In = Microsoft.OpenApi.Models.ParameterLocation.Header,
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT",
        Reference = new Microsoft.OpenApi.Models.OpenApiReference
        {
            Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
            Id = "Bearer"
        }
    };

    c.AddSecurityDefinition("Bearer", securityScheme);

    var securityRequirement = new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
        { securityScheme, new[] { "Bearer" } }
    };

    c.AddSecurityRequirement(securityRequirement);
});

// Connection para banco local
// builder.Services.AddDbContext<CarVerzelContext>(options =>
// {
//     options.UseSqlServer(builder.Configuration.GetConnectionString("CarVerzelLocalDb"));
// });

// conexão com azure em produção
 string azureDbConnectionString = builder.Configuration.GetConnectionString("CarVerzelAzureDb");
 builder.Services.AddDbContext<CarVerzelContext>(options =>
 {
     options.UseSqlServer(azureDbConnectionString);
 });

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowLocalhost4200",
        builder =>
        {
            builder.WithOrigins("http://localhost:4200")
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "CarVerzel API v1");
});

app.UseHttpsRedirection();
app.UseCors("AllowLocalhost4200");
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
