import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExtension on num {
  double get h => ScreenUtil().setHeight(this);

  double get w => ScreenUtil().setWidth(this);

  double get sp => ScreenUtil().setSp(this);

  double get r => ScreenUtil().radius(this);
}