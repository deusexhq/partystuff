//=============================================
// PlasmaSword
//=============================================
Class WeaponAugrist extends WeaponNanoSword;

#exec OBJ LOAD FILE="..\Textures\Effects.utx"

/*enum eChk
{
	CH_Elec,
	CH_Flame,
	CH_Drain,
	CH_None
};

var() eChk Spell;*/
var() int spell, lve, lvl;
var() bool bLockState;

/*function BeginPlay()
{
local WeaponAugrist Augrist;
local bool bFound;

	foreach AllActors(class'WeaponAugrist', Augrist)
		if(Augrist != Self)
			bFound=True;
	
	if(bFound) Destroy();
}*/

function Tick(float Deltatime)
{
	super.Tick(deltatime);
	
     LightHue++;
	if(LightHue >= 255)
	{
		LightHue=0;
	}
     LightSaturation=126;
	
	
//	DXP.TakeDamage(1, DeusExPlayer(Owner), DXP.Location, vect(0,0,0), 'EMP');
}

/*function GiveTo( pawn Other )
{
local inventory inv;

    super.Giveto(Other);
		inv=Spawn(class'WeaponAugrist');
		Inv.Frob(DeusExPlayer(Other),None);	  
		Inv.bInObjectBelt = True;
		inv.Destroy();
	Destroy();
}*/

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

state DownWeapon
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_None;

	}
}

state Idle
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_Steady;
	}
}

auto state Pickup
{
	function EndState()
	{
		Super.EndState();
		LightType = LT_None;
	}
}

simulated function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local DeusExPlayer dxPlayer;
	local int Bloodinc;
	dxplayer = deusexplayer(other);
	super.ProcessTraceHit(other, hitlocation, hitnormal, x, y, z);
	if(Other.isa('Pawn') || Other.IsA('DeusExCarcass'))
	{
		Evolve(Rand(30));
		return;
	}
	

}

function Evolve(int i)
{
	lve+=i;
	if(lve >= 100*lvl)
	{
		DeusExPlayer(Owner).ClientMessage(ItemArticle@ItemName$" grows stronger...");
		lvl++;
		lve=0;
	}
}

function AugExp(int Spell)
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;
	local DeusExPlayer DXP;
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

	if(Spell == 0) //Elec
	{
		foreach VisibleActors(class'DeusExPlayer', DXP, 150)
		{
			if(DXP != Owner)
			{
				DXP.TakeDamage(20*lvl,DeusExPlayer(Owner),DXP.Location,vect(0,0,1),'EMP');
			}
		}
	}
	else if(Spell == 1) //Flame
	{
		foreach VisibleActors(class'DeusExPlayer', DXP, 150)
		{
			if(DXP != Owner)
			{
				DXP.TakeDamage(20*lvl,DeusExPlayer(Owner),DXP.Location,vect(0,0,1),'Burned');
			}
		}
	}
	else if(Spell == 2) //Drain
	{
		foreach VisibleActors(class'DeusExPlayer', DXP, 150)
		{
			if(DXP != Owner)
			{
				DXP.TakeDamage(15*lvl,DeusExPlayer(Owner),DXP.Location,vect(0,0,1),'Special');
				DeusExPlayer(Owner).HealPlayer(50, True);
			}
		}
	}
}

function bool EnergyUse(int i)
{
	if(DeusExPlayer(Owner).Energy > i)
	{
		DeusExPlayer(Owner).Energy -= i;
		return true;
	}
}

function ScopeToggle()
{
	if(Spell == 0)
	{
		DeusExPlayer(Owner).ClientMessage("Flame spell active.");
		Spell = 1;
		return;
	}
	else if(Spell == 1)
	{
		DeusExPlayer(Owner).ClientMessage("Drain spell active.");
		Spell = 2;
		return;
	}
	else if(Spell == 2)
	{
		DeusExPlayer(Owner).ClientMessage("Electric spell active.");
		Spell = 0;
		return;
	}
}

function LaserToggle()
{
	if(Spell == 0 && !EnergyUse(10))
			return;
	if(Spell == 1 && !EnergyUse(20))
			return;
	if(Spell == 2 && !EnergyUse(40))
			return;
	AugExp(Spell);
}

function CycleAmmo()
{
	local Augrist GA;
	
	GA = Spawn(class'Augrist',,,Owner.Location);
	GA.spell = spell;
	GA.lve = lve;
	GA.lvl = lvl;
	Destroy();
}

defaultproperties
{
     InventoryGroup=111867
     ItemName="Augrist"
	 ItemArticle="the"
     Description="A strange, ancient triad weapon. You would be hard pressed finding out anything else about it."
     beltDescription="AUGRIST"
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
	 MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(4)=Texture'wtf' //FireTexture'Effects.Electricity.Wepn_EMPG_SFX'
     MultiSkins(5)=Texture'wtf' //FireTexture'Effects.Electricity.Wepn_EMPG_SFX'
	 MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
	 MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     LightHue=128
     lighteffect=LE_nonincidence
}
