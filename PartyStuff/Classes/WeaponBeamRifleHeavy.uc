class WeaponBeamRifleHeavy extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'LB3'
     InventoryGroup=132346
     ItemName="Heavy Beam Rifle"
     beltDescription="BEAM"
     PlayerViewOffset=(X=46.000000,Y=-22.000000,Z=-10.000000)
     PlayerViewMesh=LodMesh'DeusExItems.GEPGun'
     PickupViewMesh=LodMesh'DeusExItems.GEPGunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.GEPGun3rd'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconGEPGun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconGEPGun'
     largeIconWidth=203
     largeIconHeight=77
     invSlotsX=4
     invSlotsY=2
}
