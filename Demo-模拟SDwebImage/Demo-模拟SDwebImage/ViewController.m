//
//  ViewController.m
//  Demo-模拟SDwebImage
//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 Derrick_Qin. All rights reserved.
//

#import "ViewController.h"
#import "DownloadIMGOperation.h"
#import "DownloadIMGManager.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) int tempInt;
@property (nonatomic, copy) NSString *currentStrURL;
@end

@implementation ViewController

//懒加载数据
-(NSArray *)dataArray{
    //判断数组是否为空
    if (!_dataArray) {
        
        _dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"PicData2" ofType:@"plist"]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self downloadIMG];
    
}

-(void)downloadIMG{
    
    int randomNum = arc4random_uniform(4);
    
    while (randomNum == self.tempInt) {
        randomNum = arc4random_uniform(4);
    }
    
    self.tempInt = randomNum;
    
    NSString *strURL = self.dataArray[randomNum];
    /*==============================================================================*/
    
    [self.imageView getWebImageWithStringURL:strURL];
    
    
}

@end
