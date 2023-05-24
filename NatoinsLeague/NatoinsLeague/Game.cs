using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NatoinsLeague
{
    public class Game
    {
        public record GameR(
            [property: Column("G_ID")] int Id,
            [property: Column("G_HomeTeam")] int HomeId,
            [property: Column("G_AwayTeam")] int AwayId,
            [property: Column("G_DateTime")] GameDate GameDat
            );
    }
}
