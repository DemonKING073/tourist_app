class PlaceModal {
  String? placeName;
  String? placeDescription;
  String? category;
  List<String>? images;
  String? userId;
  List<String?>? favouriteBy;
  String? placeId;

  PlaceModal(
      {this.placeName,
      this.placeDescription,
      this.category,
      this.images,
      this.favouriteBy,
      this.userId,
      this.placeId});

  Map<String, dynamic> toJson() {
    return {
      'placeName': placeName,
      'category': category,
      'placeDescription': placeDescription,
      'images': images,
      'favouriteBy': favouriteBy,
      'userId': userId
    };
  }
}
