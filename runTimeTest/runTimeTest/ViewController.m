//
//  ViewController.m
//  runTimeTest
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "ViewController.h"
#import "dictModelController.h"
#import "UITextField+textField.h"
#import "NSObject+pro.h"
#import "Person.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image = [UIImage imageNamed:@"xxxx"];
 
    self.tf.placeholder = @"一二三四五";
    self.tf.placeHolderColor = [UIColor yellowColor];
    self.tf.name = @"ah";
    self.tf.height = @"124";
    
    Person *p = [[Person alloc] init];
    [p performSelector:@selector(run:) withObject:@10];
    [p performSelector:@selector(eat:) withObject:@"2"];
}
- (IBAction)dictmodel:(id)sender {
    dictModelController *vc = [dictModelController new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
