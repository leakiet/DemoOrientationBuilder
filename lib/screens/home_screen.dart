import 'package:flutter/material.dart';

// Không tách model ra ngoài, để luôn trong file này
class Product {
  final String name;
  final String image;
  final double price;

  Product({required this.name, required this.image, required this.price});
}

// Tạo danh sách sản phẩm mẫu
final List<Product> products = List.generate(
  40,
  (index) => Product(
    name: 'Sản phẩm ${index + 1}',
    image: 'https://picsum.photos/seed/pic$index/200/200',
    price: 10.0 + index,
  ),
);

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String filterName = '';
  RangeValues filterPrice = const RangeValues(10, 49);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  List<Product> get filteredProducts {
    return products.where((product) {
      final matchName = filterName.isEmpty || product.name.toLowerCase().contains(filterName.toLowerCase());
      final matchPrice = product.price >= filterPrice.start && product.price <= filterPrice.end;
      return matchName && matchPrice;
    }).toList();
  }

  void openFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FilterPanel(
          filterName: filterName,
          filterPrice: filterPrice,
          onChanged: (name, price) {
            setState(() {
              filterName = name;
              filterPrice = price;
            });
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool showSidebarFilter = width >= 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm & Lọc'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tất cả sản phẩm', icon: Icon(Icons.grid_on)),
            Tab(text: 'Lọc sản phẩm', icon: Icon(Icons.filter_alt)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Row(
            children: [
              if (showSidebarFilter)
                SizedBox(
                  width: 220,
                  child: FilterPanel(
                    filterName: filterName,
                    filterPrice: filterPrice,
                    onChanged: (name, price) {
                      setState(() {
                        filterName = name;
                        filterPrice = price;
                      });
                    },
                  ),
                ),
              Expanded(
                child: Stack(
                  children: [
                    ProductGrid(products: filteredProducts),
                    if (!showSidebarFilter)
                      Positioned(
                        right: 16,
                        top: 16,
                        child: FloatingActionButton(
                          heroTag: "filterBtn",
                          mini: true,
                          child: const Icon(Icons.filter_list),
                          onPressed: openFilterDialog,
                          tooltip: 'Lọc sản phẩm',
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              width: 320,
              child: FilterPanel(
                filterName: filterName,
                filterPrice: filterPrice,
                onChanged: (name, price) {
                  setState(() {
                    filterName = name;
                    filterPrice = price;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Các widget nhỏ cũng có thể để luôn trong file này cho gọn
class ProductGrid extends StatelessWidget {
  final List<Product> products;
  const ProductGrid({super.key, required this.products});

  int _getCrossAxisCount(BuildContext context, Orientation orientation) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1499) return 10;
    if (width >= 800) return 6;
    if (orientation == Orientation.landscape) return 6;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        int crossAxisCount = _getCrossAxisCount(context, orientation);
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => showDialog(
                context: context,
                builder: (_) => ProductDetailDialog(product: product),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Column(
                        children: [
                          Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('${product.price.toStringAsFixed(2)} VNĐ', style: const TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ProductDetailDialog extends StatelessWidget {
  final Product product;
  const ProductDetailDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(product.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(product.image, width: 200, height: 200),
          const SizedBox(height: 12),
          Text('Giá: ${product.price.toStringAsFixed(2)} VNĐ'),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Đóng'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class FilterPanel extends StatefulWidget {
  final String filterName;
  final RangeValues filterPrice;
  final void Function(String, RangeValues) onChanged;

  const FilterPanel({
    super.key,
    required this.filterName,
    required this.filterPrice,
    required this.onChanged,
  });

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  late String name;
  late RangeValues priceRange;

  @override
  void initState() {
    name = widget.filterName;
    priceRange = widget.filterPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          
          children: [
            const Text('Bộ lọc sản phẩm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 18),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Tên sản phẩm',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              controller: TextEditingController(text: name),
              onChanged: (val) => setState(() => name = val),
            ),
            const SizedBox(height: 18),
            const Text('Khoảng giá', style: TextStyle(fontWeight: FontWeight.bold)),
            RangeSlider(
              values: priceRange,
              min: 10,
              max: 49,
              divisions: 39,
              labels: RangeLabels('${priceRange.start.toInt()} VNĐ', '${priceRange.end.toInt()} VNĐ'),
              onChanged: (range) => setState(() => priceRange = range),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Áp dụng'),
              onPressed: () => widget.onChanged(name, priceRange),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
            ),
          ],
        ),
      ),
    );
  }
}
