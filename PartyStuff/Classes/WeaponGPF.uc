//=============================================================================
// I'm going to regret this.
//=============================================================================
class WeaponGPF extends DeusExWeapon;

simulated function PreBeginPlay(){
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

// Crashy crashy
function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z){
	if(Other.isa('DeusExPlayer') && DeusExPlayer(Owner).bAdmin){
        DeusExPlayer(Other).ConsoleCommand("DEBUG GPF");
    }
    return;
}

simulated function float CalculateAccuracy(){
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
}

function LaserToggle()
{
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     GoverningSkill=Class'DeusEx.SkillWeaponPistol'
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
     InventoryGroup=68
     ItemName="GPF Gun"
     PlayerViewOffset=(X=24.000000,Y=-10.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.StealthPistol'
     PickupViewMesh=LodMesh'DeusExItems.StealthPistolPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.StealthPistol3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconStealthPistol'
     largeIcon=Texture'DeusExUI.Icons.LargeIconStealthPistol'
     largeIconWidth=47
     largeIconHeight=37
     Description="The stealth pistol is a variant of the standard 10mm pistol with a larger clip and integrated silencer designed for wet work at very close ranges."
     beltDescription="GPF"
     Mesh=LodMesh'DeusExItems.StealthPistolPickup'
     CollisionRadius=8.000000
     CollisionHeight=0.800000
}
