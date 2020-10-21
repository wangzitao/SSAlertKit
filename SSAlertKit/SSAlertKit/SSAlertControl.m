//
//  SSAlertControl.m
//  Soul_New
//
//  Created by Zitao Wang on 2020/9/24.
//  Copyright © 2020 Soul. All rights reserved.
//

#import "SSAlertMacros.h"
#import "SSAlertControl.h"
#import <SoulBaseUI/SOColorDefine.h>
#import "UIView+Extension.h"
#import <YYCategories/YYCategoriesMacro.h>
#import <SOWebImage/SOWebImage.h>
#import <Masonry/Masonry.h>

#pragma mark - impl SSAlertButton

@interface SSAlertButton ()

@property (nonatomic,strong) UIButton *button;

@end

@implementation SSAlertButton

- (instancetype)init{
    if (self = [super init]) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.font = SOPingfangBoldFont(16);
        _button.layer.cornerRadius = 20;
        _button.layer.masksToBounds = YES;
        _button.backgroundColor = GET_COLOR(1);
        [_button  setTitleColor:GET_COLOR(0) forState:UIControlStateNormal];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setContent:(id)content{
    if ([content isKindOfClass:NSAttributedString.class]) {
        [_button setAttributedTitle:content forState:UIControlStateNormal];
    }
    else if ([content isKindOfClass:NSString.class]){
        [_button setTitle:content forState:UIControlStateNormal];
    }
    else if ([content isKindOfClass:UIImage.class]){
        [_button setImage:content forState:UIControlStateNormal];
    }
    else {
        SSAlertKitDoNothing;
    }
}

- (void)elementHeightWithWidth:(CGFloat)maxWidth{
    [super elementHeightWithWidth:maxWidth];
    self.height = SSAlertButtonHeight;
}

- (void)elementDidLayout{
    
}

- (void)setElementBackgroundColor:(UIColor *)color{
    _button.backgroundColor = color;
}

- (void)setElementFont:(UIFont *)font{
    _button.titleLabel.font = font;
}

- (void)setElementTextColor:(UIColor *)color{
    [_button  setTitleColor:color forState:UIControlStateNormal];
//    _button.titleLabel.textColor = color;
}

- (CALayer *)elementLayer{
    return self.button.layer;
}

- (void)addTarget:(id)target selector:(SEL)selector{
    [_button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end

#pragma mark - impl SSAlertImageView

@interface SSAlertImageView ()

@property (nonatomic,strong) SOWebImageView *imageView;

@end

@implementation SSAlertImageView

- (instancetype)init{
    if (self = [super init]) {
        _imageView = [SOWebImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setContent:(id)content{
    if ([content isKindOfClass:NSString.class]) {
        if ([content hasPrefix:@"http"]) {
            SOWeakIfy(self);
            [self.imageView setImageWithURL:[NSURL URLWithString:content]
                           placeholderImage:nil
                                 completion:^(UIImage * _Nullable image, NSURL *url, NSError * _Nullable error) {
                if (!error && image && image.size.height > 0 && image.size.width > 0) {
                    SOStrongIfy(self);
                    self.imageView.image = image;
//                    [self.imageView sizeToFit];
//                    CGFloat factor = self.imageView.height/self.imageView.width;
//                    self.width = self.maxWidth;
//                    self.height = self.width * factor;
                }
            }];
        }
        else {
            self.imageView.image = SOUL_IMAGE_COMMON(content);
        }
    }
    else if ([content isKindOfClass:UIImage.class]) {
        self.imageView.image = content;
        [self.imageView sizeToFit];
    }
    else if ([content isKindOfClass:NSURL.class]){
        SOWeakIfy(self);
        [self.imageView setImageWithURL:content
                       placeholderImage:nil
                             completion:^(UIImage * _Nullable image, NSURL *url, NSError * _Nullable error) {
            if (!error && image && image.size.height > 0 && image.size.width > 0) {
                SOStrongIfy(self);
                self.imageView.image = image;
//                [self.imageView sizeToFit];
//                CGFloat factor = self.height/self.width;
//                self.width = self.maxWidth;
//                self.height = self.width * factor;
            }
        }];
    }
}

- (void)elementHeightWithWidth:(CGFloat)maxWidth{
    [super elementHeightWithWidth:maxWidth];
    if (self.imageView.image) {
        [self.imageView sizeToFit];
        if (self.imageView.width > maxWidth) {
            // resize imageview if image is too wide
            CGFloat factor = self.imageView.height/self.imageView.width;
            self.imageView.width = self.maxWidth;
            self.imageView.height = self.imageView.width * factor;
            self.height = self.imageView.height;
        }
        else {
            self.height = self.imageView.height;
        }
    }
}

- (CALayer *)elementLayer{
    return self.imageView.layer;
}

- (void)elementDidLayout{
    self.imageView.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)addTarget:(id)target selector:(SEL)selector{
    [self.imageView addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
