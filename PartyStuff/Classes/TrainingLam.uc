//=============================================================================
// LAM.
//=============================================================================
class TrainingLAM extends ThrownProjectile;

var float	mpBlastRadius;
var float	mpProxRadius;
var float	mpLAMDamage;
var float	mpFuselength;

simulated function Tick(float deltaTime)
{
	local float blinkRate;

	Super.Tick(deltaTime);

	if (bDisabled)
	{
		Skin = Texture'BlackMaskTex';
		return;
	}

	// flash faster as the time expires
	if (fuseLength - time <= 0.75)
		blinkRate = 0.1;
	else if (fuseLength - time <= fuseLength * 0.5)
		blinkRate = 0.3;
	else
		blinkRate = 0.5;

   if ((Level.NetMode == NM_Standalone) || (Role < ROLE_Authority) || (Level.NetMode == NM_ListenServer))
   {
      if (Abs((fuseLength - time)) % blinkRate > blinkRate * 0.5)
         Skin = Texture'BlackMaskTex';
      else
         Skin = Texture'LAM3rdTex1';
   }
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
simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Level.NetMode != NM_Standalone )
	{
		blastRadius=mpBlastRadius;
		proxRadius=mpProxRadius;
		Damage=mpLAMDamage;
		fuseLength=mpFuselength;
		bIgnoresNanoDefense=True;
	}
}

defaultproperties
{
     mpBlastRadius=512.000000
     mpProxRadius=128.000000
     mpFuselength=1.500000
     fuseLength=3.000000
     proxRadius=128.000000
     blastRadius=384.000000
     spawnWeaponClass=Class'PartyStuff.WeaponTrainingLam'
     ItemName="Training Lightweight Attack Munition (TLAM)"
     speed=1000.000000
     MaxSpeed=1000.000000
     MomentumTransfer=50000
     ImpactSound=Sound'DeusExSounds.Weapons.LAMExplode'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     LifeSpan=0.000000
     Mesh=LodMesh'DeusExItems.LAMPickup'
     CollisionRadius=9.000000
     CollisionHeight=9.000000
     Mass=5.000000
     Buoyancy=2.000000
}
