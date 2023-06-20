import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Action constants
const String keyUp = 'Arrow Up';
const String keyDown = 'Arrow Down';
const String keyLeft = 'Arrow Left';
const String keyRight = 'Arrow Right';
const String keyCenter = 'Select';

///
/// Using Hooks instead of statefull builder
/// Make coding looks nice and compact
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
    /// Focus Node
    final FocusNode focusNode = useFocusNode();
    useEffect(() {
      return focusNode.requestFocus;
    }, []);

    /// On focus state
    var isFocused = useState(false);

    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (RawKeyEvent event) {
        if(event is RawKeyDownEvent) {
          /// Action label
          var label = event.logicalKey.keyLabel;

          /// If label equal to Key Event which arrow up, down, right, left or on Enter
          if (label == keyCenter) {
            onClick();
          }
        } else {
          isFocused.value = !isFocused.value;
          onFocus(isFocused.value);
        }
      },
      child: child,
    );
  }
}
