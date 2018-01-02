//=============================================
// RestPoint
//=============================================
Class MusicPoint extends DeusExDecoration;
//ADD SMG_MOD RADIO BOT ITEM ON CYClEAMMO
var int PlaySlot;
var() music myTrackList[10];
var() EMusicTransition Transition;
var() byte             SongSection;
var() byte             CdTrack;
var() bool bAffectAllPlayers;

function BeginPlay()
{
PlaySlot = 0;
}

function bool MMLocked(DeusExPlayer Them)
{
local MusicMemory MM;
	foreach AllActors(class'MusicMemory', MM)
	{
		if(MM.Watcher == Them)
		{
			return MM.bMMLocked;
		}
	}
}

function MemorizeMusic(music This, DeusExPlayer Them)
{
local MusicMemory MM;
	foreach AllActors(class'MusicMemory', MM)
	{
		if(MM.Watcher == Them)
		{
			MM.CurrentSong = This;
			//Log("Track memorized."@This@them.playerreplicationinfo.playername);
			Them.ClientSetMusic( This, SongSection, CdTrack, Transition );
		}
	}
}

function bool mmIsPlaying(music This, DeusExPlayer Them)
{
local MusicMemory MM;
local bool bFound;

	foreach AllActors(class'MusicMemory', MM)
	{
		if(MM.Watcher == Them)
		{
			bFound=True;
			if(MM.CurrentSong == This)
				return true;
		}
	}
	
	if(!bFound)
	{
		MM = Spawn(class'MusicMemory');
		MM.Watcher=Them;
		Log("New music memory."@This@them.playerreplicationinfo.playername);
	}
}

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer P;
	local Pawn A;

	if( bAffectAllPlayers )
	{
		PlaySlot++;
		if(myTrackList[PlaySlot] == None || PlaySlot >= Arraycount(myTrackList))
		{ 
			PlaySlot=0;
		}
		BroadcastMessage(DeusExPlayer(Frobber).PlayerReplicationInfo.PlayerName$"("$DeusExPlayer(Frobber).PlayerReplicationInfo.PlayerID$"): Now playing track: "$Left(string(myTrackList[PlaySlot]), InStr(string(myTrackList[PlaySlot]), ".")));
			foreach AllActors(class'DeusExPlayer',P)
				if(!mmIsPlaying( myTrackList[PlaySlot], P) && !mmLocked(P))
					MemorizeMusic(myTrackList[PlaySlot], P);
				
				//P.ClientSetMusic( myTrackList[PlaySlot], SongSection, CdTrack, Transition );
	}
	else
	{
			P = DeusExPlayer(Frobber);
		if( P==None )
			return;
		PlaySlot++;
		if(myTrackList[PlaySlot] == None || PlaySlot > Arraycount(myTrackList))
		{    //IT DOESNT RESET
			PlaySlot=0;
		}		
		// Go to music.
		P.ClientSetMusic( myTrackList[PlaySlot], SongSection, CdTrack, Transition );
				if(!mmIsPlaying( myTrackList[PlaySlot], P))
					MemorizeMusic(myTrackList[PlaySlot], P);
		P.ClientMessage("Now playing track: "$Left(string(myTrackList[PlaySlot]), InStr(string(myTrackList[PlaySlot]), ".")));
	}
}

defaultproperties
{
     Transition=MTRAN_Fade
     CdTrack=255
     bAffectAllPlayers=True
     bInvincible=True
     ItemName="Music Point"
     bPushable=False
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex8'
     Skin=Texture'DeusExDeco.Skins.AlarmLightTex8'
     DrawScale=1.500000
     CollisionRadius=45.200001
     CollisionHeight=32.000000
     bBlockPlayers=False
}
