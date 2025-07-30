import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
