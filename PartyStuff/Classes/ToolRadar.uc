Class ToolRadar extends DeusExDecoration;

var bool bEnabled;
var(Sounds) sound BeepActive, BeepPassive;
var bool bDebug;
var int Waittime;
var deusexplayer myOwner;

function PostBeginplay()
{
	SetTimer(1,False);
}

function Bump( actor Other )
{
}

function BlowIt()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 200;
	explosionRadius = 300;

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
		else
			spawn(class'metalFragment',,,Location);
	}
	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
	Destroy();
}

function Timer()
{
	local int range;
	local DeusExPlayer player;
	local SphereEffect SE;
	
		range=0;
		foreach RadiusActors(class'DeusExPlayer', player, 350, Location)
		{
			if (player != None )
				range=2;		
		}
		
		foreach RadiusActors(class'DeusExPlayer', player, 1000, Location)
		{
			if (player != None && range != 2)
				range=1;		
		}
		
		
	if(bEnabled && Range==0)
	{
		SetTimer(1,False);
	}
	if(bEnabled && Range==2)
	{
		PlaySound(BeepActive, SLOT_None,200,, 255);
		SetTimer(0.5,False);
	}
	if(bEnabled && Range==1)
	{
		PlaySound(BeepActive, SLOT_None,200,, 255);
		SetTimer(1.3,False);
	}

	
	if(bDebug)
	{
	BroadcastMessage("Range"@Range);
	}
}

defaultproperties
{
     ItemName="Radar"
	 bCanbeBase=True
	 BeepActive=Sound'TurretSwitch'
      Mesh=LodMesh'DeusExDeco.AcousticSensor'
     CollisionRadius=24.400000
     CollisionHeight=23.059999
     Mass=10.000000
	 bPushable=True
	 bEnabled=True
}
