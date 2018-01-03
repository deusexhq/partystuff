//=============================================================================
// RocketHostage.
//=============================================================================
class RocketHostage extends RocketMini;

auto state Flying
{
  simulated function ProcessTouch(actor Other, vector HitLocation)
  {
    local Hostager Hostaged;
    local Hostager Selector;
    local int FoundSelect;

    FoundSelect = 0;

    if(Other.IsA('Pawn') && Other != Instigator)
    {
      foreach AllActors(Class'Hostager', Selector)
      {
        if(Selector != None)
        {
          if(Selector.Instigator == Instigator || Selector.Player == Pawn(Other))
          {
            FoundSelect = 1;
          }
        }
      }
      if(FoundSelect == 0)
      {
        Hostaged = Spawn(class'Hostager');
        if(Hostaged != none)
        {
          Hostaged.Player = DeusExPlayer(Other);
          Hostaged.SetOwner(DeusExPlayer(Other));
          Hostaged.Instigator = Instigator;
        }
      }
    }
    Super.ProcessTouch(Other, HitLocation);
  }
}

simulated function ProcessTouch(actor Other, vector HitLocation)
{
  local Hostager Hostaged;
  local Hostager Selector;
  local int FoundSelect;

  FoundSelect = 0;

  if(Other.IsA('DeusExPlayer') && Other != Instigator)
  {
    foreach AllActors(Class'Hostager', Selector)
    {
      if(Selector != None)
      {
        if(Selector.Instigator == Instigator || Selector.Player == Pawn(Other))
        {
          FoundSelect = 1;
        }
      }
    }
    if(FoundSelect == 0)
    {
      Hostaged = Spawn(class'Hostager');
      if(Hostaged != none)
      {
        Hostaged.Player = DeusExPlayer(Other);
        Hostaged.SetOwner(DeusExPlayer(Other));
        Hostaged.Instigator = Instigator;
      }
    }
  }
  Super.ProcessTouch(Other, HitLocation);
}

defaultproperties
{
     bExplodes=False
     Damage=0.000000
}
