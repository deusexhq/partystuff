//=============================================================================
// ComputerPersonal.
//=============================================================================
class PSComputer extends DeusExDecoration;

//Username is the identifier of this machine, Password is used to execute commands
var() string Username, Password;
//Emails stored on this computer
var() string Messages[250];
//New idea for a like temporary mail used for system stuff
var() string Notifications[250];
//Tag of the PSZoneInfo class used for controlling that zones security
var() name ZoneTag;
//Enable debugging messages
var() bool bDebug;
var() string Group;
var() string InfoProp[16];
//Stuff thrown at the computer for storage
var class<inventory> StoredInv[10]; 

//Used for exec command, alias is the command, name is the tag of the event.
struct EvStr
{
var() config string EventAlias;
var() config name EventName;
};
var(Accounts) config EvStr pEvents[25];

var vector StoredLocation[10]; //Used for mark/recall
var int StoredCredits; //Used for the banking feature.
var DeusExPlayer pgUser; //Used to define the owner.
var PSComputerHandheld PSC; //Allow remote access, its a usable item that calls the functions from this, it executes frob for the player?
var string PrevCommand;

var float prevdist;
var Actor PrevpingA;

var() bool bCodebreakerEnabled;
var string Hax0rs[25];
var Actor Hax0rObj;
var int Hax0rStep;
var string generatedCode;

var() bool bOverdriver;
var string LastWord;
var int Stage;
var actor ODActor;

var() bool bFileManager;
var string CurFilePath;
var Actor FileActor;

function bool ParseHack(string Command)
{
	local Actor hitActor;
	local vector loc, line, HitLocation, hitNormal;
	local DeusExMover      hitMover;
	local DeusExDecoration hitDecoration;
	local ScriptedPawn		hitPawn;
	local DeusExPlayer	hitPlayer;

		if(Hax0rObj != None)
		{
			hitMover = DeusExMover(Hax0rObj);
			hitPawn = ScriptedPawn(Hax0rObj);
			hitDecoration = DeusExDecoration(Hax0rObj);
			hitPlayer = DeusExPlayer(Hax0rObj);
			if (hitMover != None)
			{
				if(Hax0rStep == 0)
				{
					if(Command ~= "debug()")
					{
						Hax0rStep=1;
						xAlert("Door", "event<<rundebug()|ncout>>'Debug mode enabled.'|n|nAny incorrect commands will end the session.|nhelp() for assistance.|nexit() to end session. (Menu will not close, must be closed manually.)");
						return true;
					}
					else if(Command ~= "exit()")
					{
						EndHack();
						return true;
					}
					else
						FailHack();
				}
				if(Hax0rStep == 1)
				{
					if(Command ~= "help()")
					{
						xAlert("Door", ">>> ELECTRONIC_DOOR (DEBUG)|ndebug() override() dumpcodes() exit()");
						return true;
					}
					else if(Command ~= "debug()")
					{
						xAlert("Door", ">>> ELECTRONIC_DOOR (DEBUG)|nDebug mode already active.|n<<ERROR");
						return true;
					}
					else if(Command ~= "Override()")
					{
						xAlert("Door", ">>> ELECTRONIC_DOOR (DEBUG)|nActivating override mode.|n>>cancel() to return to debug menu|n>>ELSE Input override code.");
						Hax0rStep = 2;
						return true;
					}
					else if(Command ~= "exit()")
					{
						EndHack();
						return true;
					}
					else
						FailHack();
				}
				if(Hax0rStep == 2)
				{
					if(Command ~= "cancel()")
					{
						xAlert("Door", ">>>Returning to debugging.");
						Hax0rStep = 1;
						return true;
					}
					else if(Command ~= generatedCode)
					{
						xAlert("Door", ">>> ELECTRONIC_DOOR (DEBUG)|nCode accepted.|nOverride mode enabled.|nEnter properties to modify.|nexit() to quit.");
						Hax0rStep = 3;
						return true;
					}
					else FailHack();
				}
				if(Hax0rStep == 3)
				{
					if(Command ~= "exit()")
						EndHack();
					else if(Command ~= "open()")
						hitMover.Trigger(pgUser, pgUser);
					/*else if( hitMover.GetPropertyText(caps(Command)) != "")
					{
						Hax0rStep=4;
					}*/
					else
					xAlert("Door", "Error in property...");
						
				}
			}
			else if (hitPawn != None)
			{
				if(Hax0rStep == 0)
				{
					if(Command ~= "debug()")
					{
						Hax0rStep++;
						pgUser.ClientMessage("event>>rundebug()");
						return true;
					}
					else
						FailHack();
				}
			}
			else if (hitDecoration != None)
			{
				if(Hax0rStep == 0)
				{
					if(Command ~= "debug()")
					{
						Hax0rStep++;
						pgUser.ClientMessage("event>>rundebug()");
						return true;
					}
					else
						FailHack();
				}
			}
			else if (hitPlayer != None)
			{
				if(Hax0rStep == 0)
				{
					if(Command ~= "debug()")
					{
						Hax0rStep++;
						pgUser.ClientMessage("event>>rundebug()");
						return true;
					}
					else
						FailHack();
				}
			}
		}
		else
			xAlert("ERROR", "Script failed... No object");
}

function FailHack()
{
	local int i;
	
	pgUser.TakeDamage(100, Pawn(Owner), Owner.Location, Vect(0,0,0), 'EMP');
	Hax0rObj = None;
	Hax0rStep = 0;
	for(i=0;i<25;i++)
		Hax0rs[i] = "";
}

function EndHack()
{
	local int i;
	
	Hax0rObj = None;
	Hax0rStep = 0;
	for(i=0;i<25;i++)
		Hax0rs[i] = "";
	
}

function bool ParseCommand(deusexplayer p, string inputPassword, string Command)
{
	local string mailstring, sendstring, target, msg;
	local int mailint,i, b;
	local bool bPassedCommand, bPassedMail, bFound;
	local actor a;
	local bool bSkipPass;
	local PSComputerReplicationActor f;
	local MenuUIMessageBoxWindow mes;
	local PSComputerHandheld toolz;
	local PSComputer PSComp;
	local Actor hitActor;
	local vector loc, line, HitLocation, hitNormal;
	local string redcode;
	
	if(bDebug)
	{
		Log(p.playerreplicationinfo.playername@username@inputpassword@command);
		P.ClientMessage(p.playerreplicationinfo.playername@username@inputpassword@command);
	}
	
	if(pgUser == P)
	{
		bSkipPass=True;
	}
		
	if(!bSkipPass && inputPassword != Password)
	{
		xAlert("Alert","ERROR: Incorrect password.", p);
		return false;
	}
	
	if(pgUser != P)
	{
		P.PlaySound(sound'Auth',,,, 256);
		pgUser = P;
		P.ClientMessage("Synced to computer.");
	}
	
	if(Command == "" && PrevCommand != "")
	{
		ParseCommand(pgUser, Password, PrevCommand);
		return true;
	}
		
	PrevCommand = Command;
	
	if(Left(command,7) ~= "redeem ")
	{
		mailstring = Right(command, Len(command)-instr(command,"redeem ")-Len("redeem "));
		if(mailstring == "wtfhax0rftw" && !bCodebreakerEnabled)
		{
			bCodebreakerEnabled = True;
			redcode = "_codebreaker (script.dat)|n [WARNING: This package is in testing and may not function properly.|nFunctionality may also change over time.] ";
			
		}

		if(mailstring == "overdose" && !bOverdriver)
		{
			bOverdriver = True;
			redcode = "_overdriver (overdriver.dat)|n [WARNING: This package is in testing and may not function properly.|nFunctionality may also change over time.] ";
			
		}

		if(mailstring == "boxx" && !bFileManager)
		{
			bFileManager = True;
			redcode = "_fileman (files.dat)|n [WARNING: This package is in testing and may not function properly.|nFunctionality may also change over time.] ";
			
		}
						
		if(redcode != "")
			xAlert("Redeemer", "Code redeemed successfully.|nThis code has activated the following system: "$redcode$"|nUse Help to access the info for the newly activated packages.");
		else
		xAlert("Error", "Code invalid or already redeemed.");
		bPassedCommand=True;
		return true;
	}
	
	if(command ~= "script")
	{
		if(bCodebreakerEnabled)
		{
			pgUser.PlaySound(sound'PhoneVoice3');
				loc = pgUser.Location;
				loc.Z += pgUser.BaseEyeHeight;
				line = Vector(pgUser.ViewRotation) * 4000;
				hitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);
				if(Hax0rObj == hitActor && !hitActor.isA('LevelInfo')) //Resuming?
				{
					xHack();
				}
				else if(hitActor != None && !hitActor.isA('LevelInfo')) //NewHack
				{
					Hax0rStep=0;
					for(i=0;i<25;i++)
						Hax0rs[i] = "";
					xHack();
				}
				else
					xAlert("ERROR", "Script failed, no object found.");
		}
		else xAlert("Error", "Your computer does not have the relevant access or software to perform this task.|nContact an administrator for assistance.");
		
		bPassedCommand=True;
		return true;
	}

	if(command ~= "overdriver")
	{
		if(bOverdriver)
		{
			pgUser.PlaySound(sound'PhoneVoice3');
				loc = pgUser.Location;
				loc.Z += pgUser.BaseEyeHeight;
				line = Vector(pgUser.ViewRotation) * 4000;
				hitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);

				if(hitActor != None && !hitActor.isA('LevelInfo')) //NewHack
				{
					LastWord = "";
					ODActor = hitActor;
					xOD();
				}
				else
					xAlert("ERROR", "Script failed, no object found.");
		}
		else xAlert("Error", "Your computer does not have the relevant access or software to perform this task.|nContact an administrator for assistance.");
	}

	if(command ~= "files")
	{
		if(bFileManager)
		{
			pgUser.PlaySound(sound'PhoneVoice3');
				loc = pgUser.Location;
				loc.Z += pgUser.BaseEyeHeight;
				line = Vector(pgUser.ViewRotation) * 4000;
				hitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);
				if(FileActor == hitActor && !hitActor.isA('LevelInfo')) //Resuming?
				{
					xFileMan();
				}
				else if(hitActor != None && !hitActor.isA('LevelInfo')) //NewHack
				{
					FileActor=hitActor;
					CurFilePath="/";
					xFileMan();
				}
				else
					xAlert("ERROR", "Script failed, no object found.");
		}
		else xAlert("Error", "Your computer does not have the relevant access or software to perform this task.|nContact an administrator for assistance.");
	}
		
	if(command ~= "me")
	{
		xAlert(Username,myData());
		bPassedCommand=True;
		return true;
	}
	if(Left(command,6) ~= "group ")
	{
		mailstring = Right(command, Len(command)-instr(command,"group ")-Len("group "));
		SetGroup(mailstring);
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,5) ~= "group")
	{
		ListComps(True);
		bPassedCommand=True;
		return true;
	}
		
	if(Left(command,4) ~= "info")
	{
		xAlert(pgUser.PlayerReplicationInfo.PlayerName$" info", InfoChk());
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,5) ~= "ping ")
	{
		mailstring = Right(command, Len(command)-instr(command,"ping ")-Len("ping "));
		PingLoc(mailstring);
		bPassedCommand=True;
		return true;
	}
		
	if(Left(command,3) ~= "chk")
	{
		ListNotif();
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,5) ~= "help ")
	{
		bPassedCommand=True;
		mailstring = Right(command, Len(command)-instr(command,"help ")-Len("help "));
		if(mailstring ~= "handheld")
			xAlert("Help", "Gives the Handheld Computer item which allows you to remotely access this computer.");
		else if(mailstring ~= "recall")
			xAlert("Help", "|P1Format: recall <number referring to the slot number>|n|P2Teleports you to that location.");
		else if(mailstring ~= "mark")
			xAlert("Help", "|P1Format: mark <number referring to the slot number>|n|P2Saves your current location in the slot number which is called by the recall command.|n|P7Best used from the handheld computer.");
		else if(mailstring ~= "dbg")
			xAlert("Help", "Toggles debugging messages.");
		else if(mailstring ~= "togglesec")
			xAlert("Help", "Toggles the Drone Security system.|n|P7Requires the Zone to be configured.");
		else if(mailstring ~= "togglealert")
			xAlert("Help", "Toggles the Drone Security system notifications, which alerts you if someone enters..|n|P7Requires the Zone to be configured.");
		else if(mailstring ~= "cred+")
			xAlert("Help", "|P1Format: cred+<number referring to the amount of credits>|n|P2Deposits credits in to the computer.");
		else if(mailstring ~= "cred-")
			xAlert("Help", "|P1Format: cred-<number referring to the amount of credits>|n|P2Withdraws credits from the computer.");
		else if(mailstring ~= "give")
			xAlert("Help", "|P1Format: give <number referring to the slot the object is in>|n|P2Withdraws the item from the computer.|n|P7Items are stored by throwing them at the computer.|nThe alert tells you which slot it saves to.|nThe item is not deleted. Refer to Clearitem.");
		else if(mailstring ~= "clearitem")
			xAlert("Help", "|P1Format: clearitem <number referring to the slot the object is in>|n|P2Removes the item from the computer.|n|P7Items are stored by throwing them at the computer.|nThe alert tells you which slot it saves to.");
		else if(mailstring ~= "setusername")
			xAlert("Help", "|P1Format: setusername <new username>|n|P2Sets this computers username.");
		else if(mailstring ~= "setpass")
			xAlert("Help", "|P1Format: setpass <new password>|n|P2Sets this computers password.");
		else if(mailstring ~= "alert")
			xAlert("Help", "|P1Format: alert <string>|n|P2Prints a message on screen.");
		else if(mailstring ~= "exec")
			xAlert("Help", "|P1Format: exec <string related to the alias stored>|n|P2Executes the command stored in the memory. |nUse getexec cmmand to show the list of current commands.");
		else if(mailstring ~= "mail")
			xAlert("Help", "|P1Format: mailsend <username> <message>: |P2Sends email to the computer labeled that username.|nmailread <number>: Reads mail in that slot.|nmaildel <number>: Deletes mail in that slot.|nmailclear, maillist, mailcount.|nmailgroup sends to your group.");
		else if(mailstring ~= "me")
			xAlert("Help", "|P1Format: me: |P2Shows basic computer information.");
		else if(mailstring ~= "ping")
			xAlert("Help", "|P1Format: ping <tag>: |P2Gives location to X object.");
		else if(mailstring ~= "script" && bCodebreakerEnabled)
			xAlert("Help", "|P1Format: script: |P2Enables script input for targetted object. [WIP]");
		else if(mailstring ~= "overdriver" && bOverdriver)
			xAlert("Help", "|P1Format: overdriver: |P2Dictionary override input for targetted object. [WIP]|nOverloads the target objects by brute forcing passwords.|nGives one word, enter another word that's first letter is the last words last letter.|ne.g. worm -> master -> rekked");
		else if(mailstring ~= "files" && bFileManager)
			xAlert("Help", "|P1Format: files: |P2Enables file manager for targetted object. [WIP]|nBrowser is command-line based.|nBrowser starts at ROOT:/|nCommands: list, cd, open");
		else xAlert("Help", "Could not find searched command.");
		return true;
		
	}	
	
	if(Left(command,4) ~= "help")
	{
		if(bCodebreakerEnabled)
			redcode = redcode$" script";
		if(bFileManager)
			redcode = redcode$" files";
		if(bOverdriver)
			redcode = redcode$" overdriver";
		
		if(redcode == "")
			redcode = "NONE";
			
		xAlert("Help Topics","handheld, recall, mark, dbg, togglesec, togglealert, cred+, cred-|n give, clearitem, setusername, setpass, alert, exec, mail, invs, locs, comps, group|nme, ping|n|P4EXTRA PACKAGES: "$redcode);
		bPassedCommand=True;
		return true;
	}
		
	if(Left(command,8) ~= "handheld")
	{
		GiveTool();
		xAlert("Alert","Given the Handheld tool.");
		bPassedCommand=True;
		return true;
	}

	if(Left(command,7) ~= "recall ")
	{
		mailint = int(Right(command, Len(command)-instr(command,"recall ")-Len("recall ")));
		if(StoredLocation[mailint] != vect(0,0,0))
		{
				pgUser.SetCollision(false, false, false);
				pgUser.bCollideWorld = true;
				pgUser.GotoState('PlayerWalking');
				pgUser.SetLocation(StoredLocation[mailint]);
				pgUser.SetCollision(true, true , true);
				pgUser.SetPhysics(PHYS_Walking);
				pgUser.bCollideWorld = true;
				pgUser.GotoState('PlayerWalking');
				pgUser.ClientReStart();
				xAlert("Alert","Sent to location.");
		}
		
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,5) ~= "mark ")
	{	
		mailint = int(Right(command, Len(command)-instr(command,"mark ")-Len("mark ")));
		
		StoredLocation[mailint] = pgUser.Location;
		xAlert("Alert","Marked location.");
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,3) ~= "dbg")
	{
		bDebug = !bDebug;
		xAlert("Alert","Debug is now "$bDebug$".");
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,4) ~= "test")
	{
		xAlert("Alert","Tested.");
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,5) ~= "comps")
	{
		ListComps();
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,4) ~= "locs")
	{
		ListLocs();
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,4) ~= "invs")
	{
		ListInv();
		bPassedCommand=True;
		return true;
	}	
	
	if(Left(command,9) ~= "togglesec")
	{
		ToggleSecurity(P);
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,11) ~= "togglealert")
	{
		ToggleAlert(P);
		bPassedCommand=True;
		return true;
	}
	
	if(Left(command,5) ~= "cred+")
	{
		mailint = int(Right(command, Len(command)-instr(command,"cred+")-Len("cred+")));
		bPassedCommand=True;
		
		if(mailint == -1)
		{
			StoredCredits += pgUser.Credits;
			pgUser.Credits = 0;
			xalert("Alert", "All credits deposited.|n"$StoredCredits$" currently stored.");
		}
		if(pgUser.Credits >= mailint)
		{
			pgUser.Credits -= mailint;
			StoredCredits += mailint;
			xalert("Alert", mailint$" credits deposited.|n"$StoredCredits$" currently stored.");
		}
		else
			xalert("Alert", "You don't have enough.");
		return true;
	}
	
	if(Left(command,5) ~= "cred-")
	{
		mailint = int(Right(command, Len(command)-instr(command,"cred-")-Len("cred-")));
		bPassedCommand=True;
		
		if(mailint == -1)
		{
			pgUser.Credits += StoredCredits;
			StoredCredits = 0;
			xalert("Alert", "All credits withdrawn.|n"$pgUser.Credits$" currently held.");
		}
		if(StoredCredits >= mailint)
		{
			StoredCredits -= mailint;
			pgUser.Credits += mailint;
			xalert("Alert", mailint$" credits withdrawn.|n"$pgUser.Credits$" currently held.");
		}
		else
			xalert("Alert", "You don't have enough.");
		return true;
	}	
	
	if(Left(command,5) ~= "give ")
	{
		mailint = int(Right(command, Len(command)-instr(command,"give ")-Len("give ")));
		bPassedCommand=True;
		if(StoredInv[mailint] != None)
		{
			SilentAdd(StoredInv[mailint],pgUser);
			bFound=True;
		}

		if(bFound)
			xalert("Alert", mailint@StoredInv[mailint]$" withdrawn.");
		else
			xalert("Alert", "Slot is empty.");
		return true;
	}
	
	if(Left(command,10) ~= "clearitem ")
	{
		mailint = int(Right(command, Len(command)-instr(command,"clearitem ")-Len("clearitem ")));
		bPassedCommand=True;
		if(StoredInv[mailint] != None)
		{
			SilentAdd(StoredInv[mailint],pgUser);
			bFound=True;
		}

		if(bFound)
			xalert("Alert", mailint$" cleared.");
		else
			xalert("Alert", "Slot is already empty.");
		return true;
	}	
	
	if(Left(command,6) ~= "alarm ")
	{
		bPassedCommand=True;
		mailstring = Right(command, Len(command)-instr(command,"alarm ")-Len("alarm "));
		if(bDebug)
			log("alarm:"@mailstring);
			
		if(instr(caps(mailstring), caps(":")) != -1)
		{
			xAlert("Alarm","[Unfinished command, doesnt yet function]|nSetting alarm for"@mailstring);
			//SetAlarm(mailstring);
		}
		else
		{
			xAlert("Alarm","Alarm string is badly formatted. Accepted format is HOUR:MINUTE.");
		}
			
	}
	
	if(Left(command,12) ~= "setusername ")
	{
		bPassedCommand=True;
		mailstring = Right(command, Len(command)-instr(command,"setusername ")-Len("setusername "));
		if(bDebug)
			log("setuser:"@mailstring);
			
			foreach AllActors(class'PSComputer',PSComp)
				PSComp.Notif(username$" changed their username to "$mailstring);
			xAlert("Info", "Setting username...|nPrevious: "$Username$"|nNew: "$mailstring);
			Username = mailstring;
			
	}
	
	if(Left(command,8) ~= "setpass ")
	{
		bPassedCommand=True;
		mailstring = Right(command, Len(command)-instr(command,"setpass ")-Len("setpass "));
		if(bDebug)
			log("setpass:"@mailstring);
			
			xAlert("Info", "Setting Password...|nPrevious: "$Password$"|nNew: "$mailstring);
			Password = mailstring;
			
	}
		
	if(Left(command,6) ~= "alert ")
	{
		bPassedCommand=True;
		mailstring = Right(command, Len(command)-instr(command,"alert ")-Len("alert "));
		if(bDebug)
			log("alert:"@mailstring);

			xAlert("Test", mailstring);
			
	}
	
	if(Left(command,5) ~= "exec ")
	{
		bPassedCommand=True;
		mailstring = Right(command, Len(command)-instr(command,"exec ")-Len("exec "));
		if(bDebug)
			log("exec:"@mailstring);
		
		for(i=0;i<25;i++)
		{
			if(mailstring ~= pEvents[i].EventAlias)
			{
				foreach AllActors(class'Actor', A)
				{
					if(A.Tag == pEvents[i].EventName)
					{
						b++;
						A.Trigger(self,pgUser);
						//pgUser.ClientMessage(pEvents[i].EventAlias$" triggered.");
					}
				}
			}
		}
		xAlert("Alert",b$" events triggered for "$mailstring);
	}
	
	if(Left(command,4) ~= "mail") //Add list to show all, and count to show how many
	{
		bPassedCommand=True;
		//mailstring is everything after mail, format mailsend x, mailread x
		mailstring = Right(command, Len(command)-instr(command,"mail")-Len("mail"));
		if(bDebug)
			log("mailer"@mailstring);
		if(Left(mailstring,6) ~= "group ")
		{
			//sendstring is everything after send, mailsend xxxxx
			msg = Right(mailstring, Len(mailstring)-instr(mailstring,"group ")-Len("group "));
			bPassedMail=True;
			GroupMail(msg);
			return true;
		}
		if(Left(mailstring,5) ~= "send ")
		{
			//sendstring is everything after send, mailsend xxxxx
			msg = Right(mailstring, Len(mailstring)-instr(mailstring,"send ")-Len("send "));
			bPassedMail=True;
			SendMail(msg);
			return true;
		}
		if(Left(mailstring,5) ~= "read ")
		{
			mailint = int(Right(mailstring, Len(mailstring)-instr(mailstring,"read ")-Len("read ")));
			bPassedMail=True;
			//p.clientmessage(ReadMail(mailint));
			xalert("Mail", readmail(mailint));
			return true;
		}
		if(Left(mailstring,4) ~= "del ")
		{
			mailint = int(Right(mailstring, Len(mailstring)-instr(mailstring,"del ")-Len("del ")));
			bPassedMail=True;
			DelMail(mailint);
			return true;
		}
		if(Left(mailstring,5) ~= "clear")
		{
			ClearMail();
			bPassedMail=True;
			return true;
		}
		if(Left(mailstring,4) ~= "list")
		{
			ListMail();
			bPassedMail=True;
			return true;
		}	
	
		if(!bPassedMail)
			xalert("Mail", "Mailer function not recognized.");
	}
	if(!bPassedCommand)
	xalert("Error", "Command not recognized.");
}

function Bump(actor Other)
{
	local int i;
	
	if(Inventory(Other) != None)
	{
		for(i=0;i<10;i++)
		{
			if(StoredInv[i] == None)
			{
				xAlert("Alert",Inventory(Other).itemName$" stored in slot "$i);
				StoredInv[i] = Inventory(Other).class;
				Other.Destroy();
				return;
			}
		}
	}

}

function string myData()
{
	return "Notifications: "$CountNotif()$"|nMail: "$CountMail(True)$"/"$CountMail()$"|nCredits "$StoredCredits;
}

function string InfoChk()
{
	local string str;
	local int k;
	str = "INFO";
	for(k=0;k<16;k++)
	{
		if(InfoProp[k] != "")
		{
			if(k==4 || k==8)
				str = str$", "$InfoProp[k]$"="$pgUser.GetPropertyText(InfoProp[k])$"|n";
			else
				str = str$", "$InfoProp[k]$"="$pgUser.GetPropertyText(InfoProp[k]);
		}
	}
	return str;
}

function string GRNFT(string in) //Get Readable Name From Tag
{
	local Actor A;
	foreach AllActors(class'Actor', A)
		if(string(A.Tag) == in)
		{
			if(DeusExDecoration(A) != None)
				return DeusExDecoration(A).itemName;
			else if(Inventory(A) != None)
				return Inventory(A).itemName;
			else if(ScriptedPawn(A) != None)
				return ScriptedPawn(A).FamiliarName;
			else if(DeusExPlayer(A) != None)
				return DeusExPlayer(A).PlayerReplicationInfo.PlayerName;
			else return in;
		}
}
function PingLoc(string ident)
{
	local PSComputer PST;
	local int k;
	local string str;
	local float dist;
	local string disttype;
	local Actor A;
	
		foreach AllActors(class'Actor',A)
		{
			if(string(a.Tag) ~= ident)
			{
				if(PrevPingA == A) //Repinging same actor
				{
					dist = VSize(a.Location - pgUser.Location);
					if(PrevDist != 0)
					{
						if(PrevDist > dist)
							disttype="("$dist$" - Closer than before)";
						else if(PrevDist < dist)
							disttype="("$dist$" - Further than before)";
						else
							disttype="("$dist$" - Same as before)";
					}
					else
					{
						disttype="("$dist$")";
					}
					
					PrevDist = dist;
					xAlert("Ping",GRNFT(ident)@disttype);
					PrevDist = dist;
				}
				else
				{
					PrevPingA = A;
					PrevDist = VSize(a.Location - pgUser.Location);
					xAlert("Ping", GRNFT(ident)@PrevDist);
				}
				
				

				
				
			}
		}	
}

function GiveTool()
{ 
	local PSComputerHandheld anItem;
	
	anItem = Spawn(class'PSComputerHandheld',,,pgUser.Location);
	anItem.SpawnCopy(pgUser);
	anItem.Destroy();
}

function SilentAdd(class<inventory> addClass, optional DeusExPlayer addTarget)
{ 
	local Inventory anItem;
	
	anItem = Spawn(addClass,,,addTarget.Location); 
	anItem.SpawnCopy(addTarget);
	anItem.Destroy();
}

function xAlert(string title, string msg, optional DeusExPlayer Target)
{
	local PSComputerReplicationactor f;

	foreach AllActors(class'PSComputerReplicationactor', f)
	{
		if(Target == None)
		{
			if(f.Flagger == pgUser)
				f.cAlert(title, msg);
		}
		else
		{
			if(f.Flagger == Target)
				f.cAlert(title, msg);
		}
	}
}

function xHack()
{
	local PSComputerReplicationactor f;

	foreach AllActors(class'PSComputerReplicationactor', f)
	{
			if(f.Flagger == pgUser)
				f.cMenuHack();
	}
}

function xOD()
{
	local PSComputerReplicationactor f;

	//foreach AllActors(class'PSComputerReplicationactor', f)
			//if(f.Flagger == pgUser)
				//f.cMenuOD();
}

function xFileMan()
{
	local PSComputerReplicationactor f;

	//foreach AllActors(class'PSComputerReplicationactor', f)
			//if(f.Flagger == pgUser)
			//	f.cMenuFiles();
}

function SendMail(string mailstring)
{
	local string sendstring, msg, target;
	local PSComputer PSC;
	local bool bFound;
	pgUser.PlaySound(sound'Send',,,, 256);
	//msg is everything after the first space in sendstring, or everything to the right of it
	msg = Right(mailstring, Len(mailstring)-instr(mailstring," ")-Len(" "));
	//Target is everything to the left of the first space, to be the username
	target = Left(Right(mailstring, Len(mailstring)),InStr(mailstring," "));
	//target = Left(sendstring, Len(sendstring)-instr(sendstring," "));
	if(bDebug)
	{
		log("mailstring:"@mailstring);
		log("Target:"@target);
		log("MSG:"@msg);
	}
	foreach AllActors(class'PSComputer', PSC)
	{
		if(PSC.Username ~= Target)
		{
			//pgUser.ClientMessage("|P3Message sent!");
			//pgUser.ClientMessage(Username$": "$Msg);
			xAlert("Mail","|P4Mail sent to "$Target$".|P1|n"$msg);
			Log(Username$" sent mail to "$Target$". ("$MSG$")");
			PSC.AddMail(Username, MSG);
			bFound=True;
		}
	}
	if(!bFound)
	{
		xAlert("Error", "|P3Message error: No computer found for that username. ["$Target$"]");
	}
}

function SetGroup(string newgroup)
{
	local string sendstring, msg, target, str;
	local PSComputer PSComp;
	local bool bFound;
	local int k;
	
	foreach AllActors(class'PSComputer', PSComp)
		if(PSComp.Group ~= Group && Group != "" && PSComp != Self)
			PSComp.Notif(username$" left your group! ("$group$")");

	Group = newgroup;
	
	foreach AllActors(class'PSComputer', PSComp)
	{
		if(PSComp.Group ~= Group && PSComp.Group != "" && PSComp != Self)
		{
			k++;
			
			if(k==6 || k==9)
				str = str$", "$PSComp.Username$"|n";
			else
				str = str$", "$PSComp.Username;
			
			PSComp.Notif(username$" joined your group! ("$group$")");
		}
	}
	xAlert("Group","Joined "$Group$".|n"$str);
}

function GroupMail(string mailstring)
{
	local string sendstring, msg, target;
	local PSComputer PSComp;
	local bool bFound;
	local int k;
	
	pgUser.PlaySound(sound'Send',,,, 256);

	
	foreach AllActors(class'PSComputer', PSComp)
	{
		if(PSComp.Group ~= Group)
		{
			//pgUser.ClientMessage("|P3Message sent!");
			//pgUser.ClientMessage(Username$": "$Msg);
			k++;
			Log(Username$" sent mail to "$PSComp.Username$" via group "$group$". ("$mailstring$")");
			PSComp.AddMail(Username$" ("$Group$")", mailstring);
		}
	}
	if(!bFound)
	{
		xAlert("Error", "|P3Message error: Group is empty.");
	}
	else
	{
		xAlert("Mail","|P4Mail sent to group "$k$" users in "$Group$" group.|P1|n"$mailstring);
	}
}

function AddMail(string User, string Msg)
{
	local int i;
	
	if(pgUser != None)
		xAlert("Mail","|P3You have mail!");
	for(i=0;i<250;i++)
	{
		if(Messages[i] == "")
		{
			Messages[i] = User$": "$Msg;
			return;
		}
	}
}

function Notif(string Msg)
{
	local int i;
	
	if(pgUser != None)
		xAlert("Alert","|P3You have new notifications!");
	for(i=0;i<250;i++)
	{
		if(Notifications[i] == "")
		{
			Notifications[i] = Msg;
			return;
		}
	}
}

function ListNotif()
{
	local int i, k;
	local string str;
	
	for(i=0;i<250;i++)
	{
		if(Notifications[i] != "")
		{
			while(k < 6)
			{
				k++;
				str = str$Notifications[i]$"|n";
				Notifications[i] = "";
			}
		}
	}

	
	xAlert(k$" notifications",str$" [END]");
}

function int CountNotif()
{
	local int i, k;

		for(i=0;i<250;i++)
		{
			if(Notifications[i] != "")
			{
				k++;
			}
		}
	return k;
}

function ClearMail()
{
	local int i, k;

	for(i=0;i<250;i++)
	{
		if(Messages[i] != "")
		{
			k++;
			Messages[i] = "";
		}
	}
	
	xAlert("Mail",k$" messages deleted.");
}

function ListLocs()
{
	local int i, k;
	local string str;
	for(i=0;i<10;i++)
	{
		if(StoredLocation[i] != vect(0,0,0))
		{
			str = str$"["$i$"] Yes, ";
		}
	//	else
		//{
		//	str = str$"["$i$"] No, ";
	//	}
	}
	
	xAlert("Locations",str$" [END]");
}

function ListInv()
{
	local int i, k;
	local string str;
	for(i=0;i<10;i++)
	{
		if(StoredInv[i] != None)
		{
			k++;
			if(k==3)
				str = str$"["$i$"] "$StoredInv[i]$"|n";
			else
				str = str$"["$i$"] "$StoredInv[i]$", ";
		}
	}
	
	xAlert(k$" items",str$" [END]");
}

function ListComps(optional bool bMyGroup)
{
	local int k;
	local string str, inf;
	local PSComputer PSComp;
	
	if(!bMyGroup)
	{
		inf = "[GLOBAL]";
		foreach AllActors(class'PSComputer',PSComp)
		{
			k++;
			if(k==6 || k==9)
				str = str$", "$PSComp.Username$"|n";
			else
				str = str$", "$PSComp.Username;
		}
	}
	else
	{
		if(Group != "")
		{
			inf = "["$Group$"]";
			foreach AllActors(class'PSComputer',PSComp)
			{
				if(PSComp.Group ~= Group)
				{
					k++;
					if(k==6 || k==9)
						str = str$", "$PSComp.Username$"|n";
					else
						str = str$", "$PSComp.Username;
				}
			}
		}
		else
		{
			inf = "[NO GROUP]";
		}
	}
	xAlert(k$" computers",inf@str$" [END]");
}

function ListMail()
{
	local int i, k;
	local string str;
	for(i=0;i<250;i++)
	{
		if(Messages[i] != "")
		{
			k++;
			str = str$Messages[i]$"|n";
			if(instr(caps(Messages[i]), caps("[X]")) == -1)
				Messages[i] = "[X]"$Messages[i];
		}
	}
	
	xAlert(k$" messages",str$" [END]");
}

function int CountMail(optional bool bUnreadOnly)
{
	local int i, k;

	if(!bUnreadOnly)
	{
		for(i=0;i<250;i++)
		{
			if(Messages[i] != "")
			{
				if(instr(caps(Messages[i]), caps("[X]")) == -1)
				{
					k++;
				}
			}
		}
	}
	else
	{
		for(i=0;i<250;i++)
		{
			if(Messages[i] != "")
			{
				k++;
			}
		}
	}
	return k;
}

function string ReadMail(int i)
{
	local string str;
	if(bDebug)
		Log(i);
	if(Messages[i] != "")
	{
		str = Messages[i];
		if(instr(caps(Messages[i]), caps("[X]")) == -1)
				Messages[i] = "[X]"$Messages[i];
		return str;
	}
	else
		return "Error: Message is empty.";
}

function DelMail(int i)
{
	if(bDebug)
		Log(i);
	if(Messages[i] != "")
	{
		xAlert("Mail","Deleted message ["$Messages[i]$"]");
		Messages[i] = "";
	}
	else
		xAlert("Mail","Error: Message is already empty.");
}

function ToggleAlert(deusexplayer p)
{
	local PSZoneInfo PSZ;
	
	P.PlaySound(sound'Send',,,, 256);
	
	if(ZoneTag == 'None')
	{
		xAlert("Error","Security system not configured...");
		return;
	}
	foreach AllActors(class'PSZoneInfo',PSZ)
	{
		if(PSZ.Tag == ZoneTag)
		{
			if(PSZ.NotifPlayer != None)
			{
				PSZ.NotifPlayer = None;
				xAlert("Alert","Cancelled zone alerts.");
				return;
			}
			else
			{
				PSZ.NotifPlayer = P;
				xAlert("Alert","Registered for zone alerts.");
				return;
			}
		}
	}
}

function ToggleSecurity(deusexplayer p)
{
	local PSZoneInfo PSZ;
	
	P.PlaySound(sound'Send',,,, 256);
	
	if(ZoneTag == 'None')
	{
		xAlert("Error","Security system not configured...");
		return;
	}
	foreach AllActors(class'PSZoneInfo',PSZ)
	{
		if(PSZ.Tag == ZoneTag)
		{
			PSZ.bRestrictedZone = !PSZ.bRestrictedZone;
			if(PSZ.bRestrictedZone)
				xAlert("Alert","Security system enabled");
			else
				xAlert("Alert","Security system disabled");
		}
	}
}

function Frob(actor frobber, inventory frobwith)
{
	local DeusExPlayer P;
	local PSComputerReplicationactor newlogin, f;
	local bool bFound, bRemembered;
	local string str;
	
	P = DeusExPlayer(frobber);
	P.PlaySound(sound'Find',,,, 256);
	if(pgUser == P)
	{
		bRemembered=True;
		pgUser.ClientMessage("|P4Recognized user; Password not required. You may just enter commands.");
		if(CountMail(True) > 0)
			str = "You have "$CountMail(True)$" unread messages.|n";
		if(CountNotif() > 0)
			str = str$"You have "$CountNotif()$" notifications! (Command <chk> reads)";
		
		if(str != "")
			xAlert("Alert",str);
	}
	if(bdebug)
		log("Computer: "$bRemembered@password);
	foreach AllActors(class'PSComputerReplicationactor', f)
		if(f.Flagger == P)
		{
			f.Flagger = P;
			f.ac = self;
			f.SetTimer(0.5,false);
			f.Username = Username;
			f.bRem=bRemembered;
			f.Password = Password;
			bFound=True;
		}
			
	if(!bFound)
	{
		newlogin = Spawn(class'PSComputerReplicationactor');
		newlogin.Flagger = P;
		newlogin.ac = self;
		newlogin.Username = Username;
		newlogin.SetTimer(0.5,false);
	}
}

defaultproperties
{
     userName="DEFAULT"
     Password="DEFAULT"
     InfoProp(0)="Health"
     InfoProp(1)="Energy"
     InfoProp(2)="ReducedDamageType"
     InfoProp(3)="bAdmin"
     bInvincible=True
     ItemName="Personal Computer Terminal"
     bPushable=False
     Mesh=LodMesh'DeusExDeco.ComputerPersonal'
     CollisionRadius=36.000000
     CollisionHeight=7.400000
}
