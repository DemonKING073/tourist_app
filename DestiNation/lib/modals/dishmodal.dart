class DishModal {
  String? dishName;
  List<String>? dishImage;
  String? dishDescription;
  String? userId;
  String? placeId;
  String? dishId;
  String? placeName;

  DishModal({
    this.dishName,
    this.dishImage,
    this.dishDescription,
    this.userId,
    this.dishId,
    this.placeId,
    this.placeName,
  });

  Map<String, dynamic> toJson() {
    return {
      'dishName': dishName,
      'dishImage': dishImage,
      'dishDescription': dishDescription,
      'userId': userId,
      'placeName': placeName,
    };
  }
}
