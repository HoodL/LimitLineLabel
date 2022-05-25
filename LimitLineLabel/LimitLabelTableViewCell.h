//
//  LimitLabelTableViewCell.h
//  LimitLineLabel
//
//  Created by 李辉 on 2022/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LimitLabelTableViewCell : UITableViewCell

- (void)bindData:(NSString *)content;

- (void)foldAllData;

@property(nonatomic, assign) BOOL isOpen;

@end

NS_ASSUME_NONNULL_END
