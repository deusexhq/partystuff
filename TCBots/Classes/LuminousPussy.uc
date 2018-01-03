class LuminousPussy extends PetsCat;

function PreBeginPlay()
{
	local Vector v1, v2;
	local Luminous Lum;

	Super.PreBeginPlay();

	lum = Spawn(class'Luminous', Self,, Location,);
	if (lum != None)
	{
		v2 = Location;
		v2.Z += collisionHeight + 40;
		lum.SetLocation(v2);
		lum.LumOwner = Self;
		//lum.SetBase(Self);
	}

}

defaultproperties
{
     bShowPain=False
     InitialAlliances(0)=(AllianceName=Player,AllianceLevel=1.000000)
     InitialAlliances(1)=(AllianceName=Mutt,AllianceLevel=1.000000)
     InitialAlliances(2)=(AllianceName=Cat,AllianceLevel=-1.000000)
     Health=600
     BindName="LuminousPussy"
     FamiliarName="Luminous Cat"
     UnfamiliarName="Luminous Cat"
}
