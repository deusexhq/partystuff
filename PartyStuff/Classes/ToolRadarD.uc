//=============================================================================
// WeaponStealthPistol.
//=============================================================================
class ToolRadarD extends DeusExWeapon;

var int Modes;
var RadarDrone LinkedDrone;
var RaidActor RA;
var bool bArmedNuclear;
var int DroneAmmo, rDroneammo;
var bool bStoredDrone;
var bool bStorageMode, bRepStorageMode;
var bool bViewing;

replication
{
reliable if (bNetOwner && Role==ROLE_Authority)
LinkedDrone, DroneAmmo, bRepstoragemode;
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		HitDamage = mpHitDamage;
		BaseAccuracy = mpBaseAccuracy;
		ReloadTime = mpReloadTime;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
		ReloadCount = mpReloadCount;
	}
}

function PostBeginPlay()
{
		local RadarDrone DR;

		foreach AllActors(class'RadarDrone', DR)
			if(DR.myOwner == DeusExPlayer(Owner))
				LinkedDrone = DR;
				
		if(LinkedDrone != None)
			DroneAmmo = LinkedDrone.Rocketsremain;
}

function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
local RadarDrone RD;
local RocketDrone Rock;
local rotator testRot;

	if(Other.isa('RadarDrone') && RadarDrone(Other).myOwner == DeusExPlayer(Owner))
	{
		if(bStorageMode)
		{
			bStoredDrone=True;
			DeusExPlayer(Owner).ClientMessage("Drone stored in gun.");
			Other.Destroy();
			return;
		}
		if(RadarDrone(Other).pOrders == 0)
		{
			RadarDrone(Other).pOrders=1;
			RadarDrone(Other).bSilence = True;
			RadarDrone(Other).GotoState('Following');
			RadarDrone(Other).myOwner.ClientMessage("RADAR Drone: Setting new orders, "$RadarDrone(Other).myOwner.PlayerReplicationinfo.PlayerName$", loading Follow/Silent.", 'Teamsay');
			return;
		}
		if(RadarDrone(Other).pOrders == 1)
		{
			RadarDrone(Other).pOrders=2;
			RadarDrone(Other).bSilence = False;
			RadarDrone(Other).GotoState('Waiting');
			RadarDrone(Other).myOwner.ClientMessage("RADAR Drone: Setting new orders, "$RadarDrone(Other).myOwner.PlayerReplicationinfo.PlayerName$", loading Stationary/Radar.", 'Teamsay');
			return;
		}
		if(RadarDrone(Other).pOrders == 2)
		{
			RadarDrone(Other).pOrders=3;
			RadarDrone(Other).bSilence = True;
			RadarDrone(Other).GotoState('Waiting');
			RadarDrone(Other).myOwner.ClientMessage("RADAR Drone: Setting new orders, "$RadarDrone(Other).myOwner.PlayerReplicationinfo.PlayerName$", loading Stationary/Silent.", 'Teamsay');
			return;
		}	
		if(RadarDrone(Other).pOrders == 3)
		{
			RadarDrone(Other).pOrders=0;
			RadarDrone(Other).bSilence = False;
			RadarDrone(Other).GotoState('Following');
			RadarDrone(Other).myOwner.ClientMessage("RADAR Drone: Setting new orders, "$RadarDrone(Other).myOwner.PlayerReplicationinfo.PlayerName$", loading Follow/Radar.", 'Teamsay');
			return;
		}	
	}
	else
	{
		Foreach AllActors(class'RadarDrone',RD)
		{
			if(RD.myOwner == DeusExPlayer(Owner))
			{
				
				if(Other != None)
				{					
					if(RD.RocketsRemain > 0)
					{
					RA = Spawn(class'RaidActor',,, HitLocation);
					RD.LookAtActor(RA, true, true, true, 0, 0.1);
					testRot = rotator(RA.Location - RD.Location);
					Rock = Spawn(class'RocketDrone',Pawn(Owner),,RD.Location + (RD.CollisionRadius+Default.CollisionRadius+5) * Vector(RD.Rotation) + vect(0,0,1) * 2,testRot);
					RA.Destroy();
					RD.RocketsRemain--;
					DroneAmmo = RD.RocketsRemain;
					//DeusExPlayer(Owner).ClientMessage(RD.RocketsRemain$" ammo remaining in Drone.");
					}
				}
			}
		}
	}
}

simulated function RenderOverlays(canvas Canvas)
{
	local DeusExPlayer P;
	local Pawn CrosshairTarget;
	local float Scale, Accuracy, Dist;
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X,Y,Z;
	local String KeyName, Alias, curKeyName;
	local int i;
	Super.RenderOverlays(Canvas);
	P = DeusExPlayer(Owner);
	if ( P != None ) 
	{	
		GetAxes(Pawn(Owner).ViewRotation,X,Y,Z);	
		StartTrace = ComputeProjectileStart(X, Y, Z);
		AdjustedAim = P.AdjustAim(1000000, StartTrace, 2*AimError, False, False);
		EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;	
		EndTrace += (FMax(1024.0, MaxRange) * Vector(AdjustedAim));
	//	rDroneAmmo = DroneAmmo;
				bOwnsCrossHair = True; 
				Scale = Canvas.ClipX/640;
				Canvas.SetPos(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale );
				//Canvas.Style = ERenderStyle.STY_Translucent;
				Canvas.DrawColor.R = 0;
				Canvas.DrawColor.G = Rand(128);
				Canvas.DrawColor.B = Rand(128);
				Canvas.Font = Canvas.SmallFont;

				curKeyName = "";
				for ( i=0; i<255; i++ )
				{
					KeyName = Owner.ConsoleCommand ( "KEYNAME "$i );
					if ( KeyName != "" )
					{
						Alias = Owner.ConsoleCommand( "KEYBINDING "$KeyName );
						if ( Alias ~= "ToggleScope" )
						{
							curKeyName = KeyName;
							break;
						}
					}
				}
				if ( curKeyName ~= "" )
					curKeyName = "NONE";
		
				if(LinkedDrone != None)
					Canvas.DrawText("      Ammo: "$DroneAmmo$" - Health: "$LinkedDrone.Health$" - Storage: "@LinkedDrone.iv);
				else if(bRepstoragemode)
					Canvas.DrawText("      Drone stored. ("$curKeyName$")");
				else
					Canvas.DrawText("      ERROR: NO DRONE");

			}
			else
				bOwnsCrossHair = False; // Only for compatibility with HDX50		
}

simulated function float CalculateAccuracy()
{
	return 0.000000; //Dirty hack to always return dead on accuracy.
}

state NormalFire //(Thanks to JimBowen for this Infinite ammo code) 
{ 
   Begin: 
      if ((ClipCount >= ReloadCount) && (ReloadCount != 0)) 
      { 
         if (!bAutomatic) 
         { 
            bFiring = False; 
            FinishAnim(); 
         } 
    
         if (Owner != None) 
         { 
            if (Owner.IsA('DeusExPlayer')) 
            { 
               bFiring = False; 
            } 
            else if (Owner.IsA('ScriptedPawn')) 
            { 
               bFiring = False; 
               ReloadAmmo(); 
            } 
         } 
         else 
         { 
            if (bHasMuzzleFlash) 
               EraseMuzzleFlashTexture(); 
            GotoState('Idle'); 
         } 
      } 
      if ( bAutomatic && (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient()))) 
         GotoState('Idle'); 
    
      Sleep(GetShotTime()); 
      if (bAutomatic) 
      { 
         GenerateBullet();       // In multiplayer bullets are generated by the client which will let the server know when 
         Goto('Begin'); 
      } 
      bFiring = False; 
      FinishAnim();  
      ReadyToFire(); 
   Done: 
      bFiring = False; 
      Finish(); 
}

simulated function lasertoggle()
{
	Recreation();
}

function Recreation()
{
//local ToolRadar RT;
local RadarDrone RD, RDb;
local int ii;
local DeusExPlayer hax;
local int oldrockets;
local string oldiv;
local inventory oldstoredinv;
	local vector loc, line, HitLocation, hitNormal;
	local int oldOrders;
	
	foreach AllActors(class'RadarDrone',RD)
	{
		if(RD.myOwner == DeusExPlayer(Owner))
		{
		Spawn(class'SphereEffect',,, RD.Location);		
		RD.SetLocation(DeusExPlayer(Owner).Location + (DeusExPlayer(Owner).CollisionRadius+Default.CollisionRadius+30) * Vector(DeusExPlayer(Owner).ViewRotation) + vect(0,0,1) * 30 );
		Spawn(class'SphereEffect',,, RD.Location);
		}
	}
}

function Recreationxredacted()
{
//local ToolRadar RT;
local RadarDrone RD, RDb;
local int ii;
local DeusExPlayer hax;
local int oldrockets;
local string oldiv;
local inventory oldstoredinv;
	local vector loc, line, HitLocation, hitNormal;
	local int oldOrders;
	foreach AllActors(class'RadarDrone',RD)
	{
		if(RD.myOwner == DeusExPlayer(Owner))
		{
		Spawn(class'SphereEffect',,, RD.Location);
		hax = RD.myOwner;
		oldrockets = RD.RocketsRemain;
		oldOrders = RD.pOrders;
		oldiv = RD.iv;
		//oldstoredinv = RD.storedinv;
		RD.Destroy();
		
		RDb = Spawn(Class'RadarDrone',,,DeusExPlayer(Owner).Location + (DeusExPlayer(Owner).CollisionRadius+Default.CollisionRadius+30) * Vector(DeusExPlayer(Owner).ViewRotation) + vect(0,0,1) * 30 );
		RDb.myOwner = hax;
		RDb.iv = oldiv;
		//rdb.storedinv = oldstoredinv;
		//rdm.oldstoredinv
		RDb.RocketsRemain = oldrockets;
		RDb.GotoState('following');
		RDb.myOwner.ClientMessage("RADAR Drone: Recreated at your location.", 'Teamsay');
		RDb.SetTimer(1,False);
		RDb.pOrders = oldOrders;
		LinkedDrone = RDb;
			if(oldOrders == 0)
			{
				RDb.bSilence = False;
				RDb.GotoState('Following');
			}
			if(oldOrders == 1)
			{
				RDb.bSilence = True;
				RDb.GotoState('Following');
			}
			if(oldOrders == 2)
			{
				RDb.bSilence = False;
				RDb.GotoState('Waiting');
			}
			if(oldOrders == 3)
			{
				RDb.bSilence = True;
				RDb.GotoState('Waiting');
			}
			
			if(bViewing)
			{
				Hax.ViewTarget = RDb;
			}
			else
			{
				Hax.ViewTarget = None;
			}
		return;
		}
	}
}

simulated function scopetoggle()
{
local RadarDrone RD;
local class<actor> NewClass;
local rotator testRot;
	if(bStoredDrone)
	{
	RD = Spawn(class'RadarDrone',Pawn(Owner),,Pawn(Owner).Location,Pawn(Owner).ViewRotation);
	RD.myOwner = DeusExPlayer(Owner);
		RD.GotoState('following');
		RD.myOwner.ClientMessage("RADAR Drone: Recreated at your location.", 'Teamsay');
		RD.SetTimer(1,False);
		LinkedDrone=RD;
	bStoredDrone=False;
	bRepstoragemode=False;
	}
	else
	{
		foreach AllActors(class'RadarDrone',RD)
			if(RD.myOwner == DeusExPlayer(Owner))
			{
				RD.Destroy();
				bStoredDrone=True;
				bRepstoragemode=True;
			}
				
	}
}

function CycleAmmo()
{
	bViewing = !bViewing;
	
	if(bViewing)
		LockPlayerCam(DeusExPlayer(Owner));
	else
		UnLockPlayerCam(DeusExPlayer(Owner));
}

function LockPlayerCam(deusexplayer dxp)
{
local RadarDrone RD;
			dxp.bBehindView=True;
			
		Foreach AllActors(class'RadarDrone',RD)
		{
			if(RD.myOwner == DeusExPlayer(Owner))
			{
				
				if(RD != None)
				{			
					dxp.ViewTarget = RD;
				}
			}
		}
}

function UnLockPlayerCam(deusexplayer dxp)
{
			dxp.bBehindView=False;
			dxp.ViewTarget = None;
}

defaultproperties
{
     GoverningSkill=Class'DeusEx.SkillWeaponPistol'
     NoiseLevel=0.010000
     droneAmmo=30
     ShotTime=0.150000
     reloadTime=1.500000
     HitDamage=0
     maxRange=4800
     AccurateRange=2400
     BaseAccuracy=0.800000
     bCanHaveScope=True
     ScopeFOV=25
     bCanHaveLaser=True
     recoilStrength=0.100000
     mpBaseAccuracy=0.200000
     mpAccurateRange=120000
     mpMaxRange=120000
	// ReloadCount=1
	// PickupAmmoCount=30
	// AmmoName=Class'PartyStuff.AmmoDrone'
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bInstantHit=True
     FireOffset=(X=-24.000000,Y=10.000000,Z=14.000000)
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.StealthPistolFire'
     AltFireSound=Sound'DeusExSounds.Weapons.StealthPistolReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.StealthPistolReload'
     SelectSound=Sound'DeusExSounds.Weapons.StealthPistolSelect'
     InventoryGroup=1287663
     ItemName="Radar Drone Controller"
     PlayerViewOffset=(X=24.000000,Y=-10.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.StealthPistol'
     PickupViewMesh=LodMesh'DeusExItems.StealthPistolPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.StealthPistol3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconStealthPistol'
     largeIcon=Texture'DeusExUI.Icons.LargeIconStealthPistol'
     largeIconWidth=47
     largeIconHeight=37
     Description="The stealth pistol is a variant of the standard 10mm pistol with a larger clip and integrated silencer designed for wet work at very close ranges."
     beltDescription="DRONE"
     Mesh=LodMesh'DeusExItems.StealthPistolPickup'
     CollisionRadius=8.000000
     CollisionHeight=0.800000
}
