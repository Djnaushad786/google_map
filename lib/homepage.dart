import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Location _locationController = Location();
  LatLng? _currentPosition;
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> multipleDestinations = [
    LatLng(23.26115964329309, 77.40450302907568),
    LatLng(26.842436286016316, 80.92539629737657),
    LatLng(19.080535461563088, 72.87068586785047),
    LatLng(28.597209967406958, 77.1636520783135),
  ];

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((_) {
      if (_currentPosition != null) {
        for (var destination in multipleDestinations) {
          getPolylinePoint(destination).then((coordinates) {
            generatePolylineFromPoint(coordinates);
          });
        }
      }
    });
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.4275846654225, -122.085485285962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          mapType: MapType.hybrid,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            if (_currentPosition != null)
              Marker(
                markerId: MarkerId('_currentLocation'),
                icon: BitmapDescriptor.defaultMarker,
                position: _currentPosition!,
              ),
            for (var destination in multipleDestinations)
              Marker(
                markerId: MarkerId(destination.toString()),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
                position: destination,
              ),
          },
          polylines: Set<Polyline>.of(polyLines.values),
        ),
      ),
    );
  }

  void _updateCameraPosition(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) return;
    }
    PermissionStatus permission = await _locationController.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _locationController.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }
    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        _updateCameraPosition(_currentPosition!);
      }
    });
  }

  Future<List<LatLng>> getPolylinePoint(LatLng destination) async {
    var apiKey = "YOUR_GOOGLE_MAPS_API_KEY";
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: apiKey,
      request: PolylineRequest(
        origin: PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoint(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId('polyline_${polyLines.length}');
    Polyline newPolyline = Polyline(
      polylineId: id,
      color: Colors.lightBlue,
      points: polylineCoordinates,
      width: 6,
    );
    setState(() {
      polyLines[id] = newPolyline;
    });
  }

}
