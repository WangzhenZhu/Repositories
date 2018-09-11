//
//  InfoHeadView.h
//  KKPat
//
//  Created by Wang on 19/07/2018.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfoHeadViewDelegate <NSObject>

- (void)InfoHeadViewToPickVc:(UIImagePickerController *)imagePickerController;
- (void)InfoHeadViewDismiss:(UIImagePickerController *)imagePickerController;
- (void)InfoHeadViewPresent:(UIAlertController *)alert;
@end
@interface InfoHeadView : UIView

@property (nonatomic, strong) NSMutableArray *imageBase64Arr;

@property (nonatomic, strong) NSMutableArray *imagesPath;

@property (nonatomic, weak) id<InfoHeadViewDelegate> delegate;
@end
