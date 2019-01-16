//
//  HandleTreeTagsModel.m
//  Star
//
//  Created by xia on 2018/7/9.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "HandleTreeTagsModel.h"


@implementation HandleTreeTagsModel


+ (ScreeningListModel *)showDefaultData:(TreeTagListModel *)model {
    ScreeningListModel *listModel = [ScreeningListModel new];
    listModel.list = [NSMutableArray new];
    [self createGroupTags:listModel.list treeListModel:model.tags];
    return listModel;
}


/**
 递归遍历各个层级的子节点

 @param list 遍历后存放的数组
 @param treeList 层级树
 */
+ (void)createGroupTags:(NSMutableArray<ScreeningTagGroupModel> *)list
          treeListModel:(NSArray<TreeTagListModel> *)treeList
{
    ScreeningTagGroupModel *targetGroup = [ScreeningTagGroupModel new];
    targetGroup.tags = [NSMutableArray new];
    
    NSMutableArray<TreeTagListModel> *treeArray = [NSMutableArray new];
    int i = 0;
    for (TreeTagListModel *T_tmp in treeList) {
        i ++ ;
        targetGroup.groupTag = T_tmp.groupName;
        ScreeningDataModel *dataModel = [ScreeningDataModel new];
        dataModel.tag = T_tmp.name;
        dataModel.selected = NO;
        dataModel.code = T_tmp.id;
        dataModel.parentId = T_tmp.parentId;
        dataModel.show = YES;
        [targetGroup.tags addObject:dataModel];
        [treeArray addObject:T_tmp];
        //当遍历到最后一个时，遍历下一层级
        if (i == treeList.count) {
            [list addObject:targetGroup];
            NSMutableArray *nextTree = [NSMutableArray new];
            for (TreeTagListModel *subTree in treeArray) {
                [nextTree addObjectsFromArray:subTree.tags];
            }
            //做递归
            [self createGroupTags:list treeListModel:[nextTree copy]];
        }
    }
}

+ (ScreeningListModel *)showSelectItemSelectTagId:(NSString *)tagId itemSection:(NSInteger)section itemRow:(NSInteger)row sourceModel:(ScreeningListModel *)sourceModel {
    ScreeningListModel *targetModel = [ScreeningListModel new];
    targetModel = sourceModel;
    
    //上一级
    if (section > 0) {
        //第一级不存在上一级
        ScreeningTagGroupModel *lastGroup = sourceModel.list[section-1];
        if (!lastGroup.currentSelect) {
            return nil;
        }
    }
    
    //当前级的状态  
    ScreeningTagGroupModel *currentGroup = sourceModel.list[section];
    currentGroup.currentSelect = YES;
    for (ScreeningDataModel *dataModel in currentGroup.tags) {
        dataModel.selected = NO;
        if ([dataModel.code isEqualToString:tagId]) {
            dataModel.selected = YES;
        }
    }
    
    //当前级所在级的所有下级 - 选中状态置空
    for (NSInteger i = section+1; i < sourceModel.list.count; i ++) {
        ScreeningTagGroupModel *groupModel = targetModel.list[i];
        for (ScreeningDataModel *dataModel in groupModel.tags) {
            dataModel.selected = NO;
            //当前级的下一级数据刷新
            if (i == section+1) {
                if ([dataModel.parentId isEqualToString:tagId]) {
                    dataModel.show = YES;
                } else {
                    dataModel.show = NO;
                }
            }
            groupModel.currentSelect = NO;
        }
    }
    
    
    return targetModel;
}

@end
