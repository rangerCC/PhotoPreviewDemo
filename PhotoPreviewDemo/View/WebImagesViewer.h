//
//  WebImagesViewer.h
//  PhotoPreviewDemo
//
//  Created by 恒阳 on 15/10/28.
//  Copyright © 2015年 ranger. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  页面索引类型
 */
typedef NS_ENUM(NSInteger, WebImagesPageIndicatorType){
    /**
     *  顶部标题样式，如 17/18
     */
    WebImagesPageIndicatorTitleLabel = 0,
    /**
     *  Page control样式
     */
    WebImagesPageIndicatorPageControl
};

@class WebImagesViewer;
@protocol WebImagesViewerDelegate <NSObject>
@required
- (NSUInteger)numberOfImagesInWebImagesViewer:(WebImagesViewer *)viewer;
// 返回的view不能为nil
- (UIView *)webImagesViewer:(WebImagesViewer *)viewer viewAtIndex:(NSInteger)index;
@end

@interface WebImagesViewer : UIView

// 设置页面索引类型，默认为TRIPWebImagesPageIndicatorTitleLabel
- (void)setPageIndicatorType:(WebImagesPageIndicatorType)pageIndicatorType;

/*!
 *  显示图片
 *
 *  @param index 当前显示的图片索引
 *  @param view  从view开始做动画显示
 *  @param image 使用image进行动画
 */
- (void)showImageAtIndex:(NSInteger)index fromView:(UIView *)view animatorImage:(UIImage *)image;
- (void)showImageAtIndex:(NSInteger)index;
- (void)dismiss;

- (UIView *)dequeueReusableViewAtIndex:(NSInteger)index;

@property (nonatomic, weak) id<WebImagesViewerDelegate> delegate;

@end
