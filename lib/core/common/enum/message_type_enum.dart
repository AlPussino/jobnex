enum MessageTypeEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif'),
  file('file'),
  emoji('emoji'),
  location('location'),
  notification('notification');

  const MessageTypeEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  MessageTypeEnum toEnum() {
    switch (this) {
      case 'text':
        return MessageTypeEnum.text;
      case 'image':
        return MessageTypeEnum.image;
      case 'audio':
        return MessageTypeEnum.audio;
      case 'video':
        return MessageTypeEnum.video;
      case 'gif':
        return MessageTypeEnum.gif;
      case 'file':
        return MessageTypeEnum.file;
      case 'location':
        return MessageTypeEnum.location;
      case 'emoji':
        return MessageTypeEnum.emoji;
      case 'notification':
        return MessageTypeEnum.notification;
      default:
        return MessageTypeEnum.text;
    }
  }
}
