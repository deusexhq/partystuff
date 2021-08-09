// Stores Login data
//============================
class PSComputerReplicationactor extends PGActors;

var PlayerPawn Flagger;
var PSComputer Ac;
var string Username, Password;
var bool bRem;

replication
{
     reliable if (Role == ROLE_Authority)
        cMenuLogin, cAlert, cMenuHack;//, cMenuRegister;//, currentMode;

     reliable if (Role < ROLE_Authority)
        ParseCommand;//setSize, createBox;
}

simulated final function cMenuHack()
{
	local DeusExPlayer _Player;
	local DeusExRootWindow _root;
	local PSComputerMenu _boxWindow;
	_Player = DeusExPlayer(Owner);
	//log("Called cMenuLogin for"@_Player.playerreplicationinfo.playername );
	if(_Player != None)
	{
		//_Player.InitRootWindow();
		_root = DeusExRootWindow(_Player.rootWindow);
		if(_root != None)
		{
			_boxWindow = PSComputerMenu(_root.InvokeUIScreen(Class'PSComputerMenuHack', True));
			if(_boxWindow != None)
			{
				_boxWindow._windowOwner = _Player;
				_boxWindow.Ac = Ac;
				_boxWindow.Mastah = Self;
				//_boxWindow.AddUserTitle(Username);
			}
		}
	}
}

simulated final function cMenuLogin()
{
	local DeusExPlayer _Player;
	local DeusExRootWindow _root;
	local PSComputerMenu _boxWindow;
	_Player = DeusExPlayer(Owner);
	//log("Called cMenuLogin for"@_Player.playerreplicationinfo.playername );
	if(_Player != None)
	{
		//_Player.InitRootWindow();
		_root = DeusExRootWindow(_Player.rootWindow);
		if(_root != None)
		{
			_boxWindow = PSComputerMenu(_root.InvokeUIScreen(Class'PSComputerMenu', True));
			if(_boxWindow != None)
			{
				_boxWindow._windowOwner = _Player;
				_boxWindow.Ac = Ac;
				_boxWindow.Mastah = Self;
				_boxWindow.Username = Username;
				_boxWindow.Password = Password;
				_boxWindow.bRem = bRem;
				//_boxWindow.AddUserTitle(Username);
			}
		}
	}
}

simulated final function cAlert(string title, string msg)
{
	local DeusExPlayer _Player;
	local DeusExRootWindow _root;
	local MenuAlert _boxWindow;
	_Player = DeusExPlayer(Owner);
	//log("Called cMenuLogin for"@_Player.playerreplicationinfo.playername );
	if(_Player != None)
	{
		//_Player.InitRootWindow();
		_root = DeusExRootWindow(_Player.rootWindow);
		if(_root != None)
		{
			_boxWindow = MenuAlert(_root.InvokeUIScreen(Class'MenuAlert', True));
			if(_boxWindow != None)
			{
				_boxWindow._windowOwner = _Player;
				_boxWindow.Ac = Ac;
				_boxWindow.Mastah = Self;
				_boxWindow.crt(title, msg);
			//	_boxWindow.ClientWidth = len(msg);
			}
		}
	}
}

simulated function bool ParseCommand(deusexplayer p, string Password, string Command)
{
	return ac.ParseCommand(p, Password,Command);
}

simulated function bool ParseHack(string Command)
{
	return ac.ParseHack(Command);
}

function timer()
{
		SetOwner(flagger);
		cMenuLogin();
}

defaultproperties
{
     NetPriority=1.500000
}
