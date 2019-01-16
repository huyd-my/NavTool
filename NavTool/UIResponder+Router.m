//
//  UIResponder+ShoppingMallRouter.m
//  Star
//
//  Created by xia on 2018/6/20.
//  Copyright © 2018年 Mr_zhaohy. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)
- (void)routerEventWithName:(NSString *)eventName userInfo:(nullable NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}
@end
