//
//  SSAlertGlobalTask.h
//  Soul_New
//
//  Created by Zitao Wang on 2020/9/28.
//  Copyright © 2020 Soul. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SSAlertViewMaxOrder INT64_MAX
#define SSAlertViewMinOrder INT64_MIN

typedef id _Nullable (^Operation)(void);

typedef enum : NSInteger {
    SSAlertGlobalTaskOrderHigh = 1024,
    SSAlertGlobalTaskOrderDefault = 0,
    SSAlertGlobalTaskOrderLow = -1024,
} SSAlertGlobalTaskOrder;

NS_ASSUME_NONNULL_BEGIN

@interface SSAlertGlobalTask : NSObject

@property (nonatomic,assign) SSAlertGlobalTaskOrder order;

@property (nonatomic,strong) Operation operation;

@end

NS_ASSUME_NONNULL_END
