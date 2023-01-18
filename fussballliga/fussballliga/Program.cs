using fussballliga.Models;


using var db = new SoccerLeagueContext();

/*
string name;
Console.WriteLine("Gib den Namen der League ein:");
do
{
    name = Console.ReadLine();
}
while (name != null);

db.Leagues.Add(new League() { Name = name, CreatedOn = DateTime.UtcNow });
*/

db.Seed();
db.SaveChanges();


