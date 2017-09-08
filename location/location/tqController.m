//
//  tqController.m
//  location
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "tqController.h"
#import <AFNetworking.h>

@interface tqController (){
    UILabel *_lab;
}

@end

@implementation tqController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 64, screenW, screenH - 70)];
    lab.textColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    lab.textColor = [UIColor blackColor];
    [self.view addSubview:lab];
    _lab = lab;
//    [self load];
  
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(100, 64, 100, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor blackColor];
    backBtn.layer.cornerRadius = 15.0f;
    backBtn.layer.masksToBounds = YES;
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}
- (void)backAct{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self load];
}

- (void)load{
    NSString *appcode = @"e7b5a3f561e340a78519b3278494ef86";
    NSString *host = @"http://jisutqybmf.market.alicloudapi.com";
    NSString *path = @"/weather/query";
    NSString *method = @"GET";
    NSString *cityName;
    if (self.filledCityName.length > 0) {
        cityName = self.filledCityName;
    }else{
       cityName = self.cityName;
    }
    
    NSString *encodedValue = [cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *querys = [NSString stringWithFormat:@"?city=%@",encodedValue];;
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
//                                                       id bodyString = [[NSDictionary alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:nil];
                                                       
                                                       //打印应答中的body
//                                                       lab.text = bodyString;
//                                                       NSDictionary *dic = bodyString;
                                                       NSDictionary *ap =jsonDict[@"result"];
                                                       NSDictionary *ass = ap[@"aqi"];
                                                       NSString *city = ap[@"city"];
                                                       NSArray *dailyArr = ap[@"daily"];
                                                       // 当天天气
                                                       NSDictionary *tq = dailyArr[0];
                                                       NSDictionary *dayDic = tq[@"day"];
                                                       NSDictionary *nightDic = tq[@"night"];
                                                       NSString *wdStr = [NSString stringWithFormat:@"%@-%@",nightDic[@"templow"],dayDic[@"temphigh"]];
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           _lab.text = [NSString stringWithFormat:@"city:%@\ndate:%@\nweather:%@\n温度:%@\nAQI:%@\nco:%@\nco24:%@\nico:%@\nipm10:%@\nipm2_5:%@\niso2:%@\n",city,tq[@"date"],dayDic[@"weather"],wdStr,ass[@"aqi"],ass[@"co"],ass[@"co24"],ass[@"ico"],ass[@"ipm10"],ass[@"ipm2_5"],ass[@"iso2"]];
                                                       });
                                                       
                                                       NSLog(@"jsonDict: %@" ,jsonDict );
                                                       
                                                       
                                                   }];
    
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
