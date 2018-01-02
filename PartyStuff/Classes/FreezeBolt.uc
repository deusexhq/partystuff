//=============================================================================
// FreezeBolt.
//=============================================================================
class FreezeBolt extends Rocket;

simulated function SpawnRocketEffects()
{
	//does nothing here
}

auto simulated state Flying
{
	function Tick(float deltaTime)
	{
		Local SizableEffectSpawner efs;

		efs = Spawn(class'SizableEffectSpawner',,,Location);
		if (efs != None)
		{
			efs.EffectClass=class'MagicRing';
			efs.EffectSkin = Texture'BlueRay';
			efs.SizeofEffect = 1;
			efs.NumberSpawns = 1;
			efs.Interval = 0;
			efs.EffectLSpan = 1.0;
   		}
	}

	simulated function ProcessTouch (Actor Other, Vector HitLocation)
	{
		local ScriptedPawn pawn;		
		local FrozenPerson fperson;
		local int i;
		local DeusExDecoration deco;
		local DeusExCarcass carcass;

		if (bStuck)
			return;


		if (DeusExDecoration(Other) != None || ScriptedPawn(Other) != None || DeusExCarcass(Other) != None)
		{
			pawn = ScriptedPawn(Other);
			deco = DeusExDecoration(Other);
			carcass = DeusExCarcass(Other);
	
			fperson = Spawn(class'FrozenPerson',,,Other.Location);
			fperson.SetCollisionSize(Other.CollisionRadius,Other.CollisionHeight);
			fperson.Texture = Other.Texture;
			fperson.Mesh=Other.Mesh;
			fperson.Mass=Other.Mass;

			for (i=0;i<8;i++)
			{
				if ((Other.MultiSkins[i]==Texture'DeusExItems.Skins.GrayMaskTex')
					|| (Other.MultiSkins[i]==Texture'DeusExItems.Skins.PinkMaskTex')
						|| (Other.MultiSkins[i]==Texture'DeusExItems.Skins.BlackMaskTex'))
				{
					fperson.MultiSkins[i]=Other.MultiSkins[i];
				}
				else
					fperson.MultiSkins[i] = Texture'IceTex';
			}
			fperson.setRotation(Other.Rotation);
			Other.Destroy();			
			Destroy();
		}
		
	}

	simulated function HitWall(vector HitNormal, actor Wall)
	{
		if (bStickToWall)
		{
			Velocity = vect(0,0,0);
			Acceleration = vect(0,0,0);
			SetPhysics(PHYS_None);
			bStuck = False;
			destroy();

			// MBCODE: Do this only on server side
			if ( Role == ROLE_Authority )
			{
				if (Level.NetMode != NM_Standalone)
				SetTimer(5.0,False);

				if (Wall.IsA('Mover'))
				{
					SetBase(Wall);
					Wall.TakeDamage(Damage, Pawn(Owner), Wall.Location, MomentumTransfer*Normal(Velocity), damageType);
				}
			}
		}

		if (Wall.IsA('BreakableGlass'))
		bDebris = False;
		AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, blastRadius*24);
		SpawnEffects(Location, HitNormal, Wall);

		Super.HitWall(HitNormal, Wall);
	}
}

defaultproperties
{
     bExplodes=False
     bBlood=False
     bDebris=False
     blastRadius=0.000000
     bTracking=False
     ItemName="FreezeBolt"
     speed=500.000000
     MaxSpeed=1000.000000
     SpawnSound=None
     ImpactSound=None
     Mesh=None
     DrawScale=1.000000
     SoundRadius=0
     SoundVolume=0
     AmbientSound=None
}
