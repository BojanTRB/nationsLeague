using NationsLeague.Models;

using var db = new NationsLeagueContext();
db.Database.EnsureDeleted();
db.Database.EnsureCreated();
db.Seed();
db.SaveChanges();
foreach (var item in db.Games.ToList())
{
    Console.WriteLine(item.AdditionalAttributes.Value.gameDay);
}