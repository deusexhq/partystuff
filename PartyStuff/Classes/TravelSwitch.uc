//=============================================================================
// PlaySound
//=============================================================================
class TravelSwitch extends Switch2;

var() string MapURL;
var() float MinPercentage;
var float VoteTimer;
var DeusExPlayer Voters[16];
var() bool bDebug;

function Frob(Actor Frobber, Inventory frobWith)
{
	local int i, f, Players, VoteCount;
	local DeusExPlayer DXP, P;
	local bool bVoted;
	
	//Super.Frob(Frobber, frobWith);
	
	P = DeusExPlayer(Frobber);
		
	foreach AllActors(class'DeusExPlayer', DXP)
		Players++;
	
	for(i=0;i<16;i++)
		if(Voters[i] != None)
			VoteCount++;
	
	for(i=0;i<16;i++)
		if(Voters[i] == P)
			bVoted=True;
				
	if(!bVoted)
	{
		for(i=0;i<16;i++)
		{
			if(Voters[i] == None)
			{
				BroadcastMessage("Vote Statistics: "$VoteCount+1$" out of "$Players$" players voted for "$MapURL$". "$float((VoteCount+1 / Players) * 100)$"% - Requires "$MinPercentage$"%");
				Voters[i] = P;
				
				if( ( (VoteCount+1 / Players) * 100 ) >= MinPercentage )
				{
					if(bDebug)
					{
						BroadcastMessage("Vote passed.");
						return;
					}
					Level.Servertravel( MapURL ,false);
				}
				return;
			}
		}
	}
	
	P.ClientMessage("Client Vote Statistics: "$VoteCount+1$" out of "$Players$" players voted for "$MapURL$". "$(VoteCount+1 / Players) * 100$"% - Requires "$MinPercentage$"%");
	

}

defaultproperties
{
	ItemName="Travel Switch"
}
