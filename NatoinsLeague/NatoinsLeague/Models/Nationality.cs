﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace NationsLeague.Models
{
    [Table("Nationality")]
    [Index("Name", Name = "UQ__National__737584F67483F7EB", IsUnique = true)]
    public partial class Nationality
    {
        public Nationality()
        {
            Nationsleagues = new HashSet<Nationsleague>();
            Players = new HashSet<Player>();
            Trainers = new HashSet<Trainer>();
        }

        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(50)]
        [Unicode(false)]
        public string Name { get; set; }

        [InverseProperty("Nationality")]
        public virtual ICollection<Nationsleague> Nationsleagues { get; set; }
        [InverseProperty("Nationality")]
        public virtual ICollection<Player> Players { get; set; }
        [InverseProperty("Nationality")]
        public virtual ICollection<Trainer> Trainers { get; set; }
    }
}