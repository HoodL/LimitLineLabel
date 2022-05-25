//
//  UILabel+Util.m
//  TestFramework
//
//  Created by 李辉 on 2022/5/22.
//

#import "UILabel+Util.h"
#import "YYKit.h"

#define limitMaxLines 4
@implementation UILabel (Util)

- (int)getLinesWithLabelWidth:(CGFloat)width {
    return (int)[self getLinesArrayOfStringWidth:width].count;
}
- (NSArray *)getLinesArrayOfStringWidth:(CGFloat)width {
    NSString *text = [self text];
    UIFont *font = [self font];
    if (text == nil) {
        return nil;
    }
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:(NSString *)kCTFontAttributeName
                   value:(__bridge  id)myFont
                   range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

- (void)updateLabel:(UILabel *)txtLabel content: (NSString *)content frame:(CGRect)frame flagStr:(NSString *)flgStr {
  //为了避免一步步处理数据的时候 在UI上出现各种奇怪的显示我们复制出一个和上面初始化的titleLabel一样的label出来在这上面处理数据带数据完全出来好之后再将数据赋值给titleLabel
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:16.0];
    label.text = content;
    NSString *str = [[NSString alloc] init];
    if (flgStr.length == 0) {
        str = content;
     } else {
        //第一次尝试将数据源和固定文本结合
        label.text = [NSString stringWithFormat:flgStr,content];
        int lines = [self getLinesWithLabel:label];
        //如果结合过后行数大于limit_numOfLines
        if (lines > limitMaxLines) {
            //那么先将label的text恢复成没有尝试结合之前的样子
            label.text = content;
            str = [self getTitle:content flagStr:flgStr label:label];
        } else {
           //如果结合过后的行数小于或等于2行直接就可以用这个处理后的数据
            str  = [NSString stringWithFormat:flgStr,content];
        }
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  //此处的lineBreakMode设置一定要和UILabel延展里面获取每行内容是设置的一样,避免因为换行地方不同造成的计算误差
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5.0;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, [str length])];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:UIColor.blueColor} range:NSMakeRange(str.length-2, 2)];
    txtLabel.attributedText = attributedString;
    
    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(kScreenWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    CGRect frame1 = self.frame;
    frame1.size.height = size.height + 10;
    //self.frame = frame1;
    self.backgroundColor = [UIColor redColor];
}

- (int)getLinesWithLabel:(UILabel *)label {
    return [label getLinesWithLabelWidth:CGRectGetWidth(label.frame)];
}
- (NSString *)getTitle:(NSString *)content flagStr:(NSString *)flagStr label:(UILabel *)label {
    int lines = [self getLinesWithLabel:label];
     //如果大于limit_numOfLines行
    if (lines >= limitMaxLines) {
        NSArray *contentArr = [label getLinesArrayOfStringWidth:CGRectGetWidth(label.frame)];
         //将limitMaxLines所有行的字符串重组
        NSMutableString *mutableStr = [NSMutableString string];
        for (int i = 0; i < limitMaxLines; i++) {
            [mutableStr appendFormat:@"%@", contentArr[i]];
        }
        [mutableStr appendString:@"…"];
        int limitLinesCount = (int)mutableStr.length;
        for (int i = 0; i < limitLinesCount; i++) {
            NSString *tempStr = [mutableStr substringWithRange:NSMakeRange(0, limitLinesCount-i-3)];
            NSString *str = [NSString stringWithFormat:@"%@…", tempStr];
            str = [NSString stringWithFormat:flagStr, str];
            label.text = str;
            NSArray *tempArr = [label getLinesArrayOfStringWidth:CGRectGetWidth(label.frame)];
            //直到我们截取到字符串和固定文字的组合刚刚好是limit_numOfLines行就大功告成
            if (tempArr.count <= limitMaxLines) {
                i = limitLinesCount + 1;
                return str;
            }
        }
        return content;
    }
    return content;
}

@end
