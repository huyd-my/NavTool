//
//  HandleTreeTagsModel.h
//  Star
//
//  Created by xia on 2018/7/9.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeTagListModel.h"
#import "ScreeningListModel.h"

@interface HandleTreeTagsModel : NSObject

/**
 初始化数据

 @param model 源数据
 @return 目标collection数据源
 */
+ (ScreeningListModel *)showDefaultData:(TreeTagListModel *)model;


/**
 选中某个item后的数据刷新

 @param tagId 当前选中item的ID
 @param section item所在的section
 @param row item所在的row
 @param sourceModel 数据源（这是一个copy的可变数组集）
 @return 处理后的数据 （不可选中时返回nil）
 */
+ (ScreeningListModel *)showSelectItemSelectTagId:(NSString *)tagId itemSection:(NSInteger)section itemRow:(NSInteger)row sourceModel:(ScreeningListModel *)sourceModel;
@end
