using fussballliga.Models;

using var db = new SoccerLeagueContext();



Console.WriteLine("Gib den Namen der League ein:");
do
{
    string name = Console.ReadLine();
}
while (name != null);

db.Leagues.Add(new League() { Name = name, CreatedOn = DateTime.UtcNow });
db.SaveChanges();
