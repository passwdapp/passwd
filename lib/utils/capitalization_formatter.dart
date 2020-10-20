import 'package:flutter/services.dart';

/// [CapitalizationFormatter] extends the [TextInputFormatter]
/// This is used to only allow entering capital letters in [TextFields]
class CapitalizationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
