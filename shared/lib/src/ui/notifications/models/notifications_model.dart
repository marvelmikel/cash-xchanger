class UserNotification {
  UserNotification({
    required this.content,
    required this.notificationDate,
    required this.notificationType,
    required this.reference,
    required this.status,
    required this.title,
    required this.userId,
  });

  String content;
  String notificationDate;
  String notificationType;
  String reference;
  bool status;
  String title;
  String userId;

  factory UserNotification.fromMap(Map<String, dynamic> json) =>
      UserNotification(
        content: json['content'] ?? '',
        notificationDate: json['notification_date'] ?? '',
        notificationType: json['notification_type'] ?? '',
        reference: json['reference'] ?? '',
        status: json['status'] ?? '',
        title: json['title'] ?? '',
        userId: json['user_id'] ?? '',
      );

  Map<String, dynamic> toMap() => {
    'content': content,
    'notification_date': notificationDate,
    'notification_type': notificationType,
    'reference': reference,
    'status': status,
    'title': title,
    'user_id': userId,
  };
}
