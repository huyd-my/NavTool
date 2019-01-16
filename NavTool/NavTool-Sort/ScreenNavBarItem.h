//
//  ScreenNavBarItem.h
//  Star
//
//  Created by xia on 2018/6/21.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenNavDataModel.h"

typedef NS_ENUM(NSInteger,ProductSortType) {
    ProductSortTypeComprehensive = 0,     //综合
    ProductSortTypeSalesDesc = 1,        //销量降序
    ProductSortTypePriceAsc = 2,         //价格升序
    ProductSortTypePriceDesc = 3,       //价格降序
    ProductSortTypeScreening = 4        //筛选
};

#define ACTION_ShowRightScreeningView @"showRightScreeningView"

@interface ScreenNavBarItem : UIView

@property(nonatomic, assign) ItemSelelctType currentType;

/**
 创建商品选择导航条

 @param title 标题
 @param normalIcon 未选中图片
 @param singleIcon 选中单次图片
 @param doubleIcon 选中双次图片
 @return shuli
 */
- (instancetype)initWithTitle:(NSString *)title
                   normalIcon:(NSString *)normalIcon
             selectSingleIcon:(NSString *)singleIcon
             selectDoubleIcon:(NSString *)doubleIcon;

- (void)updateWithType:(ItemSelelctType)type;

- (ProductSortType)currentItemState;
@end
