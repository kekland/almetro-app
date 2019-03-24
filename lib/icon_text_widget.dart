import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final bool isTop;
  final String subtitle;
  final String title;
  final IconData icon;
  final VoidCallback onClick;

  const IconTextWidget({Key key, this.subtitle, this.title, this.icon, this.isTop, this.onClick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      child: InkWell(
        borderRadius: BorderRadius.only(
          bottomLeft: (isTop)? Radius.zero : Radius.circular(16.0),
          bottomRight: (isTop)? Radius.zero : Radius.circular(16.0),
          topLeft: (isTop)? Radius.circular(16.0) : Radius.zero,
          topRight: (isTop)? Radius.circular(16.0) : Radius.zero,
        ),
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32.0,
                color: Colors.black.withOpacity(0.25),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(subtitle),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
