//
//  UIImageView+WebCache.h
//  Demo-模拟SDwebImage
//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)
-(void)getWebImageWithStringURL:(NSString *)strURL;
@property (nonatomic, copy) NSString *currentStrURL;
@end
