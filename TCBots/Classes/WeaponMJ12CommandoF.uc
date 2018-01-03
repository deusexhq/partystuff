//=============================================================================
// WeaponMJ12Commando.
//=============================================================================
class WeaponMJ12CommandoF extends WeaponNPCRanged;

// fire weapons out of alternating sides
function Fire(float Value)
{
	PlayerViewOffset.Y = -PlayerViewOffset.Y;
	Super.Fire(Value);
}

defaultproperties
{
	AIFireDelay=0.3
     ShotTime=0.200000
     reloadTime=1.000000
     HitDamage=15
     BaseAccuracy=0.400000
     bHasMuzzleFlash=True
     AmmoName=Class'DeusEx.Ammo762mm'
     PickupAmmoCount=50
     bInstantHit=True
     FireSound=Sound'DeusExSounds.Robot.RobotFireGun'
     CockingSound=Sound'DeusExSounds.Weapons.AssaultGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.AssaultGunSelect'
     PlayerViewOffset=(Y=-24.000000,Z=-12.000000)
}
