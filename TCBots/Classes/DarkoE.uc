//=============================================================================
// MJ12Troop.
//=============================================================================
class DarkoE extends DXEnemy;

var Darko Dark;
var DeusExPlayer DXP;
var int myID;

function BeepAll( string str )
{
local DeusExPlayer DXP;
foreach AllActors(class'DeusExPlayer',DXP)
{
	DXP.ClientMessage("<-(DD)->Darko("$myID$"):"@str, 'Say');
}
}

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;

Begin:
	BeepAll("you dont fight with honor, come back when you dont use binds and hacks");
			foreach AllActors(class'DeusExPlayer', DXP)
			{
				DXP.LocalLog("Does he ever shut up...");
			}
	Dark.bRESpawningDarko=True;
	Dark.SetTimer(5,False);
	Destroy();
}

function Bool HasTwoHandedWeapon()
{
	return False;
}

defaultproperties
{
     CarcassType=Class'DeusEx.ChildMaleCarcass'
     WalkingSpeed=0.300000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponAssaultGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.Ammo762mm',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCombatKnife')
     walkAnimMult=0.780000
     GroundSpeed=200.000000
	 bCanCrouch=false
	 bIsFemale=True
     Mesh=LodMesh'DeusExCharacters.GMK_DressShirt_F'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.ChildMale2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.ChildMale2Tex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ChildMale2Tex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.ChildMale2Tex0'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.ChildMale2Tex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=17.000000
     CollisionHeight=32.500000
     Mass=80.000000
     BindName="DarkoE"
     FamiliarName="<-(DD)->Darko"
     UnfamiliarName="<-(DD)->Darko"
}
