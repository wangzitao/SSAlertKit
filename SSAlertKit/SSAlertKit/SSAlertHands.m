//
//  SSAlertHands.m
//  Soul_New
//
//  Created by Zitao Wang on 2020/9/24.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "SSAlertHands.h"
#import "SSAlertContainerView.h"
#import <SoulUtils/NSObject+SODeallocBlock.h>
#import "SOUIKit.h"
#import "UIView+Extension.h"

// not particularly precise calculations
#define SOContainerTopSpace(x) (((int)(KScreenHeight - x))>>1)

@interface SSAlertHands ()

@property (nonatomic,strong) NSMutableArray <SSAlertGlobalTask *>*taskQueue;

@property (nonatomic,weak) id currentAlertView;

@end

@implementation SSAlertHands

SingletonM(Hands);

- (instancetype)init{
    if (self = [super init]) {
        _currentAlertView = nil;
        _taskQueue = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (UIView<SSAlertViewControlProtocol>*)createAlertWithData:(NSArray <NSArray<UIView<SSAlertElement>*>*>*)alertData{
    
    NSMutableArray *insetArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<alertData.count; i++) {
        [insetArray addObject:@12];
    }
    return [self createAlertWithData:alertData insetArray:insetArray];
}

- (UIView<SSAlertViewControlProtocol>*)createAlertWithData:(NSArray <NSArray<UIView<SSAlertElement>*>*>*)alertData
                                                insetArray:(NSArray <NSNumber *>*)insetArray{
    CGFloat containerHeight = 0;
    CGFloat baseOffsetY = 0;
    CGFloat baseOffsetX = 0;
    SSAlertContainerView *containerView = [[SSAlertContainerView alloc]init];
    containerView.backgroundColor = GET_COLOR(0);
    containerView.layer.cornerRadius = 12;
    containerView.alpha = 0;
    
    for (NSArray *elements in alertData) {
        // read each line's elements and layout
        NSInteger index = [alertData indexOfObject:elements];
        baseOffsetY += insetArray[index].floatValue;
        CGFloat currentMaxHeight = 0;
        baseOffsetX = SOElementEdgeSpace;
        CGFloat elementWidth = (SOContainerWidth - SOElementEdgeSpace*2 - (elements.count-1)*SOElementSpace)/elements.count;
        for (UIView<SSAlertElement>*element in elements) {
            [containerView addSubview:element];
            if (element.height > 0  && element.width > 0) {
                // if frame is set outside , just use the frame. and the custom height should not more than threshold SOElementImageMaxHeight
                if (element.height > SOElementImageMaxHeight) {
                    element.height = SOElementImageMaxHeight;
                }
            }
            else {
                [element elementHeightWithWidth:elementWidth];
                if (element.expectedHeight > 0) {
                    element.frame = CGRectMake(baseOffsetX, baseOffsetY, elementWidth, element.expectedHeight);
                }
                else {
                    element.frame = CGRectMake(baseOffsetX, baseOffsetY, elementWidth, element.height);
                }
            }
            [element elementDidLayout];
            currentMaxHeight = MAX(currentMaxHeight, element.height);
            baseOffsetX += (elementWidth + SOElementSpace);
        }
        baseOffsetY += currentMaxHeight;
    }
    containerHeight = baseOffsetY + SOElementBottomEdgeSpace;
    containerView.frame = CGRectMake(SOContainerEdgeSpace, SOContainerTopSpace(containerHeight), SOContainerWidth, containerHeight);
    return containerView;
}

- (UIView<SSAlertElement>*)createElementWithClass:(Class)ElementClass content:(id)content{
    UIView<SSAlertElement>*element = [[ElementClass alloc]init];
    NSAssert([element conformsToProtocol:@protocol(SSAlertElement)], @"element should confroms to SSAlertElement");
    [element setContent:content];
    return element;
}

- (void)showAlert:(id<SSAlertViewControlProtocol>)alert
    OBJC_DEPRECATED("use [alert show] instead ")  {
    [alert show];
}

- (void)hideAlert:(id<SSAlertViewControlProtocol>)alert{
    if ([alert respondsToSelector:@selector(close)]) {
        [alert close];
    }
}

- (void)hideCurrentAlert{
    [self hideAlert:_currentAlertView];
    self.currentAlertView = nil;
}
    
- (void)addAlert:(id<SSAlertViewControlProtocol>)alert{
    [self addAlert:alert order:SSAlertGlobalTaskOrderDefault];
}

- (void)addAlert:(id<SSAlertViewControlProtocol>)alert order:(SSAlertGlobalTaskOrder)order{
    [self addAlertTask:^id _Nullable{
        [alert show];
        return alert;
    } order:order];
}

- (void)addAlertTask:(Operation)operation order:(SSAlertGlobalTaskOrder)order {
    if (!operation) return;
    SSAlertGlobalTask *task = [[SSAlertGlobalTask alloc]init];
    task.operation = operation;
    task.order = order;
    [self addAlertTaskToQueueByOrder:task];
    [self showAlertIfNeeded];
}

- (void)addAlertTaskToQueueByOrder:(SSAlertGlobalTask *)task{
    if (_taskQueue.count == 0){
        [_taskQueue addObject:task];
    }
    else {
        BOOL inserted = false;
        for (NSInteger i=_taskQueue.count-1; i>=0; i--) {
            if (task.order<=_taskQueue[i].order) {
                [_taskQueue addObject:task];
                inserted = true;
                break;
            }
        }
        if (!inserted) {
            [_taskQueue insertObject:task atIndex:0];
        }
    }
}

- (void)showAlertIfNeeded{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_currentAlertView == nil) {
            SSAlertGlobalTask *needDispatch = self.taskQueue.firstObject;
            if (needDispatch && needDispatch.operation) {
                self.currentAlertView = needDispatch.operation();
                [self.taskQueue removeObject:needDispatch];
                [self.currentAlertView so_addDeallocBlock:^{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        // delay call the function, insure the _currentAlertView is nil
                        [self showAlertIfNeeded];
                    });
                }];
            }
        }
    });
}

@end
