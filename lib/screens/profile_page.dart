import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dữ liệu profile mẫu
  final Map<String, dynamic> userProfile = {
    'name': 'Nguyễn Văn A',
    'email': 'nguyenvana@example.com',
    'phone': '+84 123 456 789',
    'address': 'Hà Nội, Việt Nam',
    'avatar': 'https://via.placeholder.com/150',
    'joinDate': '15/03/2022',
    'totalOrders': 25,
    'totalSpent': 15250000,
  };

  final List<Map<String, dynamic>> profileStats = [
    {
      'icon': Icons.shopping_cart,
      'title': 'Đơn hàng',
      'value': '25',
      'color': Colors.blue,
    },
    {
      'icon': Icons.favorite,
      'title': 'Yêu thích',
      'value': '12',
      'color': Colors.red,
    },
    {
      'icon': Icons.star,
      'title': 'Đánh giá',
      'value': '4.8',
      'color': Colors.amber,
    },
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Tổng chi',
      'value': '15.25M',
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.edit,
      'title': 'Chỉnh sửa thông tin',
      'subtitle': 'Cập nhật thông tin cá nhân',
      'color': Colors.blue,
    },
    {
      'icon': Icons.history,
      'title': 'Lịch sử đơn hàng',
      'subtitle': 'Xem các đơn hàng đã mua',
      'color': Colors.orange,
    },
    {
      'icon': Icons.location_on,
      'title': 'Địa chỉ giao hàng',
      'subtitle': 'Quản lý địa chỉ nhận hàng',
      'color': Colors.red,
    },
    {
      'icon': Icons.payment,
      'title': 'Phương thức thanh toán',
      'subtitle': 'Thẻ tín dụng và ví điện tử',
      'color': Colors.purple,
    },
    {
      'icon': Icons.notifications,
      'title': 'Thông báo',
      'subtitle': 'Cài đặt thông báo',
      'color': Colors.teal,
    },
    {
      'icon': Icons.help,
      'title': 'Hỗ trợ',
      'subtitle': 'Liên hệ với chúng tôi',
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              // Logout functionality
              _showLogoutDialog();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout();
          } else {
            return _buildLandscapeLayout();
          }
        },
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildProfileHeader(Orientation.portrait),
          const SizedBox(height: 20),
          _buildStatsSection(Orientation.portrait),
          const SizedBox(height: 20),
          _buildMenuSection(Orientation.portrait),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Profile header and stats
          Expanded(
            flex: 1,
            child: Column(
              children: [
                _buildProfileHeader(Orientation.landscape),
                const SizedBox(height: 16),
                _buildStatsSection(Orientation.landscape),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Right column - Menu items
          Expanded(
            flex: 1,
            child: _buildMenuSection(Orientation.landscape),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Orientation orientation) {
    final isPortrait = orientation == Orientation.portrait;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isPortrait ? 20.0 : 16.0),
        child: isPortrait ? _buildPortraitHeader() : _buildLandscapeHeader(),
      ),
    );
  }

  Widget _buildPortraitHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(userProfile['avatar']),
          backgroundColor: Colors.grey[300],
          child: userProfile['avatar'].isEmpty
              ? const Icon(Icons.person, size: 50, color: Colors.grey)
              : null,
        ),
        const SizedBox(height: 16),
        Text(
          userProfile['name'],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          userProfile['email'],
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tham gia từ: ${userProfile['joinDate']}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(userProfile['avatar']),
          backgroundColor: Colors.grey[300],
          child: userProfile['avatar'].isEmpty
              ? const Icon(Icons.person, size: 40, color: Colors.grey)
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProfile['name'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userProfile['email'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Tham gia từ: ${userProfile['joinDate']}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(Orientation orientation) {
    final isPortrait = orientation == Orientation.portrait;
    final crossAxisCount = isPortrait ? 2 : 4;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thống kê',
              style: TextStyle(
                fontSize: isPortrait ? 18 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isPortrait ? 1.2 : 1.0,
              ),
              itemCount: profileStats.length,
              itemBuilder: (context, index) {
                final stat = profileStats[index];
                return _buildStatCard(stat, orientation);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, Orientation orientation) {
    final isPortrait = orientation == Orientation.portrait;
    
    return Container(
      decoration: BoxDecoration(
        color: stat['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: stat['color'].withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isPortrait ? 12.0 : 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              stat['icon'],
              color: stat['color'],
              size: isPortrait ? 28 : 24,
            ),
            SizedBox(height: isPortrait ? 8 : 4),
            Text(
              stat['value'],
              style: TextStyle(
                fontSize: isPortrait ? 18 : 16,
                fontWeight: FontWeight.bold,
                color: stat['color'],
              ),
            ),
            SizedBox(height: isPortrait ? 4 : 2),
            Text(
              stat['title'],
              style: TextStyle(
                fontSize: isPortrait ? 12 : 10,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(Orientation orientation) {
    final isPortrait = orientation == Orientation.portrait;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cài đặt',
              style: TextStyle(
                fontSize: isPortrait ? 18 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...menuItems.map((item) => _buildMenuItem(item, orientation)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, Orientation orientation) {
    final isPortrait = orientation == Orientation.portrait;
    
    return Padding(
      padding: EdgeInsets.only(bottom: isPortrait ? 12.0 : 8.0),
      child: InkWell(
        onTap: () {
          _handleMenuTap(item['title']);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(isPortrait ? 16.0 : 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(isPortrait ? 12 : 10),
                decoration: BoxDecoration(
                  color: item['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item['icon'],
                  color: item['color'],
                  size: isPortrait ? 24 : 20,
                ),
              ),
              SizedBox(width: isPortrait ? 16 : 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: isPortrait ? 16 : 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: isPortrait ? 4 : 2),
                    Text(
                      item['subtitle'],
                      style: TextStyle(
                        fontSize: isPortrait ? 12 : 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: isPortrait ? 16 : 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuTap(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on: $title'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã đăng xuất thành công'),
                  ),
                );
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }
}
