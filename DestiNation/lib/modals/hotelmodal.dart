class HotelModal {
  String? hotelName;
  List<String>? hotelImg;
  String? hotelNum;
  String? hotelEmail;
  String? userId;
  String? placeName;
  String? placeId;
  String? hotelId;

  HotelModal(
      {this.hotelName,
      this.hotelImg,
      this.hotelNum,
      this.hotelEmail,
      this.userId,
      this.placeName,
      this.hotelId,
      this.placeId});

  Map<String, dynamic> toJson() {
    return {
      'hotelName': hotelName,
      'hotelNum': hotelNum,
      'hotelEmail': hotelEmail,
      'hotelImg': hotelImg,
      'userId': userId,
      'placeName': placeName,
    };
  }
}
