class PSRespawner extends Actor;

var() class<ScriptedPawn> Respawn;
var() name respawnOrders, respawnState;
var() float respawnDelay;
var() bool bForceState, bForceOrders;
var() bool bForceCrim, bForceSteal;
var() sound sScanning[5], sTargetAcquired[3], sTargetLost[3], sCriticalDamage[3], sAreaSecure[3], sBossArmourDown, sBossArmourBack, sMedkitUsed, sCallingBackup[3], sRespondBackup[3], sHunting[3];
var bool bLimitSpawning;
var int MinPlayers, PercentageChanceOfSpawn;

var bool bRespawning;
var scriptedpawn CurrentPawn;
var bool bInit;

function PostBeginPlay()
{
	local int f;
	
	CurrentPawn = Spawn(Respawn,,,location);
	/*if(bForceState)
		CurrentPawn.SetNextState(respawnState);*/
	
	if(bForceOrders)
		CurrentPawn.setOrders(respawnOrders,,False);
	
	if(bForceCrim && DXScriptedPawn(CurrentPawn) != None)
		DXScriptedPawn(CurrentPawn).bEnableCrim=True;
		
	if(bForceSteal && DXScriptedPawn(CurrentPawn) != None)
		DXScriptedPawn(CurrentPawn).bSteal=True;
	
	if(DXScriptedPawn(CurrentPawn) != None)
	{
		bLimitSpawning = DXScriptedPawn(CurrentPawn).bLimitSpawning;
		MinPlayers = DXScriptedPawn(CurrentPawn).MinPlayers;
		PercentageChanceOfSpawn = DXScriptedPawn(CurrentPawn).PercentageChanceOfSpawn;
		if(DXScriptedPawn(CurrentPawn).bLimitSpawning)
		{
			
			if(Rand(100) > DXScriptedPawn(CurrentPawn).PercentageChanceOfSpawn)
			{
				Log("Respawner will not trigger. (Disabled due to pawns Chance of Appearance) ["$DXScriptedPawn(CurrentPawn)$"]");
				Destroy();
				return;
			}

		}
			
		for(f=0;f<5;f++)
			DXScriptedPawn(CurrentPawn).sScanning[f] = sScanning[f];
		
		for(f=0;f<3;f++)
		{
			DXScriptedPawn(CurrentPawn).sTargetAcquired[f] = sTargetAcquired[f];
			DXScriptedPawn(CurrentPawn).sTargetLost[f] = sTargetLost[f];
			DXScriptedPawn(CurrentPawn).sCriticalDamage[f] = sCriticalDamage[f];
			DXScriptedPawn(CurrentPawn).sAreaSecure[f] = sAreaSecure[f];
			DXScriptedPawn(CurrentPawn).sCallingBackup[f] = sCallingBackup[f];
			DXScriptedPawn(CurrentPawn).sRespondBackup[f] = sRespondBackup[f];
			DXScriptedPawn(CurrentPawn).sHunting[f] = sHunting[f];
		}
		
		DXScriptedPawn(CurrentPawn).sBossArmourDown = sBossArmourDown;
		DXScriptedPawn(CurrentPawn).sBossArmourBack = sBossArmourBack;
		DXScriptedPawn(CurrentPawn).sMedkitUsed = sMedkitUsed;
	}
	CurrentPawn.InitializePawn();
	Log(CurrentPawn$" spawned. ("$bForceOrders$respawnOrders$") ("$bForceState$respawnState$")");
	bRespawning=False;
}

function Tick(float deltatime)
{
	if(!bInit)
	{
		if(CurrentPawn == None && !bRespawning)
		{
			SetTimer(3,False);
			bRespawning=True;
		}
		if(CurrentPawn != None)
		{
			if(CurrentPawn.IsInState('Dying') && !bRespawning)
			{
				SetTimer(3,False);
				bRespawning=True;
			}
		}
		bInit=True;
	}
	else
	{
		if(CurrentPawn == None && !bRespawning)
		{
			SetTimer(respawnDelay,False);
			bRespawning=True;
		}
		if(CurrentPawn != None)
		{
			if(CurrentPawn.IsInState('Dying') && !bRespawning)
			{
				SetTimer(respawnDelay,False);
				bRespawning=True;
			}
		}
	}
}

function Timer()
{
	local int f;
	
	CurrentPawn = Spawn(Respawn,,,location);
	/*if(bForceState)
		CurrentPawn.SetNextState(respawnState);*/
		
	if(bForceOrders)
		CurrentPawn.setOrders(respawnOrders,,False);
	
	if(bForceCrim && DXScriptedPawn(CurrentPawn) != None)
		DXScriptedPawn(CurrentPawn).bEnableCrim=True;
		
	if(bForceSteal && DXScriptedPawn(CurrentPawn) != None)
		DXScriptedPawn(CurrentPawn).bSteal=True;
	
	if(DXScriptedPawn(CurrentPawn) != None)
	{
		
			DXScriptedPawn(CurrentPawn).bLimitSpawning = bLimitSpawning;
			DXScriptedPawn(CurrentPawn).MinPlayers = MinPlayers;
			DXScriptedPawn(CurrentPawn).PercentageChanceOfSpawn = PercentageChanceOfSpawn;
			
			for(f=0;f<5;f++)
				DXScriptedPawn(CurrentPawn).sScanning[f] = sScanning[f];
			
			for(f=0;f<3;f++)
			{
				DXScriptedPawn(CurrentPawn).sTargetAcquired[f] = sTargetAcquired[f];
				DXScriptedPawn(CurrentPawn).sTargetLost[f] = sTargetLost[f];
				DXScriptedPawn(CurrentPawn).sCriticalDamage[f] = sCriticalDamage[f];
				DXScriptedPawn(CurrentPawn).sAreaSecure[f] = sAreaSecure[f];
				DXScriptedPawn(CurrentPawn).sCallingBackup[f] = sCallingBackup[f];
				DXScriptedPawn(CurrentPawn).sRespondBackup[f] = sRespondBackup[f];
				DXScriptedPawn(CurrentPawn).sHunting[f] = sHunting[f];
			}
			
			DXScriptedPawn(CurrentPawn).sBossArmourDown = sBossArmourDown;
			DXScriptedPawn(CurrentPawn).sBossArmourBack = sBossArmourBack;
			DXScriptedPawn(CurrentPawn).sMedkitUsed = sMedkitUsed;
	}
	CurrentPawn.InitializePawn();
	Log(CurrentPawn$" spawned. ("$bForceOrders$respawnOrders$") ("$bForceState$respawnState$")");
	bRespawning=False;
}

defaultproperties
{
	respawnDelay=250
	bHidden=True
	Respawn=class'eTerrorist'
}
