import 'package:flutter/material.dart';
import '../models/product.dart';
import 'filter_panel.dart';
import 'product_grid.dart';

// Tạo danh sách sản phẩm mẫu
final List<Product> products = List.generate(
  40,
  (index) => Product(
    name: 'Sản phẩm ${index + 1}',
    image: 'https://picsum.photos/seed/pic$index/200/200',
    price: 10.0 + index,
  ),
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
          // Tab 1: Danh sách sản phẩm (có filter bên cạnh nếu màn hình đủ rộng)
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
          // Tab 2: Bộ lọc, luôn luôn hiển thị bộ lọc thôi
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
