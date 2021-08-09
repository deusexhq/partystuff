class WeaponNeedler2 extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'PartyStuff.DartLight'
     InventoryGroup=255
     ItemName="|P1Disco Needle Gun"
     beltDescription="D-NEEDLE"
     Mass=1.000000
}
