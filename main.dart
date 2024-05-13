import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Report',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather Report'),
    );
  }
}

class MyHomePage extends StatefulWidget {


  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  String ?city='', country='';
  
  WeatherFactory weatherFactory = WeatherFactory('77f41b9664ba77357563350796591658');
  

  Weather? weather;
  @override
  void initState() {     

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Weather Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CSCPicker(              
              showCities: true,              
              onStateChanged: (value) {                
              },
              onCountryChanged: (value) {
                country = value;
                setState(() {});
              },
              
              onCityChanged: (value) {
                city = value;
                setState(() {});
              },
            ),
            city != '' ? 
            StreamBuilder<Weather>(
              stream: weatherFactory.currentWeatherByCityName( 'Harare').asStream(),
              builder: (c, AsyncSnapshot<Weather> snapshot){
                if(snapshot.hasData){
                  return ListTile(
                    title: Text(snapshot.data!.temperature!.celsius.toString()),
                  );
                }
                return Container();
              },
            )
            :Container(),
            
          ],
        ),
      ),
    );
  }
}
