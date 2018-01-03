//=============================================================================
// DarkMaiden.
//=============================================================================
class GhostCiv2 extends DXHumanMilitary;
/*
function BeginPlay()
{
local int rface, rtop, rbottoms;
//multiskin 0 & 2/face
//multiskins 3 & 4 /top
//multiskins 1 /bottoms

	rface = Rand(10);
	if(rface = 0)
	{
		
	}
}*/

function Carcass SpawnCarcass()
{
	if (bStunned)
		return Super.SpawnCarcass();

	Destroy();

	return None;
}

function float ShieldDamage(name damageType)
{
	if ( (damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') )
		return 0.0;
        	else if ( (damageType == 'Flamed') || (damageType == 'Poison') || (damageType == 'PoisonEffect') || (damageType == 'Radiation') )
                	return 0.1;
	else if ( (damageType == 'Shocked') || (damageType == 'KnockedOut') || (damageType == 'Fell') )
                	return 0.5;
      	else
		return Super.ShieldDamage(damageType);
}

defaultproperties
{
     BaseAccuracy=-0.250000
     WalkingSpeed=0.280000
     bShowPain=False
     AvoidAccuracy=0.950000
     CloseCombatMult=1.000000
     bReactAlarm=False
     SurprisePeriod=0.000000
     BaseAssHeight=-18.000000
     BurnPeriod=0.000000
     GroundSpeed=180.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=750
     CombatStyle=-0.500000
     HealthHead=750
     HealthTorso=750
     HealthLegLeft=750
     HealthLegRight=750
     HealthArmLeft=750
     HealthArmRight=750
     Style=STY_Translucent
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.LowerClassMale2Tex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Ghost"
     FamiliarName="Ghost"
     UnfamiliarName="Ghost"
     bVisionImportant=False
}
