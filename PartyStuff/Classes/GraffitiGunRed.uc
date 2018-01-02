//=============================================================================
// Gun that sprays
//=============================================================================
class GraffitiGunRed extends DeusExWeapon;

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
	}
}

defaultproperties
{
     LowAmmoWaterMark=50
     GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
     NoiseLevel=0.200000
     bAutomatic=True
     ShotTime=0.000000
     reloadTime=0.000000
     HitDamage=0
     maxRange=100
     AccurateRange=100
     BaseAccuracy=0.700000
     bPenetrating=False
     StunDuration=15.000000
     bHasMuzzleFlash=False
     mpReloadTime=4.000000
     mpBaseAccuracy=0.700000
     mpAccurateRange=100
     mpMaxRange=100
     AmmoName=Class'SprayPaintRed'
     ReloadCount=200
     PickupAmmoCount=800
     FireOffset=(X=-22.000000,Y=10.000000,Z=14.000000)
     ProjectileClass=Class'GraffitiSprayRed'
     shakemag=10.000000
     FireSound=Sound'DeusExSounds.Weapons.PepperGunFire'
     AltFireSound=Sound'DeusExSounds.Weapons.PepperGunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.PepperGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.PepperGunSelect'
     InventoryGroup=92
     ItemName="Graffiti Gun Red"
     PlayerViewOffset=(X=16.000000,Y=-10.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.PepperGun'
     PickupViewMesh=LodMesh'DeusExItems.PepperGunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.PepperGun3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconPepperSpray'
     largeIcon=Texture'DeusExUI.Icons.LargeIconPepperSpray'
     largeIconWidth=46
     largeIconHeight=40
     Description="The pepper gun will accept a number of commercially available riot control agents in cartridge form and disperse them as a fine aerosol mist that can cause blindness or blistering at short-range."
     beltDescription="RED"
     Mesh=LodMesh'DeusExItems.PepperGunPickup'
     CollisionRadius=7.000000
     CollisionHeight=1.500000
     Mass=7.000000
     Buoyancy=2.000000
}
