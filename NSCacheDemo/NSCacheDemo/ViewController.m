//
//  ViewController.m
//  NSCacheDemo
//
//  Created by chunxi on 16/7/6.
//  Copyright © 2016年 chunxi. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
@property (nonatomic,strong) NSCache *cache;
@property (nonatomic,strong) NSMutableDictionary *cacheDict;
@end

@implementation ViewController
@synthesize cache,cacheDict;
- (void)viewDidLoad {
    [super viewDidLoad];

    cache = [[NSCache alloc] init];
    
    Person *p =  [Person new];
    
    [cache setObject:p forKey:@"zzz"];
    [cache setObject:p forKey:@"bbb"];
    [cache removeObjectForKey:@"zzz"];
    [cache removeObjectForKey:@"bbb"];
    
    
    
    
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"**** %@ *****",NSStringFromSelector(_cmd));
    
    // 当收到内存警告的时候 cache中的缓存会被全部删除
    // 缓存的时间要远远大于读取缓存的时间
    // cache 会强引用对象
    // 对一个对象缓存多次不会拷贝对象 只会增加对象的引用计数
}


- (IBAction)cacheAction:(UIButton *)sender {
    
    int maxCount = 1000;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"image" withExtension:@"JPG"];
    NSTimeInterval interval = CACurrentMediaTime();
    for (int i = 0 ; i < maxCount; i ++ ) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        [cache setObject:data forKey:@(i)];
        NSLog(@"i :%d  *** size :%lu ",i,(unsigned long)data.length);
    }
    interval = CACurrentMediaTime() - interval;
    NSLog(@"写入时间 ** %f",interval); //写入时间 ** 26.519067
    
    interval = CACurrentMediaTime();
    for (int i = 0 ; i < maxCount; i ++ ) {
        NSData *data = [cache objectForKey:@(i)] ;
        NSLog(@"read : i :%d  *** size :%lu ",i,(unsigned long)data.length);
    }
    interval = CACurrentMediaTime() - interval; //读取时间 ** 2.625770
    NSLog(@"读取时间 ** %f",interval);
    
    
}

- (IBAction)cachePersonAction:(UIButton *)sender {
    int maxCount = 1000;
    
    Person *p = [Person new];
    
    NSTimeInterval interval = CACurrentMediaTime();
    for (int i = 0 ; i < maxCount; i ++ ) {
        
        [cache setObject:p forKey:@(i)];
        NSLog(@"i :%d  *** size :%@ ",i,p);
    }
    interval = CACurrentMediaTime() - interval;
    NSLog(@"写入时间 ** %f",interval); //写入时间 ** 26.519067
    
    interval = CACurrentMediaTime();
    for (int i = 0 ; i < maxCount; i ++ ) {
        Person *rp= [cache objectForKey:@(i)] ;
        NSLog(@"read : i :%d  *** size :%@ ",i,rp);
    }
    interval = CACurrentMediaTime() - interval; //读取时间 ** 2.625770
    NSLog(@"读取时间 ** %f",interval);
}

- (IBAction)cacheImageByDictionaryAction:(id)sender {
    int maxCount = 1000;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"image" withExtension:@"JPG"];
    NSTimeInterval interval = CACurrentMediaTime();
    for (int i = 0 ; i < maxCount; i ++ ) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        [cacheDict setObject:data forKey:@(i)];
        NSLog(@"i :%d  *** size :%lu ",i,(unsigned long)data.length);
    }
    interval = CACurrentMediaTime() - interval;
    NSLog(@"cacheDict 写入时间 ** %f",interval); //
    
    interval = CACurrentMediaTime();
    for (int i = 0 ; i < maxCount; i ++ ) {
        NSData *data = [cacheDict objectForKey:@(i)] ;
        NSLog(@"read : i :%d  *** size :%lu ",i,(unsigned long)data.length);
    }
    interval = CACurrentMediaTime() - interval; //
    NSLog(@"cacheDict 读取时间 ** %f",interval);
}

@end
