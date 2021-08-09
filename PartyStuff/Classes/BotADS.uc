class BotADS extends Actor;

var Pawn P;
var int AdsEnergy;
var bool AdsUnlimited;

function Timer()
{
	local DeusExProjectile minproj;
	local float mindist;

	if(!AdsUnlimited && AdsEnergy <= 0)
		return;
	
	foreach P.VisibleActors(class'DeusExProjectile', minproj, 1028)
	{
		if (minproj != None && ValidProjectile(minProj))
		{
			mindist = VSize(P.Location - minproj.Location);
			
			if(!AdsUnlimited && AdsEnergy > 0)
				AdsEnergy--;

			if (mindist > 480 && mindist < 1028)
			{
				P.PlaySound(sound'GEPGunLock', SLOT_None,,,, 2.0);
			}
			
			if (mindist < 480)
			{
				minproj.bAggressiveExploded=True;
				minproj.Explode(minproj.Location, vect(0,0,1));
				P.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
			}
		}
	}

	if(P == None || P.Health <= 0)
		Destroy();
}

function bool ValidProjectile(DeusExProjectile proj)
{
   local bool bValidProj;

      if (Level.NetMode != NM_Standalone)
         bValidProj = !proj.bIgnoresNanoDefense;
      else
         bValidProj = (!proj.IsA('Cloud') && !proj.IsA('Tracer') && !proj.IsA('GreaselSpit') && !proj.IsA('GraySpit'));

      if (bValidProj)
      {
         // make sure we don't own it
         if (proj.Owner != P)
         {
			 // NEW: Ignore other "Enemy" class bots and our custom robots.
			if (DXEnemy(Proj.Owner) == None && DXRobot(Proj.Owner) == None)
			{
				// make sure it's moving fast enough
				if (VSize(proj.Velocity) > 100)
				{
				   return true;
				}
			}
         }
      }
}

defaultproperties
{
     bHidden=True
}
