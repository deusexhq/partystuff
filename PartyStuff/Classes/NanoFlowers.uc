//=============================================================================
// Flowers.
//=============================================================================
class NanoFlowers extends DeusExDecoration;

function BeginPlay()
{
	SetTimer(2,True);
}

function Bump(actor Other)
{
//Do nothing.
}

function Timer()
{
local DeusExDecoration deco;
local DeusExPlayer paw;
local deusexcarcass dec;


	foreach VisibleActors(class'DeusExPlayer', paw, 256)
	{
		if (paw != None)
		{
			if(paw.Health < 100)
			{
					paw.HealPlayer(100, True);
			}
			if(paw.Energy < 100)
			{
				paw.Energy = 100;
			}
		}
	}
	
	foreach VisibleActors(class'DeusExCarcass', DEC, 256)
	{
		if (dec != None)
		{
			Rezz(dec);
		}
	}
}

function Rezz(deusexcarcass carcian)
{
local string tempname, carcassname;
local class<scriptedpawn> newpawn;

	TempName = string(carcian.Class);

	if( InStr(TempName,"Carcass")>=0 )
		CarcassName = Left( TempName, InStr(TempName,"Carcass") );

	Spawn(class<ScriptedPawn>( DynamicLoadObject(CarcassName, class'Class' ) ),,, carcian.Location);	
	carcian.Destroy();
}

defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="Nanite Infused Flowers"
     Mesh=LodMesh'DeusExDeco.Flowers'
     CollisionRadius=11.880000
     CollisionHeight=9.630000
     Mass=20.000000
     Buoyancy=10.000000
}
