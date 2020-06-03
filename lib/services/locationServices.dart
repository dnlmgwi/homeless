import 'package:geolocator/geolocator.dart';

class LocationServices {
  //Keys
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position currentPosition;
  String currentAddress;

  Future<Placemark> getLatLngFromAddress({String address}) async {
    try {
      List<Placemark> placemark =
          await Geolocator().placemarkFromAddress("$address");

      Placemark place = placemark[0];

      return place;
    } catch (e) {
      print(e);
    }
  }

  getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      currentPosition = position;
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      currentAddress =
          // "${place.country}, ${place.locality}, ${place.postalCode}, ${place.locality}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.name}";
          "${place.country}, ${place.locality}, ${place.postalCode}, ${place.locality}";
    } catch (e) {
      print(e);
    }
  }
}

LocationServices locationServices = LocationServices();
