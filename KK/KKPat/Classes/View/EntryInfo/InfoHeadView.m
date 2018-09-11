//
//  InfoHeadView.m
//  KKPat
//
//  Created by Wang on 19/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "InfoHeadView.h"
#import "KKConfiguration.h"
#import "CustomImagePickerViewController.h"
@interface InfoHeadView()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *menBtn;

@property (weak, nonatomic) IBOutlet UIButton *womenBtn;


@property (weak, nonatomic) IBOutlet UIImageView *HeadImageView;
@property (weak, nonatomic) IBOutlet UIView *baseBgView;

@property (weak, nonatomic) IBOutlet UIView *IDCardBgView;

@property (weak, nonatomic) IBOutlet UIImageView *IDCardImageView;

@property (weak, nonatomic) IBOutlet UITextField *NameText;
@property (weak, nonatomic) IBOutlet UITextField *AgeText;

@property (nonatomic, copy) NSString *uploadFilePath;

@end
@implementation InfoHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"InfoHeadView" owner:nil options:nil] firstObject];
        self.frame = frame;
        self.baseBgView.layer.cornerRadius = 5.0f;
        self.baseBgView.layer.masksToBounds = YES;
        self.baseBgView.layer.borderWidth = 1.0f;
        self.baseBgView.layer.borderColor = RGBACG(234, 234, 234, 1);
        self.IDCardBgView.layer.cornerRadius = 5.0f;
        self.IDCardBgView.layer.masksToBounds = YES;
        self.IDCardBgView.layer.borderWidth = 1.0f;
        self.IDCardBgView.layer.borderColor = RGBACG(234, 234, 234, 1);
        
        //用户拍照
        self.HeadImageView.layer.cornerRadius = 10.0f;
        self.HeadImageView.layer.masksToBounds = YES;
        //给imageView添加点击事件
        self.HeadImageView.userInteractionEnabled = YES;
        self.HeadImageView.tag = 1001;
        UITapGestureRecognizer *singleTop = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
        [self.HeadImageView addGestureRecognizer:singleTop];
        
        //选择性别
        self.menBtn.selected = YES;
        self.womenBtn.selected = NO;
        [self.menBtn addTarget:self action:@selector(Clickmen) forControlEvents:UIControlEventTouchUpInside];
        [self.womenBtn addTarget:self action:@selector(Clickwomen) forControlEvents:UIControlEventTouchUpInside];
        
        // 身份证
        self.IDCardImageView.userInteractionEnabled = YES;
        self.IDCardImageView.tag = 1002;
        UITapGestureRecognizer *singleTopID = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
        [self.IDCardImageView addGestureRecognizer:singleTopID];
        
        //姓名/年龄
        self.NameText.delegate = self;
        self.AgeText.delegate= self;
    }
    return self;
}

#pragma mark - event response(键盘收回)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}

#pragma mark -- TextFieldDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"/n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}

- (void)addImage:(UIGestureRecognizer *)gestureRecognizer
{
    CustomImagePickerViewController *imagePick = [[CustomImagePickerViewController alloc] init];
    imagePick.ImageViewTag = gestureRecognizer.view.tag;
    imagePick.delegate = self;
    imagePick.editing = YES;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //相机
    UIAlertAction *cemera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePick.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePick.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        if (self.delegate && [self.delegate respondsToSelector:@selector(InfoHeadViewToPickVc:)]) {
            [self.delegate InfoHeadViewToPickVc:imagePick];
        }
    }];
    //相册
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (self.delegate && [self.delegate respondsToSelector:@selector(InfoHeadViewToPickVc:)]) {
            [self.delegate InfoHeadViewToPickVc:imagePick];
        }
    }];
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(InfoHeadViewDismiss:)]) {
            [self.delegate InfoHeadViewDismiss:imagePick];
        }
    }];
    [alert addAction:cemera];
    [alert addAction:photo];
    [alert addAction:Cancel];
    
    //弹出提示框
    if (self.delegate && [self.delegate respondsToSelector:@selector(InfoHeadViewPresent:)]) {
        [self.delegate InfoHeadViewPresent:alert];
    }
}



#pragma mark --UIImagePickerControllerDelegate
- (void)imagePickerController:(CustomImagePickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    [self saveImage:image withName:@"currentImage"];
    UIImageView *imgView = (UIImageView *)[self viewWithTag:picker.ImageViewTag];
    imgView.image = image;
    
    [self.imageBase64Arr addObject:[self convertImageToBase64:image]];
}

#pragma mark --图片转base64
- (NSString *)convertImageToBase64:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.2f);
    NSLog(@"length--%ld",data.length);
    NSString *encodeedImageStr =[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodeedImageStr;
}

#pragma mark -- 性别选择
- (void)Clickmen
{
    if (!self.menBtn.selected) {
        self.menBtn.selected = YES;
        self.womenBtn.selected = NO;
    }
}
- (void)Clickwomen
{
    if (!self.womenBtn.selected) {
        self.womenBtn.selected = YES;
        self.menBtn.selected = NO;
    }
}

#pragma mark -- 保存图片本地
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName {
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
    self.uploadFilePath = fullPath;
    NSLog(@"uploadFilePath : %@", self.uploadFilePath);
    [self.imagesPath addObject:self.uploadFilePath];
}
- (NSMutableArray *)imageBase64Arr
{
    if (!_imageBase64Arr) {
        _imageBase64Arr = [[NSMutableArray alloc] init];
    }
    return _imageBase64Arr;
}

- (NSMutableArray *)imagesPath
{
    if (!_imagesPath) {
        NSArray *imageArr = @[@"",@""];
        _imagesPath = [imageArr mutableCopy];
    }
    return _imagesPath;
}
@end
