//
//  ScreenNavDataModel.h
//  Star
//
//  Created by xia on 2018/6/21.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ItemSelelctType) {
    ItemSelelctTypeNone = 0,         //未选中
    ItemSelelctTypeSingleType = 1,        //单击
    ItemSelelctTypeDoubleType = 2        //双击
};

@interface ScreenNavDataModel : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *normalImage;

@property(nonatomic, copy) NSString *selectSingleImage;

@property(nonatomic, copy) NSString *selectDoubleImage;

@property(nonatomic, assign) ItemSelelctType type;

@end
