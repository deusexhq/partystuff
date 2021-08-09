//=============================================================================
// SuperTool.
//=============================================================================
class PoisonEstus extends DeusExPickup;

var bool bEstusArmed;

var float explosionDamage;
var float explosionRadius;

function DropFrom(vector StartLocation)
{
	bEstusArmed=True;
	super.DropFrom(StartLocation);
}

function BecomePickup()
{
	if(Owner != None)
		bEstusArmed=True;
	super.BecomePickup();
}

function BecomeItem()
{
	bEstusArmed=False;
	super.BecomeItem();
}

function estusExplode()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;

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
	SpawnTearGas(Location);
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
		MaxCopies = 1;
}

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		
		GotoState('DeActivated');
	}
Begin:
}

function EstusUse(actor p)
{
	p.TakeDamage(30, Pawn(Owner), vect(0,0,0),vect(0,0,1),'Poison');
	SpawnTearGas(p.location);
}

function Destroyed() 
{
	local ProjectileGenerator gen;
	
	
	if ( !bEstusArmed )
		return;
		
	EstusExplode();
	gen = Spawn(class'ProjectileGenerator',,, Location);
	if (gen != None)
	{
     //gen.RemoteRole = ROLE_None;
		//gen.particleDrawScale = 1.0;
		gen.checkTime = 0.05;
		gen.frequency = 1.0;
		gen.ejectSpeed = 200.0;
		//gen.bGravity = True;
		gen.bRandomEject = True;
		gen.ProjectileClass=class'Fireball';
		gen.LifeSpan = 2.0;
	}
	super.Destroyed();
}


function SpawnTearGas(vector target)
{
	local Vector loc;
	local TearGas gas;
	local int i;

	if ( Role < ROLE_Authority )
		return;

	for (i=0; i<512/36; i++)
	{
		if (FRand() < 0.9)
		{
			loc = target;
			loc.X += FRand() * 512 - 512 * 0.5;
			loc.Y += FRand() * 512 - 512 * 0.5;
			loc.Z += 32;
			gas = spawn(class'TearGas', None,, loc);
			if (gas != None)
			{
				gas.Velocity = vect(0,0,0);
				gas.Acceleration = vect(0,0,0);
				gas.DrawScale = FRand() * 0.5 + 2.0;
				gas.LifeSpan = FRand() * 10 + 30;
				if ( Level.NetMode != NM_Standalone )
					gas.bFloating = False;
				else
					gas.bFloating = True;
				gas.Instigator = Pawn(Owner);
			}
		}
	}
}


simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return (BeltSpot == 9);
}

defaultproperties
{
     explosionDamage=100.000000
     explosionRadius=100.000000
     bBreakable=True
     maxCopies=1
     bActivatable=True
     ItemName="Poisoned Estus flask"
     PlayerViewOffset=(X=16.000000,Y=8.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExDeco.Flask'
     PickupViewMesh=LodMesh'DeusExDeco.Flask'
     ThirdPersonMesh=LodMesh'DeusExDeco.Flask'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'PGAssets.Icons.BeltIconEstus'
     M_Activated=""
     largeIconWidth=18
     largeIconHeight=44
     Description="Estus magic potion of healing"
     beltDescription="POISONESTUS"
     Texture=Texture'DeusExDeco.Skins.AlarmLightTex9'
     Mesh=LodMesh'DeusExDeco.Flask'
     AmbientGlow=20
     MultiSkins(0)=Texture'DeusExDeco.Skins.AlarmLightTex9'
     MultiSkins(1)=Texture'DeusExDeco.Skins.AlarmLightTex9'
     MultiSkins(2)=Texture'DeusExDeco.Skins.AlarmLightTex9'
     MultiSkins(3)=Texture'DeusExDeco.Skins.AlarmLightTex9'
     MultiSkins(4)=Texture'DeusExDeco.Skins.AlarmLightTex9'
     MultiSkins(5)=Texture'DeusExDeco.Skins.AlarmLightTex9'
     MultiSkins(6)=Texture'DeusExDeco.Skins.AlarmLightTex9'
     MultiSkins(7)=Texture'DeusExDeco.Skins.AlarmLightTex9'
     SoundVolume=64
     CollisionRadius=4.200000
     CollisionHeight=7.450000
     LightBrightness=50
     LightSaturation=20
     LightRadius=5
     Mass=10.000000
     Buoyancy=8.000000
}
