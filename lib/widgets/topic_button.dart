import 'package:flutter/material.dart';

class TopicButton extends StatelessWidget {
  TopicButton({
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
    this.isTop = false,
    this.topRadius = 0.0,
    this.isBottom = false,
    this.bottomRadius = 0.0,
  });

  final String label;
  final Color color;
  final Widget icon;
  final Function() onTap;

  double topRadius;
  bool isTop;
  double bottomRadius;
  bool isBottom;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(isTop ? topRadius : 0.0),
        topRight: Radius.circular(isTop ? topRadius : 0.0),
        bottomLeft: Radius.circular(isBottom ? bottomRadius : 0.0),
        bottomRight: Radius.circular(isBottom ? bottomRadius : 0.0),
      ),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: icon,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_right_outlined),
          ],
        ),
      ),
    );
  }
}
