class WeaponEnergyAssault extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'PartyStuff.BB'
     InventoryGroup=255
     ItemName="|P5Charged Energy Rifle"
     beltDescription="ENERGY"
     Mass=1.000000
}
