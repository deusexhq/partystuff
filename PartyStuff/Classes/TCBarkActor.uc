class TCBarkActor extends PGActors;

var PlayerPawn Flagger;

var string sMessage;
var float fDelay;
var DXScriptedPawn pSender;

replication
{
     reliable if (Role == ROLE_Authority)
        cBark;
}

simulated final function cBark(string BarkMessage, float Delay, DXScriptedPawn BotSender)
{
	local DeusExPlayer _Player;
	local DeusExRootWindow _root;
	_Player = DeusExPlayer(Owner);

	if(_Player != None)
	{
		_root = DeusExRootWindow(_Player.rootWindow);
		if(_root != None)
		{
			_root.hud.barkdisplay.addBark(BarkMessage, Delay, BotSender);
		}
	}
}

function timer()
{
		SetOwner(flagger);
		cBark(sMessage, fDelay, pSender);
}

defaultproperties
{
	bHidden=True
	RemoteRole=2
    NetPriority=1.50
    Lifespan=1
}
