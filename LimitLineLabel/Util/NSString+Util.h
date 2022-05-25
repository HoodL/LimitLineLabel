//
//  NSString+Util.h
//  TestFramework
//
//  Created by 李辉 on 2022/5/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Util)

- (CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
