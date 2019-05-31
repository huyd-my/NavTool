//
//  AllProductScreenNavBar.m
//  Star
//
//  Created by xia on 2018/6/21.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "AllProductScreenNavBar.h"
#import "Macro.h"
#import "ScreenNavBarItem.h"
#import <Masonry.h>

@interface AllProductScreenNavBar()
{
    NSArray<ScreenNavDataModel *> *_dataArray;
}
@property(nonatomic, assign) CGFloat unitWidth;

@property(nonatomic, strong) NSMutableArray<ScreenNavBarItem *> *itemArray;
@end

@implementation AllProductScreenNavBar

- (instancetype)initWithScreenNavData:(NSArray<ScreenNavDataModel *> *) dataArray {
    self = [super init];
    if (self) {
        _dataArray = dataArray;
        [self createSubViews];
        [self layoutItemSubviews];
    }
    return self;
}

- (void)updateWithScreenNavData:(NSArray<ScreenNavDataModel *> *)dataModel {
    _dataArray = dataModel;
    for (int i = 0; i < self.itemArray.count; i ++) {
        ScreenNavBarItem *item = self.itemArray[i];
        ScreenNavDataModel *model = dataModel[i];
        item.currentType = model.type;
        [item updateWithType:model.type];
    }
}

- (void)createSubViews {
    for (ScreenNavDataModel *dataModel in _dataArray) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userSelectIndexItem:)];
        ScreenNavBarItem *item = [[ScreenNavBarItem alloc] initWithItemModel:dataModel];
        [item addGestureRecognizer:tap];
        [self addSubview:item];
        [self.itemArray addObject:item];
    }
}

- (void)layoutItemSubviews {
    for (int i = 0; i < _dataArray.count; i ++) {
        [self.itemArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * self.unitWidth);
            make.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self.unitWidth);
        }];
    }
}

- (void)userSelectIndexItem:(UITapGestureRecognizer *)tap {
    if (self.itemSelect) {
        //找到点击的item，并将其他item的选中状态置空
        CGFloat centerX = CGRectGetMidX(tap.view.frame);
        NSInteger selectIndex = 0;
        for (int i = 0; i < self.itemArray.count; i ++) {
            CGFloat minX = i*self.unitWidth;
            CGFloat maxX = (1+i)*self.unitWidth;
            if (centerX > minX  && centerX < maxX ) {
                selectIndex = i;
            }
        }
        
        ScreenNavBarItem *item = self.itemArray[selectIndex];
//        ScreenNavBarItem *item = (ScreenNavBarItem *)tap.view;
        self.itemSelect(item,selectIndex);
    }
}

- (CGFloat)unitWidth {
    if (!_unitWidth) {
        _unitWidth = WIDTHOFSCREEN / _dataArray.count;
    }
    return _unitWidth;
}

- (NSMutableArray<ScreenNavBarItem *> *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemArray;
}

@end
