//
//  PhotoPreviewer.h
//  PhotoPreviewDemo
//
//  Created by 恒阳 on 15/10/28.
//  Copyright © 2015年 ranger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPreviewer : UIView

- (void)showImage:(UIImage *)image;
- (void)showImage:(UIImage *)image fromView:(UIView *)view;
- (void)showImage:(UIImage *)image fromRect:(CGRect)rect;
- (void)dismiss;

@end
