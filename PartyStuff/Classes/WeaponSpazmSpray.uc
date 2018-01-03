//=============================================================================
// WeaponSpazmSpray.
//=============================================================================
class WeaponSpazmSpray expands WeaponPepperGun;

Simulated Function PreBeginPlay()
{}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ((BeltSpot <= 9) && (BeltSpot >= 1));
}


defaultproperties
{
    LowAmmoWaterMark=100
    reloadTime=2.00
    maxRange=200
    AccurateRange=200
    AmmoName=Class'AmmoSpazmGas'
    PickupAmmoCount=200
    ProjectileClass=Class'SpazmGas'
    InventoryGroup=168
    ItemName="Spazm Spray Gun"
    Description="This spazm spray gun shoots gas out, resulting in any pawns in the area having a seizure of some kind."
    beltDescription="Spasm"
}
