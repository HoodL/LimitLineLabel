//
//  LimitLabelTableViewCell2.m
//  LimitLineLabel
//
//  Created by 李辉 on 2022/5/25.
//

#import "LimitLabelTableViewCell2.h"
#import <YYKit/NSAttributedString+YYText.h>
#import "Masonry.h"
#import "UnfoldIndexManager.h"

@interface LimitLabelTableViewCell2 ()

@property(nonatomic, strong) YYLabel *contentLabel;

@end

@implementation LimitLabelTableViewCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(24);
        make.trailing.mas_equalTo(-24);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-5);
    }];
}

- (YYLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [YYLabel new];
        _contentLabel.numberOfLines = 4;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.75];
        _contentLabel.userInteractionEnabled = YES;
        _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _contentLabel.preferredMaxLayoutWidth = kScreenWidth - 48;
        [self addSeeMoreButton:nil];
    }
    return _contentLabel;
}

#pragma mark - 添加全文
- (void)addSeeMoreButton:(NSMutableAttributedString *)attri {

    __weak __typeof(self) weakSelf = self;

//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...全文"];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"..."];
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];

    hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) { // 点击全文回调 YYLabel *label = weakSelf.label;
        weakSelf.contentLabel.numberOfLines = 0;
        UITableView *tableView = (UITableView *)weakSelf.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:weakSelf];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [UnfoldIndexManager addUnfoldIndex:indexPath];

        [tableView reloadData];
        //[weakSelf.contentView layoutIfNeeded];
        //[weakSelf.contentLabel sizeToFit];
        //[tableView layoutIfNeeded];

    };

    [text setColor:[UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000] range:[text.string rangeOfString:@"全文"]];
    //[text setTextHighlight:hi range:[text.string rangeOfString:@"全文"]];
    text.font = _contentLabel.font;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];

    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage systemImageNamed:@"chevron.down"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 16, 16);
     
    YYAnimatedImageView *imageView= [[YYAnimatedImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.down"]];
    imageView.frame = CGRectMake(0, 0, 16, 16);
    imageView.userInteractionEnabled = YES;
    
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView.frame.size alignToFont:_contentLabel.font alignment:YYTextVerticalAlignmentCenter];
//    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView.image contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView.image.size alignToFont:_contentLabel.font alignment:YYTextVerticalAlignmentCenter];

    [attachText setTextHighlight:hi range:NSMakeRange(0, attachText.length)];

    [text appendAttributedString:attachText];
    //_contentLabel.attributedText = attri;
//    // 创建带有图片的富文本
//    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//    [attri insertAttributedString:string atIndex:0];
//
//    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.font alignment:YYTextVerticalAlignmentCenter];
    //_contentLabel.truncationToken = truncationToken;
    _contentLabel.truncationToken = text;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        //NSLog(@"weakSelf=%p, weakSelf.contentLabel=%p", weakSelf, weakSelf.contentLabel);
        //weakSelf.contentLabel.numberOfLines = 0;
        //[weakSelf.contentLabel sizeToFit];
        UITableView *tableView = (UITableView *)weakSelf.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:weakSelf];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [UnfoldIndexManager addUnfoldIndex:indexPath];
        [tableView reloadData];
//        [weakSelf.contentView layoutIfNeeded];
//        [weakSelf.contentLabel layoutIfNeeded];
//        [weakSelf.contentLabel sizeToFit];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [weakSelf.contentView layoutIfNeeded];

    }];
    [imageView addGestureRecognizer:tap];
}

//YYLabel *contentL = [[YYLabel alloc] init];
////设置多行
//contentL.numberOfLines = 0;
////这个属性必须设置，多行才有效
//contentL.preferredMaxLayoutWidth = kScreenWidth -32;
//
// NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:[OSCBaseCommetView contentStringFromRawString:commentItem.content withFont:24.0]];
//
////可以将要插入的图片作为特殊字符处理
////需要使用 YYAnimatedImageView 控件，直接使用UIImage添加无效。
//
//YYAnimatedImageView *imageView1= [[YYAnimatedImageView alloc] initWithImage:[UIImage imageNamed:@"ic_quote_left"]];
//imageView1.frame = CGRectMake(0, 0, 16, 16);
//
//YYAnimatedImageView *imageView2= [[YYAnimatedImageView alloc] initWithImage:[UIImage imageNamed:@"ic_quote_right"]];
//imageView2.frame = CGRectMake(0, 0, 16, 16);
//// attchmentSize 修改，可以处理内边距
//NSMutableAttributedString *attachText1= [NSMutableAttributedString attachmentStringWithContent:imageView1 contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView1.frame.size alignToFont:[UIFont systemFontOfSize:24] alignment:YYTextVerticalAlignmentCenter];
//
//NSMutableAttributedString *attachText2= [NSMutableAttributedString attachmentStringWithContent:imageView2 contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView2.frame.size alignToFont:[UIFont systemFontOfSize:24] alignment:YYTextVerticalAlignmentCenter];
//
// //插入到开头
//[attri insertAttributedString:attachText1 atIndex:0];
// //插入到结尾
//[attri appendAttributedString:attachText2];
//
////用label的attributedText属性来使用富文本
//contentL.attributedText = attri;
//
//CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 32, MAXFLOAT);
//
////计算文本尺寸
//YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:attri];
//contentL.textLayout = layout;
//CGFloat introHeight = layout.textBoundingSize.height;
//
//
//contentL.frame =  commentItem.layoutInfo.contentTextViewFrame;
//contentL.width = maxSize.width;
//
//contentL.height = introHeight + 50;

- (void)bindData:(NSString *)content {
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = _contentLabel.font;
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:content attributes:nil]];
    [text addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, content.length)];
    
   // _contentLabel.attributedText = text;
    //NSLog(@"self=%p, self.contentLabel=%p, self.contentLabel.numOflines=%ld", self, self.contentLabel, self.contentLabel.numberOfLines);
    if ([UnfoldIndexManager containsIndexPath:self.indexPath]) {
        self.contentLabel.numberOfLines = 0;
        NSLog(@"self.indexPath=%@", NSStringFromCGPoint(CGPointMake(self.indexPath.section, self.indexPath.row)));
    }
    
    self.contentLabel.attributedText = [self addFoldImage:text];
}

- (NSMutableAttributedString *)addFoldImage:(NSMutableAttributedString *)content {
    YYAnimatedImageView *imageView= [[YYAnimatedImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.up"]];
    imageView.frame = CGRectMake(0, 0, 16, 16);
    imageView.userInteractionEnabled = YES;
    
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView.frame.size alignToFont:_contentLabel.font alignment:YYTextVerticalAlignmentCenter];

    __weak __typeof(self) weakSelf = self;

    //[attachText setTextHighlight:hi range:NSMakeRange(0, attachText.length)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        //NSLog(@"weakSelf=%p, weakSelf.contentLabel=%p", weakSelf, weakSelf.contentLabel);
        //weakSelf.contentLabel.numberOfLines = 0;
        //[weakSelf.contentLabel sizeToFit];
        UITableView *tableView = (UITableView *)weakSelf.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:weakSelf];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [UnfoldIndexManager removeUnfoldIndex:indexPath];
        [tableView reloadData];
//        [weakSelf.contentView layoutIfNeeded];
//        [weakSelf.contentLabel layoutIfNeeded];
//        [weakSelf.contentLabel sizeToFit];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [weakSelf.contentView layoutIfNeeded];

    }];
    [imageView addGestureRecognizer:tap];

    [content appendAttributedString:attachText];
    return content;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.contentLabel.numberOfLines = 4;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
