import 'package:flutter/material.dart';

class AdaptiveTable<T> extends StatelessWidget {
  const AdaptiveTable({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.rowBuilder,
    required this.columns,
    this.breakpoint = 600,
    this.height = 80,
  });

  final List<T> items;
  final Widget Function(T item, int index) itemBuilder;
  final DataRow Function(T item, int index) rowBuilder;
  final List<DataColumn> columns;
  final double breakpoint;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint) {
          return DataTable(
            dataRowHeight: height,
            columns: columns,
            rows: [
              for (var i = 0; i < items.length; i++) rowBuilder(items[i], i),
            ],
          );
        }
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return itemBuilder(item, index);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      },
    );
  }
}
