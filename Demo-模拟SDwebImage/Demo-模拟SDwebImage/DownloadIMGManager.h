//
//  DownloadIMGManager.h
//  Demo-模拟SDwebImage
//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloadIMGManager : NSObject

+(instancetype)sharedManager;

-(void)downloadImageWithStrURL:(NSString *)strURL andFinishBlock:(void(^)(UIImage *))finishBlock;

-(void)cancelDownloadWithStrURL:(NSString *)strURL;

@end
