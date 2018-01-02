//=============================================================================
// Switch1.
//=============================================================================
class OwnedScanner extends DeusExDecoration;

var DeusExPlayer owner;
var bool bOwned;
var(Owning) bool bPaytoOwn;
var(Owning) int Price;
var(Owning) string OwnedAlias;
var(Owning) bool bAllowBidding;
var(Owning) bool bIncomeGenerator;
var(Owning) bool bIncomeSubtractor;
var(Owning) int Payoutcreds;
var(Owning) int payoutdelay;
var bool bConfirm;
var int Bid;
var bool bPayout;

function Tick(float Deltatime)
{
	//Check Ownage.
	if(bOwned)
	{
		if(owner.PlayerReplicationInfo.PlayerName == "")
		{
		bOwned=False;
		bPayout=False;
		}
	}

	super.Tick(Deltatime);
}

function Timer()
{
local DeusExPlayer p;
	
	if(bPayout)
	{
		if(bIncomeGenerator)
		{
			owner.Credits += Payoutcreds;
			owner.ClientMessage("You have been paid by an object you own, "$OwnedAlias$". Income: "$Payoutcreds$" |P1(New credits: "$P.Credits$")");
		}
		
		if(bIncomeSubtractor)
		{
			owner.Credits -= Payoutcreds;
			owner.ClientMessage("You have been charged credits by an object you own, "$OwnedAlias$". Money Taken: "$Payoutcreds$" |P1(New credits: "$P.Credits$")");
		}
		else if(!bIncomeGenerator && !bIncomeSubtractor)
		{
		bPayout=False;
		}
	}
if(bConfirm)
{bConfirm=False;}
}

function Frob(Actor Frobber, Inventory frobWith)
{
local DeusExPlayer p;
p = DeusExPlayer(Frobber);

	if(bOwned)//We are owned, checking if frobber is owner.
	{
		if(owner == p)
		{//Check passed.
		p.ClientMessage("You own this object!");
			super.Frob(frobber, frobWith);
		}
		else
		{
			p.ClientMessage("You do not own this object. Currently owned by"@owner.PlayerReplicationInfo.PlayerName);
				if(bAllowBidding)
				{
					if(!bConfirm)
					{	
						p.ClientMessage("Bid "$Price*1.2$" to own "$ownedalias$", press again to confirm? |P1(Current credits: "$P.Credits$")");
						bConfirm = True;
						SetTimer(3,False);
					}
					else
					{
						if(p.Credits >= Price)
						{
							owner.ClientMessage(owner.PlayerReplicationInfo.PlayerName$", you have lost the owned object"@ownedalias);
							Bid = Price*1.2;
							Price = Bid;
							owner = p;
							p.Credits -= Price;
							p.ClientMessage(owner.PlayerReplicationInfo.PlayerName$", you now own the object"@ownedalias$" |P1(New credits: "$P.Credits$")");
							bConfirm = False;
							bOwned=True;
							bPayout=True;
							SetTimer(PayoutDelay,True);
						}
						else
						{p.ClientMessage("You can't afford this purchase.");}
					}
				}

		}

	}
	else
	{
		if(bPaytoOwn)
		{//Pay to own
			if(!bConfirm)
			{
				p.ClientMessage(Price$" to own "$ownedalias$", press again to confirm? |P1(Current credits: "$P.Credits$")");
				bConfirm = True;
				SetTimer(3,False);
			}
			else
			{
				if(p.Credits >= Price)
				{
					owner = p;
					p.Credits -= Price;
					p.ClientMessage(owner.PlayerReplicationInfo.PlayerName$", you now own the object"@ownedalias$" |P1(New credits: "$P.Credits$")");
					bConfirm = False;
					bOwned=True;
					bPayout=True;
					SetTimer(PayoutDelay,True);
				}
				else
				{p.ClientMessage("You can't afford this purchase.");}
			}

		}
		else
		{//Free to own.
			owner = p;
			bOwned=True;
								bPayout=True;
					SetTimer(PayoutDelay,True);
			p.ClientMessage(owner.PlayerReplicationInfo.PlayerName$", you now own the object"@ownedalias);
		}
	}
}

defaultproperties
{
     bInvincible=True
     ItemName="Ownable Scanner"
     bPushable=False
     Physics=PHYS_None
     Texture=Texture'DeusExItems.Skins.DataCubeTex2'
     Mesh=LodMesh'DeusExItems.DataCube'
     CollisionRadius=7.000000
     CollisionHeight=1.270000
     Buoyancy=12.000000
}
