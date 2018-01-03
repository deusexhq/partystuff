//=============================================================================
// TzBallSwitch.
//=============================================================================
class TzBallSwitch extends Switch2;

var bool bOn;
var() int MaxBalls;
var vector SpawnPointBB;

replication
{
   reliable if (Role == ROLE_Authority)
      MaxBalls, ShowMessage;
} 

function BeginPlay()
{
	local TzBallSpawnPoint SPB;
	
	foreach AllActors(class'TzBallSpawnPoint',SPB)
	{
		SpawnPointBB = SPB.Location;
		return;
	}
}

function Frob(Actor Frobber, Inventory frobWith)
{
	local BasketballMP BMP;
	local int AmountOfBalls;
	Super.Frob(Frobber, frobWith);
	SetOwner(Frobber);
	
	foreach AllActors(class'BasketballMP',BMP)
	{
			AmountOfBalls++;
	}
	if (AmountOfBalls <= MaxBalls)
	{
		Spawn(Class'BasketballMP',self,,SpawnPointBB);
	}
	else 
	{
		ShowMessage(DeusExPlayer(Frobber),"There are enough balls!"); 
	}
	
	if (bOn)
	{
		PlaySound(sound'Switch4ClickOff');
		PlayAnim('Off');
	}
	else
	{
		PlaySound(sound'Switch4ClickOn');
		PlayAnim('On');
	}

	bOn = !bOn;
}

simulated function ShowMessage(DeusExPlayer Player, string Message)
{
  local HUDMissionStartTextDisplay    HUD;
  if ((Player.RootWindow != None) && (DeusExRootWindow(Player.RootWindow).HUD != None))
  {
    HUD = DeusExRootWindow(Player.RootWindow).HUD.startDisplay;
  }
  if(HUD != None)
  {
    HUD.shadowDist = 0;
    HUD.Message = "";
    HUD.charIndex = 0;
    HUD.winText.SetText("");
    HUD.winTextShadow.SetText("");
    HUD.displayTime = 5.50;
    HUD.perCharDelay = 0.30;
    HUD.AddMessage(Message);
    HUD.StartMessage();
  }
}

defaultproperties
{
     MaxBalls=3
     ItemName="Press to bring more balls!"
}
