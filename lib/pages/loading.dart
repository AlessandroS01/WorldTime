import 'package:flutter/material.dart';
import '../services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Future<void> setupWorldTime() async {
    WorldTime instance = WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png');
    await instance.getTime();

    setState(() {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'time': instance.time,
        'flag': instance.flag,
        'isDaytime': instance.isDaytime
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
        body: Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
              size: 50.0,
          ),
      ),
    );
  }
}
