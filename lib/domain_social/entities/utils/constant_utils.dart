List<String> getAudioSupportedFormat() {
//https://developer.android.com/guide/topics/media/media-formats
  List<String> androidSupportedMediaFormat = [
    '3gp',
    'mp4',
    'm4a',
    'aac',
    'ts',
    'amr',
    'flac',
    'mid',
    'xmf',
    'mxmf',
    'rtttl',
    'rtx',
    'ota',
    'imy',
    'mp3',
    'mkv',
    'ogg',
    'wav'
  ];
//https://support.apple.com/en-vn/guide/motion/motn1252ada3/mac
  List<String> iosSupportedMediaFormat = ['aac', 'aiff', 'mp3', 'mp4', 'wav'];
  return <String>{...androidSupportedMediaFormat, ...iosSupportedMediaFormat}
      .toList();
}
