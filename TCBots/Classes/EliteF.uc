//=============================================================================
// WIB.
//=============================================================================
class EliteF extends DXHumanMilitary;

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;

Begin:
	GoToState('Killswitch');
}

function PlayDying(name damageType, vector hitLoc)
{
}

function PostBeginPlay()
{
local int i;

i = Rand(5);

if(i == 0)
MultiSkins[0] = Texture'DeusExCharacters.Skins.NicoletteDuClareTex0';
else if(i == 1)
MultiSkins[0] = Texture'DeusExCharacters.Skins.NurseTex0';
else if(i == 2)
MultiSkins[0] = Texture'DeusExCharacters.Skins.Hooker2Tex0';
else if(i == 3)
MultiSkins[0] = Texture'DeusExCharacters.Skins.Female4Tex0';
else if(i == 4)
MultiSkins[0] = Texture'DeusExCharacters.Skins.TiffanySavageTex0';
else if(i == 5)
MultiSkins[0] = Texture'DeusExCharacters.Skins.SarahMeadTex0';
}

defaultproperties
{
     MinHealth=0.000000
     CarcassType=Class'DeusEx.WIBCarcass'
     WalkingSpeed=0.300000
     CloseCombatMult=0.500000
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponNanoSword')
     walkAnimMult=0.870000
     bIsFemale=True
     GroundSpeed=200.000000
     Health=400
     HealthHead=400
     HealthTorso=400
     HealthLegLeft=400
     HealthLegRight=400
     HealthArmLeft=400
     HealthArmRight=400
     Mesh=LodMesh'DeusExCharacters.GFM_SuitSkirt'
     DrawScale=1.100000
     MultiSkins(0)=Texture'DeusExCharacters.Skins.WIBTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.WIBTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.LegsTex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.WIBTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.WIBTex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex2'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex3'
     CollisionHeight=47.299999
     BindName="Elite"
     FamiliarName="Woman"
     UnfamiliarName="Woman"
}
