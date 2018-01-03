//=============================================================================
// EllipseEffect.
//=============================================================================
class AdminArmourEffect extends Effects;

simulated function Tick(float deltaTime)
{
	ScaleGlow = 2.0 * (LifeSpan / Default.LifeSpan);
}

defaultproperties
{
     LifeSpan=1.000000
	 MultiSkins(0)=Texture'Extras.Eggs.Matrix_A00'
	 //Multiskins(0)=FireTexture'Effects.Electricity.Nano_SFX_A'
     DrawType=DT_Mesh
     Style=STY_Translucent
     Mesh=LodMesh'DeusExItems.EllipseEffect'
     bUnlit=True
}
