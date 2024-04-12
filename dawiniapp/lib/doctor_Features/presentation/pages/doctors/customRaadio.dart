// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Radiolist extends StatefulWidget {
  final int? value;
  final int? groupvalue;
  final Color? color;
  final Color? selectedcolor;
  final void Function(int?)? onchange;

  const Radiolist(
      {super.key,
      this.color = Colors.grey,
      required this.groupvalue,
      this.selectedcolor = const Color(0xff00C8D5),
      this.onchange,
      required this.value});

  @override
  State<Radiolist> createState() => _RadiolistState();
}

class _RadiolistState extends State<Radiolist> {
  String selectedOpion = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool selected = widget.value != widget.groupvalue;
        if (selected) {
          widget.onchange!(widget.value);
        }
      },
      child: Container(
        height: 13.w,
        width: 13.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.value == widget.groupvalue
                ? widget.selectedcolor
                : widget.color!.withOpacity(0.4)),
      ),
    );
  }
}
