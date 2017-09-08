//
//  ViewController.m
//  location
//
//  Created by admin on 2017/8/15.
//  Copyright © 2017年 CAMRY. All rights reserved.
//

#import "ViewController.h"
#import "GYZChooseCityController.h"

#import "tqController.h"

@interface ViewController ()<GYZChooseCityDelegate>{
    UIButton *chooseCityBtn;
    NSInteger angle;
}



@property (nonatomic, strong) NSString *cityString;

@property (nonatomic, strong) UILabel *lab;

@property (nonatomic, strong) UITextField *tf;

@property (nonatomic, strong) UIImageView *imv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    chooseCityBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 40, 100, 50)];
//    chooseCityBtn.center.x = self.view.center.x;
    [chooseCityBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [chooseCityBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    [chooseCityBtn addTarget:self action:@selector(onClickChooseCity:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseCityBtn];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, screenW, screenH - 150)];
    lab.textColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    lab.textColor = [UIColor blackColor];
    [self.view addSubview:lab];
    _lab = lab;
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.image = [UIImage imageNamed:@"ico"];
    imv.frame = CGRectMake(200, 200, 70, 70);
    [self.view addSubview:imv];
    _imv = imv;
    
    // create timer
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(xz) userInfo:nil repeats:YES];
    
   
    angle = 0;
    
//    [self xz];
    [self startAnimation];
}

-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    _imv.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    angle += 20;
    [self startAnimation];
}


- (void)onClickChooseCity:(id)sender {
    
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    
    //    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    //    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
    [chooseCityBtn setTitle:city.cityName forState:UIControlStateNormal];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![chooseCityBtn.titleLabel.text isEqualToString:@"选择城市"]) {
        [self load];
    }
}


- (void)load{
    NSString *appcode = @"e7b5a3f561e340a78519b3278494ef86";
    NSString *host = @"http://jisutqybmf.market.alicloudapi.com";
    NSString *path = @"/weather/query";
    NSString *method = @"GET";
    NSString *cityName;
//    if (chooseCityBtn.titleLabel.text.length > 0) {
//        cityName = self.filledCityName;
//    }else{
//        cityName = self.cityName;
//    }
    cityName = chooseCityBtn.titleLabel.text;
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


@end
