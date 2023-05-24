using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NatoinsLeague
{
    public class GameDate
    {
        public int? GameDay;
        public DateTime? GameDat;

        public GameDate(int gameDay, DateTime gameDat)
        {
            GameDay = gameDay;
            GameDat = gameDat;
        }
    }
}
