import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/member.dart'; // Assuming this is where the Member model is defined

class GoogleMapScreen extends StatefulWidget {
  final Member member; // Property to receive the member

  const GoogleMapScreen({Key? key, required this.member}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController _mapController;

  late LatLng _initialPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    // Use member's location to set initial position
    _initialPosition = LatLng(widget.member.location.latitude, widget.member.location.longitude);

    // Add marker based on member's location
    _markers.add(
      Marker(
        markerId: MarkerId(widget.member.id),
        position: _initialPosition,
        infoWindow: InfoWindow(
          title: widget.member.name,
          snippet: widget.member.location.name,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map with Marker for ${widget.member.name}'), // Use the member's name
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 15.0,
        ),
        markers: _markers,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
