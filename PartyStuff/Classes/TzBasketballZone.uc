//=============================================================================
// TzBasketballZone.
//=============================================================================
class TzBasketballZone extends ZoneInfo;

event ActorEntered(actor Other)
{
local float avg;
	Super.ActorEntered(Other);
		if(DeusExPlayer(Other) != None)
	{
		DeusExPlayer(Other).StopPoison();
		DeusExPlayer(Other).ExtinguishFire();
		DeusExPlayer(Other).drugEffectTimer = 0;
		DeusExPlayer(Other).ReducedDamageType = 'All';
			if(DeusExPlayer(Other).Health < 100)
			{
					DeusExPlayer(Other).HealPlayer(100, True);
			}
	}
	if (Other.IsA('PlaygroundContainers') || Other.IsA('Box'))
	{
		avg = (DeusExDecoration(Other).CollisionRadius + DeusExDecoration(Other).CollisionHeight) / 2;
		DeusExDecoration(Other).Frag(DeusExDecoration(Other).fragType, vect(20,20,20), avg/20.0, avg/5 + 1);
		Other.Destroy();
	}
	else if (Other.IsA('DeusExDecoration'))
	{
		DeusExDecoration(Other).bInvincible=True;
	}
	else if (Other.IsA('SpyDrone') && !SpyDrone(Other).bDisabled)
	{
		DeusExPlayer(SpyDrone(Other).Owner).ForceDroneOff();
		SpyDrone(Other).bDisabled = True;
		SpyDrone(Other).SetPhysics(PHYS_Falling);
		SpyDrone(Other).bBounce = True;
		SpyDrone(Other).LifeSpan = 10.0;
		SpyDrone(Other).Spawn(class'SmokeTrail',,, Other.Location);
		Other.Spawn(class'SphereEffect',,, Other.Location);
	}
	else if (Other.IsA('ThrownProjectile') && !Other.IsA('BasketballMP'))
	{
		Other.TakeDamage(15, None, Other.Location, vect(0,0,0), 'EMP');
				Other.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
		Other.Spawn(class'SphereEffect',,, Other.Location);
				Other.Spawn(class'SmokeTrail',,, Other.Location);
		Other.LifeSpan = 10.0;
	}
	else if (Other.IsA('RocketLAW') || Other.IsA('HECannister20mm') || Other.isA('Rocket') || Other.isA('RocketWP')) 
	{
		Other.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
		Other.Spawn(class'SmokeTrail',,, Other.Location);
		Other.Spawn(class'SphereEffect',,, Other.Location);
				DeusExProjectile(Other).Destroy();
	}
	else if (Other.IsA('DeusExProjectile'))
	{
		Other.PlaySound(sound'ProdFire', SLOT_None,,,, 2.0);
		Other.Spawn(class'SphereEffect',,, Other.Location);
		DeusExProjectile(Other).Destroy();
	}
	else if (Other.IsA('ProjectileGenerator'))
	{
		ProjectileGenerator(Other).Destroy();
	}
	else if(Other.IsA('BasketballMP'))
	{
		if (BasketballMP(Other).bDoomedToDestroy)
		{
			BasketballMP(Other).bDoomedToDestroy = False;
			BasketballMP(Other).SetTimer(0,False);
		}
	}
}

event ActorLeaving(actor Other)
{
	Super.ActorLeaving(Other);
	DeusExPlayer(Other).ReducedDamageType = '';
	if(Other.IsA('BasketballMP'))
	{
		BasketballMP(Other).bDoomedToDestroy = True;
		BasketballMP(Other).SetTimer(15, False);
	}
}

defaultproperties
{
}
