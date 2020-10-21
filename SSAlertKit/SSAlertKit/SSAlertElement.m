//
//  SSAlertElement.m
//  SoulUIKit
//
//  Created by Zitao Wang on 2020/9/29.
//

#import "SSAlertElement.h"

#define SSAlertImplBySubClass do{}while(0)

@interface SSAlertElement (){
    CGFloat _expectedHeight;
}

@property (nonatomic,assign,readwrite) CGFloat maxWidth;

@end

@implementation SSAlertElement

@synthesize expectedHeight = _expectedHeight;

- (void)setContent:(id)content{
    SSAlertImplBySubClass;
}

- (void)addTarget:(id)target selector:(SEL)selector{
    SSAlertImplBySubClass;
}

- (void)setElementFont:(UIFont *)font{
    SSAlertImplBySubClass;
}

- (void)setElementTextColor:(UIColor *)color{
    SSAlertImplBySubClass;
}

- (void)elementDidLayout{
    SSAlertImplBySubClass;
}

- (void)elementHeightWithWidth:(CGFloat)maxWidth{
    self.maxWidth = maxWidth;
}

- (void)setElementBackgroundColor:(UIColor *)color{
    SSAlertImplBySubClass;
}

- (CALayer *)elementLayer{
    return self.layer;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
