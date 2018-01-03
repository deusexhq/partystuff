//=============================================================================
// DarkMaiden.
//=============================================================================
class Mannequin extends CrateUnbreakableMed;

var() bool bLocked;
var texture TempMultiSkins[8];
var mesh TempMesh;
var() bool bTakeMesh;

var bool bUsedOnce;

function Trigger( actor Other, pawn EventInstigator )
{
	GiveLife();
}

function GiveLife()
{
	local LivingMannequin EC;
	
	EC = spawn(class'LivingMannequin',,,Location,);
	EC.Mesh = Mesh;
	EC.MultiSkins[0]=MultiSkins[0];
	EC.MultiSkins[1]=MultiSkins[1];
	EC.MultiSkins[2]=MultiSkins[2];
	EC.MultiSkins[3]=MultiSkins[3];
	EC.MultiSkins[4]=MultiSkins[4];
	EC.MultiSkins[5]=MultiSkins[5];
	EC.MultiSkins[6]=MultiSkins[6];
	EC.MultiSkins[7]=MultiSkins[7];
	EC.SetRotation(Rotation);
	EC.Tag = Tag;
	Destroy();
}

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer P;
	P = DeusExPlayer(Frobber);
	
	if(bLocked)
	{
		DeusExPlayer(Frobber).ClientMessage("Mannequin skin is locked.");
		return;
	}
	
		if(!bUsedOnce)
		{
			Texture=Texture'DeusExItems.Skins.PinkMaskTex';
			Skin=Texture'DeusExItems.Skins.PinkMaskTex';
			Mesh = P.Mesh;
			MultiSkins[0]=P.MultiSkins[0];
			MultiSkins[1]=P.MultiSkins[1];
			MultiSkins[2]=P.MultiSkins[2];
			MultiSkins[3]=P.MultiSkins[3];
			MultiSkins[4]=P.MultiSkins[4];
			MultiSkins[5]=P.MultiSkins[5];
			MultiSkins[6]=P.MultiSkins[6];
			MultiSkins[7]=P.MultiSkins[7];
			bUsedOnce=True;
			return;
		}
	
	TempMesh = Mesh;
	TempMultiSkins[0] = MultiSkins[0];
	TempMultiSkins[1] = MultiSkins[1];
	TempMultiSkins[2] = MultiSkins[2];
	TempMultiSkins[3] = MultiSkins[3];
	TempMultiSkins[4] = MultiSkins[4];
	TempMultiSkins[5] = MultiSkins[5];
	TempMultiSkins[6] = MultiSkins[6];
	TempMultiSkins[7] = MultiSkins[7];
	
	Texture=Texture'DeusExItems.Skins.PinkMaskTex';
	Skin=Texture'DeusExItems.Skins.PinkMaskTex';
	Mesh = P.Mesh;
	MultiSkins[0]=P.MultiSkins[0];
	MultiSkins[1]=P.MultiSkins[1];
	MultiSkins[2]=P.MultiSkins[2];
	MultiSkins[3]=P.MultiSkins[3];
	MultiSkins[4]=P.MultiSkins[4];
	MultiSkins[5]=P.MultiSkins[5];
	MultiSkins[6]=P.MultiSkins[6];
	MultiSkins[7]=P.MultiSkins[7];

	P.Mesh = TempMesh;
	P.MultiSkins[0] = TempMultiSkins[0];
	P.MultiSkins[1] = TempMultiSkins[1];
	P.MultiSkins[2] = TempMultiSkins[2];
	P.MultiSkins[3] = TempMultiSkins[3];
	P.MultiSkins[4] = TempMultiSkins[4];
	P.MultiSkins[5] = TempMultiSkins[5];
	P.MultiSkins[6] = TempMultiSkins[6];
	P.MultiSkins[7] = TempMultiSkins[7];
}

defaultproperties
{
     HitPoints=100
     ItemName="Mannequin"
     bPushable=False
     Texture=Texture'DeusExItems.Skins.GrayMaskTex'
     Skin=Texture'DeusExItems.Skins.GrayMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(1)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(3)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(4)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.GrayMaskTex'
     CollisionRadius=20.200001
     CollisionHeight=47.299999
}
