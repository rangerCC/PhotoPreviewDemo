//
//  PhotoPreviewer.m
//  PhotoPreviewDemo
//
//  Created by 恒阳 on 15/10/28.
//  Copyright © 2015年 ranger. All rights reserved.
//

#import "PhotoPreviewer.h"

@interface PhotoPreviewer()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGRect originRect;
@end

@implementation PhotoPreviewer

#pragma mark - lifecyle
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIView *maskView = [[UIView alloc] initWithFrame:self.bounds];
        maskView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        maskView.backgroundColor = [UIColor blackColor];
        [self addSubview:maskView];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        _maskView = maskView;
        _imageView = imageView;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
    }
    
    return self;
}

#pragma mark - event handlers
- (void)viewTapped:(UIGestureRecognizer *)gesture
{
    [self dismiss];
}

#pragma mark - show & dismiss
- (void)showImage:(UIImage *)image
{
    [self showImage:image fromRect:CGRectZero];
}

- (void)showImage:(UIImage *)image fromView:(UIView *)view
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    CGRect originRect = [view convertRect:view.bounds toView:window];
    [self showImage:image fromRect:originRect];
}

- (void)showImage:(UIImage *)image fromRect:(CGRect)originRect
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window addSubview:self];
    
    if (CGRectEqualToRect(originRect, CGRectZero)) {
        originRect = CGRectMake(window.frame.size.width/2 - 20, window.frame.size.height/2 - 20, 40, 40);
    }
    self.originRect = originRect;
    
    self.frame = window.bounds;
    self.alpha = 1;
    self.maskView.alpha = 0;
    self.imageView.frame = self.bounds;
    self.imageView.image = image;
    
    self.imageView.transform = CGAffineTransformMakeScale(originRect.size.width / self.imageView.frame.size.width,
                                                          originRect.size.height / self.imageView.frame.size.height);
    self.imageView.center = CGPointMake(CGRectGetMidX(originRect), CGRectGetMidY(originRect));
    
    __weak PhotoPreviewer* weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.imageView.transform = CGAffineTransformIdentity;
        weakSelf.imageView.center = self.center;
    } completion:NULL];
    [UIView animateWithDuration:0.2 delay:0.1 options:0 animations:^{
        weakSelf.maskView.alpha = 1;
    } completion:NULL];
}

- (void)dismiss
{
    __weak PhotoPreviewer* weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.imageView.transform = CGAffineTransformMakeScale(weakSelf.originRect.size.width / weakSelf.imageView.frame.size.width,
                                                                  weakSelf.originRect.size.height / weakSelf.imageView.frame.size.height);
        weakSelf.imageView.center = CGPointMake(CGRectGetMidX(weakSelf.originRect), CGRectGetMidY(weakSelf.originRect));
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
