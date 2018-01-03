//=============================================================================
// SpazmGas.
//=============================================================================
class SpazmGas expands Cloud;

Var() float SpazDelay;

Function Tick(float Deltatime)
{
	local Float SpazTime;
	local DeusExPlayer Victim;
	local DeusExPlayer POwner;
	Local ScriptedPawn P;

	Super.Tick(Deltatime);

	SpazTime=DeltaTime;

	If(SpazTime>SpazDelay)
	{	
		POwner=DeusExPlayer(Owner);
	
			ForEach RadiusActors(class'DeusExPlayer',Victim,128,Self.Location)
			{
				if(Victim!=POwner&&Victim.IsInState('PlayerWalking'))
				{
					Victim.GoToState('FeigningDeath'); // Make the player collapse on the floor XD
					Victim.InHand=None;
				}
			}
			ForEach RadiusActors(class'ScriptedPawn',P,128,Self.location)
			{
				if(!P.IsA('Robot')&&!P.IsA('Animal')) // If this pawn isn't a robot...
				{
					P.GoToState('Stunned'); // Stun them directly, without damage. (Some are invunerable to stunning via damage)
				}
			}
		SpazTime=0.0;
	}
}

defaultproperties
{
    SpazDelay=0.00
    DamageType=Stunned
    Damage=0.00
    Sprite=WetTexture'Effects.Smoke.Gas_Poison_A'
    Texture=WetTexture'Effects.Smoke.Gas_Poison_A'
    Skin=WetTexture'Effects.Smoke.Gas_Poison_A'
}
