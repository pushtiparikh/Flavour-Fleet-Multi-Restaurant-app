import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flavourfleet/application/app_widget/app_provider.dart';

import '../../theme/theme.dart';

class ForgotTextButton extends ConsumerWidget {
  final String title;
  final Function() onPressed;
  final double? fontSize;
  final Color? fontColor;
  final double? letterSpacing;

  const ForgotTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.fontSize,
    this.fontColor = Style.black,
    this.letterSpacing = -14 * 0.02,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appProvider);
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
          (states) => state.isDarkMode
              ? Style.mainBackDark
              : Style.dontHaveAccBtnBack,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: Style.interNormal(
          textDecoration: TextDecoration.underline,
          size: 12,
          color: Style.black,
        ),
      ),
    );
  }
}
