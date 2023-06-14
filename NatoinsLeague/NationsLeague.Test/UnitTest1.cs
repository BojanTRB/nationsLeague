using Microsoft.EntityFrameworkCore;
using NationsLeague.Models;

namespace NationsLeague.Test
{
    public class UnitTest1
    {
        [Fact]
        public void Check_Json_Attribute_Game()
        {
            DbContextOptionsBuilder options = new DbContextOptionsBuilder();
            options.UseSqlServer("Data Source=127.0.0.1;Initial Catalog=SoccerLeague;Persist Security Info=True;User ID=sa;Password=SqlServer2019;TrustServerCertificate=True");
            NationsLeagueContext db = new(options.Options);
            db.Database.EnsureDeleted();
            db.Database.EnsureCreated();
            db.Seed();
            int count = db.Games.Where(value => value.AdditionalAttributes.Value.gameDay == 3).ToList().Count;
            Assert.Equal(1000, count);
        }
    }
}