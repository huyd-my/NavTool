//
//  AllProductScreenNavBar.h
//  Star
//
//  Created by xia on 2018/6/21.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ScreenNavDataModel.h"
#import "ScreenNavBarItem.h"


typedef void(^itemSelect)(ScreenNavBarItem *item, NSInteger selectIndex);

@interface AllProductScreenNavBar : UIView

@property(nonatomic, copy) itemSelect itemSelect;


/**
 初始化

 @param dataArray item数据源
 @return 实例
 */
- (instancetype)initWithScreenNavData:(NSArray<ScreenNavDataModel *> *) dataArray;

/**
 更新视图

 @param dataModel 更新选中方案的数组
 */
- (void)updateWithScreenNavData:(NSArray<ScreenNavDataModel *> *)dataModel;

@end
