//=============================================================================
// Vortex
//=============================================================================
class FishingBait extends ThrownProjectile;

var FishingDevice MainDev;

simulated function PostBeginPlay()
{

   Super.PostBeginPlay();
   
   Velocity = Vector(Rotation) * Speed;
   Velocity.Z -= 200;
   SetTimer(10, false);
   RandSpin(30000);
}

simulated function TakeDamage(int Damage, Pawn instigatedBy, Vector HitLocation, Vector Momentum, name damageType)
{
	return;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	return;
}

simulated function Landed( vector HitNormal )
{
   HitWall(HitNormal, None);
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{
   HitWall(Normal(HitLocation - Other.Location), None );
}

simulated function HitWall( vector HitNormal, actor Wall )
{
   Velocity = 0.75 * ((Velocity dot HitNormal) * HitNormal * (-2.0) + Velocity);   // Reflect off Wall w/damping
   speed = VSize(Velocity);
   if ( Velocity.Z > 400 )
      Velocity.Z = 0.5 * (400 + Velocity.Z);
}


function Timer()
{
	DeusExPlayer(MainDev.Owner).ClientMessage("Bait timed out...");
	MainDev.Bait = None;
	MainDev.Stage = 0;
   Destroy();
}

function ZoneChange(ZoneInfo NewZone)
{
	local FishingBait2 FB;
	
	Super.ZoneChange(NewZone);
	if (NewZone.bWaterZone)
	{
		FB = Spawn(class'FishingBait2',,,Location);
		FB.MainDev = MainDev;
		MainDev.Lure = FB;
		MainDev.Stage = 2;
		FB.SetTimer(RandRange(5,25), True);
		Destroy();
	}
}

defaultproperties
{
     MyDamageType=SpecialDamage
     LifeSpan=20.000000
     Skin=FireTexture'Effects.liquid.Virus_SFX'
     Mesh=LodMesh'DeusExDeco.Basketball'
     AmbientGlow=67
     bUnlit=True
     SoundRadius=112
     SoundVolume=255
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     bBounce=True
     bFixedRotationDir=True
     DesiredRotation=(Pitch=12000,Yaw=5666,Roll=2334)
}
