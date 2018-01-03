//=============================================================================
// WeaponStealthPistol.
//=============================================================================
class Replicator extends DeusExWeapon;
var() class<Actor> StoredActor;
var string rStoredActor;

var() rotator storedRotation;
var bool bRotLock;
var bool bAdminUnlocked, bRepAdminUnlocked;
var int Uses, rUses;
var string iv;

replication
{
reliable if (bNetOwner && Role==ROLE_Authority)
rStoredActor,iv, bRepAdminUnlocked, ruses;
}

simulated event RenderOverlays(canvas Canvas)
{
	local DeusExPlayer P;
	local Actor CrosshairTarget;
	local float Scale, Accuracy, Dist;
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X,Y,Z;
		local vector loc, line;
			local String KeyName, Alias, curKeyName;
	local int i;
	Super.RenderOverlays(Canvas);
	P = DeusExPlayer(Owner);
	if ( P != None ) 
	{	
				bOwnsCrossHair = True; 
				Scale = Canvas.ClipX/640;
				Canvas.SetPos(0.5 * Canvas.ClipX - 16 * Scale, 0.5 * Canvas.ClipY - 16 * Scale );
				//Canvas.Style = ERenderStyle.STY_Translucent;
				Canvas.DrawColor.R = 255;
				Canvas.DrawColor.G = 250;
				Canvas.DrawColor.B = 255;
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
				if(bRepAdminUnlocked)
					Canvas.DrawText("       Stored Class: "$iv$" ["$curKeyName$" to clear]");
				else
					Canvas.DrawText("       ["$rUses$"/10] Stored Class: "$iv$" ["$curKeyName$" to clear]");
			}
			else
				bOwnsCrossHair = False; // Only for compatibility with HDX50		
		//}	
//}		
}

function string GetDisplayString(Actor P)
{
	if(P.isA('ScriptedPawn'))
		return ScriptedPawn(P).FamiliarName;
	else if(P.isA('DeusExDecoration'))
		return DeusExDecoration(P).ItemName;
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

function GiveTo( pawn Other )
{
    super.Giveto(Other);
	DeusExPlayer(Other).ClientMessage("Fire at an object to begin.");
	if(DeusExPlayer(Other).bAdmin)
	{
		bAdminUnlocked=True;
		bRepAdminUnlocked=True;
		Uses=10;
		rUses=10;
		DeusExPlayer(Other).ClientMessage("ADMIN UNLOCKED! Unlimited uses.");
	}
	else
	{
		DeusExPlayer(Other).ClientMessage("Limited uses.");
		Uses=10;
		rUses=10;
		bAdminUnlocked=False;
		bRepAdminUnlocked=false;
	}
	StoredActor = None;
	rstoredactor = "NONE";
	iv = "NONE";
	SetTimer(10,True);
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local DeusExPlayer dxPlayer, DXP;
	local Pawn P;
	
	if(StoredActor == None)
	{
		if(Other.isa('ScriptedPawn'))
		{
			StoredActor = Other.Class;
			rstoredactor = GetDisplayString(Other);
			StoredRotation = Other.Rotation;
			iv = GetDisplayString(Other);
			DeusExPlayer(Owner).ClientMessage("Stored: "$GetDisplayString(Other));
			DeusExPlayer(Owner).ClientMessage("Fire now spawns. Laser to toggle rotation. Scope to clear");
			return;
		}
		else if(Other.isa('Decoration'))
		{
			StoredActor = Other.Class;
			rstoredactor = GetDisplayString(Other);;
			StoredRotation = Other.Rotation;
			iv = GetDisplayString(Other);
			DeusExPlayer(Owner).ClientMessage("Stored: "$GetDisplayString(Other));
			DeusExPlayer(Owner).ClientMessage("Fire now spawns. Laser to toggle rotation. Scope to clear");
			return;
		}		
	}
	else
	{
		if(bAdminUnlocked)
		{
			if(bRotLock)
			Spawn(StoredActor,,,HitLocation, StoredRotation);
			else
			Spawn(StoredActor,,,HitLocation, Owner.Rotation);		
		}
		else
		{
			if(Uses > 0)
			{
				Uses--;
				rUses=Uses;
				DeusExPlayer(Owner).ClientMessage(Uses$" uses remaining...");
				
				if(bRotLock)
				Spawn(StoredActor,,,HitLocation, StoredRotation);
				else
				Spawn(StoredActor,,,HitLocation, Owner.Rotation);
			}
			else
			{
				DeusExPlayer(Owner).ClientMessage("Replicator is used up and needs to recharge...");
			}		
		}
	}
}

function Timer()
{
	if(Uses < 10)
	{
	Uses++;
	rUses=Uses;
	DeusExPlayer(Owner).ClientMessage("Replicator is charging... Now at "$Uses$"/10");	
	}

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
    
   /*      // if ReloadCount is 0 and we're not hand to hand, then this is a 
      // single-use weapon so destroy it after firing once 
      if ((ReloadCount == 0) && !bHandToHand) 
      { 
         if (DeusExPlayer(Owner) != None) 
            DeusExPlayer(Owner).RemoveItemFromSlot(Self);   // remove it from the inventory grid 
         Destroy(); 
      } 
      */              // Do I REALLY need all that crap JUST for infinite ammo? 
      ReadyToFire(); 
   Done: 
      bFiring = False; 
      Finish(); 
}

function ScopeToggle()
{
	if(StoredActor != None)
	{
	StoredActor = None;
	rstoredactor = "NONE";
	iv = "NONE";
	DeusExPlayer(Owner).ClientMessage("Object cleared.");
	}
}

function LaserToggle()
{
	if(StoredActor != None)
	{
	bRotLock = !bRotLock;
	DeusExPlayer(Owner).ClientMessage("rotation Lock: "$bRotLock);
	}
}

defaultproperties
{
     GoverningSkill=Class'DeusEx.SkillWeaponPistol'
     rStoredActor="NONE"
     NoiseLevel=0.010000
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
     mpAccurateRange=1200
     mpMaxRange=1200
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
     InventoryGroup=131987
     ItemName="Replicator Gun"
     PlayerViewOffset=(X=24.000000,Y=-10.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.StealthPistol'
     PickupViewMesh=LodMesh'DeusExItems.StealthPistolPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.StealthPistol3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconStealthPistol'
     largeIcon=Texture'DeusExUI.Icons.LargeIconStealthPistol'
     largeIconWidth=47
     largeIconHeight=37
     Description="The stealth pistol is a variant of the standard 10mm pistol with a larger clip and integrated silencer designed for wet work at very close ranges."
     beltDescription="REPLICATE"
     Mesh=LodMesh'DeusExItems.StealthPistolPickup'
     CollisionRadius=8.000000
     CollisionHeight=0.800000
}
