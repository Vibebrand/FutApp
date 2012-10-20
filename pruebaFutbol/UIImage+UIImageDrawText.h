//
//  UIImage+UIImageDrawText.h
//  FutApp
//
//  Created by Ivo on 10/8/12.
//  Copyright (c) 2012 Ivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageDrawText)

+ (UIImage *)drawText:(NSString*)text inImage:(UIImage*)image atPoint:(CGPoint)point;
+ (UIImage *)drawText:(NSString *)text inImage:(UIImage *)image atPoint:(CGPoint)point withFont:(UIFont *)font andColor:(UIColor *)color;

+ (UIImage*)captureView:(UIView *)view;

@end
