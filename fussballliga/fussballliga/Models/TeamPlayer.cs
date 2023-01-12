﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace fussballliga.Models
{
    [Table("TeamPlayer")]
    public partial class TeamPlayer
    {
        public TeamPlayer()
        {
            Goals = new HashSet<Goal>();
        }

        [Key]
        public int Id { get; set; }
        [Column(TypeName = "date")]
        public DateTime PlayerFrom { get; set; }
        [Column(TypeName = "date")]
        public DateTime? PlayerTo { get; set; }
        public int PlayerId { get; set; }
        public int TeamId { get; set; }

        [ForeignKey("PlayerId")]
        [InverseProperty("TeamPlayers")]
        public virtual Player Player { get; set; }
        [ForeignKey("TeamId")]
        [InverseProperty("TeamPlayers")]
        public virtual Team Team { get; set; }
        [InverseProperty("TeamPlayer")]
        public virtual ICollection<Goal> Goals { get; set; }
    }
}