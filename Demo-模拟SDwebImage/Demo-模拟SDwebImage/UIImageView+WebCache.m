//
//  UIImageView+WebCache.m
//  Demo-模拟SDwebImage
//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "DownloadIMGManager.h"
#import <objc/runtime.h>

@implementation UIImageView (WebCache)

static char *key = "keyForURL";

-(void)setCurrentStrURL:(NSString *)currentStrURL{
    
    objc_setAssociatedObject(self, key, currentStrURL, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

-(NSString *)currentStrURL{
    
    return objc_getAssociatedObject(self, key);
}



-(void)getWebImageWithStringURL:(NSString *)strURL{
    
    if (![self.currentStrURL isEqualToString:strURL]) {
        
        [[DownloadIMGManager sharedManager] cancelDownloadWithStrURL:self.currentStrURL];
        
    }
    
    
    self.currentStrURL = strURL;
    
    [[DownloadIMGManager sharedManager] downloadImageWithStrURL:strURL andFinishBlock:^(UIImage *image) {
        
        self.image = image;
        
    }];
    
}

@end
