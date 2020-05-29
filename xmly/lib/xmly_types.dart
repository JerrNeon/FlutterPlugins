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
  OnPlayStart _onPlayStart;
  OnSoundSwitch _onSoundSwitch;
  OnPlayProgress _onPlayProgress;
  OnPlayPause _onPlayPause;
  OnBufferProgress _onBufferProgress;
  OnPlayStop _onPlayStop;
  OnBufferingStart _onBufferingStart;
  OnSoundPlayComplete _onSoundPlayComplete;
  OnError _onError;
  OnSoundPrepared _onSoundPrepared;
  OnBufferingStop _onBufferingStop;

  set setOnPlayStart(OnPlayStart onPlayStart) => _onPlayStart = onPlayStart;

  OnPlayStart get onPlayStart => _onPlayStart;

  set setOnSoundSwitch(OnSoundSwitch onSoundSwitch) =>
      _onSoundSwitch = onSoundSwitch;

  OnSoundSwitch get onSoundSwitch => _onSoundSwitch;

  set setOnPlayProgress(OnPlayProgress onPlayProgress) =>
      _onPlayProgress = onPlayProgress;

  OnPlayProgress get onPlayProgress => _onPlayProgress;

  set setOnPlayPause(OnPlayPause onPlayPause) => _onPlayPause = onPlayPause;

  OnPlayPause get onPlayPause => _onPlayPause;

  set setOnBufferProgress(OnBufferProgress onBufferProgress) =>
      _onBufferProgress = onBufferProgress;

  OnBufferProgress get onBufferProgress => _onBufferProgress;

  set setOnPlayStop(OnPlayStop onPlayStop) => _onPlayStop = onPlayStop;

  OnPlayStop get onPlayStop => _onPlayStop;

  set setOnBufferingStart(OnBufferingStart onBufferingStart) =>
      _onBufferingStart = onBufferingStart;

  OnBufferingStart get onBufferingStart => _onBufferingStart;

  set setOnSoundPlayComplete(OnSoundPlayComplete onSoundPlayComplete) =>
      _onSoundPlayComplete = onSoundPlayComplete;

  OnSoundPlayComplete get onSoundPlayComplete => _onSoundPlayComplete;

  set setOnError(OnError onError) => _onError = onError;

  OnError get onError => _onError;

  set setOnSoundPrepared(OnSoundPrepared onSoundPrepared) =>
      _onSoundPrepared = onSoundPrepared;

  OnSoundPrepared get onSoundPrepared => _onSoundPrepared;

  set setOnBufferingStop(OnBufferingStop onBufferingStop) =>
      _onBufferingStop = onBufferingStop;

  OnBufferingStop get onBufferingStop => _onBufferingStop;
}
