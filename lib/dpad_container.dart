import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const String keyUp = 'Arrow Up';
const String keyDown = 'Arrow Down';
const String keyLeft = 'Arrow Left';
const String keyRight = 'Arrow Right';
const String keyCenter = 'Select';

class DpadContainer extends HookWidget {
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
  Widget build(BuildContext context) {
    var node = useFocusNode;
    var isFocused = useState(false);
    return KeyboardListener(
      focusNode: node.call(),
      onKeyEvent: (KeyEvent event) {
        var label = event.logicalKey.keyLabel;
        if (label == keyCenter) {
          onClick;
        } else {
          isFocused.value = !(isFocused.value);
          onFocus(isFocused.value);
        }
      },
      child: child,
    );
  }
}
