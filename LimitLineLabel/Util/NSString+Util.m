//
//  NSString+Util.m
//  TestFramework
//
//  Created by 李辉 on 2022/5/22.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width {
    CGSize realSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{
        NSFontAttributeName : font
    } context:nil]
        .size;
    return ceil(realSize.height);
}

@end
