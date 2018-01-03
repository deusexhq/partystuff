//=============================================================================
// WeaponHostageGun.
//=============================================================================
class WeaponHostageGun extends WeaponGEPGun;

simulated function CycleAmmo()
{
  local Hostager Selector;
  foreach AllActors(class 'Hostager', Selector)
  {
    if(Selector != None)
    {
      if(Selector.Instigator == Instigator)
      {
        Selector.Destroy();
        DeusExPlayer(Owner).ClientMessage(GetDisplayString(Selector.Player)@"has been released.");
      }
    }
  }
}


function string GetDisplayString(Actor P)
{
	if(P.isA('DeusExPlayer'))
		return DeusExPlayer(p).PlayerReplicationInfo.PlayerName;
	else if(P.isA('ScriptedPawn'))
		return ScriptedPawn(P).FamiliarName;
	else if(P.isA('DeusExDecoration'))
		return DeusExDecoration(P).ItemName;
}

defaultproperties
{
     ProjectileClass=Class'RocketHostage'
     InventoryGroup=182
     ItemName="Hostage Weapon"
     Description="Blablabla takes people hostage blablabla."
     beltDescription="HOSTAGE"
}
