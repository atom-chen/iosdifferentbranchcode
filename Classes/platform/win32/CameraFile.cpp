#include "CameraFile.h"
CameraFile::CameraFile() {
    MaxRecordTime = 1000;
    frameRate = 1./25;  //0.1s 1帧
    startYet = false;
    testTime = 10000000;//10s -->4s 为什么时间不对呢？
}
void CameraFile::startWork(int w, int h) {
    curTime = 0;
    winWidth = w;
    winHeight = h;

    width = w;
    height = h;
    
    tempCache = malloc(sizeof(int)*w);
    
    startYet = true;
    frameRate = 1.0/25; //每s 30 帧

    totalTime = 0;
    frameCount = 0;

    outputVideo = new VideoWriter();
    //内部不用确定文件位置 由外部控制文件位置
    string name = "GameVideo.avi";
    Size s = Size(width, height);
    int ncodec = CV_FOURCC('M', 'P', '4', '2');
    //FFMPEG broken x264 i should use directly x264 API or use other API
    //int ncodec = CV_FOURCC('X', '2', '6', '4');
    outputVideo->open(name, ncodec, 25, s, true); 
    
    if(!outputVideo->isOpened()) {
        printf("not opened output video\n");
        return ;
    }
    
    img = new Mat(height, width, CV_8UC3);
    dst = new Mat(height, width, CV_8UC3);
    glPixelStorei(GL_PACK_ALIGNMENT, (img->step&3)?1:4);
    glPixelStorei(GL_PACK_ROW_LENGTH, img->step/img->elemSize());
    printf("before system\n");
    CCDirector::sharedDirector()->startRecording();
}
void CameraFile::stopWork() {
    CCDirector::sharedDirector()->stopRecording();
    delete outputVideo;
    delete img;
    delete dst;
    outputVideo = NULL;
    free(tempCache);
}
void CameraFile::compressFrame() {
    glReadPixels(0, 0, img->cols, img->rows, GL_BGR, GL_UNSIGNED_BYTE, img->data);    
    cv::flip(*img, *dst, 0);
    (*outputVideo) << (*dst);
}

