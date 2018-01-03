//
//	InvulnSphere is the effect on the Nintendo Immunity in multiplayer
//
class NaxSphere extends SphereEffect;

var ScriptedPawn AttachedPlayer;

function GoDoon()
{
	local vector EndTrace, HitLocation, HitNormal;

	// trace down to our feet
	EndTrace = Location - CollisionHeight * 2 * vect(0,0,1);

	SetLocation(EndTrace);
}

simulated function Tick(float deltaTime)
{
	local ScriptedPawn myPlayer;

   if (AttachedPlayer == None)
   {
      Destroy();
      return;
   }
   SetLocation(AttachedPlayer.Location);
	DrawScale+=0.5;
	Scaleglow-=0.01;
}

defaultproperties
{
     LifeSpan=6.000000
     CollisionHeight=20.000000
}
