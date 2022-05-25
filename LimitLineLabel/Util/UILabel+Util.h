//
//  UILabel+Util.h
//  TestFramework
//
//  Created by 李辉 on 2022/5/22.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Util)

// 获取一个数组 这个数据的元素由label的每行文字组成
- (NSArray *)getLinesArrayOfStringWidth:(CGFloat)width;
// 获取展示文字后Label的总行数
- (int)getLinesWithLabelWidth:(CGFloat)width;

- (void)updateLabel:(UILabel *)txtLabel content: (NSString *)content frame:(CGRect)frame flagStr:(NSString *)flgStr;

@end

NS_ASSUME_NONNULL_END
