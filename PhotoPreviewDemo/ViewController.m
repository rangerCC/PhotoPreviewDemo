//
//  ViewController.m
//  PhotoPreviewDemo
//
//  Created by 恒阳 on 15/10/28.
//  Copyright © 2015年 ranger. All rights reserved.
//

#import "ViewController.h"

#import "WebImagesViewer.h"

#import "SingletonObject.h"

#import "UIImageView+WebCache.h"


@interface ViewController ()<WebImagesViewerDelegate>{
    NSArray    *_imageUrls;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PhotoPreview";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageUrls = @[
                         @"https://img.alicdn.com/bao/uploaded/i4/TB1KPskGVXXXXXrXFXXmGZE.XXX_101648.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i8/TB1W23iGVXXXXXaXVXX3u3E.XXX_101649.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i5/TB1iYsjGVXXXXbcXpXX3u3E.XXX_101649.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i3/TB14XMhGVXXXXbgXVXXI9QD.XXX_101650.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i1/TB1NFZgGVXXXXauXVXXI9QD.XXX_101650.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i3/TB1ZcZiGVXXXXcKXFXXI9QD.XXX_101650.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i1/TB1bkIlGVXXXXXgXpXXmGZE.XXX_101651.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i7/TB1OMgjGVXXXXbFXFXXmGZE.XXX_101651.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i6/TB12xMmGVXXXXbJXXXX3u3E.XXX_101652.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i4/TB1p0gdGVXXXXXtapXX3u3E.XXX_101652.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i4/TB1NAwmGVXXXXaUXXXXpimUFXXX_084923.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i7/T1oTFMFrBfXXcQzCwT_013049.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i8/TB1t3ZiGVXXXXcYXFXXLueUFXXX_084919.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i1/TB1YwsdGVXXXXbAXVXXr85TFXXX_084920.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i1/TB13h.kGVXXXXcQXpXXr85TFXXX_084920.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i4/TB1xYAjGVXXXXbiXpXXLueUFXXX_084922.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i8/TB1uMp1KXXXXXXTXpXX2dgU7VXX_015912.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i2/TB1zvNFKXXXXXbmXVXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i6/TB1ANFMKXXXXXciXFXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i3/TB1ob02KXXXXXXYXpXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i6/TB11ohCKXXXXXa_XVXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i2/TB1bctOKXXXXXa8XFXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i1/TB1Q7xGKXXXXXaiXVXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i7/TB1DYJ0KXXXXXasXpXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i5/TB1rfJ5KXXXXXctXXXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i6/TB1L7lFKXXXXXbnXVXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i1/TB1fgVCKXXXXXclXVXXE4oU7VXX_015913.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i2/TB1SzRUKXXXXXcbXpXXiRwU7VXX_015914.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i2/TB1tDhFKXXXXXazXVXXiRwU7VXX_015914.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i3/TB1H4pUKXXXXXblXpXXiRwU7VXX_015914.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i5/TB1lq9CGVXXXXbHXVXXcAmu7FXX_011438.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i3/TB17NHwGFXXXXavXVXXG37c.VXX_112944.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i6/TB1g3qEGVXXXXbTXVXXSoqu7FXX_011439.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i8/TB1w5yRGVXXXXacXXXXSoqu7FXX_011439.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i1/TB10hWCGVXXXXXjaXXXSoqu7FXX_011439.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i3/TB1uiOBGVXXXXXTaXXXyMeu7FXX_011440.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i3/TB18DGPGVXXXXb6XXXXyMeu7FXX_011440.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i7/TB1o4GFGVXXXXa6XVXXyMeu7FXX_011440.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i5/TB1JfmNGVXXXXXVXpXXyMeu7FXX_011440.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i5/TB1s8uPGVXXXXX2XXXXcAmu7FXX_011441.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i5/TB1uCqRGVXXXXXRXXXXcAmu7FXX_011441.jpg",
                         @"https://img.alicdn.com/bao/uploaded/i4/TB1ZgN9GVXXXXclXpXXcAmu7FXX_011441.jpg",
                         ];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-80.0)/2.0, 300.0, 80.0, 30.0)];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 350, 320.0, 200)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:imageView];
    
    /**
     *  Using SDWebimage
     */
    NSURL *imgURL = [NSURL URLWithString:@"https://gw.alicdn.com/tps/TB1v1QqKXXXXXXeXXXXXXXXXXXX-168-48.png"];
    
    // Using UIImageView+WebCache category
    [imageView sd_setImageWithURL:imgURL
                 placeholderImage:[UIImage imageNamed:@"default_pic"]];
    
    // Using blocks
//    [imageView sd_setImageWithURL:imgURL
//                 placeholderImage:[UIImage imageNamed:@"default_pic"]
//                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                            
//                        }];
    
    // Using SDWebImageManager
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    [manager downloadImageWithURL:[NSURL URLWithString:@"https://img.alicdn.com/bao/uploaded/i4/TB1ZgN9GVXXXXclXpXXcAmu7FXX_011441.jpg"]
//                          options:0
//                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                             // progression tracking code
//                         }
//                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                            if (image) {
//                                // do something with image
//                                [imageView setImage:image];
//                            }
//                        }];
    
    // Using Asynchronous Image Downloader Independently
//    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
//    [downloader downloadImageWithURL:[NSURL URLWithString:@"http://www.sogou.com/images/logo/new/sogou.png"]
//                             options:0
//                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                // progression tracking code
//                            }
//                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//                               if (image && finished) {
//                                   // do something with image
//                                   [imageView setImage:image];
//                               }
//                           }];
    
    SingletonObject *defaultManager = [SingletonObject defaultManager];
    SingletonObject *managerCopy = [defaultManager copy];
    SingletonObject *managerMutableCopy = [defaultManager mutableCopy];
    SingletonObject *allocManager = [[SingletonObject alloc] init];
    SingletonObject *newManager = [SingletonObject new];
    NSLog(@"%@",defaultManager);
    NSLog(@"%@",managerCopy);
    NSLog(@"%@",managerMutableCopy);
    NSLog(@"%@",allocManager);
    NSLog(@"%@",newManager);
}

#pragma mark - Delegate
- (NSUInteger)numberOfImagesInWebImagesViewer:(WebImagesViewer *)viewer {
    return _imageUrls.count;
}

- (UIView *)webImagesViewer:(WebImagesViewer *)viewer viewAtIndex:(NSInteger)index {
    UIImageView *imageView = (UIImageView *)[viewer dequeueReusableViewAtIndex:index];
    
    if (!imageView || ![imageView isKindOfClass:[UIImageView class]]) {
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    NSString *url = _imageUrls[index];
    if (url) {
        NSURL *imgUrl = [NSURL URLWithString:url];
        [imageView sd_setImageWithURL:imgUrl
                     placeholderImage:[UIImage imageNamed:@"default_pic"]];
    }
    
    return imageView;
}

#pragma mark - Action
- (void)onBtnClicked:(id)sender{
    WebImagesViewer *viewer = [[WebImagesViewer alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [viewer setPageIndicatorType:WebImagesPageIndicatorTitleLabel];
    viewer.delegate = self;
    [viewer showImageAtIndex:0];
}
@end
