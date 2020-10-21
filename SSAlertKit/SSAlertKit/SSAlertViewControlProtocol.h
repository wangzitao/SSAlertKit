//
//  SSAlertViewBaseProtocol.h
//  Soul_New
//
//  Created by Zitao Wang on 2020/9/25.
//  Copyright © 2020 Soul. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SSAlertViewBottomCloseStyle,
    SSAlertViewRightTopCloseStyle,
    SSAlertViewOtherCloseStyle,
    SSAlertViewNoneCloseStyle,
} SSAlertViewCloseStyle;

typedef enum : NSUInteger {
    SSAlertViewContainerStyleTransparent,
    SSAlertViewContainerStyleNormal,
} SSAlertViewContainerStyle;


@protocol SSAlertViewControlProtocol <NSObject>

- (void)setCloseStyle:(SSAlertViewCloseStyle)closeStyle;

- (void)setCloseByBackground:(BOOL)closeByBackgroud;

- (void)show;

- (void)close;

@end

NS_ASSUME_NONNULL_END
