//=============================================================================
// AdaptiveArmor.
//=============================================================================
class PowerArmour extends PGArmour;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     Dur=25
     Def=10
     ItemName="Power Armour"
     beltDescription="POWER"
}
