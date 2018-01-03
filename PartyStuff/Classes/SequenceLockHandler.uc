class SequenceLockHandler extends Actor;

var() int AcceptedSequence;
var int CurrentInput;
var() string SequenceGroup;

var() name PassEvent, FailEvent;

/*function ResetSequence()
{
local SequenceLock SQ;

	foreach AllActors(class'SequenceLock', SQ)
	{
		SQ.bActivated=False;
	}
}*/

function AddSequence(DeusExPlayer DXP, int Seq)
{
local int j;
local string Pre, Aft, ifin;
local actor a;
		Pre = string(currentInput);
		Aft = string(Seq);
		ifin = currentInput$seq;
		CurrentInput = int(ifin);
		DXP.ClientMessage("Sequence"@SequenceGroup$": |P7"$CurrentInput);
		
			if(CurrentInput == AcceptedSequence)
			{
					if(PassEvent != '')
					{
						foreach AllActors( class 'actor', A)
						{
								if(A.Tag == PassEvent)
									A.Trigger( Self, None );
						}
					}
					CurrentInput=0;
					DXP.ClientMessage("Sequence accepted.");
			}
}
