//
//  ScreeningProductView.h
//  Star
//
//  Created by xia on 2018/6/26.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagButton.h"
#import "ScreeningListModel.h"
#import "TreeTagListModel.h"

@protocol ScreeningProductViewDelegate<NSObject>

/**
 点击确定按钮

 @param tagId tagID
 */
- (void)alertViewDidSelectSureButtonWithId: (NSString *)tagId;

/**
 点击重置按钮 -- 清空tagID，发起搜索请求
 */
- (void)alertViewDidSelectResetButtonClick;

/**
 保存点击记录

 @param model 搜索标签状态的保存数据
 */
- (void)alertViewDidSelectIndexItemWithModel:(ScreeningListModel *)model;

@end

@interface ScreeningProductView : UIView

@property(nonatomic, weak) id<ScreeningProductViewDelegate> alertDelegate;

/**
 在接口没有情况下自己写model看页面显示情况

 @param listModel 数据源
 @return 实例
 */
- (instancetype)initWithListModel:(ScreeningListModel *)listModel;


/**
 筛选弹框

 @param listModel 网络获取数据源。页面显示的元数据
 @param tagsModel 上次筛选标签。记录上次筛选状态
 @return 实例
 */
- (instancetype)initWithListModel:(ScreeningListModel *)listModel tagsModel:(TreeTagListModel *)tagsModel;

- (void)show;
@end
