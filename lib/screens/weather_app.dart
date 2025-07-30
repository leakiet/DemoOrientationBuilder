import 'package:flutter/material.dart';

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thời tiết'),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return const PortraitWeather();
            } else {
              return const LandscapeWeather();
            }
          },
        ),
      ),
    );
  }
}

class PortraitWeather extends StatelessWidget {
  const PortraitWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.lightBlue.shade200,
            Colors.lightBlue.shade400,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Indicator hiển thị orientation hiện tại
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.stay_current_portrait, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Chế độ dọc',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            // Weather icon và nhiệt độ
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(Icons.wb_sunny, size: 100, color: Colors.orange),
                  SizedBox(height: 16),
                  Text(
                    "27°C",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    "Nắng đẹp",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Thông tin chi tiết
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                children: [
                  _WeatherInfoRow(
                    icon: Icons.water_drop,
                    label: "Độ ẩm",
                    value: "60%",
                  ),
                  SizedBox(height: 10),
                  _WeatherInfoRow(
                    icon: Icons.air,
                    label: "Gió",
                    value: "10 km/h",
                  ),
                  SizedBox(height: 10),
                  _WeatherInfoRow(
                    icon: Icons.visibility,
                    label: "Tầm nhìn",
                    value: "15 km",
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Nút chi tiết
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WeatherDetailsPage()),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: const Text("Xem chi tiết"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            Text(
              "Chế độ Mini",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LandscapeWeather extends StatelessWidget {
  const LandscapeWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo.shade300,
            Colors.blue.shade400,
          ],
        ),
      ),
      child: Row(
        children: [
          // Bên trái - Weather icon và info
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Indicator orientation
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.stay_current_landscape, color: Colors.indigo, size: 20),
                          SizedBox(width: 6),
                          Text(
                            'Chế độ ngang',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    const Icon(Icons.cloud, size: 120, color: Colors.white),
                    const SizedBox(height: 20),
                    
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Chế độ Pro",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Bên phải - Thông tin chi tiết
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "27°C",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Có mây",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white70,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  Container(
                    width: double.infinity,
                    height: 69,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView(
                      
                      children: [
                        _WeatherInfoRow(
                          icon: Icons.water_drop,
                          label: "Độ ẩm",
                          value: "60%",
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 15),
                        _WeatherInfoRow(
                          icon: Icons.air,
                          label: "Gió",
                          value: "10 km/h",
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 15),
                        _WeatherInfoRow(
                          icon: Icons.compress,
                          label: "Áp suất",
                          value: "1012 hPa",
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 15),
                        _WeatherInfoRow(
                          icon: Icons.wb_sunny_outlined,
                          label: "Chỉ số UV",
                          value: "Trung bình",
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WeatherDetailsPage()),
                        );
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text("Xem chi tiết"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget helper cho thông tin thời tiết
class _WeatherInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? textColor;

  const _WeatherInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = textColor ?? Colors.grey.shade700;
    
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class WeatherDetailsPage extends StatefulWidget {
  const WeatherDetailsPage({super.key});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage>
    with SingleTickerProviderStateMixin {
  bool _showDetails = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // Trigger animation after short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _showDetails = true;
      });
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết thời tiết"),
        backgroundColor: Colors.lightBlue.shade300,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: _showDetails ? 1.0 : 0.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlue.shade100,
                  Colors.lightBlue.shade300,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  _buildLocationCard(),
                  const SizedBox(height: 20),
                  _buildWeatherDetailsCard(),
                  const SizedBox(height: 20),
                  _buildForecastCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 24),
                SizedBox(width: 8),
                Text(
                  "Vị trí",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "TP. Hồ Chí Minh, Việt Nam",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Cập nhật: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetailsCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.thermostat, color: Colors.orange, size: 24),
                SizedBox(width: 8),
                Text(
                  "Thông tin chi tiết",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _detailItem("🌫️ Chất lượng không khí", "AQI: 42 (Tốt)", Colors.green),
            _detailItem("🌞 Chỉ số UV", "5 (Trung bình)", Colors.orange),
            _detailItem("🔆 Cường độ ánh sáng", "800 lux", Colors.yellow.shade700),
            _detailItem("🌡️ Cảm giác thực tế", "30°C", Colors.red),
            _detailItem("💧 Độ ẩm", "60%", Colors.blue),
            _detailItem("💨 Gió", "10 km/h Đông Nam", Colors.grey),
            _detailItem("🌬️ Áp suất khí quyển", "1012 hPa", Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.schedule, color: Colors.purple, size: 24),
                SizedBox(width: 8),
                Text(
                  "Dự báo 3 ngày tới",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _forecastItem("Hôm nay", "27°C", Icons.wb_sunny, Colors.orange),
            _forecastItem("Ngày mai", "25°C", Icons.cloud, Colors.grey),
            _forecastItem("Ngày kia", "29°C", Icons.wb_sunny, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(String emoji, String info, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              info,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _forecastItem(String day, String temp, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            temp,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
