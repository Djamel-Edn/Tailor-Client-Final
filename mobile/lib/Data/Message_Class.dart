class Message {
  String ChatId, senderId;
  String? text;
  List<String>? images;
  DateTime date;

  Message(
      {required this.ChatId,
      required this.senderId,
      required this.text,
      required this.images,
      required this.date});
}
