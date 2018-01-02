//=============================================================================
// Cloud.
//=============================================================================
class EstusCloud extends DeusExProjectile;

var bool bFloating;
var float cloudRadius;
var float damageInterval;
var vector CloudLocation; //to make sure location is updated w/o making it dumb proxy

replication 
{
	reliable if ( Role == ROLE_Authority )
		CloudLocation;
}

auto simulated state Flying
{
	function HitWall(vector HitNormal, actor Wall)
	{
		// do nothing
		Velocity = vect(0,0,0);
	}
	function ProcessTouch (Actor Other, Vector HitLocation)
	{
		// do nothing
	}
}

event ZoneChange(ZoneInfo NewZone)
{
	Super.ZoneChange(NewZone);

	// clouds can't live underwater, so kill us quickly if we enter the water
	if ((NewZone.bWaterZone) && (LifeSpan > 2.0))
		LifeSpan = 2.0;
}

function Timer()
{
}

simulated function Tick(float deltaTime)
{
	local float value;
	local float sizeMult;
   local float NewDrawScale;

   if (Role == ROLE_Authority)
      CloudLocation = Location;
   else
      SetLocation(CloudLocation);

	// don't Super.Tick() becuase we don't want gravity to affect the stream
	time += deltaTime;

	value = 1.0+time;
	if (MinDrawScale > 0)
		sizeMult = MaxDrawScale/MinDrawScale;
	else
		sizeMult = 1;

   // DEUS_EX AMSD Update drawscale less often in mp, to reduce bandwidth hit.
   // Effect won't look quite as good for listen server client... but will otherwise
   // help tremendously (one gas grenade was 3k a sec in traffic).
   NewDrawScale = (-sizeMult/(value*value) + (sizeMult+1))*MinDrawScale;

	if (Level.Netmode == NM_Standalone)
   {
      DrawScale = NewDrawScale;
   }
   else if (Level.Netmode == NM_Client)
   {
      DrawScale = NewDrawScale;
   }
   else if (Level.Netmode == NM_DedicatedServer)
   {
      //Do nothing
   }
   else
   {
      //On a listen server, just start it full size.
      DrawScale = (-sizeMult/(50*50) + (sizeMult+1))*MinDrawScale;
   }

//      DrawScale = (-sizeMult/(value*value) + (sizeMult+1))*MinDrawScale;
   if (Role == ROLE_Authority)	
      ScaleGlow = FClamp(LifeSpan*0.5, 0.0, 1.0);

	// make it swim around a bit at random
	if (bFloating)
	{
		Acceleration = VRand() * 15;
		Acceleration.Z = 0;
	}
}

defaultproperties
{
     cloudRadius=128.000000
     damageInterval=1.000000
     blastRadius=1.000000
     AccurateRange=100
     maxRange=100
     maxDrawScale=5.000000
     bIgnoresNanoDefense=True
     ItemName="Cloud"
     ItemArticle="a"
     speed=300.000000
     MaxSpeed=300.000000
     MomentumTransfer=100
     LifeSpan=1.000000
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=None
     DrawScale=0.010000
     bUnlit=True
     CollisionRadius=16.000000
     CollisionHeight=16.000000
          maxDrawScale=2.000000
     Texture=WetTexture'Effects.Smoke.Gas_Tear_A'
}
