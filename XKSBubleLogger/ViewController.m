//
//  ViewController.m
//  XKSBubleLogger
//
//  Created by SuperMario@lvhan on 2018/1/26.
//  Copyright © 2018年 Mario. All rights reserved.
//

#import "ViewController.h"
#import "XKSBubleLogger.h"
#import "XKSBubleManager.h"
#import "XKSNetworkLogger.h"
#import "XKSBubleFunction.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *jsonString;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<NSURLSessionDataTask*> *tasks;;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [[XKSBubleManager sharedManager] addNetworkLoggerSessionConfig:configuration];
    self.session = [NSURLSession sessionWithConfiguration:configuration];
    self.tasks = [NSMutableArray array];
    
    NSError *error;
    self.jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"log" ofType:@"json"] encoding:NSUTF8StringEncoding error:&error];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.rowHeight = 44;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    [self.view addSubview:self.tableView];
    
}

- (void)createGetRequest:(NSString *)urlString {
    
    NSMutableString *requestString = [urlString mutableCopy];
    NSDictionary *param = @{@"k1":@"v1",
                            @"k2":@"v2"};
    
    if ([requestString rangeOfString:@"?"].location == NSNotFound) {
        [requestString appendString:@"?"];
    }
    NSMutableString *paraString = [NSMutableString new];
    NSArray *allKeys = [param allKeys];
    for (NSString *key in allKeys) {
        [paraString appendFormat:@"&%@=%@", key, param[key]];
    }
    [paraString deleteCharactersInRange:NSMakeRange(0, 1)];
    [requestString appendString:paraString];
    
    NSString *encodeString = [requestString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    requestString = [encodeString mutableCopy];
    
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [NSURLSessionDataTask new];
    task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {}
        
        if (error) {}
    }];
    [task resume];
}

- (void)createPostRequest:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSDictionary *parameter = @{@"userName" : @"mario",
                                @"gender" : @"male",
                                @"eyes" : @"blue"
                                };
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter
                                                       options:0
                                                         error:&error];
    NSString *bodyJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    NSString *bodyJsonString = bubleCollection2JsonString(parameter);
    NSData *body = [bodyJsonString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = body;
    
    NSURLSessionDataTask *task = [NSURLSessionDataTask new];
    task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {}
        if (error) {}
    }];
    [task resume];
    [self.tasks addObject:task];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [@[@4, @2][section] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
    }
    NSArray *logTextArray = @[@"VERBOSELog", @"INFOLog", @"WARNNINGLog", @"ERRORLog"];
    NSArray *netTextArray = @[@"GET", @"POST"];
    if (indexPath.section == 0) {
        cell.textLabel.text = logTextArray[indexPath.row];
    } else {
        cell.textLabel.text = netTextArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self createGetRequest:@"http://httpbin.org/uuid"];
                [self createGetRequest:@"http://httpbin.org/status/404"];
                [self createGetRequest:@"http://httpbin.org/status/500"];
                break;
            case 1:
                [self createPostRequest:@"http://httpbin.org/post"];
                break;
            default:
                break;
        }
        return;
    }
    
    switch (indexPath.row) {
        case 0:
            XKSVEROSE(@"%@", _jsonString);
            break;
        case 1:
            XKSINFO(@"%@", _jsonString);
            break;
        case 2:
            XKSWARNING(@"%@", _jsonString);
            break;
        case 3:
            XKSERROR(@"%@", _jsonString);
            break;
        default:
            break;
    }
}


@end
