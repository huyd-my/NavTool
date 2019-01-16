//
//  TagButton.m
//  SCCollectionButton
//
//  Created by 不明下落 on 2018/6/24.
//  Copyright © 2018年 不明下落. All rights reserved.
//

#import "TagButton.h"

@implementation TagButton

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        [self normalShow];
    }
    return self;
}

- (void)normalShow {
    self.textColor = self.normalTextColor;
    self.backgroundColor = self.normalBGColor;
    self.layer.borderColor = self.normalBoderColor.CGColor;
}

- (void)selectShow {
    self.textColor = self.selectTextColor;
    self.backgroundColor = self.selectBGColor;
    self.layer.borderColor = self.selectBoderColor.CGColor;
}

- (void)updateWithDataModel:(ScreeningDataModel *)dataModel {
    self.text = dataModel.tag;
    if (dataModel.selected) {
        if (_tagDelegate && [_tagDelegate respondsToSelector:@selector(returnTagIdWhileSelect:)]) {
            [_tagDelegate returnTagIdWhileSelect:dataModel.code];
        }
        self.layer.borderColor = self.selectBoderColor.CGColor;
        [self selectShow];
    } else {
        self.layer.borderColor = self.normalBoderColor.CGColor;
        [self normalShow];
    }
}



- (UIImage*)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIColor *)normalTextColor {
    if (!_normalTextColor) {
        _normalTextColor = [UIColor blackColor];
    }
    return _normalTextColor;
}
- (UIColor *)normalBGColor {
    if (!_normalBGColor) {
        _normalBGColor = [UIColor redColor];
    }
    return _normalBGColor;
}
- (UIColor *)normalBoderColor {
    if (!_normalBoderColor) {
        _normalBoderColor = [UIColor redColor];
    }
    return _normalBoderColor;
}
- (UIColor *)selectTextColor {
    if (!_selectTextColor) {
        _selectTextColor = [UIColor redColor];
    }
    return _selectTextColor;
}
- (UIColor *)selectBGColor {
    if (!_selectBGColor) {
        _selectBGColor = [UIColor whiteColor];
    }
    return _selectBGColor;
}
- (UIColor *)selectBoderColor {
    if (!_selectBoderColor) {
        _selectBoderColor = [UIColor redColor];
    }
    return _selectBoderColor;
}
@end
