//=============================================================================
// TBeam.
//=============================================================================
class BeamActor expands Effects;

Var DeusExPlayer POwner,Other;
var vector MoveAmount;
var int NumPuffs;
replication
{
	// Things the server should send to the client.
	unreliable if( Role==ROLE_Authority )
		MoveAmount, NumPuffs;
}


simulated function Tick( float DeltaTime )
{
	if ( Level.NetMode  != NM_DedicatedServer )
	{
		ScaleGlow = (Lifespan/Default.Lifespan) * 1.0;
		AmbientGlow = ScaleGlow * 210;
	}
}

simulated function PostBeginPlay()
{
		SetTimer(0.001, false);
}

simulated function Timer()
{
	local BeamActor r;
	local DeusExPlayer P;
	
	P=DeusExPlayer(Owner);
	
	if (NumPuffs>0)
	{
		r = Spawn(class'BeamActor',P,,Location+MoveAmount);
		r.RemoteRole = ROLE_None;
		r.NumPuffs = NumPuffs -1;
		r.MoveAmount = MoveAmount;
		r.SetOwner(P);
		r.Texture = self.Texture;
		r.Skin = self.Skin;
		r.Sprite = self.Sprite;
	}
}

defaultproperties
{
     LifeSpan=1.300000
     DrawType=DT_Sprite
     Style=STY_Translucent
     Sprite=Texture'DeusExDeco.Skins.AlarmLightTex6'
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex6'
     Skin=Texture'DeusExDeco.Skins.AlarmLightTex6'
     bUnlit=True
     LightBrightness=255
     LightHue=128
     LightRadius=2
}
