#include "particle_nodes/CCParticleBatchNode.h"
#include "sprite_nodes/CCSpriteFrame.h"
#include "textures/CCTextureAtlas.h"
#include "support/CCPointExtension.h"

#include "CCParticleSystemFrameQuad.h"
NS_CC_EXT_BEGIN

CCParticleSystemFrameQuad::CCParticleSystemFrameQuad(void)
: m_uTotalFrames(0),
m_pFrameQuads(NULL)
{
}

CCParticleSystemFrameQuad::~CCParticleSystemFrameQuad(void)
{
	clearFrameSetting();
}

void CCParticleSystemFrameQuad::clearFrameSetting()
{
	if(m_pFrameQuads!=NULL){
		for(unsigned int i=0; i<m_uTotalFrames; i++){
			delete[] m_pFrameQuads[i];
		}
		delete[] m_pFrameQuads;
		m_pFrameQuads = NULL;
	}
	m_uTotalFrames = 0;
}
//the frames should have the same size in texture so shouldn't trim the frame
//I wish this limit will be removed in next moment
void CCParticleSystemFrameQuad::setTextureWithFrames(CCTexture2D* texture, CCArray* frames)
{
    // Only update the texture if is different from the current one
    if( !m_pTexture || texture->getName() != m_pTexture->getName() )
    {
        CCParticleSystem::setTexture(texture);
    }

	clearFrameSetting();
	unsigned int totalFrames = frames->count();
	m_pFrameQuads = new float *[totalFrames];
	for(unsigned int i=0; i<totalFrames;i++){
		CCSpriteFrame *frame = dynamic_cast<CCSpriteFrame*>(frames->objectAtIndex(i));
		if(frame==NULL || frame->getTexture()->getName()!= m_pTexture->getName())
			continue;
		
		CCRect rect = frame->getRect();

		float* m_sQuad = new float[4];
		m_pFrameQuads[m_uTotalFrames] = m_sQuad;
		m_uTotalFrames++;

		float atlasWidth = (float)m_pTexture->getPixelsWide();
		float atlasHeight = (float)m_pTexture->getPixelsHigh();

		float left, right, top, bottom;

		if (frame->isRotated())
		{
	#if CC_FIX_ARTIFACTS_BY_STRECHING_TEXEL
			left    = (2*rect.origin.x+1)/(2*atlasWidth);
			right    = left+(rect.size.height*2-2)/(2*atlasWidth);
			top        = (2*rect.origin.y+1)/(2*atlasHeight);
			bottom    = top+(rect.size.width*2-2)/(2*atlasHeight);
	#else
			left    = rect.origin.x/atlasWidth;
			right    = (rect.origin.x+rect.size.height) / atlasWidth;
			top        = rect.origin.y/atlasHeight;
			bottom    = (rect.origin.y+rect.size.width) / atlasHeight;
	#endif // CC_FIX_ARTIFACTS_BY_STRECHING_TEXEL
		}
		else
		{
	#if CC_FIX_ARTIFACTS_BY_STRECHING_TEXEL
			left    = (2*rect.origin.x+1)/(2*atlasWidth);
			right    = left + (rect.size.width*2-2)/(2*atlasWidth);
			top        = (2*rect.origin.y+1)/(2*atlasHeight);
			bottom    = top + (rect.size.height*2-2)/(2*atlasHeight);
	#else
			left    = rect.origin.x/atlasWidth;
			right    = (rect.origin.x + rect.size.width) / atlasWidth;
			top        = rect.origin.y/atlasHeight;
			bottom    = (rect.origin.y + rect.size.height) / atlasHeight;
	#endif // ! CC_FIX_ARTIFACTS_BY_STRECHING_TEXEL
		}
		m_sQuad[0] = left;
		m_sQuad[1] = right;
		m_sQuad[2] = top;
		m_sQuad[3] = bottom;
	}

    GLfloat wide = (GLfloat)m_pTexture->getPixelsWide();
    GLfloat high = (GLfloat)m_pTexture->getPixelsHigh();

    ccV3F_C4B_T2F_Quad *quads = NULL;
    unsigned int start = 0, end = 0;
    if (m_pBatchNode)
    {
        quads = m_pBatchNode->getTextureAtlas()->getQuads();
        start = m_uAtlasIndex;
        end = m_uAtlasIndex + m_uTotalParticles;
    }
    else
    {
        quads = m_pQuads;
        start = 0;
        end = m_uTotalParticles;
    }

    for(unsigned int i=start; i<end; i++) 
    {
		int fid = rand()%m_uTotalFrames;
		float* m_sQuad = m_pFrameQuads[fid];
        // bottom-left vertex:
        quads[i].bl.texCoords.u = m_sQuad[0];
        quads[i].bl.texCoords.v = m_sQuad[3];
        // bottom-right vertex:
        quads[i].br.texCoords.u = m_sQuad[1];
        quads[i].br.texCoords.v = m_sQuad[3];
        // top-left vertex:
        quads[i].tl.texCoords.u = m_sQuad[0];
        quads[i].tl.texCoords.v = m_sQuad[2];
        // top-right vertex:
        quads[i].tr.texCoords.u = m_sQuad[1];
        quads[i].tr.texCoords.v = m_sQuad[2];
    }
}

void CCParticleSystemFrameQuad::update(float dt)
{
    CC_PROFILER_START_CATEGORY(kCCProfilerCategoryParticles , "CCParticleSystemFrameQuad - update");

    if (m_bIsActive && m_fEmissionRate)
    {
        float rate = 1.0f / m_fEmissionRate;
        //issue #1201, prevent bursts of particles, due to too high emitCounter
        if (m_uParticleCount < m_uTotalParticles)
        {
            m_fEmitCounter += dt;
        }
        
        while (m_uParticleCount < m_uTotalParticles && m_fEmitCounter > rate) 
        {
            this->addParticle();
            m_fEmitCounter -= rate;
        }

        m_fElapsed += dt;
        if (m_fDuration != -1 && m_fDuration < m_fElapsed)
        {
            this->stopSystem();
        }
    }

    m_uParticleIdx = 0;

    CCPoint currentPosition = CCPointZero;
    if (m_ePositionType == kCCPositionTypeFree)
    {
        currentPosition = this->convertToWorldSpace(CCPointZero);
    }
    else if (m_ePositionType == kCCPositionTypeRelative)
    {
        currentPosition = m_obPosition;
    }

    if (m_bVisible)
    {
        while (m_uParticleIdx < m_uParticleCount)
        {
            tCCParticle *p = &m_pParticles[m_uParticleIdx];

            // life
            p->timeToLive -= dt;

            if (p->timeToLive > 0) 
            {
                // Mode A: gravity, direction, tangential accel & radial accel
                if (m_nEmitterMode == kCCParticleModeGravity) 
                {
                    CCPoint tmp, radial, tangential;

                    radial = CCPointZero;
                    // radial acceleration
                    if (p->pos.x || p->pos.y)
                    {
                        radial = ccpNormalize(p->pos);
                    }
                    tangential = radial;
                    radial = ccpMult(radial, p->modeA.radialAccel);

                    // tangential acceleration
                    float newy = tangential.x;
                    tangential.x = -tangential.y;
                    tangential.y = newy;
                    tangential = ccpMult(tangential, p->modeA.tangentialAccel);

                    // (gravity + radial + tangential) * dt
                    tmp = ccpAdd( ccpAdd( radial, tangential), modeA.gravity);
                    tmp = ccpMult( tmp, dt);
                    p->modeA.dir = ccpAdd( p->modeA.dir, tmp);
                    tmp = ccpMult(p->modeA.dir, dt);
                    p->pos = ccpAdd( p->pos, tmp );
                }

                // Mode B: radius movement
                else 
                {                
                    // Update the angle and radius of the particle.
                    p->modeB.angle += p->modeB.degreesPerSecond * dt;
                    p->modeB.radius += p->modeB.deltaRadius * dt;

                    p->pos.x = - cosf(p->modeB.angle) * p->modeB.radius;
                    p->pos.y = - sinf(p->modeB.angle) * p->modeB.radius;
                }

                // color
                p->color.r += (p->deltaColor.r * dt);
                p->color.g += (p->deltaColor.g * dt);
                p->color.b += (p->deltaColor.b * dt);
                p->color.a += (p->deltaColor.a * dt);

                // size
                p->size += (p->deltaSize * dt);
                p->size = MAX( 0, p->size );

                // angle
                p->rotation += (p->deltaRotation * dt);

                //
                // update values in quad
                //

                CCPoint    newPos;

                if (m_ePositionType == kCCPositionTypeFree || m_ePositionType == kCCPositionTypeRelative) 
                {
                    CCPoint diff = ccpSub( currentPosition, p->startPos );
                    newPos = ccpSub(p->pos, diff);
                } 
                else
                {
                    newPos = p->pos;
                }

                // translate newPos to correct position, since matrix transform isn't performed in batchnode
                // don't update the particle with the new position information, it will interfere with the radius and tangential calculations
                if (m_pBatchNode)
                {
                    newPos.x+=m_obPosition.x;
                    newPos.y+=m_obPosition.y;
                }

                updateQuadWithParticle(p, newPos);
                //updateParticleImp(self, updateParticleSel, p, newPos);

                // update particle counter
                ++m_uParticleIdx;
            } 
            else 
            {
                // life < 0
                int currentIndex = p->atlasIndex;
                if( m_uParticleIdx != m_uParticleCount-1 )
                {
                    m_pParticles[m_uParticleIdx] = m_pParticles[m_uParticleCount-1];
                }
                if (m_pBatchNode)
                {
                    //disable the switched particle
                    m_pBatchNode->disableParticle(m_uAtlasIndex+currentIndex);

                    //switch indexes
                    m_pParticles[m_uParticleCount-1].atlasIndex = currentIndex;
                }
				else if( m_uParticleIdx != m_uParticleCount-1 )
				{
					//switch quads texCoords
					ccV3F_C4B_T2F_Quad temp = m_pQuads[m_uParticleIdx];
					m_pQuads[m_uParticleIdx] = m_pQuads[m_uParticleCount-1];
					m_pQuads[m_uParticleCount-1] = temp;
				}


                --m_uParticleCount;

                if( m_uParticleCount == 0 && m_bIsAutoRemoveOnFinish )
                {
                    this->unscheduleUpdate();
                    m_pParent->removeChild(this, true);
                    return;
                }
            }
        } //while
        m_bTransformSystemDirty = false;
    }
    if (! m_pBatchNode)
    {
        postStep();
    }

    CC_PROFILER_STOP_CATEGORY(kCCProfilerCategoryParticles , "CCParticleSystemFrameQuad - update");
}

CCParticleSystemFrameQuad * CCParticleSystemFrameQuad::create() {
    CCParticleSystemFrameQuad *pParticleSystemFrameQuad = new CCParticleSystemFrameQuad();
    if (pParticleSystemFrameQuad && pParticleSystemFrameQuad->init())
    {
        pParticleSystemFrameQuad->autorelease();
        return pParticleSystemFrameQuad;
    }
    CC_SAFE_DELETE(pParticleSystemFrameQuad);
    return NULL;
}

NS_CC_EXT_END