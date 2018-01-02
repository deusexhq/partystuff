class DynMusicActor extends PGActors;

var DeusExPlayer Watcher;
var DynMusicMutator DM;
var bool bInCombat;
var bool bPSZDisabled;

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

function music GetMemorizedMusic(DeusExPlayer Them)
{
local MusicMemory MM;
	foreach AllActors(class'MusicMemory', MM)
	{
		if(MM.Watcher == Them)
		{
			return MM.CurrentSong;
		}
	}
}

function Tick(float deltatime)
{
local DeusExPlayer DXP;
local ScriptedPawn SP;
local bool bFoundCombat;

	if(Watcher != None)
	{
		SetLocation(watcher.Location);
			if(bPSZDisabled)
				return;
		if(!bInCombat)
		{
			foreach VisibleActors(class'ScriptedPawn', SP, 785, Location)
			{
				if(!SP.IsA('Animal') && !SP.IsA('SuperCleanerBot') && !SP.IsA('CleanerBot') && !SP.IsA('MedicalBot') && !SP.IsA('RepairBot'))  
					if(SP.IsInState('Attacking') || SP.IsInState('Alerting') || SP.IsInState('Burning') || SP.IsInState('Seeking') || SP.IsInState('Stunned') || SP.IsInState('HandlingEnemy'))
						bFoundCombat=True;
			}

			if(bFoundCombat)
			{
				if(MMLocked(Watcher))
					return;
					
				bInCombat=True;
					if(DM.BattleEnterMsg != "")
						Watcher.ClientMessage(DM.BattleEnterMsg);
				Watcher.ClientSetMusic( DM.BattleTrack, DM.BattleSongSection, DM.BattleCdTrack, DM.Transition );
				SetTimer(1,True);
			}
		}
	}
}

function Timer()
{
local ScriptedPawn SP;
local bool bFoundCombat;
	if(bInCombat)
	{
		foreach RadiusActors(class'ScriptedPawn', SP, 785, Location)
		{
		if(!SP.IsA('Animal') && !SP.IsA('SuperCleanerBot') && !SP.IsA('CleanerBot') && !SP.IsA('MedicalBot') && !SP.IsA('RepairBot'))  
			if(SP.IsInState('Attacking') || SP.IsInState('Alerting') || SP.IsInState('Burning') || SP.IsInState('TakingHit') || SP.IsInState('Seeking') || SP.IsInState('Stunned') || SP.IsInState('HandlingEnemy'))
				bFoundCombat=True;
		}
		
		if(!bFoundCombat)
		{
			bInCombat=False;
					if(DM.BattleExitMsg != "")
						Watcher.ClientMessage(DM.BattleExitMsg);
			Watcher.ClientSetMusic( GetMemorizedMusic(Watcher), Level.SongSection, Level.CdTrack, DM.Transition );
		}
	}
	else
		SetTimer(1,False);
}

defaultproperties
{
     bHidden=True
}
