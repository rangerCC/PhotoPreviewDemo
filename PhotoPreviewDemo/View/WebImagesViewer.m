//
//  WebImagesViewer.m
//  PhotoPreviewDemo
//
//  Created by 恒阳 on 15/10/28.
//  Copyright © 2015年 ranger. All rights reserved.
//

#import "WebImagesViewer.h"

@interface WebImagesViewer()<UIScrollViewDelegate>
@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, assign) NSInteger originIndex;
@property (nonatomic, assign) NSInteger imageCount;

@property (nonatomic, strong) UIImageView *animatorView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *pageLabel;

@property (nonatomic, strong) NSMutableArray *recycleViews;
@property (nonatomic, strong) NSMutableArray *currentViews;
@end

@implementation WebImagesViewer

- (void)dealloc {
    _scrollView.delegate = nil;
    _scrollView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 30)];
        pageControl.hidesForSinglePage = YES;
        pageControl.alpha = 0;
        [self addSubview:pageControl];
        
        UILabel *pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, self.frame.size.width, 20)];
        pageLabel.textColor = [UIColor whiteColor];
        pageLabel.textAlignment = NSTextAlignmentCenter;
        pageLabel.backgroundColor = [UIColor clearColor];
        pageLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:pageLabel];
        
        _scrollView   = scrollView;
        _pageControl  = pageControl;
        _pageLabel    = pageLabel;
        _recycleViews = [NSMutableArray array];
        _currentViews = [NSMutableArray array];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    }
    
    return self;
}

#pragma mark - view builder
- (void)loadImages {
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * self.imageCount, self.bounds.size.height);
    
    self.pageControl.numberOfPages = self.imageCount;
    if (self.originIndex < self.imageCount) {
        self.pageControl.currentPage = self.originIndex;
        self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)(self.originIndex+1), (long)self.imageCount];
        self.scrollView.contentOffset = CGPointMake(self.originIndex * self.scrollView.frame.size.width, 0);
    }
    
    [self loadCurrentImages];
}

- (void)loadCurrentImages {
    NSInteger currentPage = self.pageControl.currentPage;
    NSInteger startPage = currentPage > 0 ? currentPage - 1 : currentPage;
    NSInteger endPage = currentPage < self.imageCount - 1 ? currentPage + 1 : currentPage;
    
    BOOL appendHead = NO;
    NSInteger currentStartPage = -1;
    NSInteger currentEndPage = -1;
    if (self.currentViews.count > 0) {
        currentStartPage = [[self.currentViews firstObject] tag];
        currentEndPage = [[self.currentViews lastObject] tag];
        
        // recycle usless views
        if (currentStartPage < startPage) {
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, startPage - currentStartPage)];
            NSArray *recycleArray = [self.currentViews objectsAtIndexes:indexes];
            [self.currentViews removeObjectsAtIndexes:indexes];
            [self.recycleViews addObjectsFromArray:recycleArray];
            currentStartPage = startPage;
        } else if (currentEndPage > endPage) {
            appendHead = YES;
            
            NSInteger removeCount = currentEndPage - endPage;
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.currentViews.count - removeCount, removeCount)];
            NSArray *recycleArray = [self.currentViews objectsAtIndexes:indexes];
            [self.currentViews removeObjectsAtIndexes:indexes];
            [self.recycleViews addObjectsFromArray:recycleArray];
            currentEndPage = endPage;
        }
    }
    
    // add new current views
    if (currentStartPage >= 0) {
        for (NSInteger i = startPage; i < currentStartPage; ++i) {
            UIView *view = [self addViewAtIndex:i];
            [self.currentViews insertObject:view atIndex:i - startPage];
        }
        
        for (NSInteger i = currentEndPage + 1; i <= endPage; ++i) {
            UIView *view = [self addViewAtIndex:i];
            [self.currentViews addObject:view];
        }
    } else {
        for (NSInteger i = startPage; i <= endPage; i++) {
            UIView *view = [self addViewAtIndex:i];
            [self.currentViews addObject:view];
        }
    }
}

- (UIView *)addViewAtIndex:(NSInteger)i {
    CGSize mainSize = self.bounds.size;
    
    UIView *view = [self.delegate webImagesViewer:self viewAtIndex:i];
    NSAssert(view != nil, @"- webImagesViewer:viewAtIndex: 不能返回nil");
    view.frame = CGRectMake(i * mainSize.width, 0, mainSize.width, mainSize.height);
    view.tag = i;
    [self.scrollView addSubview:view];
    return view;
}

#pragma mark - content setters
- (void)setPageIndicatorType:(WebImagesPageIndicatorType)pageIndicatorType {
    self.pageLabel.hidden = YES;
    self.pageControl.alpha = 0;
    
    switch (pageIndicatorType) {
        case WebImagesPageIndicatorTitleLabel:
            self.pageLabel.hidden = NO;
            break;
        case WebImagesPageIndicatorPageControl:
            self.pageControl.alpha = 1;
        default:
            break;
    }
}

- (void)setDelegate:(id<WebImagesViewerDelegate>)delegate
{
    _delegate = delegate;
    self.imageCount = [delegate numberOfImagesInWebImagesViewer:self];
}

#pragma mark - show & hide
- (void)showImageAtIndex:(NSInteger)index {
    [self showImageAtIndex:index fromView:nil animatorImage:nil];
}

- (void)showImageAtIndex:(NSInteger)index fromView:(UIView *)view animatorImage:(UIImage *)image {
    self.originIndex = index;
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window addSubview:self];
    
    if (view && image) {
        CGRect originRect = [view convertRect:view.bounds toView:window];
        
        UIImageView *animatorView = [[UIImageView alloc] initWithFrame:originRect];
        animatorView.contentMode = UIViewContentModeScaleAspectFit;
        animatorView.image = image;
        [window addSubview:animatorView];
        
        self.originRect = originRect;
        self.animatorView = animatorView;
        
        self.alpha = 0;
        [UIView animateWithDuration:0.3 animations: ^{
            self.animatorView.frame = window.bounds;
            self.alpha = 1;
        } completion: ^(BOOL finished) {
            [self.animatorView removeFromSuperview];
            [self loadImages];
        }];
    }
    else {
        [self loadImages];
        
        self.alpha = 0;
        self.scrollView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.3 animations: ^{
            self.alpha = 1;
            self.scrollView.transform = CGAffineTransformIdentity;
        } completion:NULL];
    }
}

- (void)dismiss {
    BOOL dismissToOrigin = NO;
    if (self.pageControl.currentPage == self.originIndex && self.animatorView.image) {
        dismissToOrigin = YES;
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        [window addSubview:self.animatorView];
        
        [self.scrollView removeFromSuperview];
        self.scrollView = nil;
    }
    
    [UIView animateWithDuration:0.3 animations: ^{
        if (dismissToOrigin) {
            self.animatorView.frame = self.originRect;
        }
        else {
            self.scrollView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        }
        self.alpha = 0;
    } completion: ^(BOOL finished) {
        [self.animatorView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (UIView *)dequeueReusableViewAtIndex:(NSInteger)index {
    id lastObject = [self.recycleViews lastObject];
    if (lastObject) {
        [self.recycleViews removeLastObject];
    }
    return lastObject;
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (currentPage != self.pageControl.currentPage) {
        self.pageControl.currentPage = currentPage;
        self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)(self.pageControl.currentPage+1), (long)self.imageCount];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5f);
    if (currentPage != self.pageControl.currentPage) {
        self.pageControl.currentPage = currentPage;
        self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)(self.pageControl.currentPage+1), (long)self.imageCount];
        
        [self loadCurrentImages];
    }
}

@end
