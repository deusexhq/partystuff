//=============================================================================
// SizableEffectSpawner.
//=============================================================================
class SizableEffectSpawner expands Effects;

var() class<SizableEffects> EffectClass;	//type of effect
var() float Interval;		//time between spaws
var() float TimeLimit;			//until when should I spawn? If 0, not limited
var() float SizeofEffect;		//drawscale of effect
var() Texture EffectSkin;		//what is the skin of this effect?
var() float EffectLSpan;		//how much will this effect live?
var() int NumberSpawns;			//if 0, not limited by a number

var float TotalTime, IntervalTime;	
var int spawnedItems;


function Tick(float deltaTime)
{
	local SizableEffects newEffect;

	TotalTime+=deltaTime;
	IntervalTime+=deltaTime;

	if (IntervalTime > Interval)
	{		
		if ((TimeLimit!=0 && TotalTime > TimeLimit) || (NumberSpawns!=0 && spawnedItems >= NumberSpawns))
		{
			Self.Destroy();
		}

		newEffect=Spawn(EffectClass,Owner);
		if (newEffect!=None)
		{
			newEffect.Size=SizeofEffect;
			newEffect.Skin=EffectSkin;
			newEffect.LifeSpan=EffectLSpan;
			spawnedItems++;
		}
		IntervalTime=0;
	}
}

defaultproperties
{
     EffectLSpan=3.000000
     bDirectional=True
}
