//
//  SCCollectionButtonsView.m
//  SCCollectionButton
//
//  Created by 不明下落 on 2018/6/24.
//  Copyright © 2018年 不明下落. All rights reserved.
//

#import "SCCollectionButtonsView.h"
#import "ButtonsCollectionViewCell.h"
#import "HeadCollectionReusableView.h"
#import "ScreeningListModel.h"
#import <Masonry.h>

#define HeadCollectionReusableViewId @"HeadCollectionReusableViewId"
#define ButtonsCollectionViewCellId @"ButtonsCollectionViewCellId"

@interface SCCollectionButtonsView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ButtonsCollectionViewCellDelegate, HeadCollectionReusableViewDelegate, TagButtonDelegate>
{
    ScreeningListModel *_listModel;
    TagsCollectionType _type;
}
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SCCollectionButtonsView

- (instancetype)initWithFrame:(CGRect)frame style:(TagsCollectionType)type {
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        self.backgroundColor = [UIColor whiteColor];
        [self collectionView];
    }
    return self;
}

- (void)updateWithListModel:(ScreeningListModel *)listModel {
    _listModel = listModel;
    [self.collectionView reloadData];
}

- (void)reloadTagsData {
    [self.collectionView reloadData];
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)longPress:(UILongPressGestureRecognizer *)ges {
    if (ges.state == UIGestureRecognizerStateBegan) {
        ButtonsCollectionViewCell *cell = (ButtonsCollectionViewCell *)ges.view;
        [cell updateShowDeleteButton];
    }
}
#pragma mark - TagButtonDelegate
- (void)returnTagIdWhileSelect:(NSString *)tagId {
    if (_tagsViewDelegate && [_tagsViewDelegate respondsToSelector:@selector(returnTagCodeWhileSelecte:)]) {
        [_tagsViewDelegate returnTagCodeWhileSelecte:tagId];
    }
}
#pragma mark - HeadCollectionReusableViewDelegate
- (void)removeAllButtonClick {
    if (_tagsViewDelegate && [_tagsViewDelegate respondsToSelector:@selector(removeAllTag)]) {
        [_tagsViewDelegate removeAllTag];
    }
}

#pragma mark - ButtonsCollectionViewCellDelegate
- (void)delegateButtonClickWithText:(NSString *)tag {
    if (_tagsViewDelegate && [_tagsViewDelegate respondsToSelector:@selector(removeOneTagWithText:)]) {
        [_tagsViewDelegate removeOneTagWithText:tag];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _listModel.list.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ScreeningTagGroupModel *array = _listModel.list[section];
    int i = 0;
    for (ScreeningDataModel *data in array.tags) {
        if (data.show) {
            i += 1;
        }
    }
    return i;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ButtonsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ButtonsCollectionViewCellId forIndexPath:indexPath];
    if (_type == TagsCollectionTypeSeachHistory) {
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longGesture.minimumPressDuration = 1.0;
        longGesture.view.tag = indexPath.row;
//        [cell addGestureRecognizer:longGesture];
    }

    cell.tagsButton.font = self.textFont;
    cell.tagsButton.tagDelegate = self;
    
    cell.tagsButton.normalTextColor = self.normalTextColor;
    cell.tagsButton.normalBGColor = self.normalBoderColor;
    cell.tagsButton.normalBoderColor = self.normalBoderColor;
    
    cell.tagsButton.selectTextColor = self.selectTextColor;
    cell.tagsButton.selectBGColor = self.selectBGColor;
    cell.tagsButton.selectBoderColor = self.selectBoderColor;
    cell.tagsButton.layer.cornerRadius = 0.5*self.height;
    ScreeningTagGroupModel *array = _listModel.list[indexPath.section];
    NSMutableArray<ScreeningDataModel *> *tags = [NSMutableArray arrayWithCapacity:0];
    for (ScreeningDataModel *data in array.tags) {
        if (data.show) {
            [tags addObject:data];
        }
    }
    
    [cell.tagsButton updateWithDataModel:tags[indexPath.row]];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeadCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadCollectionReusableViewId forIndexPath:indexPath];
    headerView.headDelegate = self;
    ScreeningTagGroupModel *array = _listModel.list[indexPath.section];
    [headerView updateWithText:array.groupTag];
    [headerView updateWithShowRightButton:_type == TagsCollectionTypeSeachHistory];
    return headerView;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //这部分可以重新考虑解决方案
    //当前  将数据处理部分全部移交给使用该控件的父级视图，collection只取、展示数据，不更改数据
    ScreeningTagGroupModel *array = _listModel.list[indexPath.section];
    NSMutableArray<ScreeningDataModel *> *showTags = [NSMutableArray arrayWithCapacity:0];
    for (ScreeningDataModel *data in array.tags) {
        if (data.show) {
            [showTags addObject:data];
        }
    }
    ScreeningDataModel *model = showTags[indexPath.row];
    if (_tagsViewDelegate && [_tagsViewDelegate respondsToSelector:@selector(didSelectTagInSection:inRow:tagText:tagCode:)]) {
        [_tagsViewDelegate didSelectTagInSection:indexPath.section inRow:indexPath.row tagText:model.tag tagCode:model.code];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScreeningTagGroupModel *groupModel = _listModel.list[indexPath.section];
    NSMutableArray<ScreeningDataModel *> *showTags = [NSMutableArray arrayWithCapacity:0];
    for (ScreeningDataModel *data in groupModel.tags) {
        if (data.show) {
            [showTags addObject:data];
        }
    }
    ScreeningDataModel *itemModel = showTags[indexPath.row];
    CGSize textSize  = [self sizeWithText:itemModel.tag font:self.textFont maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    return CGSizeMake(textSize.width+self.leftAndRightPadding, self.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,15,15,15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50.0f);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5*self.topAndBottonMagin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5*self.leftAndRightMagin;
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ButtonsCollectionViewCell class] forCellWithReuseIdentifier:ButtonsCollectionViewCellId];
         [_collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadCollectionReusableViewId];
        
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
        }];
    }
    return _collectionView;
}


- (UIFont *)textFont {
    if (!_textFont) {
        _textFont = [UIFont systemFontOfSize:13];
    }
    return _textFont;
}
- (CGFloat)height {
    if (!_height) {
        _height = 40;
    }
    return _height;
}

- (CGFloat)leftAndRightPadding {
    if (!_leftAndRightPadding) {
        _leftAndRightPadding = 8;
    }
    return _leftAndRightPadding;
}

- (CGFloat)leftAndRightMagin {
    if (!_leftAndRightMagin) {
        _leftAndRightMagin = 4;
    }
    return _leftAndRightMagin;
}
- (CGFloat)topAndBottonMagin {
    if (!_topAndBottonMagin) {
        _topAndBottonMagin = 4;
    }
    return _topAndBottonMagin;
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
