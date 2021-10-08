import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const String keyUp = 'Arrow Up';
const String keyDown = 'Arrow Down';
const String keyLeft = 'Arrow Left';
const String keyRight = 'Arrow Right';
const String keyCenter = 'Select';

class DpadContainer extends StatefulWidget {
  final Function onClick;
  final Function(bool isFocused) onFocus;
  final Widget child;

  const DpadContainer({
    Key? key,
    required this.onClick,
    required this.child,
    required this.onFocus,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DpadContainerState();
  }
}

class DpadContainerState extends State<DpadContainer> {
  List<FocusNode> focusNodes = [];
  late FocusNode node;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    node = FocusNode();
  }

  void _handleFocusChange() {
    if (node.hasFocus != isFocused) {
      setState(() {
        isFocused = node.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    node.removeListener(_handleFocusChange);
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      child: widget.child,
      focusNode: node,
      onKey: (RawKeyEvent event) {
        setState(() {
          isFocused = !isFocused;
        });

        widget.onFocus(isFocused);

        if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
          switch (event.logicalKey.keyLabel) {
            case keyCenter:
              widget.onClick();
              break;
            case keyUp:
              break;
            case keyDown:
              break;
            default:
              break;
          }
        }
      },
    );
  }
}
