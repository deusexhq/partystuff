//=============================================================================
// PSZoneInfo
//=============================================================================
class PSVoteZone extends ZoneInfo;

var() string MapURL;
var() float MinPercentage;
var float VoteTimer;
var DeusExPlayer Voters[16];
var() bool bDebug;


event ActorLeaving( actor Other )
{
	local int i, VoteCount, Players;
	local DeusExPlayer P, DXP;
	local bool bVoted;
	
	P = DeusExPlayer(other);
	if(P == None)
		return;
	for(i=0;i<16;i++)
		if(Voters[i] == P)
			bVoted=True;
			
	for(i=0;i<16;i++)
		if(Voters[i] != None)
			VoteCount++;
	
	foreach AllActors(class'DeusExPlayer', DXP)
		Players++;		
	if(bVoted)
	{
		for(i=0;i<16;i++)
		{
			if(Voters[i] == P)
			{
				Voters[i] = None;
				BroadcastMessage("[Voter leave] Vote Statistics: "$VoteCount-1$" out of "$Players$" players voted for "$MapURL$". "$(VoteCount-1 / Players) * 100$"% - Requires "$MinPercentage$"%");
				//Voters[i] = P;
				return;
			}
		}
	}	
	super.ActorLeaving(Other);
}

event ActorEntered(actor Other)
{	
	local int i, f, Players, VoteCount;
	local DeusExPlayer DXP, P;
	local bool bVoted;

	P = DeusExPlayer(other);
	
	if(P == None)
		return;
		
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
				BroadcastMessage("Vote Statistics: "$VoteCount+1$" out of "$Players$" players voted for "$MapURL$". "$(VoteCount+1 / Players) * 100$"% - Requires "$MinPercentage$"%");
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
	
	P.ClientMessage("Vote Statistics: "$VoteCount$" out of "$Players$" players voted for "$MapURL$". "$(VoteCount / Players) * 100$"% - Requires "$MinPercentage$"%");
	

	Super.ActorEntered(Other);
}

defaultproperties
{
}
