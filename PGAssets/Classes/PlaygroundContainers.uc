//=============================================================================
// SmallBox.
//=============================================================================
class PlaygroundContainers extends Containers;

var string CreatedBy;
/*
function Tick(float CleanupTimer)
{
local Playground P;
local DeusExPlayer DXP;
local PlaygroundContainers PC;
local bool bQueDelete;

	Super.Tick (CleanupTimer);
	if(p == None)
	spawn(class'Playground');
}
*/
function Destroy2(string Destroyer)
{
	if(Destroyer ~= CreatedBy)
	Destroy();
}

defaultproperties
{
}
