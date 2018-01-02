class CActor extends PGActors;
var DeusExPlayer Crim;
var int CC, CL, CLim;
var string cn;

function Timer()
{
	if(Crim == None)
	{
		BroadcastMessage(cn$" has fled and is no longer wanted.");
		Destroy();
	}
	
	if(Crim.Health < 0)
	{
		BroadcastMessage(cn$" was terminated, security has been recalled.");
		Destroy();
	}

}

defaultproperties
{
	CLim=5
	bHidden=True
}
