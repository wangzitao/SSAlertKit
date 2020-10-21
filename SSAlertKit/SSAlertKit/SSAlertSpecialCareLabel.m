//
//  SSAlertSpecialCareLabel.m
//  SoulUIKit
//
//  Created by Zitao Wang on 2020/9/29.
//

#import "SSAlertSpecialCareLabel.h"
#import "SSAlertLabel.h"
#import <SoulUtils/NSString+SOSize.h>
#import "UIView+Extension.h"
#import "UIView+SOAddition.h"
#import "SSAlertMacros.h"
#import <Masonry/Masonry.h>
#import "SOUIKit.h"
#import <NSArray+SafeAccess.h>
#import <SoulUtil.h>

#define SSAlertDiscountLabelHeight 16
#define SSAlertDiscountLabelWidth 54


@interface SSAlertSpecialCareLabel ()

@property (nonatomic,strong) UILabel *mainLabel;
@property (nonatomic,strong) UILabel *originPriceLabel;
@property (nonatomic,strong) UILabel *discountPriceLabel;
@property (nonatomic,strong) UILabel *discountLabel;

@end

@implementation SSAlertSpecialCareLabel

- (instancetype)init {
    if (self = [super init]) {
        UIView *view = [UIView new];
        [self addSubview:view];
        
        view.layer.cornerRadius = 8;
        view.layer.masksToBounds = YES;
        view.layer.borderColor = GET_COLOR(1).CGColor;
        view.layer.borderWidth = 1;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    
        _mainLabel = [UILabel new];
        _mainLabel.textColor = GET_COLOR(1);
        _mainLabel.font = SOPingfangBoldFont(14);
        _mainLabel.text = @"特别关心";
        [self addSubview:_mainLabel];
            
        [_mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(16);
            make.centerY.equalTo(self);
            make.width.equalTo(@56);
            make.height.equalTo(@20);
        }];
        
        _discountPriceLabel = [UILabel new];
        _discountPriceLabel.font = SOPingfangFont(12);
        _discountPriceLabel.textColor = GET_COLOR(1);
        _discountPriceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_discountPriceLabel];
        
        [_discountPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-16);
            make.centerY.equalTo(self);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        _originPriceLabel = [UILabel new];
        _originPriceLabel.font = SOPingfangLightFont(10);
        _originPriceLabel.textColor = GET_COLOR(6);
        _originPriceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_originPriceLabel];
        
        [_originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-16);
            make.width.lessThanOrEqualTo(@70);
            make.height.equalTo(@20);
            make.top.equalTo(_discountPriceLabel.mas_bottom).with.offset(-2);
        }];

        _discountLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _discountLabel.font = SOPingfangFont(10);
        _discountLabel.textColor = UIColor.whiteColor;
        _discountLabel.layer.borderColor = HEXCOLOR(0xFE6063,1).CGColor;
        _discountLabel.layer.borderWidth = 1;
        _discountLabel.backgroundColor = HEXCOLOR(0xFE6063,1);
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_discountLabel];
    }
    return self;
}

- (void)elementHeightWithWidth:(CGFloat)maxWidth{
    [super elementHeightWithWidth:maxWidth];
    self.height = SSAlertSpecialCareLabelHeight;
}

- (void)setContent:(NSArray*)content{
    if (![content isKindOfClass:NSArray.class]) {
        return;
    }
    NSString *originPrice = [content stringWithIndex:0];
    NSString *price = [content stringWithIndex:1];
    NSString *saleUnit = [content stringWithIndex:2];
    NSNumber *discount = [content numberWithIndex:3];
    
    if (!originPrice || !price || !saleUnit) {
        return;
    }
            
    if (!SOEqual(discount.floatValue, 0)  && !SOEqual(discount.floatValue, 1)) {
        _discountLabel.text = [NSString stringWithFormat:@"限时%.1f折",discount.floatValue * 10];
        _discountLabel.hidden = NO;
    }
    else {
        _discountLabel.hidden = YES;
    }
    
    if (SOEqual(originPrice.floatValue, price.floatValue)
        || SOEqual(originPrice.floatValue, 0)
        || originPrice.floatValue < 0) {
        _originPriceLabel.hidden = YES;
    }
    else {
        _originPriceLabel.hidden = NO;
        NSMutableAttributedString *originAttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ soul币/%@",originPrice,saleUnit]];
        NSRange contentRange = {0,[originAttr length]};
        [originAttr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        _originPriceLabel.attributedText = originAttr;
    }
    _discountPriceLabel.text = [NSString stringWithFormat:@"%@ soul币/%@",price,saleUnit];

}

- (void)elementDidLayout{
    _discountLabel.frame = CGRectMake(self.width - SSAlertDiscountLabelWidth, 0, SSAlertDiscountLabelWidth, SSAlertDiscountLabelHeight);
    [_discountLabel roundCorner:UIRectCornerTopRight|UIRectCornerBottomLeft radius:8];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
