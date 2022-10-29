import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({super.key, required this.icon, this.onTap, this.selectedBackgroundColor, this.unSelectedBackgroundColor, this.isSelected = true, this.selectedIconColor, this.unSelectedIconColor});
  final IconData icon;
  final void Function()? onTap;
  final bool isSelected;
  final Color? selectedBackgroundColor;
  final Color? unSelectedBackgroundColor;
  final Color? selectedIconColor;
  final Color? unSelectedIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(color: isSelected ? selectedBackgroundColor ?? Colors.orangeAccent : unSelectedBackgroundColor ?? Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(100)),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Icon(
          icon,
          color: isSelected ? selectedIconColor ?? Colors.white : unSelectedIconColor ?? Colors.grey,
        ),
      ),
    );
  }
}
