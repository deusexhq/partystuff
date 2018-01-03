//=============================================================================
// PSZoneInfo
//=============================================================================
class PSArenaZone extends ZoneInfo;

var() int Payout;
var() bool bRunning;
var() music myTrack;
var() EMusicTransition Transition;
var() byte             SongSection;
var() byte             CdTrack;
var() name PSATags[10];
var() class<DXEnemy> EnemiesGroupOne[10];
var() class<DXEnemy> EnemiesGroupTwo[10];
var() class<DXEnemy> EnemiesGroupThree[10];
var() class<DXEnemy> EnemiesGroupFour[10];
var() class<DXEnemy> EnemiesGroupFive[10];
var() name EntryButtonTag, ExitButtonTag, StartButtonTag;
var PSArenaTimer PST;

function BeginMatch()
{
	local PSArenaExitSwitch PSAEx;
	local PSArenaEntrySwitch PSAEn;

	BroadcastMessage("Beginning match with "$CountPlayers()$" players!");
	PST = Spawn(class'PSArenaTimer');
	PST.SetTimer(5,False);
	PST.Zoney = Self;
		
	foreach AllActors(class'PSArenaExitswitch', PSAEx)
		if(PSAEx.Tag == ExitButtonTag)
			PSAEx.bPSActive=False;
	foreach AllActors(class'PSArenaEntryswitch', PSAEn)
		if(PSAEn.Tag == EntryButtonTag)
			PSAEn.bPSActive=False;	

}

function Kombat()
{
	local int i;
	local PSArenaSpawner PSA;
	local DeusExPlayer DXP;
	local int p;
	p = Rand(5);
	
	foreach ZoneActors(class'DeusExPlayer', DXP)
		DXP.ClientSetMusic( myTrack, SongSection, CdTrack, Transition );
	if(p == 0)
		for(i=0;i<10;i++)
			foreach AllActors(class'PSArenaSpawner', PSA)
				if(PSA.Tag == PSATags[i])
					Spawn(EnemiesGroupOne[i],,,PSA.Location);
	if(p == 1)
		for(i=0;i<10;i++)
			foreach AllActors(class'PSArenaSpawner', PSA)
				if(PSA.Tag == PSATags[i])
					Spawn(EnemiesGroupTwo[i],,,PSA.Location);

	if(p == 2)
		for(i=0;i<10;i++)
			foreach AllActors(class'PSArenaSpawner', PSA)
				if(PSA.Tag == PSATags[i])
					Spawn(EnemiesGroupThree[i],,,PSA.Location);
					
	if(p == 3)
		for(i=0;i<10;i++)
			foreach AllActors(class'PSArenaSpawner', PSA)
				if(PSA.Tag == PSATags[i])
					Spawn(EnemiesGroupFour[i],,,PSA.Location);
					
	if(p == 4)
		for(i=0;i<10;i++)
			foreach AllActors(class'PSArenaSpawner', PSA)
				if(PSA.Tag == PSATags[i])
					Spawn(EnemiesGroupFive[i],,,PSA.Location);
	
		bRunning=True;
}

function int CountPlayers()
{
	local int i;
	local DeusExPlayer DXP;
	foreach ZoneActors(class'DeusExPlayer', DXP)
		if(!DXP.IsInState('Spectating'))
			i++;
		
	return i;
}

function int CountEnemy()
{
	local int i;
	local DXEnemy DXP;
	foreach ZoneActors(class'DXEnemy', DXP)
		i++;
		
	return i;
}

function EndMatch(bool bWon)
{
	local PSArenaExit AE;
	local DeusExPlayer DXP;
	local DXEnemy DXE;
	local PSArenaExitSwitch PSAEx;
	local PSArenaEntrySwitch PSAEn;
	local PSArenaStartSwitch PSAEs;
	local int realpay;
	
	realpay = payout / countplayers();
	if(bWon)
	{
		BroadcastMessage("Match over! Players win! "$payout$" credits split among the players. ("$realpay$" each)");
		foreach ZoneActors(class'DeusExPlayer', DXP)
		{
			if(!DXP.IsInState('Spectating'))
			{
				DXP.Credits += realpay;
				foreach AllActors(class'PSArenaExit', AE)
				{
					DXP.SetCollision(false, false, false);
					DXP.bCollideWorld = true;
					DXP.GotoState('PlayerWalking');
					DXP.SetLocation(AE.location);
					DXP.SetCollision(true, true , true);
					DXP.SetPhysics(PHYS_Walking);
					DXP.bCollideWorld = true;
					DXP.GotoState('PlayerWalking');
					DXP.ClientReStart();	
				}
			}
		}
	}
	else
	{
		BroadcastMessage("Match over! Players defeated.");
		foreach ZoneActors(class'DXEnemy', DXE)
			DXE.Destroy();
		
	}
	
	PST.Destroy();
	bRunning=False;
	foreach AllActors(class'PSArenaExitswitch', PSAEx)
		if(PSAEx.Tag == ExitButtonTag)
			PSAEx.bPSActive=True;
	foreach AllActors(class'PSArenaEntryswitch', PSAEn)
		if(PSAEn.Tag == EntryButtonTag)
			PSAEn.bPSActive=True;	
	foreach AllActors(class'PSArenaStartswitch', PSAEs)
		if(PSAEs.Tag == StartButtonTag)
			PSAEs.bPSActive=True;
}

defaultproperties
{
}
