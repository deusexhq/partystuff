//=============================================================================
// SizableEffects.
//=============================================================================
class SizableEffects expands Effects;

var() float Size;

function Tick(float deltaTime)
{
	DrawScale = 3.0 * size * (Default.LifeSpan - LifeSpan) / Default.LifeSpan;
	ScaleGlow = 2.0 * (LifeSpan / Default.LifeSpan);
}

defaultproperties
{
     size=1.000000
     LifeSpan=1.000000
     bUnlit=True
}
