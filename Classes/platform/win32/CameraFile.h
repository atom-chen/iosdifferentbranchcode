//
//  CameraFile.h
//  nozomi
//
//  Created by  stc on 13-4-11.
//
//

#ifndef nozomi_CameraFile_h
#define nozomi_CameraFile_h


#include <stdlib.h>
#include "cocos2d.h"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
using namespace cocos2d;
using namespace cv;


class CameraFile{
public:
    CameraFile();
    ~CameraFile();
    //const char *getFileName();
    //void savedToCamera();
    //void initWriter();
    void startWork(int width, int height);
    void compressFrame(void);
    void stopWork(void);
private:
    float curTime;
    float MaxRecordTime; // 最大视频时间
    float frameRate;  //帧率
    float testTime;

    int winWidth;//屏幕大小
    int winHeight; //屏幕大小
    int width; //视频的 宽度
    int height; //视频的高度

    void *tempCache;
    bool startYet;  //是否开始记录
    int frameCount;
    float totalTime; //当前总共记录的时间

    //使用openCV 记录视频
    VideoWriter *outputVideo;
    Mat *img;
    Mat *dst;
};


#endif
