class WeaponBeamRifle extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'LB2'
     InventoryGroup=132643
     ItemName="Light Beam Rifle"
     beltDescription="BEAM"
     Mass=1.000000
}
