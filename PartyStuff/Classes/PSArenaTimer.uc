class PSArenaTimer extends PGActors;

var PSArenaZone Zoney;

function Timer()
{
	Zoney.Kombat();
}

function Tick(float deltatime)
{
	local DeusExPlayer DXP;
	local DXEnemy Enemies;
	
	if(Zoney == None)
		Destroy();
		
	if(Zoney.bRunning && Zoney.CountPlayers() == 0)
		Zoney.EndMatch(false);
	if(Zoney.bRunning && Zoney.CountEnemy() == 0)
		Zoney.EndMatch(True);
}

defaultproperties
{
}
