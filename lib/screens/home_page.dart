import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: orientation == Orientation.portrait
                  ? _buildPortraitLayout(context)
                  : _buildLandscapeLayout(context),
            );
          },
        ),
      ),
    );
  }

  // Layout cho chế độ dọc (Portrait)
  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Logo hoặc tiêu đề
        const Icon(
          Icons.home,
          size: 80,
          color: Colors.blue,
        ),
        const SizedBox(height: 20),
        const Text(
          'Chào mừng đến với ứng dụng Demo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 40),
        
        // Nút dẫn đến trang Products
        _buildProductButton(context),
        const SizedBox(height: 20),
        
        // Nút dẫn đến trang Books
        _buildProfileButton(context),
        const SizedBox(height: 20),
        
        // Nút dẫn đến trang Product Trung
        _buildProductTrung(context),
        const SizedBox(height: 20),
        
        // Nút dẫn đến trang Weather
        _buildWeatherButton(context),
        const SizedBox(height: 20),
        
        // Nút dẫn đến trang Revenue
        _buildRevenueButton(context),
        const SizedBox(height: 40),
        
        // Thông tin thêm
        _buildInfoCard(),
      ],
    );
  }

  // Layout cho chế độ ngang (Landscape)
  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      children: [
        // Phần bên trái - Logo và tiêu đề
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.home,
                size: 60,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Chào mừng đến với ứng dụng Demo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 20),
        
        // Phần bên phải - Các nút bấm
        Expanded(
          flex: 1,
          child: ListView(  
            children: [
              _buildProductButton(context),
              const SizedBox(height: 12),
              _buildProfileButton(context),
              const SizedBox(height: 12),
              _buildProductTrung(context),
              const SizedBox(height: 12),
              _buildWeatherButton(context),
              const SizedBox(height: 12),
              _buildRevenueButton(context),
            ],
          ),
        ),
      ],
    );
  }

    // Widget nút Products
  Widget _buildProductButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.push('/products');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag, size: 24),
          SizedBox(width: 10),
          Text(
            'Xem danh sách sản phẩm (Kiet)',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Widget nút Books
  Widget _buildProfileButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.push('/profile');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book, size: 24),
          SizedBox(width: 10),
          Text(
          'Xem Trang Profile (Quyen)',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Widget nút Books
  Widget _buildProductTrung(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.push('/productTrung');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book, size: 24),
          SizedBox(width: 10),
          Text(
            'Xem Trang Product (Trung)',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Widget nút Weather
  Widget _buildWeatherButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.push('/weather');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_sunny, size: 24),
          SizedBox(width: 10),
          Text(
            'Xem Thời tiết (Weather)',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Widget nút Revenue
  Widget _buildRevenueButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.push('/revenue');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, size: 24),
          SizedBox(width: 10),
          Text(
            'Bảng điều khiển doanh thu',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Widget thông tin thêm
  Widget _buildInfoCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.screen_rotation,
              size: 32,
              color: Colors.grey,
            ),
            const SizedBox(height: 8),
            const Text(
              'Demo OrientationBuilder',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Xoay thiết bị để xem sự thay đổi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
