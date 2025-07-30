import 'package:flutter/material.dart';

class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrientationBuilder Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return PortraitWeather();
        } else {
          return LandscapeWeather();
        }
      },
    );
  }
}

class PortraitWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wb_sunny, size: 100, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              "27°C",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text("Sunny", style: TextStyle(fontSize: 22)),
            SizedBox(height: 16),
            Text("Humidity: 60%", style: TextStyle(fontSize: 16)),
            Text("Wind: 10 km/h", style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailsPage()),
                );
              },
              child: Text("Chi tiết"),
            ),
            SizedBox(height: 10),
            Text("Mini Mode", style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

class LandscapeWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.lightBlue[300],
              child: Center(
                child: Icon(Icons.cloud, size: 100, color: Colors.indigo),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "27°C",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text("Cloudy", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Divider(),
                  Text("Humidity: 60%", style: TextStyle(fontSize: 18)),
                  Text("Wind: 10 km/h", style: TextStyle(fontSize: 18)),
                  Text("Pressure: 1012 hPa", style: TextStyle(fontSize: 18)),
                  Text("UV Index: Moderate", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailsPage()),
                      );
                    },
                    child: Text("Chi tiết"),
                  ),
                  SizedBox(height: 10),
                  Text("Pro Mode", style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  bool _showDetails = false;

  @override
  void initState() {
    super.initState();
    // Trigger animation after short delay
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _showDetails = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết thời tiết"),
        backgroundColor: Colors.lightBlue[300],
      ),
      body: AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: _showDetails ? 1.0 : 0.0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              Text(
                "📍 Địa điểm: TP. Hồ Chí Minh",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "📊 Thông tin chi tiết:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              detailItem("🌫️ Chất lượng không khí", "AQI: 42 (Tốt)"),
              detailItem("🌞 Chỉ số UV", "5 (Trung bình)"),
              detailItem("🔆 Cường độ nắng", "800 lux"),
              detailItem("🌡️ Cảm giác nhiệt", "30°C"),
              detailItem("💧 Độ ẩm", "60%"),
              detailItem("💨 Gió", "10 km/h Đông Nam"),
              detailItem("🌬️ Áp suất", "1012 hPa"),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
