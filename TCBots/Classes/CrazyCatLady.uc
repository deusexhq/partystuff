//-----------------------------------------------------------
// YHEAHHHH
//-----------------------------------------------------------
class CrazyCatLady expands DXHumanMilitary;

var bool bKitties;

function Carcass SpawnCarcass()
{
	Explode();

	return None;
}

function Explode()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 100;
	explosionRadius = 1000;

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
		sphere.Skin=FireTexture'Effects.Electricity.Virus_SFX';
		sphere.Texture=FireTexture'Effects.Electricity.Virus_SFX';

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
			spawn(class'FleshFragment',,,Location);
	}

	HurtRadius(explosionDamage, explosionRadius, 'Burned', explosionDamage*100, Location);
}

function PreBeginPlay()
{
	SetTimer(5,True);
}

function Tick(float deltatime)
{
local CrazyKitty CK;

	bKitties=False;
			
	foreach allactors(class'CrazyKitty',CK)
	{
		if(CK != none)
		{
			bKitties=True;
		}

	}
}

function bool FilterDamageType(Pawn instigatedBy, Vector hitLocation, Vector offset, Name damageType)
{
	if ((damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') || (damageType == 'Flamed') || (damageType == 'Burned') || bKitties)
		return false;
	else
		return Super.FilterDamageType(instigatedBy, hitLocation, offset, damageType);
}

function Timer()
{
local CrazyKitty CK;
local int ckc;

	ckc = 0;
	
	foreach allactors(class'CrazyKitty',CK)
	{
		ckc++;
	}
	
	if(ckc < 6)
	{
		MakeKitty();
	}
}

function MakeKitty()
{
	local int i;
	local Rotator rot;
	local Vector loc;
	local CrazyKitty kitty;
	loc = Location;
	loc.X += (CollisionRadius * 1.2);
	loc.Y += (CollisionRadius * 1.2);
	kitty = Spawn(class'CrazyKitty',,, loc);
	kitty.myOwner = self;
	kitty.GotoState('following');
}

defaultproperties
{
     WalkingSpeed=0.300000
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     HealthHead=1000
     HealthTorso=1000
     HealthLegLeft=1000
     HealthLegRight=1000
     HealthArmLeft=1000
     HealthArmRight=1000
     Mesh=LodMesh'DeusExCharacters.GFM_TShirtPants'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.BumFemaleTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.BumFemaleTex0'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.BumFemaleTex0'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.PantsTex4'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.BumFemaleTex1'
     CollisionRadius=20.000000
     CollisionHeight=43.000000
     BindName="CrazyCatLady"
     FamiliarName="Crazy Cat Lady"
     UnfamiliarName="Crazy Cat Lady"
}
