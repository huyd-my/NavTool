//
//  SCCollectionButtonsView.h
//  SCCollectionButton
//
//  Created by 不明下落 on 2018/6/24.
//  Copyright © 2018年 不明下落. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreeningListModel.h"

typedef NS_ENUM(NSInteger, TagsCollectionType)
{
    TagsCollectionTypeSeachHistory = 0,
    TagsCollectionTypeNomal = 1,
};

@protocol SCCollectionButtonsViewDelegate<NSObject>
@optional
- (BOOL)didSelectTagInSection:(NSInteger)section inRow:(NSInteger)row tagText:(NSString *)tag tagCode:(NSString *)code;
- (void)removeOneTagWithText:(NSString *)text;
- (void)removeAllTag;

/**
 返回最后高亮状态的tagID   --当cell重用是这个方法会有问题

 @param tagCode ID
 */
- (void)returnTagCodeWhileSelecte:(NSString *)tagCode;
@end

@interface SCCollectionButtonsView : UIView

@property(nonatomic, assign) BOOL removeOtherTag;

@property(nonatomic, assign) CGFloat leftAndRightPadding;
@property(nonatomic, assign) CGFloat leftAndRightMagin;
@property(nonatomic, assign) CGFloat topAndBottonMagin;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, strong) UIFont *textFont;

@property(nonatomic, strong) UIColor *selectTextColor;
@property(nonatomic, strong) UIColor *selectBGColor;
@property(nonatomic, strong) UIColor *selectBoderColor;

@property(nonatomic, strong) UIColor *normalTextColor;
@property(nonatomic, strong) UIColor *normalBGColor;
@property(nonatomic, strong) UIColor *normalBoderColor;

@property(nonatomic, weak) id<SCCollectionButtonsViewDelegate> tagsViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame style:(TagsCollectionType)type;

- (void)updateWithListModel:(ScreeningListModel *)listModel;

- (void)reloadTagsData;

@end
