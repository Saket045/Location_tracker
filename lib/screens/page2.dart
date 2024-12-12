import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/member.dart';

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
  bool _isExpanded = false;

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
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.member.name}\'s Location'),
      ),
      body: Column(
        children: [
          // Top part with Google Map
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isExpanded ? 0 : MediaQuery.of(context).size.height * 0.6,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 15,
              ),
              markers: {_marker},
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          ),
          // Bottom part (expandable)
          Expanded(
            child: GestureDetector(
              onTap: _toggleExpand,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_isExpanded ? 0 : 30),
                    topRight: Radius.circular(_isExpanded ? 0 : 30),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      _isExpanded ? 'Tap to show map' : 'Tap to expand',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Member: ${widget.member.name}\nLocation: ${widget.member.location.name}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
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

