//=============================================================================
// AdaptiveArmor.
//=============================================================================
class FlameArmour extends PGArmour;

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
     Dur=100
     Def=10
     bResistFire=True
     ItemName="Flame Armour"
     beltDescription="FLAME"
}
