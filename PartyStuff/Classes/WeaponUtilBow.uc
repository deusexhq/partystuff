//=============================================================================
// WeaponMiniCrossbow.
//=============================================================================
class WeaponUtilBow extends DeusExWeapon;

var int Mode;
var int Grapvel, JumpVel;
var int rMode;
var int rGrapvel, rJumpVel;
replication
{
reliable if (bNetOwner && Role==ROLE_Authority)
rMode, rGrapvel, rJumpVel;
}

function GiveTo( pawn Other )
{
    super.Giveto(Other);
        Mode = 3;
        rMode = 3;
	Other.ClientMessage("Cycle ammo to change modes.");
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
      PickupAmmoCount = mpReloadCount;
	}
}

/*
0 - Trigger
1 - Climber
2 - JumpPad
3 - Grapple
*/

function CycleAmmo()
{
	if(DeusExPlayer(Owner).bAdmin)
	{
	Mode++;
	if(Mode == 4)
		Mode = 0;
	}
	else
	{
	Mode++;
	if(Mode == 4)
		Mode = 1;
	}
	
	rmode=mode;
	/*if(Mode == 0)
		OwnerMsg("Trigger mode.");
	else if(Mode == 1)
		OwnerMsg("Ladder mode.");
	else if(Mode == 2)
		OwnerMsg("Jump Pad mode.");
	else if(Mode == 3)
		OwnerMsg("Grapple mode.");*/
}

function LaserToggle()
{
	if(Mode == 3)
	{
	Grapvel += 500;
	rGrapvel = Grapvel;
//	OwnerMsg("Grapple force"@Grapvel);
	}
	if(Mode == 2)
	{
	Jumpvel += 10;
	rJumpvel = Jumpvel;
//	OwnerMsg("Jump force"@Jumpvel);
	}
}

function ScopeToggle()
{
	if(Mode == 3)
	{
	Grapvel -= 500;
		rGrapvel = Grapvel;
	//	OwnerMsg("Grapple force"@Grapvel);
	}
	if(Mode == 2)
	{
	Jumpvel -= 10;
	rJumpvel = Jumpvel;
	//OwnerMsg("Jump force"@Jumpvel);
	}
}

function OwnerMsg(string str)
{
	DeusExPlayer(Owner).ClientMessage(str,'TeamSay');
}

simulated event RenderOverlays(canvas Canvas)
{
	local DeusExPlayer P;
	local int i;
	local Pawn CrosshairTarget;
	local float Scale, Accuracy, Dist;
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X,Y,Z;
local String KeyNamescope, Aliasscope, curKeyNamescope;
local String KeyNamelaser, Aliaslaser, curKeyNamelaser;
local String KeyNameammo, Aliasammo, curKeyNameammo;
	Super.RenderOverlays(Canvas);
	P = DeusExPlayer(Owner);
	if ( P != None ) 
	{	
				/*curKeyNamescope = "";
				for ( i=0; i<255; i++ )
				{
					KeyNamescope = Owner.ConsoleCommand ( "KEYNAME "$i );
					if ( KeyNamescope != "" )
					{
						Aliasscope = Owner.ConsoleCommand( "KEYBINDING "$KeyNamescope );
						if ( Aliasscope ~= "Togglescope" )
						{
							curKeyNamescope = KeyNamescope;
							break;
						}
					}
				}
				if ( curKeyNamescope ~= "" )
					curKeyNamescope = "NONE";
					
				curKeyNamelaser = "";
				for ( i=0; i<255; i++ )
				{
					KeyNamelaser = Owner.ConsoleCommand ( "KEYNAME "$i );
					if ( KeyNamelaser != "" )
					{
						Aliaslaser = Owner.ConsoleCommand( "KEYBINDING "$KeyNamelaser );
						if ( Aliaslaser ~= "ToggleLaser" )
						{
							curKeyNamelaser = KeyNamelaser;
							break;
						}
					}
				}
				if ( curKeyNamelaser ~= "" )
					curKeyNamelaser = "NONE";
					
				curKeyNameammo = "";
				for ( i=0; i<255; i++ )
				{
					KeyNameammo = Owner.ConsoleCommand ( "KEYNAME "$i );
					if ( KeyNameammo != "" )
					{
						Aliasammo = Owner.ConsoleCommand( "KEYBINDING "$KeyNameammo );
						if ( Aliasammo ~= "SwitchAmmo" )
						{
							curKeyNameammo = KeyNameammo;
							break;
						}
					}
				}
				if ( curKeyNameammo ~= "" )
					curKeyNameammo = "NONE";*/
		GetAxes(Pawn(Owner).ViewRotation,X,Y,Z);	
		StartTrace = ComputeProjectileStart(X, Y, Z);
		AdjustedAim = P.AdjustAim(1000000, StartTrace, 2*AimError, False, False);
		EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;	
		EndTrace += (FMax(1024.0, MaxRange) * Vector(AdjustedAim));
				bOwnsCrossHair = True; 
				Scale = Canvas.ClipX/640;
				Canvas.SetPos(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale );
				//Canvas.Style = ERenderStyle.STY_Translucent;
				Canvas.DrawColor.R = 0;
				Canvas.DrawColor.G = Rand(128);
				Canvas.DrawColor.B = Rand(128);
				Canvas.Font = Canvas.SmallFont;
				//Canvas.DrawIcon(Texture'DeusExUI.UserInterface.AugIcontarget_Small', Scale);
				//Canvas.bCenter=True;
				if(rMode == 0)
					Canvas.DrawText("     (Next Mode = Ammo Change) Trigger");
				else if(rMode == 1)
					Canvas.DrawText("     (Next Mode = Ammo Change) Ladder creation");
				else if(rMode == 2)
					Canvas.DrawText("     (Next Mode = Ammo Change) Jump Pad - [ <- SCOPE] "$rJumpVel$" [LASER -> ]");
				else if(rMode == 3)
					Canvas.DrawText("     (Next Mode = Ammo Change) Grapple - [ <- SCOPE] "$rGrapVel$" [LASER -> ]");
				//Canvas.DrawPortal(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale , 30, 30, CrosshairTarget, CrosshairTarget.Location, CrosshairTarget.Rotation);
			}
			else
				bOwnsCrossHair = False; // Only for compatibility with HDX50			
}


simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
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

defaultproperties
{
     LowAmmoWaterMark=4
	 Grapvel=1500
	 Jumpvel=-950
	 rGrapvel=1500
	 rJumpvel=-950
     GoverningSkill=Class'DeusEx.SkillWeaponPistol'
     NoiseLevel=0.050000
     EnemyEffective=ENMEFF_Organic
     Concealability=CONC_All
     ShotTime=0.800000
     reloadTime=2.000000
     HitDamage=25
     maxRange=1600
     AccurateRange=800
     BaseAccuracy=0.800000
     bCanHaveScope=True
     ScopeFOV=15
     bCanHaveLaser=True
     bHasSilencer=True
     StunDuration=10.000000
     bHasMuzzleFlash=False
     mpReloadTime=0.500000
     mpHitDamage=30
     mpBaseAccuracy=0.100000
     mpAccurateRange=2000
     mpMaxRange=2000
     bCanHaveModBaseAccuracy=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     FireOffset=(X=-25.000000,Y=8.000000,Z=14.000000)
     ProjectileClass=Class'DartUtil'
     shakemag=30.000000
     FireSound=Sound'DeusExSounds.Weapons.MiniCrossbowFire'
     AltFireSound=Sound'DeusExSounds.Weapons.MiniCrossbowReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.MiniCrossbowReload'
     SelectSound=Sound'DeusExSounds.Weapons.MiniCrossbowSelect'
     InventoryGroup=9213
     ItemName="Utility-Crossbow"
     PlayerViewOffset=(X=25.000000,Y=-8.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.MiniCrossbow'
     PickupViewMesh=LodMesh'DeusExItems.MiniCrossbowPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.MiniCrossbow3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconCrossbow'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCrossbow'
     largeIconWidth=47
     largeIconHeight=46
     Description="The mini-crossbow was specifically developed for espionage work, and accepts a range of dart types (normal, tranquilizer, or flare) that can be changed depending upon the mission requirements."
     beltDescription="UTIL"
     Mesh=LodMesh'DeusExItems.MiniCrossbowPickup'
     CollisionRadius=8.000000
     CollisionHeight=1.000000
     Mass=15.000000
}
