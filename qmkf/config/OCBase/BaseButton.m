//
//  BaseButton.m
//  qmkf
//
//  Created by Mac on 2020/2/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "BaseButton.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation BaseButton

- (void)takePic {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//                UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [self presentCamera:@""];
//                }];
//                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [self callPhotoLibrary:@""];
//                }];
//                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                [alertController addAction:cancelAction];
////                [alertController addAction:okAction];
//                [alertController addAction:okAction1];
//                [GetCurrentVC presentViewController:alertController animated:YES completion:^{
//                }];
            }else{
//                [Utils requestUseVideoCamera:^(BOOL isCanUse) {
//
//                }];
            }
        });
    }];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized: //已获取权限
                {
                    
                   
                }
                    break;
                    
                case PHAuthorizationStatusDenied: //用户已经明确否认了这一照片数据的应用程序访问
//                    [Utils requestUseVideoCamera:^(BOOL isCanUse) {
//
//                    }];
                    break;
                    
                case PHAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限
//                    [Utils requestUseVideoCamera:^(BOOL isCanUse) {
//
//                    }];
                    break;
                    
                default://其他。。。
                    break;
            }
        });
    }];
    
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

#define GetCurrentVC [self getCurrentVC]

#pragma mark - 调用相机拍摄照片
-(void)presentCamera:(NSString *)notificationName{
    
    UIImagePickerController *pickerCon = [[UIImagePickerController alloc]init];
    pickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerCon.delegate = self;
    [GetCurrentVC presentViewController:pickerCon animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage *image;
        //如果允许编辑则获得编辑后的照片，否则获取原始照片
        if (picker.allowsEditing) {
            image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
        }else{
            image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
        }
        
        UIImage * resImage = [BaseButton imageCompressForWidthScale:image targetWidth:1080];
        //UIImage转换为NSData
        NSData *_imageData = UIImageJPEGRepresentation(resImage,0.65);//UIImagePNGRepresentation(image);
        
//        [self callBackForCameraTakeAPhoto:_imageData];
        resImage = [UIImage imageWithData:_imageData];
        self.baseBlock(image);
        
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        NSLog(@"video...");
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr=[url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)callBackForCameraTakeAPhoto:(id)id_data {
}

//指定宽度按比例缩放
+(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
 
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
 
    if(CGSizeEqualToSize(imageSize, size) == NO){
 
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
 
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
 
        if(widthFactor > heightFactor){
 
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
 
        }else if(widthFactor < heightFactor){
 
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
 
    UIGraphicsBeginImageContext(size);
 
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
 
    [sourceImage drawInRect:thumbnailRect];
 
    newImage = UIGraphicsGetImageFromCurrentImageContext();
 
    if(newImage == nil){
 
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

@end
