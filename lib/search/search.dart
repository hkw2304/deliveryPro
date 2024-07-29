import 'package:deliveryproject/domain/store_api.dart';
import 'package:deliveryproject/repositories/dbhelper.dart';
import 'package:deliveryproject/services/fetchStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<StoreApi>> apis;
  Location location = new Location();
  late GoogleMapController _controller;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  final List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    apis = fetchStore();
    apis.then((item) => item.forEach((index) {
          var tmpStore = StoreApi(
              BPLCNM: index.BPLCNM,
              UPTAENM: index.UPTAENM,
              X: index.X,
              Y: index.Y);
          DBHelper().insertStore(tmpStore);
        }));
    _requestPermission();
    _markers.add(Marker(
      markerId: MarkerId('initialMarker'),
      position: LatLng(37.5665, 126.9780), // 예시로 서울의 좌표를 사용
    ));
    _circles.add(Circle(
      circleId: CircleId('initialCircle'),
      center: LatLng(37.5665, 126.9780),
      // 예시로 서울의 좌표를 사용
      radius: 300,
      fillColor: Colors.blueAccent.withOpacity(0.5),
      strokeWidth: 3,
      strokeColor: Colors.blueAccent,
    ));
  }

  void _requestPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 14.4746,
        ),
      ));

      setState(() {
        _markers.clear();
        _circles.clear();
        _markers.add(Marker(
          markerId: MarkerId('currentLocation'),
          position:
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
          icon: BitmapDescriptor.defaultMarker,
        ));
        _circles.add(Circle(
          circleId: CircleId('currentLocationCircle'),
          center: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          radius: 300,
          fillColor: Colors.blueAccent.withOpacity(0.5),
          strokeWidth: 3,
          strokeColor: Colors.blueAccent,
        ));
      });
    });
  }

  void _add_marker() {
    setState(() {
      DBHelper dbHelper = DBHelper();
      dbHelper.stores().then((value) => value.forEach((element) {
          print('hello');
          print('>>>>>>>>>>>>> ${double.parse(element.X)}');
            addMarker(LatLng(double.parse(element.Y), double.parse(element.X)),
                element.UPTAENM, element.BPLCNM);
          }));
    });
  }

  addMarker(cordinate, marker_id, marker_name) {
    markers.add(Marker(
        position: cordinate,
        markerId: MarkerId(marker_id),
        infoWindow: InfoWindow(title: marker_name)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.5665, 126.9780),
              zoom: 15,
            ),
            markers: _markers,
            circles: _circles,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 60, right: 10),
          alignment: Alignment.topRight,
          child: Column(
            children: <Widget>[
              FloatingActionButton.extended(
                label: Text('가게위치'),
                icon: Icon(Icons.local_parking),
                backgroundColor: Colors.blue,
                onPressed: _add_marker,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
