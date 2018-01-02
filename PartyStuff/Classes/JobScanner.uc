//=============================================================================
// Switch1.
//=============================================================================
class JobScanner extends DeusExDecoration;

var DeusExPlayer assist1, assist2, assist3;
var(Job) string JobAlias, JobString;
var(Job) int Payoutcreds;
var(Job) int payoutdelay;
var(Job) string JobSkin;
var(Job) string JobInventory1;
var(Job) string JobInventory2;
var(Job) string JobInventory3;
var(Job) string JobInventory4;

function Timer()
{
local DeusExPlayer p;

	if(Assist1 != None)
	{
		Assist1.Credits += Payoutcreds;
		Assist1.ClientMessage("You have been paid by a job, "$JobAlias$". Income: "$Payoutcreds);
	}
	if(Assist2 != None)
	{
		Assist2.Credits += Payoutcreds;
		Assist2.ClientMessage("You have been paid by a job, "$JobAlias$". Income: "$Payoutcreds);
	}
	if(Assist3 != None)
	{
		Assist3.Credits += Payoutcreds;
		Assist3.ClientMessage("You have been paid by a job, "$JobAlias$". Income: "$Payoutcreds);
	}
}

function BeginPlay()
{
	SetTimer(payoutdelay,True);
}

function Frob(Actor Frobber, Inventory frobWith)
{
local DeusExPlayer p;
local JobScanner js;
local class<ScriptedPawn> SCR;
local class<inventory> invy, invy2, invy3, invy4;
local inventory inv;

p = DeusExPlayer(Frobber);

	foreach AllActors(class'JobScanner',js)
	{
		if(js != Self)
		{
			if(js.Assist1 == P || js.Assist2 == P || js.Assist3 == P)
			{
				P.ClientMessage("You already have a job elsewhere.");
				return;
			}
		}
	}
	
	if(P == Assist1)
	{
		Assist1 = None;
		P.ClientMessage(JobAlias$" job resigned.");
		return;
	}

	if(P == Assist2)
	{
		Assist2 = None;
		P.ClientMessage(JobAlias$" job resigned.");
		return;
	}

	if(P == Assist3)
	{
		Assist3 = None;
		P.ClientMessage(JobAlias$" job resigned.");
		return;
	}
	
	if(Assist1 == None)
	{
		if(JobSkin != "")
			P.ConsoleCommand("say /skin"@JobSkin);
		
		if(JobInventory1 != "")
			invy = class<inventory>( DynamicLoadObject( JobInventory1, class'Class' ) );
		if(JobInventory2 != "")
			invy2 = class<inventory>( DynamicLoadObject( JobInventory2, class'Class' ) );
		if(JobInventory3 != "")
			invy3 = class<inventory>( DynamicLoadObject( JobInventory3, class'Class' ) );
		if(JobInventory4 != "")
			invy4 = class<inventory>( DynamicLoadObject( JobInventory4, class'Class' ) );
		if( invy !=None )
		{
			inv=Spawn(invy);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy2 !=None )
		{
			inv=Spawn(invy2);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy3 !=None )
		{
			inv=Spawn(invy3);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy4 !=None )
		{
			inv=Spawn(invy4);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		Assist1 = P;
		P.ClientMessage(JobAlias$" job joined.");
			if(JobString != "")
			{
				P.ClientMessage(JobString);
			}
		return;
	}
	
	if(Assist2 == None)
	{
		if(JobSkin != "")
			P.ConsoleCommand("say /skin"@JobSkin);
		if(JobInventory1 != "")
			invy = class<inventory>( DynamicLoadObject( JobInventory1, class'Class' ) );
		if(JobInventory2 != "")
			invy2 = class<inventory>( DynamicLoadObject( JobInventory2, class'Class' ) );
		if(JobInventory3 != "")
			invy3 = class<inventory>( DynamicLoadObject( JobInventory3, class'Class' ) );
		if(JobInventory4 != "")
			invy4 = class<inventory>( DynamicLoadObject( JobInventory4, class'Class' ) );
		if( invy !=None )
		{
			inv=Spawn(invy);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy2 !=None )
		{
			inv=Spawn(invy2);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy3 !=None )
		{
			inv=Spawn(invy3);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy4 !=None )
		{
			inv=Spawn(invy4);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		Assist2 = P;
		P.ClientMessage(JobAlias$" job joined.");
			if(JobString != "")
			{
				P.ClientMessage(JobString);
			}
		return;
	}
	
	if(Assist3 == None)
	{
		if(JobSkin != "")
			P.ConsoleCommand("say /skin"@JobSkin);
		if(JobInventory1 != "")
			invy = class<inventory>( DynamicLoadObject( JobInventory1, class'Class' ) );
		if(JobInventory2 != "")
			invy2 = class<inventory>( DynamicLoadObject( JobInventory2, class'Class' ) );
		if(JobInventory3 != "")
			invy3 = class<inventory>( DynamicLoadObject( JobInventory3, class'Class' ) );
		if(JobInventory4 != "")
			invy4 = class<inventory>( DynamicLoadObject( JobInventory4, class'Class' ) );
	
		if( invy !=None )
		{
			inv=Spawn(invy);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy2 !=None )
		{
			inv=Spawn(invy2);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy3 !=None )
		{
			inv=Spawn(invy3);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		
		if( invy4 !=None )
		{
			inv=Spawn(invy4);
			Inv.Frob(DeusExPlayer(Frobber),None);	  
			inv.Destroy();
		}
		Assist3 = P;
		P.ClientMessage(JobAlias$" job joined.");
			if(JobString != "")
			{
				P.ClientMessage(JobString);
			}
		return;
	}
}

defaultproperties
{
     JobAlias="DEFAULT JOB NAME"
     Payoutcreds=15
     payoutdelay=60
     bInvincible=True
     ItemName="Job Scanner"
     bPushable=False
     Physics=PHYS_None
     Texture=Texture'DeusExItems.Skins.DataCubeTex2'
     Mesh=LodMesh'DeusExItems.DataCube'
     CollisionRadius=7.000000
     CollisionHeight=1.270000
     Buoyancy=12.000000
}
