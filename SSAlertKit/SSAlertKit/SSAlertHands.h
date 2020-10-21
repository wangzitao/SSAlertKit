//
//  SSAlertHands.h
//  Soul_New
//
//  Created by Zitao Wang on 2020/9/24.
//  Copyright © 2020 Soul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSAlertGlobalTask.h"
#import "SSAlertElement.h"
#import "SSAlertViewControlProtocol.h"
#import "SOUIKit.h"
#import "SSAlertMacros.h"

@class SSAlertTitleLabel;
@class SSAlertDetailLabel;
@class SSAlertButton;
@class SSAlertImageView;
@class SSAlertSpecialCareLabel;

NS_ASSUME_NONNULL_BEGIN

#define SSAlertHandsInstance [SSAlertHands sharedHands]

#define SSAlertTitle(x) [SSAlertHandsInstance createElementWithClass:NSClassFromString(@"SSAlertTitleLabel") content:x]
#define SSAlertDetail(x) [SSAlertHandsInstance createElementWithClass:NSClassFromString(@"SSAlertDetailLabel") content:x]
#define SSAlertImage(x) [SSAlertHandsInstance createElementWithClass:NSClassFromString(@"SSAlertImageView") content:x]
#define SSAlertButton(x) [SSAlertHandsInstance createElementWithClass:NSClassFromString(@"SSAlertButton") content:x]
#define SSAlertSpecialCareLabel(x) [SSAlertHandsInstance createElementWithClass:NSClassFromString(@"SSAlertSpecialCareLabel") content:x]

#define SOElementBottomEdgeSpace 24
#define SOElementEdgeSpace 24
#define SOElementSpace 14
#define SOContainerEdgeSpace 40
#define SOContainerWidth (KScreenWidth-SOContainerEdgeSpace*2)

// not particularly precise calculations
#define SOElementImageMaxHeight (((int)KScreenHeight)>>1)

@interface SSAlertHands : NSObject

SingletonH(Hands);

- (SSAlertElement<SSAlertViewControlProtocol>*)createAlertWithData:(NSArray *)alertData;

- (UIView<SSAlertViewControlProtocol>*)createAlertWithData:(NSArray <NSArray<UIView<SSAlertElement>*>*>*)alertData
                                                insetArray:(NSArray <NSNumber *>*)insetArray;

- (SSAlertElement<SSAlertElement>*)createElementWithClass:(Class)ElementClass content:(id)content;

- (void)addAlertTask:(Operation)operation order:(SSAlertGlobalTaskOrder)order;

// the method is equal to addAlert:alert order:SSAlertGlobalTaskOrderDefault
- (void)addAlert:(id<SSAlertViewControlProtocol>)alert;

// if alert is confirm to SSAlertViewControlProtocol, use the convenient method instead of addAlertTask:order
- (void)addAlert:(id<SSAlertViewControlProtocol>)alert order:(SSAlertGlobalTaskOrder)order;

- (void)hideCurrentAlert;

@end

NS_ASSUME_NONNULL_END
