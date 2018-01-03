// For replicating PSK menu
//============================
class PSKR extends PGActors;

var PlayerPawn Flagger;
var PSKeypad Ac;

replication
{
     reliable if (Role == ROLE_Authority)
        cMenuLogin, cAlert;//, cMenuRegister;//, currentMode;

     reliable if (Role < ROLE_Authority)
        ChkPass;//setSize, createBox;
}

simulated final function cMenuLogin()
{
	local DeusExPlayer _Player;
	local DeusExRootWindow _root;
	local PSKM _boxWindow;
	_Player = DeusExPlayer(Owner);
	//log("Called cMenuLogin for"@_Player.playerreplicationinfo.playername );
	if(_Player != None)
	{
		//_Player.InitRootWindow();
		_root = DeusExRootWindow(_Player.rootWindow);
		if(_root != None)
		{
			_boxWindow = PSKM(_root.InvokeUIScreen(Class'PSKM', True));
			if(_boxWindow != None)
			{
				_boxWindow._windowOwner = _Player;
				_boxWindow.Ac = Ac;
				_boxWindow.Mastah = Self;
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
				_boxWindow.crt(title, msg);
			//	_boxWindow.ClientWidth = len(msg);
			}
		}
	}
}

simulated function bool ChkPass(deusexplayer p, string Password)
{
	return ac.ChkPass(p, Password);
}

function timer()
{
		SetOwner(flagger);
		cMenuLogin();
}

defaultproperties
{
	bHidden=True
	RemoteRole=2
    NetPriority=1.50
}
