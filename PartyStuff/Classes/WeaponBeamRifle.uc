class WeaponBeamRifle extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'PartyStuff.LB2'
     InventoryGroup=35
     ItemName="Light Beam Rifle"
     beltDescription="BEAM"
     Mass=1.000000
}
