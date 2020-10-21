//
//  SSAlertContainerView.m
//  Soul_New
//
//  Created by Zitao Wang on 2020/9/24.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "SSAlertContainerView.h"
#import "SOUIKit.h"
#import <Masonry/Masonry.h>
#import "SSAlertMacros.h"

@interface SSAlertContainerView ()

@property (nonatomic,assign) SSAlertViewCloseStyle closeStyle;
@property (nonatomic,assign) BOOL closeByBackground;
@property (nonatomic,strong) UIButton *closeButton;

@end

@implementation SSAlertContainerView

- (void)dealloc{

}

- (instancetype)init{
    if (self = [super init]) {
        _closeStyle = SSAlertViewNoneCloseStyle;
    }
    return self;
}

- (void)show{
    [self showBackground:nil];
    [self showSelf];
}

- (void)showBackground:(void (^ __nullable)(void))showCompletion{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    backgroundView.alpha = 0;
    [backgroundView addSubview:self];
    
    if (_closeByBackground) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        [backgroundView addGestureRecognizer:tap];
    }
    
    switch (_closeStyle) {
        case SSAlertViewBottomCloseStyle:{
            [self.closeButton setImage:[UIImage imageNamed:@"icon_popview_close"] forState:UIControlStateNormal];
            [backgroundView addSubview:self.closeButton];
            [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_bottom).with.offset(24);
                make.centerX.equalTo(backgroundView);
                make.height.width.equalTo(@33);
            }];
        }
            break;
        case SSAlertViewRightTopCloseStyle:{
            [self.closeButton setImage:[UIImage imageNamed:@"specialCare_close"] forState:UIControlStateNormal];
            [backgroundView addSubview:self.closeButton];
            [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(3);
                make.right.equalTo(self.mas_right).with.offset(-3);
                make.height.width.equalTo(@33);
            }];
        }
            break;
        case SSAlertViewOtherCloseStyle:{
            SSAlertKitDoNothing;
        }
            break;
        default:
            break;
    }
    
    [[SSAlertContainerView mainWindow]addSubview:backgroundView];
    [UIView animateWithDuration:.2 animations:^{
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        if(showCompletion) showCompletion();
    }];
}

- (void)showSelf{
    [UIView animateWithDuration:.2 animations:^{
        self.alpha = 1;
    }];
}

- (void)hideBackground:(UIView *)backgroundView{
    [UIView animateWithDuration:.2 animations:^{
        backgroundView.alpha = 0;
    }completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

- (void)hideSelf:(void (^ __nullable)(void))hideCompletion{
    [UIView animateWithDuration:.2 animations:^{
        self.closeButton.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(hideCompletion) hideCompletion();
    }];
}

- (void)close{
    UIView *backgroundView = self.superview;
    [self hideBackground:backgroundView];
    [self hideSelf:nil];
}

- (void)setCloseStyle:(SSAlertViewCloseStyle)closeStyle{
    _closeStyle = closeStyle;
}

- (void)setCloseByBackground:(BOOL)closeByBackground
{
    _closeByBackground = closeByBackground;
}

+ (UIWindow*)mainWindow{
    UIWindow *window;
    if (@available(iOS 13.0, *)){
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes){
            if (windowScene.activationState == UISceneActivationStateForegroundActive){
                window = windowScene.windows.lastObject;
            }
        }
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

#pragma mark - closeButton

- (UIButton *)closeButton{
    if (nil == _closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"icon_popview_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
