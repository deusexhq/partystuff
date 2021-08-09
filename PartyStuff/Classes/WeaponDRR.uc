class WeaponDRR extends WeaponAssaultGun;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     AmmoNames(0)=None
     AmmoNames(1)=None
     ProjectileNames(1)=None
     bInstantHit=False
     ProjectileClass=Class'PartyStuff.RocketDrone'
     InventoryGroup=116
     ItemName="Automatic Drone Rocket Rifle"
     beltDescription="DRR"
     Mass=1.000000
}
