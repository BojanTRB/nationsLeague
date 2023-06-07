using NationsLeague.Models;

using var db = new NationsLeagueContext();

db.Seed();
db.SaveChanges();