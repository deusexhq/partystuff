// SkullGun

class WeaponSkullGun extends DeusExWeapon;

simulated function PreBeginPlay() {
	Super.PreBeginPlay();
	if ( Level.NetMode != NM_StandAlone ) {
		HitDamage = mpHitDamage;
		BaseAccuracy = mpBaseAccuracy;
		ReloadTime = mpReloadTime;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
		ReloadCount = mpReloadCount;
	}
}

defaultproperties
{
     LowAmmoWaterMark=7
     reloadTime=0.000000
     HitDamage=35
     maxRange=24000
     AccurateRange=24400
     BaseAccuracy=0.100000
     bCanHaveScope=True
     bHasScope=True
     ScopeFOV=30
     bCanHaveLaser=True
     bHasLaser=True
     mpHitDamage=10
     mpBaseAccuracy=0.100000
     mpAccurateRange=8000
     mpMaxRange=8000
     mpReloadCount=17
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     AmmoName=Class'AmmoSkull'
     ReloadCount=17
     PickupAmmoCount=17
     ProjectileClass=Class'SkullBolt'
     shakemag=0.000000
     FireSound=Sound'DeusExSounds.Weapons.PlasmaRifleFire'
     AltFireSound=Sound'DeusExSounds.Weapons.PlasmaRifleReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.PlasmaRifleReload'
     SelectSound=Sound'DeusExSounds.Weapons.PlasmaRifleSelect'
     InventoryGroup=2
     ItemName="Skullgun"
     PlayerViewOffset=(X=22.000000,Y=-10.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Glock'
     PickupViewMesh=LodMesh'DeusExItems.GlockPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Glock3rd'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconPistol'
     Description="A powerfull weapon that is currently being produced for terrorists such as you, the skull gun superheats skulls and accelerates the resulting armor-peircing-bone-mass. Extremely deadly."
     beltDescription="SKULLGUN"
     Mesh=LodMesh'DeusExItems.Glock'
     CollisionRadius=7.000000
     CollisionHeight=1.000000
     Mass=3.000000
}
