//
//  SingletonObject.m
//  PhotoPreviewDemo
//
//  Created by 恒阳 on 15/10/29.
//  Copyright © 2015年 ranger. All rights reserved.
//

#import "SingletonObject.h"

@implementation SingletonObject

static SingletonObject *defaltManager = nil;

// 单例模式对外的唯一接口，用到的dispatch_once函数在一个应用程序内只会执行一次，且dispatch_once能确保线程安全
+ (SingletonObject *)defaultManager{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (nil == defaltManager) {
            defaltManager = [[SingletonObject alloc] init];
        }
    });
    return defaltManager;
}

// 确保当用户通过[[Singleton alloc] init]创建对象时对象的唯一性，alloc方法会调用该方法，只不过zone参数默认为nil，因该类覆盖了allocWithZone方法，所以只能通过其父类分配内存，即[super allocWithZone:zone]
+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (nil == defaltManager) {
            defaltManager = [super allocWithZone:zone];
        }
    });
    return defaltManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.name = @"Singleton";
    }
    return self;
}

// 确保当用户通过copy方法产生对象时对象的唯一性
- (id)copy{
    return self;
}

// 确保当用户通过mutableCopy方法产生对象时对象的唯一性
- (id)mutableCopy{
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"memeory address:%p,property name:%@",self,self.name];
}
@end
