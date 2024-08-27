import 'dart:developer';
import 'package:open_geocoder/model/geo_address.dart';
import 'package:open_geocoder/open_geocoder.dart';
import '../common/constant/constant.dart';

Future<String> getCurrentAddress(
    {required double latitude, required double longitude}) async {
  GeoLatLang? geoLatLang = await OpenGeocoder.getAddressWithLatLong(
      latitude: latitude, longitude: longitude);
  if (geoLatLang != null) {
    log('Name: ${geoLatLang.displayName}');
    return geoLatLang.displayName!;
  } else {
    return Constant.unknown;
  }
}
