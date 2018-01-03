//=============================================================================
// PSZoneInfo
//=============================================================================
class PSZoneInfo extends ZoneInfo;

var() string EnterString, LeaveString, ProjDestroyedString;
var() music myTrack;
var() EMusicTransition Transition;
var() byte             SongSection;
var() byte             CdTrack;
var() bool bSafeZone;
var() bool bMusicZone;
var() bool bHealZone;
var() bool bInventoryKillZone;
var() bool bNoBoxZone;
var() sound EntrySound, ExitSound;
var(Restrictions) bool bRestrictedZone;
var(Restrictions) bool bAllowAdmins;
var(Restrictions) string EntryMsg, ExitMsg;
var(Restrictions) int rTimer;
var() bool bDisableDynMusic;
var() bool bEnableSaving;
var deusexplayer NotifPlayer;
var(Events) name mySkyboxTag;

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

event ActorLeaving( actor Other )
{
	local SecDrone PD;
	
	super.ActorLeaving(Other);
		
	if(DynMusicActor(Other) != None)
		DynMusicActor(Other).bPSZDisabled = False;
		
		if(bRestrictedZone)
		{
			foreach AllActors(class'SecDrone', PD)
			{
				if(PD.AttachPlayer == DeusExPlayer(Other))
				{
					DeusExPlayer(Other).ClientMessage("Security Drone: "$ExitMsg, 'TeamSay');
					Spawn(class'sphereEffect',,,pD.Location);
					PD.Destroy();
					if(NotifPlayer != None)
					{
						NotifPlayer.ClientMessage(DeusExPlayer(Other).PlayerReplicationInfo.PlayerName$" left your restricted zone.");
					}
				}
			}
		}
		if(LeaveString != "" && DeusExPlayer(Other) != None)
			DeusExPlayer(Other).ClientMessage(LeaveString);
			
		if(ExitSound != None && DeusExPlayer(Other) != None)
			DeusExPlayer(Other).PlaySound(ExitSound,,,, 256);
			
		if(bSafeZone)
		{
			if(DeusExPlayer(Other) != None)
				DeusExPlayer(Other).ReducedDamageType = '';
			if(DeusExDecoration(Other) != None)
				DeusExDecoration(Other).bInvincible = DeusExDecoration(Other).default.bInvincible;
			if (Other.IsA('ScriptedPawn'))
				ScriptedPawn(Other).bInvincible=ScriptedPawn(Other).default.bInvincible;
				
			if(Other.IsA('BasketballMP'))
			{
				BasketballMP(Other).Style = STY_Translucent;
				BasketballMP(Other).bDoomedToDestroy = True;
				BasketballMP(Other).SetTimer(15, False);
				Other.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
				Other.Spawn(class'SmokeTrail',,, Other.Location);
				Other.Spawn(class'SphereEffect',,, Other.Location);
			}
			if(Other.IsA('BasketballMP4Player'))
			{
				Other.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
				Other.Spawn(class'SmokeTrail',,, Other.Location);
				Other.Spawn(class'SphereEffect',,, Other.Location);
				Other.Destroy();
			}
		}
}

function bool ShouldRestrict(deusexplayer Check)
{
	local SecDrone PD;
	
	foreach AllActors(class'SecDrone', PD)
		if(PD.AttachPlayer == Check)
			return false;
			
	if(bAllowAdmins)
		if(Check.bAdmin)
			return False;
		
	return True;
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

event ActorEntered(actor Other)
{
	local float avg;
	local SecDrone PD;
	
	Super.ActorEntered(Other);
	if(DynMusicActor(Other) != None && bDisableDynMusic)
		DynMusicActor(Other).bPSZDisabled = True;
		
	if(DeusExPlayer(Other) != None)
	{
		if(bRestrictedZone)
		{
			if(ShouldRestrict(DeusExPlayer(Other)))
			{
				PD = Spawn(class'SecDrone',,,Other.Location);
				PD.SetTimer(rTimer,false);
				PD.AttachPlayer = DeusExPlayer(Other);
				PD.gotostate('following');
				Spawn(class'SphereEffect',,,PD.Location);
				DeusExPlayer(Other).ClientMessage("Security Drone: "$EntryMsg, 'TeamSay');
				if(NotifPlayer != None)
				{
					NotifPlayer.ClientMessage(DeusExPlayer(Other).PlayerReplicationInfo.PlayerName$" entered your restricted zone.");
					PD.NotifPlayer = NotifPlayer;
				}
			}
		}
		if(EntrySound != None)
			DeusExPlayer(Other).PlaySound(EntrySound,,,, 256);
			
		if(bMusicZone)
		{	
			if(!mmIsPlaying(myTrack, deusExPlayer(Other)) && !MMLocked(DeusExPlayer(Other)))
				MemorizeMusic(myTrack,DeusExPlayer(Other));
		}	
		if(EnterString != "")
			DeusExPlayer(Other).ClientMessage(EnterString);
			
		if(bHealZone)
		{
			if(DeusExPlayer(Other).Health < 100)
			{
				DeusExPlayer(Other).HealPlayer(100, True);
			}
			
			if(DeusExPlayer(Other).Energy < 100)
			{
				DeusExPlayer(Other).Energy = 100;
			}
			DeusExPlayer(Other).StopPoison();
			DeusExPlayer(Other).ExtinguishFire();
			DeusExPlayer(Other).drugEffectTimer = 0;
		}
		
		if(bSafeZone)
		{
			DeusExPlayer(Other).ReducedDamageType = 'All';
		}
	}
	if(bNoBoxZone)
	{
		if (Other.IsA('Box'))
		{
			avg = (DeusExDecoration(Other).CollisionRadius + DeusExDecoration(Other).CollisionHeight) / 2;
			DeusExDecoration(Other).Frag(DeusExDecoration(Other).fragType, vect(20,20,20), avg/20.0, avg/5 + 1);
			Other.Destroy();
		}
	}
	if(bSafeZone)
	{
		if (Other.IsA('ScriptedPawn'))
		{
			ScriptedPawn(Other).bInvincible=true;
		}
		else if (Other.IsA('DeusExDecoration'))
		{
			DeusExDecoration(Other).bInvincible=True;
		}
		else if (Other.IsA('SpyDrone') && !SpyDrone(Other).bDisabled)
		{
			DeusExPlayer(SpyDrone(Other).Owner).ForceDroneOff();
			DeusExPlayer(SpyDrone(Other).Owner).ClientMessage(ProjDestroyedString);
			SpyDrone(Other).bDisabled = True;
			SpyDrone(Other).SetPhysics(PHYS_Falling);
			SpyDrone(Other).bBounce = True;
			SpyDrone(Other).LifeSpan = 10.0;
			SpyDrone(Other).Spawn(class'SmokeTrail',,, Other.Location);
			Other.Spawn(class'SphereEffect',,, Other.Location);
		}
		else if (Other.IsA('ThrownProjectile') && !Other.IsA('BasketballMP'))
		{
				DeusExPlayer(ThrownProjectile(Other).Owner).ClientMessage(ProjDestroyedString);
			Other.TakeDamage(15, None, Other.Location, vect(0,0,0), 'EMP');
					Other.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
			Other.Spawn(class'SphereEffect',,, Other.Location);
					Other.Spawn(class'SmokeTrail',,, Other.Location);
			Other.LifeSpan = 10.0;
		}
		else if (Other.IsA('RocketLAW') || Other.IsA('HECannister20mm') || Other.isA('Rocket') || Other.isA('RocketWP')) 
		{
			DeusExPlayer(Other.Owner).ClientMessage(ProjDestroyedString);
			Other.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
			Other.Spawn(class'SmokeTrail',,, Other.Location);
			Other.Spawn(class'SphereEffect',,, Other.Location);
			DeusExProjectile(Other).Destroy();
		}
		else if (Other.IsA('DeusExProjectile') && !Other.IsA('BasketballMP'))
		{
			DeusExPlayer(Other.Owner).ClientMessage(ProjDestroyedString);
			Other.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
			Other.Spawn(class'SphereEffect',,, Other.Location);
			DeusExProjectile(Other).Destroy();
		}
		else if (Other.IsA('ProjectileGenerator'))
		{
			ProjectileGenerator(Other).Destroy();
		}
		else if(Other.IsA('BasketballMP'))
		{
			if (BasketballMP(Other).bDoomedToDestroy)
			{
				BasketballMP(Other).bDoomedToDestroy = False;
				BasketballMP(Other).Style = STY_Normal;
				BasketballMP(Other).SetTimer(0,False);
			}
		}
	}
	if(bInventoryKillZone)
	{
		if(Other.IsA('Inventory'))
			Other.Destroy(); 
	}
}

simulated function LinkToSkybox()
{
	local skyzoneinfo TempSkyZone;

	if(mySkyboxTag == 'None')
	{
		super.LinkToSkybox();
		return;
	}
	// SkyZone.
	foreach AllActors( class 'SkyZoneInfo', TempSkyZone, '' )
	{
		if(TempSkyZone.Tag == mySkyboxTag)
		{
			SkyZone = TempSkyZone;
		}
	}
	
	foreach AllActors( class 'SkyZoneInfo', TempSkyZone, '' )
	{
		if( TempSkyZone.bHighDetail == Level.bHighDetailMode )
		{
			if(TempSkyZone.Tag == mySkyboxTag)
			{
				SkyZone = TempSkyZone;
			}
		}
	}
}

defaultproperties
{
	rTimer=15
	EntryMsg="You are entering restricted area. Please leave, or you will be terminated in 15 seconds."
	ExitMsg="Have a nice day"
}
