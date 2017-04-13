//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@implementation SKTagButton

- (void)setTagInfo:(SKTag *)tagInfo {
    _tagInfo = tagInfo;
    
    if (tagInfo.attributedText) {
        [self setAttributedTitle:tagInfo.attributedText forState: UIControlStateNormal];
    } else {
        [self setTitle: tagInfo.text forState:UIControlStateNormal];
        [self setTitleColor:tagInfo.textColor forState: UIControlStateNormal];
        self.titleLabel.font = tagInfo.font ?: [UIFont systemFontOfSize:tagInfo.fontSize];
    }
    
    self.backgroundColor = tagInfo.bgColor;
    self.contentEdgeInsets = tagInfo.padding;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if (tagInfo.bgImg) {
        [self setBackgroundImage:tagInfo.bgImg forState: UIControlStateNormal];
    }
    
    if (tagInfo.borderColor) {
        self.layer.borderColor = tagInfo.borderColor.CGColor;
    }
    
    if (tagInfo.borderWidth) {
        self.layer.borderWidth = tagInfo.borderWidth;
    }
    
    self.userInteractionEnabled = tagInfo.enable;
    if (tagInfo.enable) {
        UIColor *highlightedBgColor = tagInfo.highlightedBgColor ?: [self darkerColor:self.backgroundColor];
        [self setBackgroundImage:[self imageWithColor:highlightedBgColor] forState:UIControlStateHighlighted];
    }
    
    self.layer.cornerRadius = tagInfo.cornerRadius;
    self.layer.masksToBounds = YES;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIColor *)darkerColor:(UIColor *)color {
    CGFloat h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.85
                               alpha:a];
    return color;
}

@end
