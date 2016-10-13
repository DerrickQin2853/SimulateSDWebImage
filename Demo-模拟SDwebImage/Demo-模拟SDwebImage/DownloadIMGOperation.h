//
//  DownloadIMGOperation.h
//  Demo-模拟SDwebImage
//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadIMGOperation : NSOperation

@property (nonatomic, copy) NSString *strURL;

@property (nonatomic, copy) void(^finishBlock)(UIImage *);

+(instancetype)operationWithStringURL:(NSString *)strURL andFinishBlock:(void(^)(UIImage *))finishBlock;

@end
