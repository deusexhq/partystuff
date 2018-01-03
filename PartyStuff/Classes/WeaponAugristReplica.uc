//=============================================
// PlasmaSword
//=============================================
Class WeaponAugristReplica extends WeaponNanoSword;

#exec OBJ LOAD FILE="..\Textures\Effects.utx"

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

state DownWeapon
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_None;

	}
}

state Idle
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_Steady;
	}
}

auto state Pickup
{
	function EndState()
	{
		Super.EndState();
		LightType = LT_None;
	}
}

function AugExp()
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

	DeusExPlayer(Owner).ReducedDamageType = 'Burned';
	HurtRadius(explosionDamage, explosionRadius, 'Burned', explosionDamage*100, Location);
}

defaultproperties
{
     InventoryGroup=111867
     ItemName="Augrist Replica"
	 ItemArticle="an"
     Description="A strange, ancient triad weapon. You would be hard pressed finding out anything else about it."
     beltDescription="AUGRIST"
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
	 MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(4)=FireTexture'Effects.Electricity.Wepn_EMPG_SFX'
     MultiSkins(5)=FireTexture'Effects.Electricity.Wepn_EMPG_SFX'
	 MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
	 MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     LightHue=128
}
