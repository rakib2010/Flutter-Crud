class MessageModel{
  late String subject;
  late String content;

//<editor-fold desc="Data Methods">

  MessageModel({
    required this.subject,
    required this.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageModel &&
          runtimeType == other.runtimeType &&
          subject == other.subject &&
          content == other.content);

  @override
  int get hashCode => subject.hashCode ^ content.hashCode;

  @override
  String toString() {
    return '{' +
        ' subject: $subject,' +
        ' content: $content,' +
        '}';
  }


  String toJson() {
    return '{' +
        ' subject: $subject,' +
        ' content: $content,' +
        '}';
  }

  MessageModel copyWith({
    String? subject,
    String? content,
  }) {
    return MessageModel(
      subject: subject ?? this.subject,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': this.subject,
      'content': this.content,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      subject: map['subject'] as String,
      content: map['content'] as String,
    );
  }

//</editor-fold>
}