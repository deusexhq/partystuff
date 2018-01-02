//-----------------------------------------------------------
//
//-----------------------------------------------------------
class DXEnemy expands DXHumanMilitary
      abstract;

function bool ShouldFlee()
{
	return false;
}

function bool IsFearful()
{
	return false;
}

function bool WillTakeStompDamage(actor stomper)
{
     // This blows chunks!
     if (stomper.IsA('PlayerPawn') && (GetPawnAllianceType(Pawn(stomper)) != ALLIANCE_Hostile))
          return false;
     else
          return true;
}

function Frob(Actor Frobber, Inventory frobWith) 
{
}

//---END-CLASS---

defaultproperties
{
     InitialAlliances(0)=(AllianceName=Player,AllianceLevel=-1.000000)
     InitialAlliances(1)=(AllianceName=SecuritySamurai,AllianceLevel=-1.000000)
     InitialAlliances(2)=(AllianceName=Security,AllianceLevel=-1.000000)
}
