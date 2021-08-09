//=============================================================================
// FlagPole.
//=============================================================================
class PSFlagPole extends DeusExDecoration;

var() bool bLocked;

enum ESkinColor
{
	SC_China,
	SC_France,
	SC_President,
	SC_UNATCO,
	SC_USA,
	SC_Serb,
	SC_serbi,
	SC_England,
	SC_Canada
};

var() travel ESkinColor SkinColor;

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);
	SetOwner(Frobber);
	
	if(bLocked)
	return;
	if(Skincolor == SC_China)
	{
		SkinColor = SC_France;
		Skin = Texture'FlagPoleTex2'; return;
	}
		if(Skincolor == SC_France)
	{
		SkinColor = SC_President;
		Skin = Texture'FlagPoleTex3'; return;
	}
	if(Skincolor == SC_President)
	{
		SkinColor = SC_UNATCO;
		Skin = Texture'FlagPoleTex4'; return;
	}
	if(Skincolor == SC_UNATCO)
	{
		SkinColor = SC_USA;
		Skin = Texture'FlagPoleTex5'; return;
	}
	if(Skincolor == SC_USA)
	{
		SkinColor = SC_Serb;
		Skin = Texture'FlagPoleTex6'; return;
	}
	if(Skincolor == SC_Serb)
	{
		SkinColor = SC_Serbi;
		Skin = Texture'FlagPoleTex7'; return;
	}	
	if(Skincolor == SC_Serbi)
	{
		SkinColor = SC_England;
		Skin = Texture'FlagPoleTex8'; return;
	}
	if(Skincolor == SC_England)
	{
		SkinColor = SC_Canada;
		Skin = Texture'FlagPoleTex9'; return;
	}
	if(Skincolor == SC_Canada)
	{
		SkinColor = SC_China;
		Skin = Texture'FlagPoleTex1'; return;
	}
}

function BeginPlay()
{
	Super.BeginPlay();

	SetSkin();
}

function TravelPostAccept()
{
	Super.TravelPostAccept();

	SetSkin();
}

function SetSkin()
{
	switch (SkinColor)
	{
		case SC_China:		Skin = Texture'FlagPoleTex1'; break;
		case SC_France:		Skin = Texture'FlagPoleTex2'; break;
		case SC_President:	Skin = Texture'FlagPoleTex3'; break;
		case SC_UNATCO:		Skin = Texture'FlagPoleTex4'; break;
		case SC_USA:		Skin = Texture'FlagPoleTex5'; break;
		case SC_Serb:		Skin = Texture'FlagPoleTex6'; break;
		case SC_Serbi:		Skin = Texture'FlagPoleTex7'; break;
		case SC_England:		Skin = Texture'FlagPoleTex8'; break;
		case SC_Canada:		Skin = Texture'FlagPoleTex9'; break;
	}
}

defaultproperties
{
     bInvincible=True
     FragType=Class'DeusEx.WoodFragment'
     ItemName="Flag Pole"
     bPushable=False
     Mesh=LodMesh'DeusExDeco.FlagPole'
     CollisionRadius=17.000000
     CollisionHeight=56.389999
     Mass=40.000000
     Buoyancy=30.000000
}
