//========================================
// CozATM
//========================================
Class BankingATM extends ATM;

var DeusExPlayer AccountOwner[50];
var int AccountMoney[50];
var BankingATM MasterATM;

function Frob(Actor Frobber, Inventory frobWith)
{
	local int k;
	local int i;
	local PSCreditCard ccc;
	local BankingATM CATM;

	if(MasterATM == None)
	{
		foreach AllActors(class'BankingATM',CATM)
		{
			if(CATM.Tag == 'MasterATM')
			{
				MasterATM = CATM;
			}
		}
	}

	for (i=1; i<50; i++)
	{
		if(MasterATM.AccountOwner[i] == DeusExPlayer(Frobber))
		{
			foreach AllActors(class'PSCreditCard',ccc)
			{
				if(ccc.Owner == DeusExPlayer(Frobber))
				{
					if(ccc.bDeposit == True)
					{
						if(DeusExPlayer(Frobber).Credits >= ccc.mode)
						{
							DeusExPlayer(Frobber).Credits -= ccc.mode;
							MasterATM.AccountMoney[i] += ccc.Mode;
							DeusExPlayer(Frobber).ClientMessage("|p7You just deposited "$ccc.mode$" credits. "$MasterATM.AccountMoney[i]$" credits in account.");
							return;
						}
						else
						{
							DeusExPlayer(Frobber).ClientMessage("|p2 You don't have "$ccc.mode$" credits to deposit!");
							return;
						}
					}
					else
					{
						if(MasterATM.AccountMoney[i] >= ccc.mode)
						{
							DeusExPlayer(Frobber).Credits += ccc.mode;
							MasterATM.AccountMoney[i] -= ccc.mode;
							DeusExPlayer(Frobber).ClientMessage("|p7You have just withdrawn "$ccc.mode$" credits. "$MasterATM.AccountMoney[i]$" credits in account.");
							return;
						}
						else
						{
							DeusExPlayer(Frobber).ClientMessage("|p2 You don't have "$ccc.mode$" credits in your account!");
							return;
						}

					}
				}
			}
		}
	}

	for (k=1; k<50; k++)
	{
		if(MasterATM.AccountOwner[k] == none)
		{
			MasterATM.AccountOwner[k] = DeusExPlayer(Frobber);
			DeusExPlayer(Frobber).ClientMessage("|p7 You don't have an account. A new one was created for you.");
			return;
		}
	}
}

defaultproperties
{
}
