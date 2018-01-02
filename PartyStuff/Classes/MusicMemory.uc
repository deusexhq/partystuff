class MusicMemory extends PGActors;

var DeusExPlayer Watcher;
var music CurrentSong;
var bool bMMLocked;

function PostBeginPlay()
{
	SetTimer(5,True);
}

function Timer()
{
	if(Watcher == None)
		Destroy();
}

defaultproperties
{
bHidden=True
}
