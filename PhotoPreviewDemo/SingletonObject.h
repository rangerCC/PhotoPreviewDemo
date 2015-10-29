//
//  SingletonObject.h
//  PhotoPreviewDemo
//
//  Created by 恒阳 on 15/10/29.
//  Copyright © 2015年 ranger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonObject : NSObject
@property (nonatomic,strong) NSString *name;
+ (SingletonObject *)defaultManager;
@end
