import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookLocalizationScreen extends StatefulWidget {
  const BookLocalizationScreen({Key? key}) : super(key: key);

  @override
  _BookLocalizationScreenState createState() => _BookLocalizationScreenState();
}

class _BookLocalizationScreenState extends State<BookLocalizationScreen> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    //_loadCustomIcon();
  }

  @override
  Widget build(BuildContext context) {
    //_loadCustomIcon();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localização Aproximada do Livro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-9.908715120057176, -63.03458896814527), // Substitua latitude e longitude pelas coordenadas reais do livro
                  zoom: 20,
                ),
                markers: <Marker>{
                  Marker(
                    markerId: MarkerId('Livro'),
                    position: LatLng(-9.908715120057176, -63.03458896814527),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
