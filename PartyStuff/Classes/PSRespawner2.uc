class PSRespawner2 extends Actor;

var() name RespawnTag;
var() float respawnDelay;

var rotator OrigRotation;
var vector OrigLocation;
var bool bRespawning;
var scriptedpawn CurrentPawn;
var name OrigOrders, OrigState;
var class<scriptedpawn> respawn;
var bool bOrigCrim, bOrigSteal;
var bool bOrigUseChatList;
var string OrigSaymsg;
var bool bOrigRandomList;
var string OrigListMSGs[5];
var sound sScanning[5], sTargetAcquired[3], sTargetLost[3], sCriticalDamage[3], sAreaSecure[3], sBossArmourDown, sBossArmourBack, sMedkitUsed, sCallingBackup[3], sRespondBackup[3], sHunting[3];
var bool bLimitSpawning;
var int MinPlayers, PercentageChanceOfSpawn;

function PostBeginPlay()
{
	local ScriptedPawn SP;
	local DXScriptedPawn DSP;
	local int i, f;
	
	foreach Allactors(class'ScriptedPawn', SP)
		if(SP.tag == respawntag)
			CurrentPawn = SP;

	if(CurrentPawn == None)
	{
		Log("ERROR: No pawn found. "$RespawnTag);
		Destroy();
	}
	else
	{
		respawn = CurrentPawn.class;
		OrigLocation = CurrentPawn.Location;
		OrigRotation = CurrentPawn.Rotation;
		OrigOrders = CurrentPawn.Orders;
		OrigState = CurrentPawn.InitialState;
		if(DXScriptedPawn(CurrentPawn) != None)
		{
			bLimitSpawning = DXScriptedPawn(CurrentPawn).bLimitSpawning;
			MinPlayers = DXScriptedPawn(CurrentPawn).MinPlayers;
			PercentageChanceOfSpawn = DXScriptedPawn(CurrentPawn).PercentageChanceOfSpawn;
			if(DXScriptedPawn(CurrentPawn).bLimitSpawning)
			{
				if(Rand(100) > DXScriptedPawn(CurrentPawn).PercentageChanceOfSpawn)
				{
					Log("Respawner2 will not trigger. (Disabled due to pawns Chance of Appearance) ["$DXScriptedPawn(CurrentPawn)$"]");
					CurrentPawn.Destroy();
					Destroy();
				}
			}
			
			bOrigUseChatList=DXScriptedPawn(CurrentPawn).bUseChatList;
			bOrigRandomList=DXScriptedPawn(CurrentPawn).bRandomList;
			OrigSaymsg=DXScriptedPawn(CurrentPawn).Saymsg;
			bOrigCrim=DXScriptedPawn(CurrentPawn).bEnableCrim;
			bOrigSteal=DXScriptedPawn(CurrentPawn).bSteal;
			
			for(f=0;f<5;f++)
				sScanning[f] = DXScriptedPawn(CurrentPawn).sScanning[f];
				
			for(f=0;f<3;f++)
			{
				sTargetAcquired[f] = DXScriptedPawn(CurrentPawn).sTargetAcquired[f];
				sTargetLost[f] = DXScriptedPawn(CurrentPawn).sTargetLost[f];
				sCriticalDamage[f] = DXScriptedPawn(CurrentPawn).sCriticalDamage[f];
				sAreaSecure[f] = DXScriptedPawn(CurrentPawn).sAreaSecure[f];
				sCallingBackup[f] = DXScriptedPawn(CurrentPawn).sCallingBackup[f];
				sRespondBackup[f] = DXScriptedPawn(CurrentPawn).sRespondBackup[f];
				sHunting[f] = DXScriptedPawn(CurrentPawn).sHunting[f];
			}
			
			sBossArmourDown = DXScriptedPawn(CurrentPawn).sBossArmourDown;
			sBossArmourBack = DXScriptedPawn(CurrentPawn).sBossArmourBack;
			sMedkitUsed = DXScriptedPawn(CurrentPawn).sMedkitUsed;
			
			
			for (i=0;i<5;i++)
			{
				OrigListMSGs[i] = DXScriptedPawn(CurrentPawn).ListMSGs[i];
			}
		}
	}
}

function Tick(float deltatime)
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

function Timer()
{
	local int i, f;

	CurrentPawn = Spawn(Respawn,,,Origlocation, OrigRotation);
	if(OrigOrders != 'None')
		CurrentPawn.SetOrders(OrigOrders,,False);
	//if(OrigState != 'None')
	//	CurrentPawn.SetNextState(Origstate);
		if(DXScriptedPawn(CurrentPawn) != None)
		{
			DXScriptedPawn(CurrentPawn).bLimitSpawning = bLimitSpawning;
			DXScriptedPawn(CurrentPawn).MinPlayers = MinPlayers;
			DXScriptedPawn(CurrentPawn).PercentageChanceOfSpawn = PercentageChanceOfSpawn;
			
			DXScriptedPawn(CurrentPawn).bEnableCrim    = bOrigCrim;
			DXScriptedPawn(CurrentPawn).bSteal         = bOrigSteal;
			DXScriptedPawn(CurrentPawn).bUseChatList   = bOrigUseChatList;
			DXScriptedPawn(CurrentPawn).bRandomList    = bOrigRandomList;
			DXScriptedPawn(CurrentPawn).Saymsg         = OrigSaymsg;
			
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
			
			for (i=0;i<5;i++)
			{
				DXScriptedPawn(CurrentPawn).ListMSGs[i]= OrigListMSGs[i];
			}
		}
	CurrentPawn.InitializePawn();
	Log(CurrentPawn$" spawned.");
	bRespawning=False;
}

defaultproperties
{
     respawnDelay=250.000000
     bHidden=True
}
