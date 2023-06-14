﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NationsLeague.Models
{
    [Table("Team")]
    [Index("Name", Name = "UQ__Team__737584F69D6AD34E", IsUnique = true)]
    [Index("Name", Name = "UQ__Team__737584F6AF99F30B", IsUnique = true)]
    public partial class Team
    {
        public Team()
        {
            GameAwayTeamNavigations = new HashSet<Game>();
            GameHomeTeamNavigations = new HashSet<Game>();
            TeamPlayers = new HashSet<TeamPlayer>();
            TeamTrainers = new HashSet<TeamTrainer>();
        }

        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(200)]
        [Unicode(false)]
        public string Name { get; set; }
        public int? NationsleagueID { get; set; }

        [ForeignKey("NationsleagueID")]
        [InverseProperty("Teams")]
        public virtual Nationsleague Nationsleague { get; set; }
        [InverseProperty("AwayTeamNavigation")]
        public virtual ICollection<Game> GameAwayTeamNavigations { get; set; }
        [InverseProperty("HomeTeamNavigation")]
        public virtual ICollection<Game> GameHomeTeamNavigations { get; set; }
        [InverseProperty("Team")]
        public virtual ICollection<TeamPlayer> TeamPlayers { get; set; }
        [InverseProperty("Team")]
        public virtual ICollection<TeamTrainer> TeamTrainers { get; set; }
    }
}