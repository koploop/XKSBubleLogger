//
//  XKSBubleMacro.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/24.
//  Copyright © 2018年 Mario. All rights reserved.
//

#ifndef XKSBubleMacro_h
#define XKSBubleMacro_h

#pragma mark - 颜色

#define RGBACOLOR(__r,__g,__b,__a) \
[UIColor colorWithRed:(__r)/255.0f green:(__g)/255.0f blue:(__b)/255.0f alpha:(__a)]
#define RGBCOLOR(__r,__g,__b)  RGBACOLOR(__r,__g,__b,1)

#pragma mark - 尺寸

#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height


#endif /* XKSBubleMacro_h */
