//=============================================================================
// Box.
//=============================================================================
class PSSing extends PGActors;

var Actor Fattener;
var bool bReturning;

function string GetDisplayString(Actor P)
{
	if(P.isA('DeusExPlayer'))
		return DeusExPlayer(p).PlayerReplicationInfo.PlayerName;
	else if(P.isA('ScriptedPawn'))
		return ScriptedPawn(P).FamiliarName;
	else if(P.isA('DeusExDecoration'))
		return DeusExDecoration(P).ItemName;
}

function Tick(float deltatime)
{
	if(Fattener == None)
	{
		Destroy();
		Log("NO PLAYER ATTACHED, DESTROYING",'Singularity');
	}
	else
	{
			SetLocation(Fattener.Location);
		if(!bReturning)
		{
			Fattener.DrawScale -= 0.1;
			if(Fattener.Drawscale <= -1)
			{
				bReturning=True;
			}		
		}
		else
		{
			Fattener.DrawScale += 0.1;
			if(Fattener.Drawscale >= 0)
			{
			BroadcastMessage(GetDisplayString(Fattener)$" imploded.");
			DeusExPlayer(Fattener).ReducedDamageType = '';
			ScriptedPawn(Fattener).bInvincible=False;
			DeusExDecoration(Fattener).bInvincible=False;
			DeusExDecoration(Fattener).HitPoints = 1;
				Fattener.TakeDamage(200,None,vect(0,0,0),vect(0,0,1),'Exploded');
				Explode();

				Fattener.DrawScale=Fattener.Default.DrawScale;
				Destroy();
			}					
		}

	}
}

function Explode()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 600;
	explosionRadius = 100;

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

	// spawn some rocks and flesh fragments
	for (i=0; i<explosionDamage/6; i++)
	{
		if (FRand() < 0.3)
			spawn(class'Rockchip',,,Location);
	}

	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
}

defaultproperties
{
     bHidden=True
}
