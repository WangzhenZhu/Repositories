//
//  EntryInfoViewController.m
//  KKPat
//
//  Created by Wang on 17/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//


#import "EntryInfoViewController.h"
#import "KKPatTabBarController.h"
#import "KKConfiguration.h"
#import "InfoHeadView.h"
#import "Historyillness.h"
#import "HumanIdentityCard.h"

#import "KKEntryInfoManager.h"

@interface EntryInfoViewController ()<InfoHeadViewDelegate,KKAPIManagerParamSourceDelegate,KKAPIManagerApiCallBackDelegate>

@property (nonatomic, strong) UIScrollView *InfoScrollView;

@property (nonatomic, assign) float Height;

@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, strong) InfoHeadView *infoHeadView;

@property (nonatomic, strong) HumanIdentityCard *HumanIDManager;

@property (nonatomic, strong) KKEntryInfoManager *entryManager;

@property (nonatomic, strong) OSSClient *client;


@end

@implementation EntryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOSS];
    [self.InfoScrollView addSubview:self.infoHeadView];
    [self initView];
    [self.view addSubview:self.InfoScrollView];
//    self.view.backgroundColor = ThemeColor;

}

- (void)initOSS
{
    [OSSLog enableLog];
    id<OSSCredentialProvider> credential = [[OSSAuthCredentialProvider alloc] initWithAuthServerUrl:STS_AUTH_URL];
    self.client = [[OSSClient alloc] initWithEndpoint:EndPoint credentialProvider:credential];
//    self.bucketName = @"kkmed-doc-test";
}
- (void)initView
{
    self.Height = self.infoHeadView.bounds.size.height;
    for (int i = 0; i < 3; i++) {
        Historyillness *historyview = [[Historyillness alloc] initWithFrame:CGRectMake(18, self.Height + 50 ,ScreenWidth-18*2, 500)];
        historyview.layer.cornerRadius = 5.0f;
        historyview.layer.masksToBounds = YES;
        historyview.layer.borderWidth = 1.0f;
        historyview.layer.borderColor = RGBACG(234, 234, 234, 1);
        [_InfoScrollView addSubview:historyview];
        self.Height = _Height + (float)historyview.bounds.size.height + 50;
        NSLog(@"height--%f",self.Height);
    }
  
    

    [self.sendBtn addTarget:self action:@selector(SendInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.InfoScrollView addSubview: self.sendBtn];
    
  
}


- (void)SendInfoAction
{
//    [self uploadOSS:BUCKET_NAME withObjectname:UPLOAD_OBJECT_KEY withFilepath:self.infoHeadView.imagesPath[0]];
    for (UIView *view in [UIApplication sharedApplication].delegate.window.subviews) {
        [view removeFromSuperview];
    }
    KKPatTabBarController *KKPTabVc = [[KKPatTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = KKPTabVc;
//    [self.HumanIDManager loadData];

}
#pragma mark ---InfoHeadViewDelegate
- (void)InfoHeadViewPresent:(UIAlertController *)alert
{
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)InfoHeadViewDismiss:(UIImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}
- (void)InfoHeadViewToPickVc:(UIImagePickerController *)imagePickerController
{
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


#pragma mark ---KKAPIManagerParamSourceDelegate
- (NSDictionary *)paramForApi:(KKAPIBaseManager *)manager
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    NSString *paths = [[NSBundle mainBundle] pathForResource:@"base64" ofType:@"txt"];
//    NSString *content = [[NSString alloc] initWithContentsOfFile:paths encoding:NSUTF8StringEncoding error:nil];
    if ([manager isKindOfClass:[HumanIdentityCard class]]) {

  
//  @{@"img1":_infoHeadView.imageBase64Arr[0],@"img2":_infoHeadView.imageBase64Arr[1]};

        [params setObject:_infoHeadView.imageBase64Arr[0] forKey:@"img1"];
        [params setObject:_infoHeadView.imageBase64Arr[1] forKey:@"img2"];
//        NSDictionary *params = @{@"img1":content,@"img2":content};

            return params;
    }
    return nil;
}

#pragma mark --KKAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(KKAPIBaseManager *)manager
{
    KKPatTabBarController *KKPTabVc = [[KKPatTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = KKPTabVc;
    id responeData = manager.responseObject;
    NSLog(@"data====%@",responeData);
 
}

- (void)managerCallAPIDidFailed:(KKAPIBaseManager *)manager
{
    [SVProgressHUD showErrorWithStatus:manager.errorMessage];
}


- (void)uploadOSS:(NSString *)bucketName withObjectname:(NSString *)objectKey withFilepath:(NSString *)filePath{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // 必填字段
    put.bucketName = bucketName;
    put.objectKey = objectKey;
    put.uploadingFileURL = [NSURL fileURLWithPath:filePath];
    // put.uploadingData = <NSData *>; // 直接上传NSData
    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    // 以下可选字段的含义参考： https://docs.aliyun.com/#/pub/oss/api-reference/object&PutObject
    // put.contentType = @"";
    // put.contentMd5 = @"";
    // put.contentEncoding = @"";
    // put.contentDisposition = @"";
    // put.objectMeta = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil]; // 可以在上传时设置元信息或者其他HTTP头部
    OSSTask * putTask = [self.client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    // [putTask waitUntilFinished];
    // [put cancel];
}
- (UIScrollView *)InfoScrollView
{
//    _InfoScrollView.contentSize = CGSizeMake(ScreenWidth,self.Height);
    if (_InfoScrollView == nil) {
        _InfoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight+20)];
        _InfoScrollView.backgroundColor = [UIColor whiteColor];
        _InfoScrollView.contentSize = CGSizeMake(ScreenWidth, 2600);
        _InfoScrollView.showsHorizontalScrollIndicator=NO;
        _InfoScrollView.showsVerticalScrollIndicator=NO;
        _InfoScrollView.bounces = NO;
    }
    return _InfoScrollView;
}

- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, self.Height + 100, ScreenWidth-18*2, 50)];
        _sendBtn.layer.shadowColor = RGBACG(0, 0, 0, 0.3);
        _sendBtn.layer.shadowOffset = CGSizeMake(5, 10.f);
        _sendBtn.layer.shadowOpacity = YES;
        [_sendBtn setBackgroundImage:IMG(@"ok_entryInfo_btn") forState:UIControlStateNormal];
        [_sendBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    }
    return _sendBtn;
}

- (InfoHeadView *)infoHeadView
{
    if (!_infoHeadView) {
        _infoHeadView = [[InfoHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 700)];
        _infoHeadView.delegate = self;
        _infoHeadView.backgroundColor = [UIColor clearColor];
        
    }
    return _infoHeadView;
}
- (HumanIdentityCard *)HumanIDManager
{
    if (!_HumanIDManager) {
        _HumanIDManager = [[HumanIdentityCard alloc] init];
        _HumanIDManager.delegate = self;
        _HumanIDManager.paramsSource = self;
    }
    return _HumanIDManager;
}

- (KKEntryInfoManager *)entryManager
{
    if (!_entryManager) {
        _entryManager = [[KKEntryInfoManager alloc] init];
        _entryManager.delegate = self;
        _entryManager.paramsSource = self;
    }
    return _entryManager;
}
@end
