//
//  ScreenNavBarItem.h
//  Star
//
//  Created by xia on 2018/6/21.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenNavDataModel.h"


#define ACTION_ShowRightScreeningView @"showRightScreeningView"

@interface ScreenNavBarItem : UIView

@property(nonatomic, assign) ItemSelelctType currentType;

@property(nonatomic, assign) NSInteger currentItemCode;

/**
 创建商品选择导航条          === >   改用model创建

 @param title 标题
 @param normalIcon 未选中图片
 @param singleIcon 选中单次图片
 @param doubleIcon 选中双次图片
 @param itemCode item的标识
 @return shuli
 */
//- (instancetype)initWithTitle:(NSString *)title
//                   normalIcon:(NSString *)normalIcon
//             selectSingleIcon:(NSString *)singleIcon
//             selectDoubleIcon:(NSString *)doubleIcon
//                     itemCode:(NSInteger)itemCode;


/**
 初始化方法

 @param model 数据源
 @return 实例
 */
- (instancetype)initWithItemModel:(ScreenNavDataModel *)model;


/**
 更新item的样式

 @param type 样式的枚举
 */
- (void)updateWithType:(ItemSelelctType)type;

@end
