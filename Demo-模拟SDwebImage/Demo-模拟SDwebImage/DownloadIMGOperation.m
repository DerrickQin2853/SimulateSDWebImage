//
//  DownloadIMGOperation.m
//  Demo-模拟SDwebImage
//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "DownloadIMGOperation.h"
#import "NSString+Path.h"

@interface DownloadIMGOperation ()

@end

@implementation DownloadIMGOperation

+(instancetype)operationWithStringURL:(NSString *)strURL andFinishBlock:(void(^)(UIImage *))finishBlock{
    
    DownloadIMGOperation *op = [[DownloadIMGOperation alloc]init];
    
    op.strURL = strURL;
    op.finishBlock = finishBlock;
    
    return op;
}

-(void)main{
    
    NSURL *imgURL = [NSURL URLWithString:self.strURL];
    
    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
    
    [imgData writeToFile:[self.strURL appendCachePath] atomically:YES];
    
    NSLog(@"图片写入沙盒");
    
    if (self.isCancelled) {
        NSLog(@"多次点击取消图片赋值操作，拦截");
        return;
    }
    
    UIImage * image = [UIImage imageWithData:imgData];
    
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        
        if (self.finishBlock) {
            self.finishBlock(image);
        }
    }];

}

@end
