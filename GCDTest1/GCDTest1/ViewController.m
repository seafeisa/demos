//
//  ViewController.m
//  GCDTest1
//
//  Created by admin on 2018/3/15.
//  Copyright © 2018年 Zhongshan Camry Electronic Company Limited. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 同步 并发
//    [self syncConcurrent];
    // 同步串行
//    [self syncSerial];
    // 异步 并发
    [self asyncConcurrent];
    
    // 异步 串行
//    [self asyncSerial];
    
    // 主线程中执行 同步+主队列
//    [self syncMain];
    
    // 在其他线程执行 同步+主队列
//    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    
    // 异步 + 主队列
//    [self asyncMain];
    
    // 线程通信
//    [self communciation];
    
    // 栅栏
//    [self barrier];
    
    // 迭代apply
//    [self apply];
    
    // group
//    [self groupNotify];
    
    // 暂停当前线程(阻塞当前线程) 等待 group 中的任务执行完 才会往下执行
//    [self groupWait];
    
    [self groupEnterAndLeave];
}

// 同步 + 并发 (不会开启新的线程,任务顺序执行)
- (void)syncConcurrent {
    NSLog(@"currentThread ---- %@",[NSThread currentThread]);
    NSLog(@"syncConcurrent --- begin");
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.Senssun.GCDTest1",DISPATCH_QUEUE_CONCURRENT);
    
    // 同步执行任务
    dispatch_sync(queue, ^{
       // 追加任务1
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1-----%@",[NSThread currentThread]);
        }
    });
    
    // 追加任务2
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2-----%@",[NSThread currentThread]);
        }
    });
    
    // 追加任务3
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3-----%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncConcurrent === end");
    
}

// 同步 + 串行
- (void)syncSerial {
    NSLog(@"currentThread ----- %@",[NSThread currentThread]);
    NSLog(@"syncSerial begin");
    
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.Senssun.GCDTest1", DISPATCH_QUEUE_SERIAL);
    // 同步执行任务
    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1-----%@",[NSThread currentThread]);
        }
    });
    
    // 追加任务2
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2-----%@",[NSThread currentThread]);
        }
    });
    
    // 追加任务3
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3-----%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncSerial === end");
    
    
}

// 异步 并发 (开启新的线程 任务同步执行)
- (void)asyncConcurrent {
    NSLog(@"currentThread ===== %@",[NSThread currentThread]);
    NSLog(@"asyncConcurrent ---- begin");
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.Senssun.GCDTest1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1 ------ %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2 ------ %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3 ------ %@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncConcurrent ---- end");
}

// 异步 串行(会开启新的线程 任务是在新的线程里顺序执行)
- (void)asyncSerial {
    NSLog(@"currentThread ---- %@",[NSThread currentThread]);
    NSLog(@"asyncSerial ----- begin");
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.Senssun.GCDTest1", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1-------------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2-------------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3-------------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncSerial----end");
}

// 同步 + 主队列 (在主线程调用 同步执行+主队列 会出现死锁 相互等待卡死不往下执行)
- (void)syncMain {
    NSLog(@"currentThread ---- %@",[NSThread currentThread]);
    NSLog(@"syncMain --- begin");
    // 获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncMian ---- end");
}

// 异步 + 主队列
- (void)asyncMain {
    NSLog(@"currentThread --- %@",[NSThread currentThread]);
    NSLog(@"asyncMian ---- begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1 ----- %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2 ----- %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3 ----- %@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncMian ----- end");
}

// 线程间通信
- (void)communciation {
    // 获取全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2 ---------- %@",[NSThread currentThread]);
        }
    });
}

// 栅栏方法 执行完 barrier 之前的任务才会执行后边的任务
- (void)barrier {
    dispatch_queue_t queue = dispatch_queue_create("com.Senssun.GCDTest1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
       // 追加任务1
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"barrier ---- %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3-------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4-------%@",[NSThread currentThread]);
        }
    });
}

- (void)after {
    NSLog(@"currentThread --- %@",[NSThread currentThread]);
    NSLog(@"begin");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"after ---- %@",[NSThread currentThread]);
    });
}

// 单例 整个程序运行过程中只执行一次,并且即使在多线程的环境下, dispatch_once 也可以保证线程安全
- (void)once {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //只执行一次的代码(这里面默认是线程安全的)
    });
}

- (void)apply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"APPLY---begin");
    
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zu-----%@",index,[NSThread currentThread]);
    });
    NSLog(@"apple ---- end");
}

- (void)groupNotify {
    NSLog(@"currentThread ----------- %@",[NSThread currentThread]);
    NSLog(@"group ---- begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2-----------%@",[NSThread currentThread]);
        }
    });
   
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------------%@",[NSThread currentThread]);
        }
    });
   
    NSLog(@"group----end");
}

- (void)groupWait {
    NSLog(@"currentThread ---- %@",[NSThread currentThread]);
    NSLog(@"groupWait-----begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1-----------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2-----------%@",[NSThread currentThread]);
        }
    });
    
    // 等待上边的任务执行完 才会执行下边的任务(会阻塞当前线程)
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"group ----- end");
}

- (void)groupEnterAndLeave {
    NSLog(@"currentThread ---- %@",[NSThread currentThread]);
    NSLog(@"group===begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1-------------%@",[NSThread currentThread]);
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------------%@",[NSThread currentThread]);
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        for (int i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3-----------%@",[NSThread currentThread]);
        }
        NSLog(@"group----------end");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
