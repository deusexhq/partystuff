//=============================================================================
// DartFlare.
//=============================================================================
class DartUtil extends Dart;

var float mpDamage;
var int Mode;
var Actor PullPawn;
var vector OwnerLocation, TargetLocation;
var int Grapvel;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
	if ( Level.NetMode != NM_Standalone )
		Damage = mpDamage;
}

function Grapple(bool bPulling)
{
	local vector loc, line, HitLocation, hitNormal;
	local Vector DVector;
	loc = Owner.Location;
	loc.Z += DeusExPlayer(Owner).BaseEyeHeight;
	line = Vector(DeusExPlayer(Owner).ViewRotation) * 90000;

	Trace(hitLocation, hitNormal, loc+line, loc, true);
	DVector = Owner.Location - Location;

	if(!bPulling)
	{
					DeusExPlayer(Owner).DoJump();
					DeusExPlayer(Owner).Velocity = (normal(Location - DeusExPlayer(Owner).Location) * GetVel());
					DeusExPlayer(Owner).SetPhysics(Phys_Falling);	
	}
	else
	{
					PullPawn.Velocity.Z = 180;
					PullPawn.SetPhysics(Phys_Falling);	
					PullPawn.Velocity = (normal(Owner.Location - PullPawn.Location) * GetVel());

	}
}

function int GetVel()
{
local WeaponUtilBow WUB;
	foreach AllActors(class'WeaponUtilBow', WUB)
	{
		if(WUB.Owner == Owner)
		{
		    return WUB.Grapvel;
		}
	}
}

function int GetJVel()
{
local WeaponUtilBow WUB;
	foreach AllActors(class'WeaponUtilBow', WUB)
	{
		if(WUB.Owner == Owner)
		{
		    return WUB.Jumpvel;
		}
	}
}

function BeginPlay()
{
local WeaponUtilBow WUB;
	foreach AllActors(class'WeaponUtilBow', WUB)
	{
		if(WUB.Owner == Owner)
		{
		    Mode = WUB.Mode;
		}
	}
}

function UseMode(int i)
{
local ClaymoreProj CP;
local DartFixture DF;
local DartJumpPad DP;
	if(i == 1)
	{
		SetCollision(false, false, false);
		bHidden=False;
		DF = Spawn(class'DartFixture',,,Location,Rotation);
		DF.bMovable=True;
		DF.SetLocation(Location);
		DF.SetRotation(Rotation);
		DF.bMovable=False;
	}
	if(i == 2)
	{
		SetCollision(false, false, false);
		bHidden=False;
		DP = Spawn(class'DartJumpPad',,,Location,Rotation);
		DP.bMovable=True;
		DP.SetLocation(Location);
		DP.SetRotation(Rotation);
		DP.bMovable=False;
		DP.Velz = GetJVel();
	}
}

auto simulated state Flying
{
	simulated function ProcessTouch (Actor Other, Vector HitLocation)
	{
		if (bStuck)
			return;

		if ((Other != instigator) && (DeusExProjectile(Other) == None) &&
			(Other != Owner))
		{
			damagee = Other;
			Explode(HitLocation, Normal(HitLocation-damagee.Location));

         // DEUS_EX AMSD Spawn blood server side only
         if (Role == ROLE_Authority)
			{
            if (damagee.IsA('Pawn') && !damagee.IsA('Robot') && bBlood)
               SpawnBlood(HitLocation, Normal(HitLocation-damagee.Location));
			   
			   if(Mode == 3)
			   {
				if(!damagee.bmovable)
					Grapple(False);
				else
				{
				PullPawn = Damagee;
				Grapple(True);
				}
			   }
			   else
			   {
			   		UseMode(mode);
				}
			}
		}
	}
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		if (bStickToWall)
		{
			Velocity = vect(0,0,0);
			Acceleration = vect(0,0,0);
			SetPhysics(PHYS_None);
			bStuck = True;

			// MBCODE: Do this only on server side
			if ( Role == ROLE_Authority )
			{
            if (Level.NetMode != NM_Standalone)
               SetTimer(5.0,False);

				if (Wall.IsA('Mover'))
				{
					SetBase(Wall);
						if(Mode == 0)
						{
							Wall.Trigger(Owner,DeusExPlayer(Owner));
							Destroy();
						}
				//	Wall.TakeDamage(Damage, Pawn(Owner), Wall.Location, MomentumTransfer*Normal(Velocity), damageType);
				}
			}
		}

		if (Wall.IsA('BreakableGlass'))
			bDebris = False;

		SpawnEffects(Location, HitNormal, Wall);
			 if(Mode == 3)
			   {
				Grapple(False);
			   }
			   else
			   {
			   		UseMode(mode);
				}
		Super.HitWall(HitNormal, Wall);
	}
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
		local bool bDestroy;
		local float rad;

      // Reduce damage on nano exploded projectiles
      if ((bAggressiveExploded) && (Level.NetMode != NM_Standalone))
         Damage = Damage/6;

		bDestroy = false;

		if (bExplodes)
		{
         //DEUS_EX AMSD Don't draw effects on dedicated server
         if ((Level.NetMode != NM_DedicatedServer) || (Role < ROLE_Authority))			
            DrawExplosionEffects(HitLocation, HitNormal);

			GotoState('Exploding');
		}
		else
		{
			// Server side only
			if ( Role == ROLE_Authority )
			{
				if ((damagee != None)) // Don't even attempt damage with a tracer
				{
					if ( Level.NetMode != NM_Standalone )
					{
						if ( damagee.IsA('DeusExPlayer') )
							DeusExPlayer(damagee).myProjKiller = Self;
					}
					damagee.TakeDamage(Damage, Pawn(Owner), HitLocation, MomentumTransfer*Normal(Velocity), damageType);
				}
			}
			if (!bStuck)
				bDestroy = true;
		}

		rad = Max(blastRadius*24, 1024);

		// This needs to be outside the simulated call chain
		PlayImpactSound();

      //DEUS_EX AMSD Only do these server side
      if (Role == ROLE_Authority)
      {
         if (ImpactSound != None)
         {
            AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, blastRadius*24);
            if (bExplodes)
               AISendEvent('WeaponFire', EAITYPE_Audio, 2.0, blastRadius*5);
         }
      }
		if (bDestroy)
			Destroy();
	}
	simulated function BeginState()
	{
		local DeusExWeapon W;

		initLoc = Location;
		initDir = vector(Rotation);	
		Velocity = speed*initDir;
		PlaySound(SpawnSound, SLOT_None);
	}
}

defaultproperties
{
     mpDamage=10.000000
     spawnAmmoClass=None
     ItemName="Utility Dart"
     Damage=5.000000
     bUnlit=True
     LightEffect=LE_Disco
     LightBrightness=255
     LightSaturation=50
     LightRadius=20
}
