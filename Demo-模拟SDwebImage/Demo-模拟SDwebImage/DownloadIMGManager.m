//
//  DownloadIMGManager.m
//  Demo-模拟SDwebImage
//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "DownloadIMGManager.h"
#import "DownloadIMGOperation.h"
#import "NSString+Path.h"

@interface DownloadIMGManager ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableDictionary *imageCache;
@property (nonatomic, strong) NSMutableDictionary *operationCache;

@end

@implementation DownloadIMGManager

+(instancetype)sharedManager{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DownloadIMGManager alloc]init];
    });
    
    return instance;
}

-(NSOperationQueue *)queue{
    
    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}

-(NSMutableDictionary *)operationCache{
    if (!_operationCache) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}

-(NSMutableDictionary *)imageCache{
    if (!_imageCache) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

-(void)downloadImageWithStrURL:(NSString *)strURL andFinishBlock:(void(^)(UIImage *))finishBlock{
    
    if (self.imageCache[strURL]) {
        
        finishBlock(self.imageCache[strURL]);
        NSLog(@"从缓存读取图片");
        return;
    }
    else{
        
        UIImage *sandBoxImage = [UIImage imageWithContentsOfFile:[strURL appendCachePath]];
        
        if (sandBoxImage) {
            NSLog(@"从沙盒读取图片");
            finishBlock(sandBoxImage);
            
            [self.imageCache setObject:sandBoxImage forKey:strURL];
            NSLog(@"从沙盒图片放入图片缓存");
            return;
        }
    }
    
    DownloadIMGOperation *op = [DownloadIMGOperation operationWithStringURL:strURL andFinishBlock:^(UIImage *image) {
        
        finishBlock(image);
        
        [self.imageCache setObject:image forKey:strURL];
        NSLog(@"图片加入缓存");
        [self.operationCache removeObjectForKey:strURL];
        NSLog(@"操作移出缓存");
    }];
    
    
    [self.queue addOperation:op];
    [self.operationCache setObject:op forKey:strURL];
    
    
}

-(void)cancelDownloadWithStrURL:(NSString *)strURL{
    
    NSLog(@"进入CANCEL方法");
    
    DownloadIMGOperation *lastOp = self.operationCache[strURL];
    
    [lastOp cancel];
    
}



@end
