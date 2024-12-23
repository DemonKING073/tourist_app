class ActivitiesModal {
  String? activityName;
  List<String>? activityImage;
  String? activityDescription;
  String? userId;
  String? placeName;
  String? placeId;
  String? activityId;

  ActivitiesModal(
      {this.activityName,
      this.activityImage,
      this.activityDescription,
      this.userId,
      this.placeName,
      this.activityId,
      this.placeId});

  Map<String, dynamic> toJson() {
    return {
      'activityName': activityName,
      'activityImage': activityImage,
      'activityDescription': activityDescription,
      'userId': userId,
      'placeName': placeName,
    };
  }
}
