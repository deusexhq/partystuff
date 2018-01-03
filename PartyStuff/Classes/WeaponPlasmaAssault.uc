class WeaponPlasmaAssault extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     HitDamage=8
     bInstantHit=False
     ProjectileClass=Class'DeusEx.PlasmaBolt'
     InventoryGroup=41
     ItemName="|P4Plasma Assault Gun"
     beltDescription="PLAS"
     Mass=1.000000
}
