//
//  ScreenNavDataModel.h
//  Star
//
//  Created by xia on 2018/6/21.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 item的样式

 - ItemSelelctTypeNone: 未选中
 - ItemSelelctTypeSingleType: 单击
 - ItemSelelctTypeDoubleType: 双击
 */
typedef NS_ENUM(NSInteger,ItemSelelctType) {
    ItemSelelctTypeNone = 0,
    ItemSelelctTypeSingleType = 1,
    ItemSelelctTypeDoubleType = 2        
};

@interface ScreenNavDataModel : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *normalImage;

@property(nonatomic, copy) NSString *selectSingleImage;

@property(nonatomic, copy) NSString *selectDoubleImage;

@property(nonatomic, assign) NSInteger itemCode;

@property(nonatomic, assign) ItemSelelctType type;

@end
