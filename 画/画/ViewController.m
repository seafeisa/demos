//
//  ViewController.m
//  画
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "ViewController.h"
#import "drawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    drawView *drav = [[drawView alloc] initWithFrame:self.view.bounds];
    drav.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
