import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:destination/modals/activitymodal.dart';
import 'package:destination/modals/dishmodal.dart';
import 'package:destination/modals/hotelmodal.dart';
import 'package:destination/modals/placemodal.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RecommendedService {
  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      final path = 'place_images/${DateTime.now()}.png';
      final file = File(imageFile.path);
      final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      ('Error uploading image to firebase storage: $e');
      return null;
    }
  }

  Future<String?> getPlaceIdByPlaceName(String placeName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('places')
          .where('placeName', isEqualTo: placeName)
          .get();
      final documents = querySnapshot.docs;
      if (documents.isNotEmpty) {
        return documents.first.id;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting place ID: $e');
      return null;
    }
  }

  Future<String?> createPlace(PlaceModal place) async {
    try {
      // Add the place document with auto-generated ID
      final placeRef = await FirebaseFirestore.instance
          .collection('places')
          .add(place.toJson());

      print('Place added successfully with ID: ${placeRef.id}');

      return placeRef.id;
    } catch (e) {
      print('Error creating place: $e');
      return null;
    }
  }

  Future<void> updatePlace(PlaceModal place) async {
    try {
      print('Updating place...');
      await FirebaseFirestore.instance
          .collection('places')
          .doc(place.placeId)
          .update(place.toJson());
      print('Place updated successfully');
    } catch (e) {
      print('Error updating place: $e');
    }
  }

  Future<String?> uploadHotelImage(File imageFile) async {
    try {
      final path = 'hotels_images/${DateTime.now()}.png';
      final file = File(imageFile.path);
      final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      ('Error uploading image to firebase storage: $e');
      return null;
    }
  }

  Future<String?> createHotel(HotelModal hotel, String placeId) async {
    try {
      print('Creating hotel with place ID: $placeId');

      final placeDocRef =
          FirebaseFirestore.instance.collection('places').doc(placeId);

      final hotelRef =
          await placeDocRef.collection('hotels').add(hotel.toJson());

      final hotelId = hotelRef.id;

      print(
          'Hotel added successfully with ID: $hotelId to place with ID: $placeId');

      return hotelId;
    } catch (e) {
      print('Error creating hotel: $e');

      return null;
    }
  }

  Future<void> updateHotel(HotelModal hotel) async {
    print('.......');
    print(hotel.placeName);
    try {
      final placeDocRef =
          FirebaseFirestore.instance.collection('places').doc(hotel.placeName);
      final hotelDocRef = placeDocRef
          .collection('hotels')
          .doc(hotel.hotelName); // Assuming each hotel has an ID
      await hotelDocRef.update(hotel.toJson());
      print('Hotel updated successfully');
    } catch (e, stackTrace) {
      print('Error updating hotel: $e');
      print('Document path: ${hotel.hotelName}/hotels/${hotel.hotelName}');
      print('StackTrace: $stackTrace');
    }
  }

  Future<String?> uploadActivitiesImage(File imageFile) async {
    try {
      final path = 'activity_images/${DateTime.now()}.png';
      final file = File(imageFile.path);
      final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      ('Error uploading image to firebase storage: $e');
      return null;
    }
  }

  Future<String?> createActivities(
      ActivitiesModal activity, String placeId) async {
    try {
      print('Creating activities with place ID: $placeId');

      final placeDocRef =
          FirebaseFirestore.instance.collection('places').doc(placeId);

      final activityRef =
          await placeDocRef.collection('activities').add(activity.toJson());
      final activityId = activityRef.id;

      print(
          'activity added successfully with ID: $activityId to place with ID: $placeId');

      return activityId;
    } catch (e) {
      print('Error creating activity: $e');

      return null;
    }
  }

  Future<void> updateActivity(ActivitiesModal activity) async {
    try {
      await FirebaseFirestore.instance
          .collection('activities')
          .doc(activity.placeName)
          .update(activity.toJson());
    } catch (e) {
      print('Error updating place: $e');
    }
  }

  Future<String?> uploadDishImage(File imageFile) async {
    try {
      final path = 'dish_images/${DateTime.now()}.png';
      final file = File(imageFile.path);
      final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      ('Error uploading image to firebase storage: $e');
      return null;
    }
  }

  Future<String?> createDishes(DishModal dish, String placeId) async {
    try {
      print('Creating dishes with place ID: $placeId');

      final placeDocRef =
          FirebaseFirestore.instance.collection('places').doc(placeId);

      final dishRef = await placeDocRef.collection('dishes').add(dish.toJson());

      final dishId = dishRef.id;

      print(
          'activity added successfully with ID: $dishId to place with ID: $placeId');

      return dishId;
    } catch (e) {
      print('Error creating activity: $e');

      return null;
    }
  }

  Future<void> updateDish(DishModal dish) async {
    try {
      await FirebaseFirestore.instance
          .collection('dishes')
          .doc(dish.placeName)
          .update(dish.toJson());
    } catch (e) {
      print('Error updating place: $e');
    }
  }
}
