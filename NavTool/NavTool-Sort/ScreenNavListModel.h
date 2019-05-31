//
//  ScreenNavListModel.h
//  NavTool
//
//  Created by 不明下落 on 2019/1/16.
//  Copyright © 2019 不明下落. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScreenNavDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScreenNavListModel : NSObject
@property(nonatomic, strong) NSMutableArray<ScreenNavDataModel *> *list;
- (instancetype)handleItemModelArrayWithItemSelect:(NSInteger)selectIndex;
@end

NS_ASSUME_NONNULL_END
