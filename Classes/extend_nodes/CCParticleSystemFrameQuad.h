#ifndef	__CAESARS_NODE_CCPARTICLESYSTEM_FRAMEQUAD_H__
#define __CAESARS_NODE_CCPARTICLESYSTEM_FRAMEQUAD_H__

#include "ExtensionMacros.h"
#include "particle_nodes/CCParticleSystemQuad.h"

NS_CC_EXT_BEGIN

class CCParticleSystemFrameQuad : public CCParticleSystemQuad
{
private:
	unsigned int m_uTotalFrames;
	float** m_pFrameQuads;

	void clearFrameSetting();
public:
	CCParticleSystemFrameQuad(void);
	~CCParticleSystemFrameQuad(void);

	//the frames should have the same size in texture
    virtual void setTextureWithFrames(CCTexture2D* texture, CCArray* frames);

	// CCParticleSystem
	virtual void update(float dt);

	static CCParticleSystemFrameQuad * create();
};
	
NS_CC_EXT_END

#endif //__CAESARS_NODE_CCPARTICLESYSTEM_FRAMEQUAD_H__