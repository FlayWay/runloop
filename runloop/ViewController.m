//
//  ViewController.m
//  runloop
//
//  Created by ljkj on 2018/5/24.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "ViewController.h"
#import "LJThread.h"
#import "CustomViewCell.h"

typedef void(^SaveFuncBlock)();

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LJThread *thread;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *saveArr;

@property (nonatomic, copy) SaveFuncBlock funcBlock;

//最大任务数（超过最大任务数的任务就停止执行）
@property (nonatomic, assign) NSInteger maxTasksNumber;

@end

@implementation ViewController

- (NSMutableArray *)saveArr
{
    if (!_saveArr)
    {
        _saveArr = [NSMutableArray array];
    }
    return _saveArr;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.maxTasksNumber = 15;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CustomViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self addRunloopObserver];
    
    [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timeMethod) userInfo:nil repeats:YES];
    
    return;
    _thread = [[LJThread alloc]initWithBlock:^{
      
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timeMethods) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"来了");
        
    }];
    
    [_thread start];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self addTask:^{
       
        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
        UIImage *image1 = [UIImage imageWithContentsOfFile:path1];
        cell.imageV1.image = image1;
    }];
    
    [self addTask:^{

        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
        UIImage *image2 = [UIImage imageWithContentsOfFile:path2];
        cell.imageV2.image = image2;
        
    }];
    
    [self addTask:^{
        
        NSString *path3 = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
        UIImage *image3 = [UIImage imageWithContentsOfFile:path3];
        cell.imageV3.image = image3;
        
    }];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)addTask:(SaveFuncBlock)block
{
    
    [self.saveArr addObject:block];
    if (self.saveArr.count>self.maxTasksNumber)
    {
        [self.saveArr removeObjectAtIndex:0];
    }
}

- (void)addRunloopObserver
{

   CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
       
       if (self.saveArr.count>0)
       {
           SaveFuncBlock block = self.saveArr.firstObject;
           block();
           [self.saveArr removeObjectAtIndex:0];
       }
       
    });
    
    
    
    
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
    
}

- (void)timeMethod
{
    
}

















- (void)timeMethods
{
    NSLog(@"come here");
    [NSThread sleepForTimeInterval:1.0];
    static int a = 0;
    NSLog(@"%@----------%d",[NSThread currentThread],a++);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSThread exit];
}



@end
