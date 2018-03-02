//
//  XKSBubleFunction.m
//  XKSBubleLoger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "XKSBubleFunction.h"

@implementation XKSBubleFunction

NSBundle* bubleExternalBundle(NSString *bundleName){
    NSCParameterAssert(bundleName);
    NSString *bundeFullName;
    if ([bundleName rangeOfString:@".bundle"].location == NSNotFound) {
        bundeFullName = [NSString stringWithFormat:@"%@.bundle",bundleName];
    }else{
        bundeFullName = bundleName;
    }
    NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bundeFullName];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    return bundle;
}

UIImage* bubleExternalBundleImage(NSString *bundleName,NSString *imageName){
    NSBundle *bundle = bubleExternalBundle(bundleName);
    if (!bundle) {
        return [UIImage imageNamed:imageName];
    }
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

UIStoryboard* bubleExternalStoryBoard(NSString *bundleName,NSString *storyBoardName){
    NSCParameterAssert(bundleName);
    NSCParameterAssert(storyBoardName);
    NSBundle *bundle = bubleExternalBundle(bundleName);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:bundle];
    return storyboard;
}

NSArray* bubleExternalXibArray(NSString *bundleName,NSString *xibName){
    NSCParameterAssert(xibName);
    NSBundle *bundle = bubleExternalBundle(bundleName);
    NSArray *array   = [bundle loadNibNamed:xibName owner:nil options:nil];;
    if (!array) {
        array = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    }
    return array;
}

#pragma mark - *JSON*
///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* collection2JsonString(id collection){
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = nil;
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:collection
                                                   options:0
                                                     error:&error];
    } @catch (NSException *exception) {
        return nil;
    }
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    //Tip: 解决苹果系统的一个BUG 集合转换成Json时会将'/'转换为'\/'
    //为了处理base64后'/'的问题 http://www.cnblogs.com/kongkaikai/p/5627205.html
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return jsonString;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
id jsonString2Collection(NSString *jsonString){
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id collection = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&err];
    if(err) {
        return nil;
    }
    return collection;
}



@end
