//
//  SSAlertTitleLabel.m
//  Soul_New
//
//  Created by Zitao Wang on 2020/9/24.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "SSAlertMacros.h"
#import "SSAlertLabel.h"
#import <SoulUtils/NSString+SOSize.h>
#import <SoulBaseUI/SOColorDefine.h>
#import "UIView+Extension.h"
#import <Masonry/Masonry.h>

#pragma mark - impl SSAlertTitleLabel

@interface SSAlertTitleLabel ()

@property (nonatomic,strong) UILabel *label;


@end

@implementation SSAlertTitleLabel

- (instancetype)init{
    if (self = [super init]) {
        _label = [UILabel new];
        _label.font = SOPingfangBoldFont(18);
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = GET_COLOR(2);
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setContent:(id)content{
    if ([content isKindOfClass:NSAttributedString.class]) {
        [self.label setAttributedText:content];
    }
    else if([content isKindOfClass:NSString.class]) {
        [self.label setText:content];
    }
    else {
        SSAlertKitDoNothing;
    }
}

- (void)setElementFont:(UIFont *)font{
    self.label.font = font;
}

- (void)setElementTextColor:(UIColor *)color {
    self.label.textColor = color;
}

- (void)setElementBackgroundColor:(UIColor *)color{
    self.label.backgroundColor = color;
}

- (void)elementHeightWithWidth:(CGFloat)maxWidth{
    [super elementHeightWithWidth:maxWidth];
    CGSize size = [self.label.text sizeWithFont:self.label.font MaxWidth:maxWidth];
    self.height = size.height;
}

- (CALayer *)elementLayer{
    return self.label.layer;
}

- (void)elementDidLayout{
    
}

@end

#pragma mark - impl SSAlertDetailLabel

@interface SSAlertDetailLabel ()

@property (nonatomic,strong) UILabel *label;

@end


@implementation SSAlertDetailLabel

- (instancetype)init{
    if (self = [super init]) {
        _label = [UILabel new];
        _label.font = SOPingfangFont(14);
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = GET_COLOR(15);
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setContent:(id)content{
    if ([content isKindOfClass:NSAttributedString.class]) {
        [self.label setAttributedText:content];
    }
    else if ([content isKindOfClass:NSString.class]) {
        [self.label setText:content];
    }
    else {
        SSAlertKitDoNothing;
    }
}

- (void)elementHeightWithWidth:(CGFloat)maxWidth{
    [super elementHeightWithWidth:maxWidth];
    CGSize size = [self.label.text sizeWithFont:self.label.font MaxWidth:maxWidth];
    self.height = size.height;
}


- (void)setElementFont:(UIFont *)font{
    self.label.font = font;
}

- (void)setElementTextColor:(UIColor *)color {
    self.label.textColor = color;
}

- (void)setElementBackgroundColor:(UIColor *)color{
    self.label.backgroundColor = color;
}

- (CALayer *)elementLayer{
    return self.label.layer;
}

- (void)elementDidLayout{
    
}

@end

