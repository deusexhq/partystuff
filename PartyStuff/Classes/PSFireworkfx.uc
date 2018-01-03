//=============================================================================
// GreaselSpit.
//=============================================================================
class PSFireworkfx extends DeusExProjectile;

#exec OBJ LOAD FILE=Effects

function PreBeginPlay()
{
	super.PreBeginPlay();
	
	if(FRand() < 0.2)
	Multiskins[1] = Texture'DeusExDeco.Skins.AlarmLightTex3';
	else if(FRand() >= 0.2 && FRand() < 0.4)
	Multiskins[1] = Texture'DeusExDeco.Skins.AlarmLightTex5';
	else if(FRand() >= 0.4 && FRand() < 0.7)
	Multiskins[1] = Texture'DeusExDeco.Skins.AlarmLightTex7';
	else if(FRand() >= 0.7)
	Multiskins[1] = Texture'DeusExDeco.Skins.AlarmLightTex9';
}

defaultproperties
{
     AccurateRange=300
     maxRange=450
     bIgnoresNanoDefense=True
     speed=600.000000
     MaxSpeed=800.000000
     Damage=0.000000
     MomentumTransfer=400
     Style=STY_Translucent
     Mesh=LodMesh'DeusExItems.GreaselSpit'
}
