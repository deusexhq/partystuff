//=============================================================================
// WeaponTripBomb.
//=============================================================================
class WeaponSurfKnife extends DeusExWeapon;

var localized String shortName;

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

function PostBeginPlay()
{
   Super.PostBeginPlay();
   bWeaponStay=False;
}

// Become a pickup
// Weapons that carry their ammo with them don't vanish when dropped
function BecomePickup()
{
	Super.BecomePickup();
   if (Level.NetMode != NM_Standalone)
      if (bTossedOut)
         Lifespan = 0.0;
}

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

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
     LowAmmoWaterMark=5
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.050000
     EnemyEffective=ENMEFF_Organic
     EnviroEffective=ENVEFF_AirVacuum
     Concealability=CONC_Visual
     ShotTime=0.200000
     reloadTime=0.200000
     HitDamage=15
     maxRange=1280
     AccurateRange=640
     BaseAccuracy=0.900000
     bHasMuzzleFlash=False
     bHandToHand=True
     mpReloadTime=0.200000
     mpHitDamage=35
     mpBaseAccuracy=0.100000
     mpAccurateRange=640
     mpMaxRange=640
     FireOffset=(X=-10.000000,Y=14.000000,Z=22.000000)
     ProjectileClass=Class'PartyStuff.SurfKnives'
     shakemag=5.000000
     InventoryGroup=12
     ItemName="Surfin' Knives"
     ItemArticle="some"
     PlayerViewOffset=(X=24.000000,Y=-12.000000,Z=-21.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Shuriken'
     PickupViewMesh=LodMesh'DeusExItems.ShurikenPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Shuriken3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconShuriken'
     largeIcon=Texture'DeusExUI.Icons.LargeIconShuriken'
     largeIconWidth=36
     largeIconHeight=45
     Description="A favorite weapon of assassins in the Far East for centuries, throwing knives can be deadly when wielded by a master but are more generally used when it becomes desirable to send a message. The message is usually 'Your death is coming on swift feet.'"
     beltDescription="SURF KNIFE"
     Texture=Texture'DeusExItems.Skins.ReflectionMapTex1'
     Mesh=LodMesh'DeusExItems.ShurikenPickup'
     CollisionRadius=7.500000
     CollisionHeight=0.300000
}
