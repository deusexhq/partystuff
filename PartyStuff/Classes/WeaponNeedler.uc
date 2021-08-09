class WeaponNeedler extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'DeusEx.Dart'
     InventoryGroup=217
     ItemName="|P1Needle Gun"
     beltDescription="NEEDLE"
     Mass=1.000000
}
