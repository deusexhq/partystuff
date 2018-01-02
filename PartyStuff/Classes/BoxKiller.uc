class BoxKiller extends Rocket;

state Exploding
{
	ignores ProcessTouch, HitWall, Explode;

   function DamageRing()
   {
		local Pawn apawn;
		local float damageRadius;
		local Vector dist;
		local ProjectileGenerator Projy;
	
		local box bawks;
		local ScriptedPawn pwn;

	foreach VisibleActors(class'Box',bawks,blastRadius)
	{
		bawks.lifespan = 0.1;
	}
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

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
local box player;
local ScriptedPawn pwn;

	foreach VisibleActors(class'Box',player,100)
	{
		player.Destroy();
	}
}

defaultproperties
{
}
