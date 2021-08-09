//=============================================================================
// TBeam.
//=============================================================================
class BeamActorPink expands Effects;

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
	local BeamActorPink r;
	local DeusExPlayer P;
	
	P=DeusExPlayer(Owner);
	
	if (NumPuffs>0)
	{
		r = Spawn(class'BeamActorPink',P,,Location+MoveAmount);
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
     Sprite=Texture'PGAssets.Skins.federalpink'
     Texture=Texture'PGAssets.Skins.federalpink'
     Skin=Texture'PGAssets.Skins.federalpink'
     bUnlit=True
     LightBrightness=255
     LightHue=128
     LightRadius=2
}
