import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookLocalizationScreen extends StatefulWidget {
  @override
  _BookLocalizationScreenState createState() => _BookLocalizationScreenState();
}

class _BookLocalizationScreenState extends State<BookLocalizationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-9.913550246037811, -63.03498391240491),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('Pokemon'),
            position: LatLng(-9.913550246037811, -63.03498391240491),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          // Aqui você pode interagir com o controlador do mapa, se necessário
        },
      ),
    );
  }
}
