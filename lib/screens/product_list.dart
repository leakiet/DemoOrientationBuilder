import 'package:flutter/material.dart';

class MyProductList extends StatefulWidget {
  const MyProductList({super.key});
  
  @override
  State<MyProductList> createState() => _MyProductListState();
}

class _MyProductListState extends State<MyProductList> {
  // Danh sách sản phẩm demo
  final List<Product> products = [
    Product(
      id: 1,
      name: 'iPhone 15 Pro',
      price: 999.99,
      image: 'https://via.placeholder.com/150/FF0000/FFFFFF?text=iPhone',
      description: 'Điện thoại thông minh cao cấp với chip A17 Pro',
    ),
    Product(
      id: 2,
      name: 'Samsung Galaxy S24',
      price: 899.99,
      image: 'https://via.placeholder.com/150/00FF00/FFFFFF?text=Samsung',
      description: 'Flagship Android với camera AI tiên tiến',
    ),
    Product(
      id: 3,
      name: 'MacBook Air M3',
      price: 1299.99,
      image: 'https://via.placeholder.com/150/0000FF/FFFFFF?text=MacBook',
      description: 'Laptop siêu mỏng với chip M3 mạnh mẽ',
    ),
    Product(
      id: 4,
      name: 'iPad Pro 12.9"',
      price: 1099.99,
      image: 'https://via.placeholder.com/150/FFFF00/000000?text=iPad',
      description: 'Máy tính bảng chuyên nghiệp cho sáng tạo',
    ),
    Product(
      id: 5,
      name: 'Apple Watch Series 9',
      price: 399.99,
      image: 'https://via.placeholder.com/150/FF00FF/FFFFFF?text=Watch',
      description: 'Đồng hồ thông minh với tính năng sức khỏe',
    ),
    Product(
      id: 6,
      name: 'AirPods Pro 2',
      price: 249.99,
      image: 'https://via.placeholder.com/150/00FFFF/000000?text=AirPods',
      description: 'Tai nghe không dây với chống ồn chủ động',
    ),
    Product(
      id: 7,
      name: 'Nintendo Switch OLED',
      price: 349.99,
      image: 'https://via.placeholder.com/150/FFA500/FFFFFF?text=Switch',
      description: 'Máy chơi game di động với màn hình OLED',
    ),
    Product(
      id: 8,
      name: 'Sony WH-1000XM5',
      price: 399.99,
      image: 'https://via.placeholder.com/150/800080/FFFFFF?text=Sony',
      description: 'Tai nghe chống ồn tốt nhất thế giới',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: OrientationBuilder(
        builder: (context, orientation) {
          // Thay đổi số cột dựa trên hướng xoay
          int crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Hiển thị thông tin về hướng xoay hiện tại
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    color: orientation == Orientation.portrait 
                        ? Colors.green.shade100 
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: orientation == Orientation.portrait 
                          ? Colors.green 
                          : Colors.orange,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        orientation == Orientation.portrait 
                            ? Icons.stay_current_portrait 
                            : Icons.stay_current_landscape,
                        color: orientation == Orientation.portrait 
                            ? Colors.green 
                            : Colors.orange,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        orientation == Orientation.portrait 
                            ? 'Chế độ dọc (Portrait) - 2 cột' 
                            : 'Chế độ ngang (Landscape) - 4 cột',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: orientation == Orientation.portrait 
                              ? Colors.green.shade800 
                              : Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                // Danh sách sản phẩm
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: orientation == Orientation.portrait ? 0.75 : 0.8,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        orientation: orientation,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        ),
      ),
    );
  }
}

// Model cho sản phẩm
class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });
}

// Widget card sản phẩm
class ProductCard extends StatelessWidget {
  final Product product;
  final Orientation orientation;

  const ProductCard({
    super.key,
    required this.product,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          // Hiển thị thông tin chi tiết sản phẩm
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(product.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Giá: \$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Đóng'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Đã thêm ${product.name} vào giỏ hàng!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('Thêm vào giỏ'),
                ),
              ],
            ),
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh sản phẩm
              Expanded(
                flex: orientation == Orientation.portrait ? 3 : 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade100,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Tên sản phẩm
              Expanded(
                flex: 1,
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: orientation == Orientation.portrait ? 14 : 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Giá sản phẩm
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: orientation == Orientation.portrait ? 16 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}