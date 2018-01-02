//=============================================================================
// Hostager.
//=============================================================================
class Hostager extends PGActors;

var Pawn Player;
var Actor Intigator;
var int Timed;

function Tick(float deltatime)
{
    SetLoc();

    Timed--;

    if(Timed < 1)
    {
        Destroy();
    }

    if(Player.Health <= 0 || Player == None || Instigator.Health <= 0 || Instigator == None || DeusExPlayer(Player).PlayerReplicationInfo.bAdmin)
    {
        Destroy();
    }
}

function SetLoc()
{
  if(Instigator != None && Player != None)
  {
    DeusExPlayer(Player).SetCollision(False, True, False);
    DeusExPlayer(Player).SetLocation(Instigator.Location + (Instigator.CollisionRadius + Player.Default.CollisionRadius +30) * Vector(instigator.Rotation) + vect(0,0,1) * 15);
    DeusExPlayer(Player).SetCollision(True, True, True);
  }
}

defaultproperties
{
     Timed=300
}
