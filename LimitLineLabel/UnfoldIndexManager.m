//
//  UnfoldIndexManager.m
//  LimitLineLabel
//
//  Created by 李辉 on 2022/5/26.
//

#import "UnfoldIndexManager.h"
static NSMutableArray *unfoldList = nil;

@implementation UnfoldIndexManager

+ (NSMutableArray *)addUnfoldIndex:(NSIndexPath *)indexPath {
    if (unfoldList == nil) {
        unfoldList = [NSMutableArray array];
    }
    [unfoldList addObject:indexPath];
    return unfoldList;
}

+ (NSMutableArray *)removeUnfoldIndex:(NSIndexPath *)indexPath {
    [unfoldList removeObject:indexPath];
    return unfoldList;
}

+ (BOOL)containsIndexPath:(NSIndexPath *)indexPath {
    return [unfoldList containsObject:indexPath];
}

+ (void)resetUnfoldIndexs {
    [unfoldList removeAllObjects];
    unfoldList = nil;
}

@end
