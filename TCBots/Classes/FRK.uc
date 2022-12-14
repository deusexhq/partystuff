//=============================================================================
// Karkian.
//=============================================================================
class FRK extends Karkian;

var float FlameTime;
var float FlameRand;
var float ProjRandom;

function Tick(float deltaSeconds)
{
	Super.Tick(deltaSeconds);

	FlameRand=rand(11);
	FlameTime += deltaSeconds;
	if((AnimSequence=='Attack')||(AnimSequence=='Run')||(AnimSequence=='Roar'))
	{
		if (FlameTime > 0.25)  //spawn once every 1/4 second
		{
			If (FlameRand<8)
			{
				FlameTime = 0;
					ProjRandom=rand(5);
					
					if(ProjRandom==0)
					{
						Spawn(class'Rocket', Self, , Location + vect(0,0,-2));
					}
					if(ProjRandom==1)
					{
						Spawn(class'RocketMini', Self, , Location + vect(0,0,-2));
					}
					if(ProjRandom==2)
					{
						Spawn(class'RocketLAW', Self, , Location + vect(0,0,-2));
					}
					if(ProjRandom==3)
					{
						Spawn(class'Rocket', Self, , Location + vect(0,0,-2));
					}
					if(ProjRandom==4)
					{
						Spawn(class'RocketMini', Self, , Location + vect(0,0,-2));
					}
					if(ProjRandom==5)
					{
						Spawn(class'RocketMini', Self, , Location + vect(0,0,-2));
					}
			}
			else
			{
				FlameTime=0;
			}
		}
	}
}

defaultproperties
{
    InitialAlliances=[  ??
    bCanGlide=True
    Health=700
    Physics=4
    BindName="FRK"
    FamiliarName="Flying Rocket Karkian"
    UnfamiliarName="Flying Rocket Karkian"
}
