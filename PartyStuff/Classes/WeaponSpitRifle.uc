class WeaponSpitRifle extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'GreaselShoot'
     InventoryGroup=197
     ItemName="|P2Bio Spitter Gun"
     beltDescription="SPIT"
     Mass=1.000000
}
