import 'package:flutter/material.dart';

class DebugValues extends StatelessWidget {
  final Map<String, dynamic> debugValues;
  const DebugValues({super.key, required this.debugValues});

  @override
  Widget build(BuildContext context) {
    final entries = debugValues.entries.toList();

    return Table(
      columnWidths: const {
        0: FixedColumnWidth(100),
        1: FixedColumnWidth(100),
      },
      children: entries
          .map(
            (e) => TableRow(
              children: [
                TableCell(child: Text(e.key)),
                TableCell(
                  child: Text(
                    _valueToString(e.value),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  String _valueToString(dynamic value) {
    if (value is double) {
      return value.toStringAsFixed(5);
    }

    return value.toString();
  }
}
