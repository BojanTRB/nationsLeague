using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NatoinsLeague
{
    public class NationsLeagueContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Data Source=127.0.0.1;Initial Catalog=SoccerLeague;User ID=sa;Password=SqlServer2019;TrustServerCertificate=True");
            }
        }

        public NationsLeagueContext(DbContextOptions opt) : base(opt) { }
        public IQueryable<Game.GameR> Bewerbe => Set<Game.GameR>();  // read-only access. No .Add() or .Remove() method.

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Game.GameR>()
                .HasNoKey()
                .ToView("GAMEVIEW");   // Oracle: uppercase
        }
    }
}
