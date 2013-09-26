
#include <AL/al.h>
#include <AL/alc.h>
#include <AL/alut.h>
#include <sys/stat.h>
#include <stdio.h>

int main() {
    alutInit(0, 0);
    ALuint buffer = alutCreateBufferFromFile("test.wav");
    if (buffer == AL_NONE) {
        printf("Error open file\n");
        alDeleteBuffers(1, &buffer);
    }
    int err = alutGetError();
    if(err != AL_NO_ERROR) {
        printf("ALERROR %d\n", err); 
    }
    printf("buffer, err %d %d %d %d\n", buffer, AL_NONE, err, AL_NO_ERROR);
    alutExit();
}
