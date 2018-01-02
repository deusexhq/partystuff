class KnifeBomb expands ThrownProjectile;

state Exploding
{
	ignores ProcessTouch, HitWall, Explode;

   function DamageRing()
   {
		local Pawn apawn;
		local float damageRadius;
		local Vector dist;
		local ProjectileGenerator Projy;
	
			projy = Spawn(class'ProjectileGenerator',,,Self.Location);
			projy.Lifespan=0.7;
			projy.EjectSpeed=400;
			projy.bRandomEject = True;
			projy.ProjectileClass=class'PoisonKnife';
			projy.NumPerSpawn=12;
		if ( Level.NetMode != NM_Standalone )
		{
			damageRadius = (blastRadius / gradualHurtSteps) * gradualHurtCounter;

			for ( apawn = Level.PawnList; apawn != None; apawn = apawn.nextPawn )
			{
				if ( apawn.IsA('DeusExPlayer') )
				{
					dist = apawn.Location - Location;
					if ( VSize(dist) < damageRadius )
					{
						if ( gradualHurtCounter <= 2 )
						{
							if ( apawn.FastTrace( apawn.Location, Location ))
								DeusExPlayer(apawn).myProjKiller = Self;
						}
						else
							DeusExPlayer(apawn).myProjKiller = Self;
					}
				}
			}
		}
      //DEUS_EX AMSD Ignore Line of Sight on the lowest radius check, only in multiplayer
		HurtRadius
		(
			(2 * Damage) / gradualHurtSteps,
			(blastRadius / gradualHurtSteps) * gradualHurtCounter,
			damageType,
			MomentumTransfer / gradualHurtSteps,
			Location,
         ((gradualHurtCounter <= 2) && (Level.NetMode != NM_Standalone))
		);
   }

	function Timer()
	{
		gradualHurtCounter++;
      DamageRing();
		if (gradualHurtCounter >= gradualHurtSteps)
			Destroy();
	}

Begin:
	// stagger the HurtRadius outward using Timer()
	// do five separate blast rings increasing in size
	gradualHurtCounter = 1;
	gradualHurtSteps = 5;
	Velocity = vect(0,0,0);
	bHidden = True;
	LightType = LT_None;
	SetCollision(False, False, False);
   DamageRing();
	SetTimer(0.25/float(gradualHurtSteps), True);
}


simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local int i;
	local SmokeTrail puff;
	local TearGas gas;
	local Fragment frag;
	local ParticleGenerator gen;
	local ProjectileGenerator projgen;
	local vector loc;
	local rotator rot;
	local ExplosionLight light;
	local DeusExDecal mark;
   local AnimatedSprite expeffect;

	rot.Pitch = 16384 + FRand() * 16384 - 8192;
	rot.Yaw = FRand() * 65536;
	rot.Roll = 0;

	// don't draw damage art on destroyed movers
	if (DeusExMover(Other) != None)
		if (DeusExMover(Other).bDestroyed)
			ExplosionDecal = None;

	if (ExplosionDecal != None)
	{
		mark = DeusExDecal(Spawn(ExplosionDecal, Self,, HitLocation, Rotator(HitNormal)));
		if (mark != None)
		{
			mark.DrawScale = FClamp(damage/30, 0.1, 3.0);
			mark.ReattachDecal();
         if (!bDamaged)
            mark.RemoteRole = ROLE_None;
		}
	}

	for (i=0; i<blastRadius/36; i++)
	{
		if (FRand() < 0.9)
		{
			if (bDebris && bStuck)
			{
				frag = spawn(FragmentClass,,, HitLocation);
				if (!bDamaged)
					frag.RemoteRole = ROLE_None;
				if (frag != None)
					frag.CalcVelocity(VRand(), blastRadius);
			}

			loc = Location;
			loc.X += FRand() * blastRadius - blastRadius * 0.5;
			loc.Y += FRand() * blastRadius - blastRadius * 0.5;

			if (damageType == 'Exploded')
			{
				light = Spawn(class'ExplosionLight',,, HitLocation);
				if ((light != None) && (!bDamaged))
					light.RemoteRole = ROLE_None;

				if (FRand() < 0.5)
				{
					expeffect = spawn(class'ExplosionSmall',,, loc);
					light.size = 2;
				}
				else
				{
					expeffect = spawn(class'ExplosionMedium',,, loc);
					light.size = 4;
				}
				if ((expeffect != None) && (!bDamaged))
					expeffect.RemoteRole = ROLE_None;
			}
			else if (damageType == 'EMP')
			{
				light = Spawn(class'ExplosionLight',,, HitLocation);
				if (light != None)
				{
					if (!bDamaged)
						light.RemoteRole = ROLE_None;
					light.size = 6;
					light.LightHue = 170;
					light.LightSaturation = 64;
				}
			}
		}
	}
}

defaultproperties
{
     fuseLength=1.000000
     proxRadius=128.000000
     spawnWeaponClass=Class'WeaponKnifeBomb'
     spawnAmmoClass=Class'AmmoKB'
     ItemName="Knife Bomb"
     speed=1500.000000
     ImpactSound=Sound'DeusExSounds.Generic.SmallExplosion2'
     Mesh=LodMesh'DeusExItems.EMPGrenadePickup'
}
