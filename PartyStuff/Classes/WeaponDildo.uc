//=============================================
// PlasmaSword
//=============================================
Class WeaponDildo extends WeaponBaton;

var Name WeaponDamageType;
var bool bHard;

function Timer()
{
		mpHitDamage=25;
		mpMaxRange=150;
		bHard=False;
		DeusExPlayer(Owner).ClientMessage("Dildo went soft.");
		
}

function DropFrom(vector StartLocation)
{
	if(bHard)
	{
		DeusExPlayer(Owner).ClientMessage("Your hand has gripped the dildo too hard.");
	}
	else
	{
		super.DropFrom(startLocation);
	}
}

function ScopeToggle()
{
	if(!bHard)
	{
		mpHitDamage=100;
		mpMaxRange=300;
		HitDamage=100;
		MaxRange=300;
		DeusExPlayer(Owner).ClientMessage("Dildo hardened.");
		bHard=True;
	}
	else
	{
		mpHitDamage=25;
		HitDamage=25;
		MaxRange=150;
		mpMaxRange=150;
		bHard=False;
		DeusExPlayer(Owner).ClientMessage("Dildo went soft.");
	}
}

defaultproperties
{
     WeaponDamageType=exploded
     mpHitDamage=25
     mpBaseAccuracy=1.000000
     mpAccurateRange=150
     mpMaxRange=150
     InventoryGroup=141
     ItemName="Dildo"
     Description="A strange, ancient triad weapon. You would be hard pressed finding out anything else about it."
     beltDescription="DILDO"
     Skin=Texture'DildoTex1'
     Fatness=180
     MultiSkins(0)=Texture'DildoTex1'
     Mass=20.000000
}
