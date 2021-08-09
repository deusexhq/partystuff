//=============================================================================
// AdaptiveArmor.
//=============================================================================
class NanoArmour extends PGArmour;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     Dur=10000
     Def=10
     ItemName="Nano Armour"
     beltDescription="NANO"
}
