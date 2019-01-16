//
//  ScreeningListModel.h
//  Star
//
//  Created by xia on 2018/6/26.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 当个item需要的数据
 */
@interface ScreeningDataModel: NSObject
//当前标签是否选中
@property(nonatomic, assign) BOOL selected;
//当前标签是否需要展示
@property(nonatomic, assign) BOOL show;
//标签名字
@property(nonatomic, copy) NSString *tag;
//
@property(nonatomic, copy) NSString *code;
//父标签ID
@property(nonatomic, copy) NSString *parentId;
@end

@protocol ScreeningDataModel<NSObject>
@end


/**
 section所需的数据
 */
@interface ScreeningTagGroupModel : NSObject
//组名
@property(nonatomic, copy) NSString *groupTag;

@property(nonatomic, assign) BOOL currentSelect;

@property(nonatomic, strong) NSMutableArray<ScreeningDataModel> *tags;
@end

@protocol ScreeningTagGroupModel<NSObject>
@end

@interface ScreeningListModel : NSObject

@property(nonatomic, strong) NSMutableArray<ScreeningTagGroupModel> *list;

@end
