import 'package:flutter/material.dart';
import 'package:mapesa/src/debug/developer_provider.dart';

class DeveloperState {}

///
/// The developer overlay that will hangover the entire application.
/// All UI interactions with the overlay are defined here
///
/// Its drawn by the top level widget.
/// Children widgets will be able to control it by using shared state (DeveloperState)
///
class DebugOverlayWidget extends StatefulWidget {
  final Widget child;

  const DebugOverlayWidget({super.key, required this.child});

  @override
  State<DebugOverlayWidget> createState() => _DebugOverlayWidgetState();
}

class _DebugOverlayWidgetState extends State<DebugOverlayWidget> {
  static final _devProvider = DeveloperProvider.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleButtonClick() async {
    await _devProvider.resetApp();
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset app?'),
          content: const Text('This action will reset the app.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _handleButtonClick();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('App has been reset'),
                  ),
                );
              },
              child: const Text('Reset'),
            ),
            FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: _showAlertDialog,
                icon: const Icon(
                  Icons.bug_report,
                  color: Colors.red,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.green)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
