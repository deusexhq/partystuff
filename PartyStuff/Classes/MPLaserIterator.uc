class MPLaserIterator extends LaserIterator;

function sBeam getBeam(int i)
{
    return beams[i];
}

function Init(PlayerPawn Camera)
{
	local MPLaserEmitter Owner;
	local int i;

	Owner = MPLaserEmitter(Outer);
	if (Owner != None)
	{
		MaxItems = 0;
		nextItem = 0;
		prevLoc = Owner.Location;
		prevRand = vect(0,0,0);
		savedLoc = Owner.Location;
		savedRot = Owner.Rotation;
		proxy = Owner.proxy;
		bRandomBeam = Owner.bRandomBeam;
		if (!Owner.bFrozen && !Owner.bHiddenBeam)
		{
			// set MaxItems based on length of beams
			for (i=0; i<ArrayCount(Beams); i++)
				if (Beams[i].bActive)
					MaxItems += Beams[i].numSegments;

			// make sure we render the last one
			if (MaxItems > 0)
				MaxItems++;
		}
	}
}

defaultproperties
{
}
