//=============================================================================
// SecurityForce.
//=============================================================================
class Xephiro extends DXEnemy;

function Carcass SpawnCarcass()
{
	Explode();

	return None;
}

function Explode()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 100;
	explosionRadius = 1000;

	// alert NPCs that I'm exploding
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, Location);
	if (light != None)
		light.size = 4;

	Spawn(class'ExplosionSmall',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionLarge',,, Location + 2*VRand()*CollisionRadius);

	sphere = Spawn(class'SphereEffect',,, Location);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;
		sphere.Skin=FireTexture'Effects.Electricity.Virus_SFX';
		sphere.Texture=FireTexture'Effects.Electricity.Virus_SFX';

	// spawn a mark
	s = spawn(class'ScorchMark', Base,, Location-vect(0,0,1)*CollisionHeight, Rotation+rot(16384,0,0));
	if (s != None)
	{
		s.DrawScale = FClamp(explosionDamage/30, 0.1, 3.0);
		s.ReattachDecal();
	}

	// spawn some rocks and flesh fragments
	for (i=0; i<explosionDamage/6; i++)
	{
		if (FRand() < 0.3)
			spawn(class'Rockchip',,,Location);
		else
			spawn(class'FleshFragment',,,Location);
	}

	HurtRadius(explosionDamage, explosionRadius, 'Burned', explosionDamage*100, Location);
}

function PostBeginPlay()
{
local int MeshRand, MeshFinalize;
MeshRand = 4;
	//branch for GM_Trench
	if(MeshRand <= 5)
	{
		bIsFemale=False;
		MeshFinalize=1;
		Mesh=LodMesh'DeusExCharacters.GM_Trench';
	}
	//branch for GFM_Trench
	if(MeshRand >= 6)
	{
		bIsFemale=True;
		MeshFinalize=2;
		Mesh=LodMesh'DeusExCharacters.GFM_Trench';
	}	

	Skinner(MeshFinalize);
	super.PostBeginPlay();
}

function Skinner(int MeshType)
{
local int rHead, rCoat, rTop, rPants;
		rHead = Rand(7);
		rCoat = Rand(6);
		rTop = Rand(6);
		rPants = Rand(6);
		
	if(rCoat == 0)
	{
	MultiSkins[1] = Texture'DeusExCharacters.Skins.WaltonSimonsTex2';
	MultiSkins[5] = Texture'DeusExCharacters.Skins.WaltonSimonsTex2';
	}
	if(rCoat == 1)
	{
	MultiSkins[1] = Texture'DeusExCharacters.Skins.TriadRedArrowTex2';
	MultiSkins[5] = Texture'DeusExCharacters.Skins.TriadRedArrowTex2';
	}		
	if(rCoat == 2)
	{
	MultiSkins[1] = Texture'DeusExCharacters.Skins.TrenchCoatTex1';
	MultiSkins[5] = Texture'DeusExCharacters.Skins.TrenchCoatTex1';
	}	
	if(rCoat == 3)
	{
	MultiSkins[1] = Texture'DeusExCharacters.Skins.TobyAtanweTex2';
	MultiSkins[5] = Texture'DeusExCharacters.Skins.TobyAtanweTex2';
	}			
	if(rCoat == 4)
	{
	MultiSkins[1] = Texture'DeusExCharacters.Skins.StantonDowdTex2';
	MultiSkins[5] = Texture'DeusExCharacters.Skins.StantonDowdTex2';
	}			
	if(rCoat == 5)
	{
	MultiSkins[1] = Texture'DeusExCharacters.Skins.SmugglerTex2';
	MultiSkins[5] = Texture'DeusExCharacters.Skins.SmugglerTex2';
	}			
	if(rCoat == 6)
	{
	MultiSkins[1] = Texture'DeusExCharacters.Skins.GilbertRentonTex2';
	MultiSkins[5] = Texture'DeusExCharacters.Skins.GilbertRentonTex2';
	}		
	
	if(rTop == 0)
	{
	MultiSkins[4] = Texture'DeusExCharacters.Skins.FordSchickTex1';
	}
	if(rTop == 1)
	{
	MultiSkins[4] = Texture'DeusExCharacters.Skins.GilbertRentonTex1';
	}		
	if(rTop == 2)
	{
	MultiSkins[4] = Texture'DeusExCharacters.Skins.TrenchShirtTex2';
	}	
	if(rTop == 3)
	{
	MultiSkins[4] = Texture'DeusExCharacters.Skins.JockTex1';
	}			
	if(rTop == 4)
	{
	MultiSkins[4] = Texture'DeusExCharacters.Skins.JuanLebedevTex1';
	}			
	if(rTop == 5)
	{
	MultiSkins[4] = Texture'DeusExCharacters.Skins.ThugMaleTex1';
	}			
	if(rTop == 6)
	{
	MultiSkins[4] = Texture'DeusExCharacters.Skins.TobyAtanweTex1';
	}		

	if(rPants == 0)
	{
	MultiSkins[2] = Texture'DeusExCharacters.Skins.TriadRedArrowTex3';
	}
	if(rPants == 1)
	{
	MultiSkins[2] = Texture'DeusExCharacters.Skins.TiffanySavageTex2';
	}		
	if(rPants == 2)
	{
	MultiSkins[2] = Texture'DeusExCharacters.Skins.ThugMale2Tex2';
	}	
	if(rPants == 3)
	{
	MultiSkins[2] = Texture'DeusExCharacters.Skins.SoldierTex2';
	}			
	if(rPants == 4)
	{
	MultiSkins[2] = Texture'DeusExCharacters.Skins.SamCarterTex2';
	}			
	if(rPants == 5)
	{
	MultiSkins[2] = Texture'DeusExCharacters.Skins.PantsTex4';
	}			
	if(rPants == 6)
	{
	MultiSkins[2] = Texture'DeusExCharacters.Skins.JunkieFemaleTex2';
	}		

	if(MeshType == 1) //Male Trench
	{
		if(rHead == 0)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.AlexJacobsonTex0';
		}
		if(rHead == 1)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.ThugMaleTex0';
		}		
		if(rHead == 2)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.BumMale2Tex0';
		}	
		if(rHead == 3)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.ButlerTex0';
		}			
		if(rHead == 4)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.ThugMale3Tex0';
		}			
		if(rHead == 5)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.GarySavageTex0';
		}			
		if(rHead == 6)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.JunkieMaleTex0';
		}		
		if(rHead == 7)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.SkinTex4';
		}
	}
	if(MeshType == 2) //Female Trench
	{
		if(rHead == 0)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.JunkieFemaleTex0';
		}
		if(rHead == 1)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.TiffanySavageTex0';
		}		
		if(rHead == 2)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.SkinTex5';
		}	
		if(rHead == 3)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.ScientistFemaleTex0';
		}			
		if(rHead == 4)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.SarahMeadTex0';
		}			
		if(rHead == 5)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.Female4Tex0';
		}			
		if(rHead == 6)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.Female1Tex0';
		}		
		if(rHead == 7)
		{
		MultiSkins[0] = Texture'DeusExCharacters.Skins.BumFemaleTex0';
		}	
	}
}


defaultproperties
{     
	AllyClass=class'ForgottenEnemy'
	tScanning="Come on out, noob."
	tTargetAcquired="Finally you come to fight me."
	tTargetLost="Why are you so nooby."
	tCriticalDamage="Abuse, fucking noob admin!"
	tAreaSecure="My area, no noobs."
	tBossArmourDown="Stop abusing admin."
	tBossArmourBack="JUSTICE."
	tMedkitUsed="Noobs dont know about medkits."
	tCallingBackup="APEX SWARMMMMMM."
	Medkits=5
	bReturnArmour=True
	ReturnArmour=250
	bHasCloakX=True
	InitialAlliances(3)=(AllianceName=Forgotten,AllianceLevel=1.000000)
     scoreCredits=3000
     WalkingSpeed=0.213333
     walkAnimMult=0.750000
     GroundSpeed=220.000000
	 InitialInventory(0)=(Inventory=Class'WeaponPlasmaRifle')
     InitialInventory(1)=(Inventory=Class'AmmoPlasma', Count=999)
	 InitialInventory(0)=(Inventory=Class'WeaponSawedOffShotgun')
     InitialInventory(1)=(Inventory=Class'AmmoShell', Count=999)
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MIBTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.TrenchCoatTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.JoJoFineTex2'
     MultiSkins(3)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JockTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.TrenchCoatTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
	      HealthHead=900
     HealthTorso=900
     HealthLegLeft=900
     HealthLegRight=900
     HealthArmLeft=900
     HealthArmRight=900
     BindName="Forgotten"
	 nameArticle="The Apex Troll, "
     FamiliarName="Xephiro"
     UnfamiliarName="Xephiro"
	 
}
