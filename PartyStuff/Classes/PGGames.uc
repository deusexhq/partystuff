//=============================================================================
// PGGames
//=============================================================================
class PGGames extends Mutator Config (TCMod);

var DeusExPlayer LastSeeker, Seeker, GameMaster, PGPlayerList[16];
var int randy, PlayerCount, ScavengerItemCount, HideRound, ScavengerRound, GuessRound, ClueCount, HuntRound, ScoundrelRound, FlagsRound, failedGuesses, Captures, MurderRound, MurderTarget;
//Hide and Seek, Scavenger, Guess, Hunt, Scoundrel, Capture, Murderer
var bool bHSOn, bSOn, bGOn, bHOn, bScOn, bCOn, bMOn;
var bool bHidePhase; 
var string SavedGuess;
var ScoundrelManager SM;
var DeusExPlayer Murderer;

function BeepToAll(string str)
{
	local DeusExPlayer DXP;
	
	foreach allactors(class'DeusExPlayer',DXP)
	{
		DXP.ClientMessage(str,'Say');
	}
}

function BeepToAdmins(string str)
{
	local DeusExPlayer DXP;
	
	foreach allactors(class'DeusExPlayer',DXP)
	{
		if(DXP.bAdmin)
		{
			DXP.ClientMessage("|P2ADMIN: "$str,'TeamSay');	
		}	
	}
}

function ModifyPlayer(Pawn Other)
{
	local int x;
	local int k;
	local int i;
	local int m;
	local DeusExPlayer P;
	local PGSeeker ccc;
	local inventory inv;
		P = DeusExPlayer(Other);

	if(P==Seeker)
	{
		inv=Spawn(class'PGSeeker');
		Inv.Frob(Seeker,None);	  
		Inventory.bInObjectBelt = True;
		inv.Destroy();
	}

	   Super.ModifyPlayer(Other);
}

function Tick(float deltatime)
{
local PGSItem PGSI;
local int myCount;
local DeusExPlayer DXP;
local PGSeeker PGS;
local PGHiderActors PGH;
local inventory inv;
local HideFailActor Fail;

	if(bScOn)
	{
		if(SM == None)
		{
			BroadcastMessage("ScoundrelManager not in play, disabling.");
			bScOn=False;		
		}

	}
	
	foreach AllActors(class'HideFailActor',Fail)
	{
		if(Fail != None)
		{
			if(Fail.BadPlayer == Seeker)
			{
				bHSOn=False;
				LastSeeker = Seeker;
				Seeker = None;
				Fail.Destroy();
				
				foreach allactors(class'PGSeeker',PGS)
				{
					PGS.Destroy();
				}			
				
				foreach allactors(class'PGHiderActors',PGH)
				{
					PGH.Destroy();
				}
				
				foreach allactors(class'DeusExPlayer',DXP)
				{
					if(!DXP.isinState('Spectating'))
					{
						DXP.bHidden=False;
						DXP.SetPhysics(PHYS_Falling);			
					}
				}
				BeepToAll("|P3Hide and Seek round "$HideRound$" has ended due to seeker failure.");	
			}
		}
	}
}

function PostBeginPlay ()
{
	Level.Game.BaseMutator.AddMutator (Self);
	bHSOn=False;
	bSOn=False;
	bGOn=False;
	bHOn=False;
	bScOn=False;
	bCOn=False;
	bMOn=False;
	HideRound = 0;
	ScavengerRound = 0;
	GuessRound = 0;
	ScoundrelRound = 0;
	FlagsRound = 0;
	HuntRound = 0;
	ClueCount = 0;
	failedGuesses = 0;
	Captures=0;
	MurderRound=0;
	SavedGuess = "";
	//super.PostBeginPlay();
}

function Timer()
{
local PGSItem PGSI;
local int myCount;
local DeusExPlayer DXP;
local PGSeeker PGS;
local PGHiderActors PGH;
local inventory inv;

	if(bHSOn && bHidePhase)
	{
		bHidePhase=False;
		BeepToAll("Hiding phase is over.");
		
		foreach allactors(class'DeusExPlayer',DXP)
		{
				if(!DXP.isinState('Spectating'))
				{
					DXP.bHidden=False;
				}
		}
		inv=Spawn(class'PGSeeker');
		Inv.Frob(Seeker,None);	  
		Inventory.bInObjectBelt = True;
		inv.Destroy();
		Seeker.SetPhysics(PHYS_Falling);
		SetTimer(2,False);
	}
	
	if(bHSOn && !bHidePhase)
	{
		myCount=0;
		foreach allactors(class'DeusExPlayer',DXP)
		{
				if(!DXP.isinState('Spectating'))
				{
					myCount++;
				}
		}
		foreach AllActors(class'PGHiderActors',PGH)
		{
			myCount--;
		}
		myCount--; //Negative one for the Seeker
		
		if(myCount <= 0)
		{
			bHSOn=False;
			LastSeeker = Seeker;
			Seeker = None;
			foreach allactors(class'PGSeeker',PGS)
			{
				PGS.Destroy();
			}			
			
			foreach allactors(class'PGHiderActors',PGH)
			{
				PGH.Destroy();
			}
			BeepToAll("|P3Hide and Seek round "$HideRound$" has ended.");
		}
		else if(myCount >= 1)
		{
			SetTimer(2,False);
		}	
	}
	
	if(bSOn)
	{
		myCount=0;
		foreach AllActors(class'PGSItem',PGSI)
		{
			myCount++;
		}
		
		if(myCount == 0)
		{
			bSOn=False;
			
			foreach AllActors(class'PGSItem',PGSI)
			{
				PGSI.Destroy();
			}
			
			BeepToAll("|P2Scavenger Hunt round "$ScavengerRound$" has ended.");	
		}
		else if(myCount >= 1)
		{
			SetTimer(2,False);
		}	
	}

	if(bMOn)
	{
		GiveMurdererInv();
		GiveSurviveInv();
		BeepToAll("Begin the hunt.");
			foreach AllActors(class'DeusExPlayer', DXP)
			{
				if(Murderer == DXP)
				{
					DXP.ClientMessage("|P2You are the murderer. "$MurderTarget$" kills to win.");
				}
			}
	}
}

function Mutate (String S, PlayerPawn PP)
{
	local int ID, JSlot;
	local string part, pg;
	local Pawn APawn;
	local DeusExPlayer DXP;
	local Inventory inv;
	local PGSItem PGSI;
	local int myCount;
	local PGSeeker PGS;
	local PGHiderActors PGH;
	local psRepeater rep;
	local CaptureFlag CFlag;
	local CaptureFlagSpawner CF;
	Super.Mutate (S, PP);
	
		if(S ~= "GameList")
		{
		BroadcastMessage("|P1GAMES: |P3HIDE|P1, |P3SCAVENGER|P1, |P3GUESS|P1, |P4SCOUNDREL|P1, |P2CAPTURE|P1, |P2HUNT|P1, |P2MURDER|P1.");
		BroadcastMessage("|P2<UNPLAYABLE> |P3<COMPLETE> |P4<EXPERIMENTAL>");
		}
		
		if(S ~= "GameCommands")
		{
		BroadcastMessage("|P4HideStart, GuessStart, Guess, GuessClue, ScoundrelStart, ScavengerStart, MurderStart. MurderEnd");
		BroadcastMessage("|P4HideEnd, GuessEnd, ScoundrelEnd, ScavengerEnd, ScavengerCount, HideCount, GetSeeker, CaptureStart, CaptureEnd");
		BroadcastMessage("|P4Games, GameList");
		}
		
		if(S ~= "Games")
		{
			if(bGOn)
			{
				BroadcastMessage("Guessing game is active! [Round "$GuessRound$"]");
				BeepToAll("Game Starter: "$GameMaster.PlayerReplicationInfo.PlayerName);
				pg = left(SavedGuess,ClueCount);
				myCount = Len(SavedGuess);
				BeepToAll("Current Clue: "$pg);
				BroadcastMessage("Failed Guesses:"@failedGuesses);
				if(ClueCount >= 3)
				{
					BroadcastMessage(myCount$" characters long.");
				}
			}
			
			if(bHSOn)
			{
				BroadcastMessage("Hide and Seek is active! [Round "$HideRound$"]");
				BeepToAll("Seeker: "$Seeker.PlayerReplicationInfo.PlayerName);
				myCount=0;
				foreach allactors(class'DeusExPlayer',DXP)
				{
					if(!DXP.isinState('Spectating'))
					{
					myCount++;
					}
				}
				foreach AllActors(class'PGHiderActors',PGH)
				{
					myCount--;
				}
				myCount--; //Negative one for the Seeker
				BroadcastMessage(myCount$" hiders remaining.");
				if(bHidePhase)
				{
					BroadcastMessage("Currently in hiding phase.");
				}
			}
			
			if(bSOn)
			{
				BeepToAll("Scavenger hunt is active! [Round "$ScavengerRound$"]");
				myCount=0;
				foreach AllActors(class'PGSItem',PGSI)
				{
					myCount++;
				}		
				BroadcastMessage(myCount$" items remaining.");
			}
			
			if(bScOn)
			{
				BeepToAll("Scoundrel hunt is active! [Round "$ScoundrelRound$"]");				
			}
					
			if(bCOn)
			{
				BeepToAll("Capture is running!");				
			}
			if(bMOn)
			{
				BeepToAll("Murder is running!");				
			}			
		}
		
		if(S ~= "ScoundrelStart" && PP.bAdmin) 
		{
			bScOn=True;
			ScoundrelRound++;
			BroadcastMessage("Scoundrel starting! [Round "$ScoundrelRound$"]");
			SM = spawn(class'ScoundrelManager',,,Location,);
			SM.myRef = Self;
		}
		
		if(S ~= "ScoundrelEnd" && bScOn) 
		{
			bScOn=False;
			SM.CloseGame();
		}	
				
		if(left(S,11) ~= "GuessStart " && !bGOn)
        {
			PG = Right(S, Len(S) - 11);
			bGOn=True;
			SavedGuess = PG;
			GameMaster = DeusExPlayer(PP);
			ClueCount=0;
			PP.ClientMessage("CLIENT: "$SavedGuess$" answered locked in.");
			GuessRound++;
			BeepToAll("|P2Guessing game has begun. [Round "$GuessRound$"]");
			BroadcastMessage("|P2"$GameMaster.PlayerReplicationInfo.PlayerName$" has locked in an answer. ["$len(SavedGuess)$" characters]");
		}
	
		if(S ~= "GuessEnd" && bGOn && (PP == GameMaster || PP.bAdmin))
        {
			bGOn=False;
			ClueCount = 0;
			failedGuesses = 0;
			SavedGuess = "";
			GameMaster = None;
			BeepToAll("|P2Guessing game has ended. [Round "$GuessRound$"]");
		}
	
		if(left(S,6) ~= "Guess " && bGOn && PP != GameMaster)
        {
          //  PG = Right(S, Len(S) - 6),InStr(S," "));
			PG = Right(S, Len(S) - 6);
				if(PG ~= SavedGuess)
				{
					BeepToAll("|P3"$DeusExPlayer(PP).PlayerReplicationInfo.PlayerName$" guessed "$PG$" ["$len(PG)$"]");
					BroadcastMessage(PG$" was correct! ["$failedGuesses$" incorrect guesses this round]");
					DeusExPlayer(PP).PlayerReplicationInfo.Score += 10;
					bGOn=False;
					ClueCount = 0;
					failedGuesses = 0;
					SavedGuess = "";
					GameMaster = None;
					BroadcastMessage("|P2Guessing game has ended. [Round "$GuessRound$"]");					
				}
				else
				{
					BroadcastMessage("|P2"$DeusExPlayer(PP).PlayerReplicationInfo.PlayerName$" guessed "$PG$". ["$len(PG)$"]");
					BeepToAll(PG$" was incorrect!");
					failedGuesses++;
					DeusExPlayer(PP).PlayerReplicationInfo.Score -= 1;
					if(failedGuesses == 2 || failedGuesses == 5 || failedGuesses == 10 || failedGuesses == 20 || failedGuesses == 30)
					{
						ClueCount++;
						pg = left(SavedGuess,ClueCount);
						myCount = Len(SavedGuess);
						BroadcastMessage("Clue was given: "$pg);
						if(ClueCount >= 3)
						{
							BroadcastMessage(myCount$" characters long.");
						}
					}
				}

		}
		
		if(S ~= "GuessClue" && bGOn && PP == GameMaster)
        {
			ClueCount++;
			pg = left(SavedGuess,ClueCount);
			myCount = Len(SavedGuess);
			BeepToAll("Clue was given: "$pg);
			if(ClueCount >= 3)
			{
				BroadcastMessage(myCount$" characters long.");
			}
		}
		
		if(S ~= "HideStart" && !bHSOn  ) 
		{
			bHSOn=True;

			Seeker = DeusExPlayer(PP);

			foreach allactors(class'DeusExPlayer',DXP)
			{
				if(!DXP.isinState('Spectating'))
				{
				DXP.bHidden=True;
				}
			}
			Seeker.bHidden=False;
			Seeker.SetPhysics(PHYS_None);
			HideRound++;
			BeepToAll("|P2Hide and Seek game has begun. [Round "$HideRound$"]");
			BroadcastMessage(Seeker.PlayerReplicationInfo.PlayerName$" is now a Seeker.");
			BroadcastMessage("HIDE PHASE: Players are invisible, seeker is locked in position.");
			bHidePhase=True;
			SetTimer(60,False);
		}
		
		if(S ~= "GetSeeker" && bHSOn && DeusExPlayer(PP) == Seeker)
		{		
			inv=Spawn(class'PGSeeker');
			Inv.Frob(Seeker,None);	  
			Inventory.bInObjectBelt = True;
			inv.Destroy();	
		}
		
		if(S ~= "HideEnd" && bHSOn && DeusExPlayer(PP).bAdmin)
		{
		bHSOn=False;
		LastSeeker = Seeker;
		Seeker = None;
			foreach allactors(class'PGSeeker',PGS)
			{
				PGS.Destroy();
			}			
			
			foreach allactors(class'PGHiderActors',PGH)
			{
				PGH.Destroy();
			}
			foreach allactors(class'DeusExPlayer',DXP)
			{
				if(!DXP.isinState('Spectating'))
				{
					DXP.bHidden=False;
					DXP.SetPhysics(PHYS_Falling);			
				}
			}
			BeepToAll("|P3Hide and Seek round "$HideRound$" has ended.");
		}
				
		if(S ~= "ScavengerStart" && !bSOn && DeusExPlayer(PP).bAdmin)
		{
			//ResetScores();
			ScavengerItemCount=0;
			foreach AllActors(class'PGSItem',PGSI)
			{
				ScavengerItemCount++;
				PGSI.bActive=True;
			}
				if(ScavengerItemCount == 0)
				{
					BroadcastMessage("Scavenger Hunt could not begin! :: No Items Placed.");
					return;
				}
			bSOn=True;
			ScavengerRound++;
			BeepToAll("|P2Scavenger Hunt game has begun. [Round "$ScavengerRound$"]");
			BroadcastMessage(ScavengerItemCount$" items to find.");
			SetTimer(2,False);
		}
		
		if(S ~= "ScavengerEnd" && bSOn && DeusExPlayer(PP).bAdmin)
		{
			bSOn=False;
			
			foreach AllActors(class'PGSItem',PGSI)
			{
				PGSI.Destroy();
			}
			
			BroadcastMessage("|P2Scavenger Hunt round "$ScavengerRound$" has ended.");
		}
		
		if(S ~= "ScavengerCount" && bSOn) 
		{

			myCount=0;
			foreach AllActors(class'PGSItem',PGSI)
			{
				myCount++;
			}		
			BroadcastMessage(myCount$" items remaining.");
		}
		
		if(S ~= "HideCount" && bHSOn)
		{
			myCount=0;
			foreach allactors(class'DeusExPlayer',DXP)
			{
				if(!DXP.isinState('Spectating'))
				{
				myCount++;
				}
			}
			foreach AllActors(class'PGHiderActors',PGH)
			{
				myCount--;
			}
			myCount--; //Negative one for the Seeker
			BroadcastMessage(myCount$" hiders remaining.");
		}
		
		if(S ~= "MurderStart" && !bMOn && !bHSOn)
		{
			BroadcastMessage("There's a murderer among you...");
			SelectMurderer();
			bMOn=True;
			MurderRound++;
		}

		if(S ~= "MurderEnd" && bMOn)
		{
		
		}
		
		if(S ~= "CaptureStart" && !bCOn)
		{
			Captures++;
			BroadcastMessage("Starting Capture. [Round "$Captures$"]");
			bCOn=True;
			foreach AllActors(class'CaptureFlagSpawner',CF)
				CF.SetTimer(10,False);
		}

		if(S ~= "CaptureEnd" && bCOn)
		{
			bCOn=False;
			foreach AllActors(class'CaptureFlag',CFlag)
				CFlag.Destroy();
		}
		
		if( DeusExPlayer(PP).bAdmin && S ~= "ClearScore"  && !bHSOn  && !bSOn && !bGOn && !bScOn && !bMOn )
		{
			BeepToAll("Scoreboard reset.");
			ResetScores();
		}
}

function SelectMurderer()
{
local int i, u, k;
    local Pawn APawn;
//Pass one, count the player numbers
	for(APawn = level.PawnList; APawn != none; APawn = APawn.nextPawn)
        if(APawn.bIsPlayer && !APawn.IsInState('Spectating'))
            if(PlayerPawn(APawn) == none || NetConnection(PlayerPawn(APawn).Player) != none)
				i++;
				
	BeepToAll(i$" players. Randomizing selection.");
	k = Rand(i);
	BeepToAll(string(k));
	
	for(APawn = level.PawnList; APawn != none; APawn = APawn.nextPawn)
        if(APawn.bIsPlayer && !APawn.IsInState('Spectating'))
            if(PlayerPawn(APawn) == none || NetConnection(PlayerPawn(APawn).Player) != none)
			{
				if(u == k)
				{	
					Murderer = DeusExPlayer(APawn);
					BeepToAll("Selection process ended.");
					SetTimer(10,False);
					MurderTarget=i;
				}
				else
				{
					u++;
				}
			}
}

function GiveSurviveInv()
{
local inventory inv;
    local Pawn APawn;
	for(APawn = level.PawnList; APawn != none; APawn = APawn.nextPawn)
		if(APawn.bIsPlayer)
			if(PlayerPawn(APawn) == none || NetConnection(PlayerPawn(APawn).Player) != none)
			{
				if(DeusExPlayer(APawn) != Murderer)
				{
					/*HDisarm(DeusExPlayer(APawn));
					inv=Spawn(class'WeaponSurviveKnife');
					Inv.Frob(DeusExPlayer(APawn),None);	  
					Inventory.bInObjectBelt = True;
					inv.Destroy();

					inv=Spawn(class'WeaponSurvivePistol');
					Inv.Frob(DeusExPlayer(APawn),None);	  
					Inventory.bInObjectBelt = True;
					inv.Destroy();*/
				}
			}
}

function GiveMurdererInv()
{
local inventory inv;
    local Pawn APawn;
	for(APawn = level.PawnList; APawn != none; APawn = APawn.nextPawn)
		if(APawn.bIsPlayer)
			if(PlayerPawn(APawn) == none || NetConnection(PlayerPawn(APawn).Player) != none)
			{
				if(DeusExPlayer(APawn) == Murderer)
				{
					HDisarm(DeusExPlayer(APawn));
				/*	inv=Spawn(class'WeaponMurderKnife');
					Inv.Frob(DeusExPlayer(APawn),None);	  
					Inventory.bInObjectBelt = True;
					inv.Destroy();

					inv=Spawn(class'WeaponMurderPistol');
					Inv.Frob(DeusExPlayer(APawn),None);	  
					Inventory.bInObjectBelt = True;
					inv.Destroy();*/
				}
			}
}

function HDisarm(DeusExPlayer Other)
{
local DeusExWeapon w;
  foreach allactors(class'DeusExWeapon',W)
	{
		if(W.Owner == Other)
		{
			W.Destroy();
		}
	}
}

function ResetScores()
{
local PlayerReplicationInfo PRI;
	foreach allactors(class'PlayerReplicationInfo',PRI)
	{
		PRI.Score = 0;
		PRI.Deaths = 0;
		PRI.Streak = 0;
	}
}

defaultproperties
{
bHidden=True
}
