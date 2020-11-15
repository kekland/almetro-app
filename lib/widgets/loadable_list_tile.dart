import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadableListTile extends StatefulWidget {
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Future<void> Function() onTap;

  const LoadableListTile({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.trailing,
    @required this.onTap,
  }) : super(key: key);

  @override
  _LoadableListTileState createState() => _LoadableListTileState();
}

class _LoadableListTileState extends State<LoadableListTile> {
  bool _isLoading = false;

  Future<void> _onTap() async {
    setState(() => _isLoading = true);

    await widget.onTap();

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      subtitle: widget.subtitle,
      enabled: !_isLoading,
      trailing: _isLoading
          ? SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            )
          : widget.trailing,
      onTap: _onTap,
    );
  }
}
