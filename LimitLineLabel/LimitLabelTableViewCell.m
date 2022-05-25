//
//  LimitLabelTableViewCell.m
//  LimitLineLabel
//
//  Created by 李辉 on 2022/5/22.
//

#import "LimitLabelTableViewCell.h"
#import "UILabel+Util.h"
#import "Masonry.h"

#define limitMaxLines  4

@interface LimitLabelTableViewCell()

@end

@implementation LimitLabelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel setFrame:CGRectMake(20,0,[UIScreen mainScreen].bounds.size.width-40,60)];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.trailing.mas_equalTo(-20);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-5);
    }];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.trailing.mas_equalTo(-20);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.contentLabel.mas_bottom);
        make.height.mas_equalTo(5);
    }];
}

- (void)bindData:(NSString *)content {
    _contentText = content;
    if (_isOpen) {
        self.contentLabel.text = content;
        self.contentLabel.numberOfLines = 0;
        return;
    }
//    self.contentLabel.numberOfLines = limitMaxLines + 1;
//    [self.contentLabel updateLabel:self.contentLabel content:content frame:self.contentLabel.frame flagStr:@"%@全文"];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"绿音富平柿饼500g独立包装抽真空霜降柿子饼"];
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    
    attch.image = [UIImage systemImageNamed:@"chevron.down"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 16, 16);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:attri.length];
    self.contentLabel.attributedText = attri;

}

- (void)foldAllData {
    _isOpen = !_isOpen;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //[self setSelected:NO animated:YES];
    // Configure the view for the selected state
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:16.0];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.numberOfLines = limitMaxLines + 1;
    }
    return _contentLabel;
}

@end
