//=============================================================================
// Spray mark.
//=============================================================================
class GraffitiMark extends AveDecal;

var float spreadTime;
var float maxDrawScale;
var float time;

simulated function Tick(float deltaTime)
{
	time += deltaTime;
	if (time <= spreadTime)
	{
		DrawScale = maxDrawScale * time / spreadTime;
		ReattachDecal(vect(0.1,0.1,0));
	}
}

defaultproperties
{
     spreadTime=0.100000
     maxDrawScale=0.500000
     Texture=Texture'PGAssets.Skins.gdefault'
}
