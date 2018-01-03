//=============================================================================
// SmokeGrenade - by Deadalus08.
//=============================================================================
class SmokeGrenade extends ThrownProjectile;

var ParticleGenerator smokeGen;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Level.NetMode == NM_DedicatedServer)
		return;
   
   if(!bProximityTriggered)
	SpawnSmokeEffects();
}


function SpawnSmokeEffects()
{
	smokeGen = Spawn(class'ParticleGenerator', Self);
	if (smokeGen != None)
	{
      smokeGen.RemoteRole = ROLE_None;
		smokeGen.particleTexture = Texture'Effects.Smoke.SmokePuff1';
		smokeGen.particleDrawScale = 2.0;
		smokeGen.checkTime = 0.02;
		smokeGen.riseRate = 8.0;
		smokeGen.ejectSpeed = 5.0;
		smokeGen.particleLifeSpan = 4.0;
		smokeGen.bRandomEject = True;
		smokeGen.SetBase(Self);
	}
}

function Tick(float deltatime)
{
	super.Tick(deltatime);
	
	if(bProximityTriggered)
		smokeGen.Destroy();
	
}
//
// SpawnTearGas needs to happen on the server so the clouds are insync and damage is dealt out of them
//
function SpawnTearGas()
{
	local Vector loc;
	local SmokeCloud gas;
	local int i;

	if ( Role < ROLE_Authority )
		return;

	smokeGen.Destroy();
	
	for (i=0; i<blastRadius/8; i++)
	{
		if (FRand() < 0.9)
		{
			loc = Location;
			loc.X += FRand() * blastRadius - blastRadius * 0.5;
			loc.Y += FRand() * blastRadius - blastRadius * 0.5;
			loc.Z += FRand() * blastRadius/36;
			gas = spawn(class'SmokeCloud', None,, loc);
			if (gas != None)
			{
				gas.Velocity = vect(0,0,0);
				gas.Acceleration = vect(0,0,0);
				gas.DrawScale = FRand() * 3.0 + 7.0;
				gas.LifeSpan = FRand() * 10 + 30;				
				//gas.Texture=Texture'Effects.Smoke.SmokePuff1';
				if ( Level.NetMode != NM_Standalone )
					gas.bFloating = False;
				else
					gas.bFloating = True;
				gas.Instigator = Instigator;
			}
		}
	}
}

defaultproperties
{
     fuseLength=1.000000
     proxRadius=128.000000
     AISoundLevel=0.000000
     bBlood=False
     bDebris=False
     DamageType=TearGas
     spawnWeaponClass=Class'WeaponSmokeGrenade'
     ItemName="Gas Grenade"
     speed=1000.000000
     MaxSpeed=1000.000000
     Damage=10.000000
     MomentumTransfer=50000
     ImpactSound=Sound'DeusExSounds.Weapons.GasGrenadeExplode'
     LifeSpan=0.000000
     Mesh=LodMesh'DeusExItems.GasGrenadePickup'
     CollisionRadius=4.300000
     CollisionHeight=1.400000
     Mass=5.000000
     Buoyancy=2.000000
}
