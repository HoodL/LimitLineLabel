//
//  UnfoldIndexManager.h
//  LimitLineLabel
//
//  Created by 李辉 on 2022/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnfoldIndexManager : NSObject

+ (NSMutableArray *)addUnfoldIndex:(NSIndexPath *)indexPath;

+ (NSMutableArray *)removeUnfoldIndex:(NSIndexPath *)indexPath;

+ (BOOL)containsIndexPath:(NSIndexPath *)indexPath;

+ (void)resetUnfoldIndexs;

@end

NS_ASSUME_NONNULL_END
