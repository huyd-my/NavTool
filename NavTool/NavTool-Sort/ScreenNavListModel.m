//
//  ScreenNavListModel.m
//  NavTool
//
//  Created by 不明下落 on 2019/1/16.
//  Copyright © 2019 不明下落. All rights reserved.
//

#import "ScreenNavListModel.h"

#define ScreenItemIndex 3

@implementation ScreenNavListModel
- (instancetype)handleItemModelArrayWithItemSelect:(NSInteger)selectIndex {
    ScreenNavListModel *listModel = self;
    for (int i = 0 ; i < self.list.count; i ++) {
        ScreenNavDataModel *model = listModel.list[i];
        if (i == selectIndex) {
            if (model.type == ItemSelelctTypeNone || model.type == ItemSelelctTypeDoubleType) {
                model.type = ItemSelelctTypeSingleType;
            } else if (model.type == ItemSelelctTypeSingleType) {
                model.type = ItemSelelctTypeDoubleType;
            }
        } else if (i == ScreenItemIndex) {
            
        } else {
            model.type = ItemSelelctTypeNone;
        }
        listModel.list[i] = model;
    }
    return listModel;
}

@end
