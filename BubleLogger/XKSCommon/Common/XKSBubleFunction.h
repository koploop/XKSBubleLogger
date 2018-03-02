//
//  XKSBubleFunction.h
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *BubleBundleName = @"XKSBubleLogger";

@interface XKSBubleFunction : NSObject

/**
 *  @author _Finder丶Tiwk, 16-01-14 00:01:53
 *
 *  @brief 通过其它bundle的名字来获取一个NSBundle对象
 *  @param bundleName 要获取的NSBundle的文件名字符串
 *  @return NSBundle对象
 *  @since v0.1.0
 */
FOUNDATION_EXPORT NSBundle* bubleExternalBundle(NSString *bundleName);

/*!
 *  @author _Finder丶Tiwk, 16-10-10 11:10:14
 *
 *  @brief 加载其它bundle中的image
 *  @param bundleName Bundle的文件名字符串
 *  @param imageName  图片名称字符串
 *  @return 其它bundle中的UIImage
 */
FOUNDATION_EXPORT UIImage* bubleExternalBundleImage(NSString *bundleName,NSString *imageName);

/**
 *  @author _Finder丶Tiwk, 16-05-04 18:05:48
 *
 *  @brief 从指定bundle中加载一个指定的storyboard
 *  @param bundleName     bundle名称
 *  @param storyBoardName storyboard名称
 *  @return storyboard
 *  @since v1.0.0
 */
FOUNDATION_EXPORT UIStoryboard* bubleExternalStoryBoard(NSString *bundleName,NSString *storyBoardName);

/**
 *  @author _Finder丶Tiwk, 16-05-04 18:05:33
 *
 *  @brief 从指定bundle中加载一个指定的xib组件数组
 *  @param bundleName bundle名称
 *  @param xibName    xib文件名称
 *  @return xib里包含的组件的数组
 *  @since v1.0.0
 */
FOUNDATION_EXPORT NSArray* bubleExternalXibArray(NSString *bundleName,NSString *xibName);


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - *JSON*

FOUNDATION_EXPORT NSString* bubleCollection2JsonString(id collection);

FOUNDATION_EXPORT id bubleJsonString2Collection(NSString *jsonString);

@end
