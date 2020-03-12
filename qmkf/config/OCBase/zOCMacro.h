//
//  zOCMacro.h
//  qmkf
//
//  Created by Mac on 2019/12/11.
//  Copyright © 2019 Mac. All rights reserved.
//

#ifndef zOCMacro_h
#define zOCMacro_h
#import "UIColor+Hex.h"

#define Screen_width  [[UIScreen mainScreen] bounds].size.width
#define Screen_height [[UIScreen mainScreen] bounds].size.height
#define GetCurrentWindow [UIApplication sharedApplication].keyWindow
#define k_IPHONE_X [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0
// Tabbar safe bottom margin.
#define k_TabbarSafeBottomMargin k_IPHONE_X ? 34.f : 0.f

// Status bar & navigation bar height.
#define k_StatusBarAndNavigationBarHeight  (k_IPHONE_X ? 88.f : 64.f)

#define HexStringColor(_hexString)\
[UIColor colorWithHexString:_hexString]

#define HexStringColor_Alpha(_hexString,digit)\
[UIColor colorWithHexString:_hexString alpha:digit]

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#endif /* zOCMacro_h */
