//=============================================================================
// ssRing.  Copyright (C) 2002 Hejhujka & Luminous Path.
//=============================================================================
class SSRing extends SphereEffect;

var float blastRadius;

simulated function Tick(float deltaTime)
{
 
 Super.Tick(DeltaTime);

 DrawScale = 3.0 * size * (Default.LifeSpan - LifeSpan) / Default.LifeSpan;
 ScaleGlow = 1.1 * (LifeSpan / Default.Lifespan);
    }

defaultproperties
{
     LifeSpan=2.500000
     Skin=FireTexture'Effects.liquid.Virus_SFX'
}
