//=============================================================================
// AdaptiveArmor.
//=============================================================================
class FiberArmour extends PGArmour;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     Dur=25
     Def=1000
     ItemName="Fiber Armour"
     beltDescription="FIBER"
}
