import 'package:flutter/material.dart';
import 'package:tempo_template/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/networking.dart';
import 'location_screen.dart';

const apiKey = '96f6d3499b81737dade19c7fa1c13ed2';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Location location = Location();

  late double latitude;
  late double longitude ;

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/'
            'data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    pushToLocationScreen(weatherData);
  }

  Future<void> getLocation() async {
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  void pushToLocationScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(localWeatherData: weatherData);
    }));
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
