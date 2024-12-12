import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/member.dart'; // Assuming this is the provided member.dart
import 'dart:convert'; // For JSON decoding
import 'package:flutter/services.dart'; // For loading assets

class ExpandableMapPage extends StatefulWidget {
  final Member member;

  const ExpandableMapPage({Key? key, required this.member}) : super(key: key);

  @override
  _ExpandableMapPageState createState() => _ExpandableMapPageState();
}

class _ExpandableMapPageState extends State<ExpandableMapPage> {
  late GoogleMapController _mapController;
  late LatLng _initialPosition;
  late Marker _marker;
  Marker? _destinationMarker; // Marker for the destination
  bool _isExpanded = false;

  List<PastLocation> _pastLocations = [];
  Set<Polyline> _polylines = {}; // Store polylines
  Set<Marker> _markers = {}; // Store all markers

  @override
  void initState() {
    super.initState();
    _initialPosition = LatLng(widget.member.location.latitude, widget.member.location.longitude);
    _marker = Marker(
      markerId: MarkerId(widget.member.id),
      position: _initialPosition,
      infoWindow: InfoWindow(
        title: widget.member.name,
        snippet: widget.member.location.name,
      ),
    );

    _markers.add(_marker); // Add initial marker
    _loadPastLocations();
  }

  Future<void> _loadPastLocations() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/members.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Find the matching member from the JSON data
      final memberData = jsonData.firstWhere((data) => data['id'] == widget.member.id);

      // Parse `past_location` from the JSON data
      final List<dynamic> pastLocationData = memberData['past_location'] ?? [];

      setState(() {
        _pastLocations = pastLocationData.map((data) => PastLocation.fromJson(data)).toList();
      });
    } catch (e) {
      print('Error loading past locations: $e');
    }
  }

  void _toggleExpand([bool? forceExpand]) {
    setState(() {
      _isExpanded = forceExpand ?? !_isExpanded;
    });
  }

  void _drawPolyline(LatLng destination) {
    setState(() {
      // Clear existing polylines and destination marker
      _polylines.clear();
      if (_destinationMarker != null) {
        _markers.remove(_destinationMarker);
      }

      // Add new polyline
      _polylines.add(Polyline(
        polylineId: PolylineId('route_to_${destination.latitude}_${destination.longitude}'),
        points: [_initialPosition, destination],
        color: Colors.blue,
        width: 5,
      ));

      // Add destination marker (blue dot)
      _destinationMarker = Marker(
        markerId: MarkerId('destination'),
        position: destination,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Blue marker
        infoWindow: InfoWindow(
          title: 'Destination',
        ),
      );

      // Add destination marker to markers set
      _markers.add(_destinationMarker!);
    });

    // Animate camera to the selected location
    _mapController.animateCamera(CameraUpdate.newLatLng(destination));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set AppBar background to white
        title: Text(
          '${widget.member.name}\'s Location',
          style: TextStyle(color: Colors.black), // Set text color in AppBar to black
        ),
        elevation: 0, // Remove shadow
      ),
      body: Stack(
        children: [
          // Map View
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isExpanded ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * 0.6,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 13,
              ),
              markers: _markers, // Add markers to the map
              polylines: _polylines, // Add polylines to the map
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          ),
          // Expandable Bottom View
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => _toggleExpand(),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isExpanded
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.height * 0.4,
                width: double.infinity, // Ensure it takes the full width
                decoration: BoxDecoration(
                  color: Colors.white, // Set background to white
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _pastLocations.length,
                        itemBuilder: (context, index) {
                          PastLocation loc = _pastLocations[index];
                          LatLng destination = LatLng(loc.latitude, loc.longitude);

                          return GestureDetector(
                            onTap: () {
                              _drawPolyline(destination);
                              _toggleExpand(false); // Collapse the bottom view
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  loc.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  'Entry: ${loc.entryTime}\nExit: ${loc.exitTime}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
