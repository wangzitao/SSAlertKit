//
//  SSAlertElement.h
//  Soul_New
//
//  Created by Zitao Wang on 2020/9/24.
//  Copyright © 2020 Soul. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSAlertElement <NSObject>

// the maximum width can be displayed, generally equal to the width of the element
@property (nonatomic,assign,readonly) CGFloat maxWidth;

// if you load content asynchronously, you can set this value to help layout. ex: [UIImageView setImageWithURL] ...
@property (nonatomic,assign) CGFloat expectedHeight;

@required

//use 'id' type to support a more flexible view structure in the future
- (void)setContent:(id)content;

// calculate the height based on the width, need call super method while subclass is implementation
- (void)elementHeightWithWidth:(CGFloat)maxWidth;

- (void)setElementFont:(UIFont *)font;

- (void)setElementTextColor:(UIColor *)color;

- (void)setElementBackgroundColor:(UIColor *)color;

- (CALayer *)elementLayer;

- (void)elementDidLayout;

- (void)addTarget:(id)target selector:(SEL)selector;

@end

