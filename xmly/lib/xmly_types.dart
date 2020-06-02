typedef IConnectCallback();

typedef OnPlayStart();

typedef OnSoundSwitch();

typedef OnPlayProgress(double progress);

typedef OnPlayPause();

typedef OnBufferProgress(int progress);

typedef OnPlayStop();

typedef OnBufferingStart();

typedef OnSoundPlayComplete();

typedef OnError(String errorMsg);

typedef OnSoundPrepared();

typedef OnBufferingStop();

class IPlayStatusCallback {
  OnPlayStart onPlayStart;
  OnSoundSwitch onSoundSwitch;
  OnPlayProgress onPlayProgress;
  OnPlayPause onPlayPause;
  OnBufferProgress onBufferProgress;
  OnPlayStop onPlayStop;
  OnBufferingStart onBufferingStart;
  OnSoundPlayComplete onSoundPlayComplete;
  OnError onError;
  OnSoundPrepared onSoundPrepared;
  OnBufferingStop onBufferingStop;
}
