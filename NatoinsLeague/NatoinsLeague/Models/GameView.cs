﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace NationsLeague.Models
{
    [Keyless]
    public partial class GameView
    {
     public record GameV(
        [property: Column("G_ID")] int gameId,   // Oracle: uppercase
        [property: Column("G_HOMETEAM")] int homeTeamId,
        [property: Column("G_AWAYTEAM")] int awayTeamId,
        [property: Column("G_VALUE")] Date date);
    }
}