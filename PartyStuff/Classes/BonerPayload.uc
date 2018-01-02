//=============================================
// MSGR object
//=============================================
Class BonerPayload extends DeusExDecoration;

var DeusExPlayer Payloader;
var bool bReturning;

function PostBeginPlay()
{
local int Payloads;
local BonerPayload BP;
	foreach AllActors(class'BonerPayload', BP)
	{
		if(BP.Payloader == Payloader)
		{
			Payloads++;
		}
	}
	if(Payloads > 10)
	{
		Destroy();
	}
}

function Tick(float v)
{		
	if(!bReturning)
	{
		Drawscale+=0.02;
		if(Drawscale >= 1.5)
		{
			bReturning=True;
		}
	}
	else
	{
		Drawscale-=0.02;
		if(Drawscale <= 1.0)
		{
			bReturning=False;
		}
	}

}

function BlowLoad()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 100;
	explosionRadius = 400;

	// alert NPCs that I'm exploding
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, Location);
	if (light != None)
		light.size = 4;

	Spawn(class'ExplosionSmall',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionLarge',,, Location + 2*VRand()*CollisionRadius);

	sphere = Spawn(class'SphereEffect',,, Location);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;

	// spawn a mark
	s = spawn(class'ScorchMark', Base,, Location-vect(0,0,1)*CollisionHeight, Rotation+rot(16384,0,0));
	if (s != None)
	{
		s.DrawScale = FClamp(explosionDamage/30, 0.1, 3.0);
		s.ReattachDecal();
	}

	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
	Destroy();
}

defaultproperties
{
     bInvincible=True
     bHighlight=False
	 bMovable=True
	 bCanBeBase=True
     Physics=PHYS_None
     DrawType=DT_Sprite
     Style=STY_Translucent
     Sprite=FireTexture'Effects.Laser.LaserSpot1'
     Texture=FireTexture'Effects.Laser.LaserSpot1'
     Skin=FireTexture'Effects.Laser.LaserSpot1'
     CollisionRadius=5.200001
     CollisionHeight=5.000000
     bBlockPlayers=True
}
