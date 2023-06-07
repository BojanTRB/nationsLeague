﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NationsLeague.Models
{
    [Table("Game")]
    public partial class Game
    {
        public Game()
        {
            Goals = new HashSet<Goal>();
        }

        [Key]
        public int Id { get; set; }
        public int HomeTeam { get; set; }
        public int AwayTeam { get; set; }
        [Required]
        [Unicode(false)]
        public string Value { get; set; }

        [ForeignKey("AwayTeam")]
        [InverseProperty("GameAwayTeamNavigations")]
        public virtual Team AwayTeamNavigation { get; set; }
        [ForeignKey("HomeTeam")]
        [InverseProperty("GameHomeTeamNavigations")]
        public virtual Team HomeTeamNavigation { get; set; }
        [InverseProperty("Game")]
        public virtual ICollection<Goal> Goals { get; set; }
    }
}