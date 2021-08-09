//=============================================================
// Permenant song play, plus other enhancements eventually
//=============================================================
class MusicBotWindow extends PlayMusicWindow;

event InitWindow()
{
Super.InitWindow();

SetTitle("Radio");
EnableWindow(True);
Show(True);
}

event DestroyWindow()
{
}

function PlaySong(int rowID)
{
local String songName;
local Int songSection;

if (btnAmbient.GetToggle())
 songSection = 0;
else if (btnCombat.GetToggle())
 songSection = 3;
else if (btnConversation.GetToggle())
 songSection = 4;
else if (btnOutro.GetToggle())
 songSection = 5;
else if (btnDying.GetToggle())
 songSection = 1;

songName = lstSongs.GetField(rowID, 1);
player.ConsoleCommand("Set LevelInfo Song None");

player.PlayMusic(songName, songSection);
}

defaultproperties
{
}
