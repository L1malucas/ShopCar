using CarVerzel.Admin;

namespace CarVerzel.Repository;

public static class AdminRepository
{
    public static Adm? Get(string username, string password)
    {
        var admin = new List<Adm>
        {
            new Adm { Id = 1, Username = "batman", Password = "wayne", Role = "admin" },
        };

        return admin.FirstOrDefault(x => x.Username.ToLower() == username.ToLower() && x.Password == password)
        ;
    }
}
