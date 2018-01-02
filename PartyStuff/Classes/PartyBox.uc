//=============================================================================
// It drops weapons, good for any party.
//=============================================================================
class PartyBox extends Containers;

function Destroyed()
{
	local actor dropped;
	local class<actor> tempClass;
	local int i;
	local Rotator rot;
	local Vector loc;
	local TrashPaper trash;
	local Rat vermin;
	local int randy, randy2, randy3;
	// trace down to see if we are sitting on the ground
	loc = vect(0,0,0);
	loc.Z -= CollisionHeight + 8.0;
	loc += Location;

	if( (Pawn(Base) != None) && (Pawn(Base).CarriedDecoration == self) )
		Pawn(Base).DropDecoration();
		Randy = Rand(35);
		if(Randy == 1)
		{
			Contents=class'WeaponBioRifle';
		}
		if(Randy == 2)
		{
			Contents=class'WeaponEnergyAssault';
		}	
		if(Randy == 3)
		{
			Contents=class'WeaponLaserAssault';
		}		
		if(Randy == 4)
		{
			Contents=class'WeaponNeedler';
		}
		if(Randy == 5)
		{
			Contents=class'WeaponNeedler2';
		}
		if(Randy == 6)
		{
			Contents=class'WeaponPlasmaAssault';
		}	
		if(Randy == 7)
		{
			Contents=class'WeaponSpitRifle';
		}	
	
		if(Randy == 8)
		{
			Contents=class'WeaponDildo';
		}
		if(Randy == 9)
		{
			Contents=class'WeaponDragonsClaw';
		}	
		if(Randy == 10)
		{
			Contents=class'WeaponHeavyBeamSword';
		}		
		if(Randy == 11)
		{
			Contents=class'WeaponInflatableSword';
		}
		if(Randy == 12)
		{
			Contents=class'WeaponPlasmaSword';
		}
		if(Randy == 13)
		{
			Contents=class'WeaponThinSword';
		}
		if(Randy == 14)
		{
			Contents=class'WeaponBurnRifle';
		}		
		if(Randy == 15)
		{
			Contents=class'WeaponMomsKnife';
		}
		if(Randy == 16)
		{
			Contents=class'WeaponWPGrenade';
		}
		if(Randy == 17)
		{
			Contents=class'WeaponStealthShotgun';
		}
		if(Randy == 18)
		{
			Contents=class'MM';
		}
		if(Randy == 19)
		{
			Contents=class'WeaponSkullGun';
		}
		if(Randy == 20)
		{
			Contents=class'WeaponPhatRifle';
		}
		if(Randy == 21)
		{
			Contents=class'WeaponMagnum';
		}
		if(Randy == 22)
		{
			Contents=class'WeaponRailgun';
		}
		if(Randy == 23)
		{
			Contents=class'WeaponClaymore';
		}
		if(Randy == 24)
		{
			Contents=class'WeaponLightshow';
		}
		if(Randy == 25)
		{
			Contents=class'WeaponKnifeBomb';
		}
		if(Randy == 26)
		{
			Contents=class'WeaponNailgun';
		}
		if(Randy == 27)
		{
			Contents=class'WeaponBoxGun';
		}
		if(Randy == 28)
		{
			Contents=class'WeaponDePressurizer';
		}
		if(Randy >= 29)
		{
			TrollExplode();
		}
		tempClass = Contents;	

			loc = Location+VRand()*CollisionRadius;
			loc.Z = Location.Z;
			rot = rot(0,0,0);
			rot.Yaw = FRand() * 65535;
			dropped = Spawn(tempClass,,, loc, rot);
			if (dropped != None)
			{
				dropped.RemoteRole = ROLE_DumbProxy;
				dropped.SetPhysics(PHYS_Falling);
				dropped.bCollideWorld = true;
				dropped.Velocity = VRand() * 50;
				if ( inventory(dropped) != None )
					inventory(dropped).GotoState('Pickup', 'Dropped');
			}
}

function TrollExplode()
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
     HitPoints=10
     FragType=Class'DeusEx.WoodFragment'
     ItemName="Party Battle Weapon Box!"
     bBlockSight=True
     Skin=Texture'PartyBox'
     Mesh=LodMesh'DeusExDeco.CrateBreakableMed'
     CollisionRadius=34.000000
     CollisionHeight=24.000000
     Mass=50.000000
     Buoyancy=60.000000
}
