//=============================================================================
// DarkMaiden.
//=============================================================================
class Nax2 extends DXHumanMilitary;

var NaxSphere NS;

state Dying
{
	ignores SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, Timer, TakeDamage;
	
	event Landed(vector HitNormal)
	{
		SetPhysics(PHYS_Walking);
	}

function Tick(float v)
{
	Scaleglow-=0.01;
	if(Scaleglow<0.01)
		Destroy();
	
}

Begin:
	//SpawnCarcass();
		StandUp();

		// don't do that stupid timer thing in Pawn.uc
		AIClearEventCallback('Futz');
		AIClearEventCallback('MegaFutz');
		AIClearEventCallback('Player');
		AIClearEventCallback('WeaponDrawn');
		AIClearEventCallback('LoudNoise');
		AIClearEventCallback('WeaponFire');
		AIClearEventCallback('Carcass');
		AIClearEventCallback('Distress');

		bInterruptState = false;
		BlockReactions(true);
		bCanConverse = False;
		bStasis = False;
	Style=STY_Translucent;
	Multiskins[6]=Texture'DeusExItems.Skins.PinkMaskTex';
	Acceleration = vect(0,0,0);
	NS = spawn(class'NaxSphere',,,Location,);
	NS.AttachedPlayer = Self;
	NS.GoDoon();
	//Destroy();
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
AllyClass=class'SecuritySniper'
AllianceGroup="Admins"
     BaseAccuracy=-0.550000
     WalkingSpeed=0.280000
     bShowPain=False
     AvoidAccuracy=0.950000
     CloseCombatMult=1.000000
     bReactAlarm=False
	 bKeepWeaponDrawn=True
     SurprisePeriod=0.000000
     BaseAssHeight=-18.000000
     InitialInventory(0)=(Inventory=Class'WeaponRifle')
     InitialInventory(1)=(Inventory=Class'weaponShuriken',Count=36)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponNanoSword')
	 initialInventory(3)=(Inventory=Class'Ammo3006',Count=200)
     BurnPeriod=0.000000
     GroundSpeed=300.000000
     AccelRate=2048.000000
     PeripheralVision=-0.200000
     HearingThreshold=0.010000
     BaseEyeHeight=38.000000
     Health=1750
     CombatStyle=-0.500000
     HealthHead=1750
     HealthTorso=1750
     HealthLegLeft=1750
     HealthLegRight=1750
     HealthArmLeft=1750
     HealthArmRight=1750
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JuanLebedevTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.JuanLebedevTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.Male4Tex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MaxChenTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.JuanLebedevTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionHeight=47.299999
     BindName="Nax"
     FamiliarName="Nax"
     UnfamiliarName="Nax"
     bVisionImportant=False
}
