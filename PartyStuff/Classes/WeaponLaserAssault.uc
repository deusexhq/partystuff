class WeaponLaserAssault extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'PartyStuff.LB'
     InventoryGroup=132
     ItemName="|P2Charged Laser Rifle"
     beltDescription="LASER"
     Mass=1.000000
}
