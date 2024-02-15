import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  BitmapDescriptor? _customMarkerIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    final response =
        await http.get(Uri.parse('https://example.com/custom_marker.png'));
    final bytes = response.bodyBytes;
    final BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromBytes(bytes);
    setState(() {
      _customMarkerIcon = bitmapDescriptor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.999952, 21.419477),
          zoom: 12,
        ),
        markers: _customMarkerIcon != null
            ? Set<Marker>.of(_createMarkers())
            : {}, // Check if icon is initialized
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }

  List<Marker> _createMarkers() {
    return [
      Marker(
        markerId: const MarkerId('marker_1'),
        position: const LatLng(41.999952, 21.419477), // San Francisco coordinates
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    ];
  }
}
