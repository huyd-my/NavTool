//
//  TreeTagListModel.h
//  Star
//
//  Created by xia on 2018/7/6.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TreeTagListModel
@end


@interface TreeTagListModel : NSObject

@property(nonatomic, copy) NSString *id;

/**
 标签名称
 */
@property(nonatomic, copy) NSString *name;

/**
 标签code
 */
@property(nonatomic, copy) NSString *code;

/**
 标签所在层级名
 */
@property(nonatomic, copy) NSString *groupName;

/**
 上一级标签的ID
 */
@property(nonatomic, copy) NSString *parentId;

@property(nonatomic, strong) NSArray<TreeTagListModel> *tags;


@end
