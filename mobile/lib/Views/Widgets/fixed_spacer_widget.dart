import 'package:flutter/material.dart';

class FixedSpacer {
  /// Height: 8
  static SizedBox vSmallest({double? width}) =>
      SizedBox(height: 8, width: width);

  /// Height: 16
  static SizedBox vSmaller({double? width}) =>
      SizedBox(height: 16, width: width);

  /// Height: 24
  static SizedBox vSmall({double? width}) => SizedBox(height: 24, width: width);

  /// Height: 32
  static SizedBox vNormal({double? width}) =>
      SizedBox(height: 32, width: width);

  /// Height: 40
  static SizedBox vBig({double? width}) => SizedBox(height: 40, width: width);

  /// Height: 48
  static SizedBox vBigger({double? width}) =>
      SizedBox(height: 48, width: width);

  /// Height: 64
  static SizedBox vBiggest({double? width}) =>
      SizedBox(height: 64, width: width);

  /// Width: 2
  static SizedBox hSmallest({double? height}) =>
      SizedBox(height: height, width: 2);

  /// Width: 4
  static SizedBox hSmaller({double? height}) =>
      SizedBox(height: height, width: 4);

  /// Width: 8
  static SizedBox hSmall({double? height}) =>
      SizedBox(height: height, width: 8);

  /// Width: 16
  static SizedBox hNormal({double? height}) =>
      SizedBox(height: height, width: 16);
}
