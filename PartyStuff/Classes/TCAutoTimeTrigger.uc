class TCAutoTimeTrigger extends Actor;

var() float TCDelay;
var() name Events[10];

function PostBeginPlay()
{
	SetTimer(TCDelay,True);
}

function Timer()
{
local mover a;
local int j;

	for(j=0;j<10;j++)
	{
		if(Events[j] != '')
		{
			foreach AllActors( class 'mover', A)
			{
				for(j=0;j<10;j++)
				{
					if(A.Tag == Events[j])
						A.Trigger( Self, None );
				}
			}
		}
	}
}

defaultproperties
{
     bHidden=True
}
