//=============================================================================
// Switch1.
//=============================================================================
class SequenceLock extends DeusExDecoration;

var() int SequenceNum;
var bool bActivated;
var() string mySequenceGroup;
var() bool bResetter;

function Frob(Actor Frobber, Inventory frobWith)
{
local SequenceLockHandler SQH;

	if(bResetter)
	{
		foreach AllActors(class'SequenceLockHandler', SQH)
		{
			if(SQH.SequenceGroup ~= mySequenceGroup)
			{
				SQH.CurrentInput=0;
				DeusExPlayer(Frobber).ClientMessage("Sequence"@mySequenceGroup$": |P2"$SQH.CurrentInput);
			}
		}
	return;
	}
	
		/*if(bActivated)
	{
		DeusExPlayer(Frobber).ClientMessage("Button already activated.");
	return;
	}*/
		foreach AllActors(class'SequenceLockHandler', SQH)
		{
			if(SQH.SequenceGroup ~= mySequenceGroup)
			{
				SQH.AddSequence(DeusExPlayer(Frobber), SequenceNum);
				//bActivated=True;
			}
		}
}

defaultproperties
{
     bInvincible=True
     ItemName="Sequence Lock"
     bPushable=False
     Physics=PHYS_None
     Texture=Texture'DeusExItems.Skins.DataCubeTex2'
     Mesh=LodMesh'DeusExItems.DataCube'
     CollisionRadius=7.000000
     CollisionHeight=1.270000
     Buoyancy=12.000000
}
