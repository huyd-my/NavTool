//
//  ScreenNavBarItem.m
//  Star
//
//  Created by xia on 2018/6/21.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "ScreenNavBarItem.h"
#import "RDControlFactory.h"
#import "UIResponder+Router.h"
#import <RdAppSkinColor.h>
#import <Masonry.h>

@interface ScreenNavBarItem()
{
    NSString *_title;
    NSString *_iconN;
    NSString *_iconS;
    NSString *_iconD;
    ItemSelelctType _type;
}
@property(nonatomic, strong) UILabel *titlelabel;
@property(nonatomic, strong) UIImageView *iconIMG;
@end

@implementation ScreenNavBarItem

- (instancetype)initWithTitle:(NSString *)title normalIcon:(NSString *)normalIcon selectSingleIcon:(NSString *)singleIcon selectDoubleIcon:(NSString *)doubleIcon {
    self = [super init];
    if (self) {
        _title = title;
        _iconN = normalIcon;
        _iconS = singleIcon;
        _iconD = doubleIcon;
        self.backgroundColor = [UIColor whiteColor];
        [self titlelabel];
        [self iconIMG];
    }
    return self;
}

- (void)updateWithType:(ItemSelelctType)type {
    _type = type;
    if (type == ItemSelelctTypeNone) {
        self.titlelabel.textColor = [RdAppSkinColor sharedInstance].emphasisSubTextColor;
        self.iconIMG.image = [UIImage imageNamed:_iconN];
    } else if (type == ItemSelelctTypeSingleType) {
        self.titlelabel.textColor = [RdAppSkinColor sharedInstance].mainColor;
        self.iconIMG.image = [UIImage imageNamed:_iconS];
    } else if (type == ItemSelelctTypeDoubleType) {
        self.titlelabel.textColor = [RdAppSkinColor sharedInstance].mainColor;
        self.iconIMG.image = [UIImage imageNamed:_iconD];
    }
}

- (ProductSortType)currentItemState {
    if ([_title isEqualToString:@"综合"]) {
        return ProductSortTypeComprehensive;
    }
    if ([_title isEqualToString:@"销量"]) {
        return ProductSortTypeSalesDesc;
    }
    if ([_title isEqualToString:@"价格"]) {
        if (_currentType == ItemSelelctTypeSingleType) {
            return ProductSortTypePriceAsc;
        } else if (_currentType == ItemSelelctTypeDoubleType) {
            return ProductSortTypePriceDesc;
        }
    }
    if ([_title isEqualToString:@"筛选"]) {
        return ProductSortTypeScreening;
    }
    return 0;
}

- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [UILabel getLabelWithFontSize:15 textColor:[RdAppSkinColor sharedInstance].emphasisSubTextColor superView:self];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        _titlelabel.text = _title;
        CGFloat offsetCenter = _iconN.length <= 0 ? 0 : -7;
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.centerX.mas_equalTo(self).offset(offsetCenter);
        }];
    }
    return _titlelabel;
}
- (UIImageView *)iconIMG {
    if (!_iconIMG) {
        _iconIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_iconN]];
        [self addSubview:_iconIMG];
        CGFloat side = _iconN.length <= 0 ? 0 : 12;
        [_iconIMG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.titlelabel.mas_right).offset(2);
            make.size.mas_equalTo(CGSizeMake(side, side));
        }];
    }
    return _iconIMG;
}

@end
