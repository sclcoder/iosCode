//
//  SDAlertViewController.m
//  SDPlayground
//
//  Created by chunlei.sun on 2021/9/24.
//

#import "SDAlertViewController.h"
#import <LEEAlert/LEEAlert.h>

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>


@interface SDAlertViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SDAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self getVideoFirstViewImage:@"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"];

}
// 获取视频第一帧
- (void)getVideoFirstViewImage:(NSString *)videoURL{
   
    NSString *url = videoURL;
   
   __block UIImage *videoImage;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:url] options:nil];
        NSParameterAssert(asset);
        AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
        assetImageGenerator.appliesPreferredTrackTransform = YES;
        assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
        CGImageRef thumbnailImageRef = NULL;
        NSError *thumbnailImageGenerationError = nil;
        thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(0, 60)actualTime:NULL error:&thumbnailImageGenerationError];
        if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
        
        videoImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef]: nil;
    
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = videoImage;
        });
    });
}


- (IBAction)showAlert:(id)sender {
    // 添加设置的顺序决定了显示的顺序 可根据需要去调整
    [LEEAlert alert].config
    .LeeAddTextField(nil) // 如果不需要其他设置 也可以传入nil 输入框会按照默认样式显示
    .LeeContent(@"内容1")
    .LeeTitle(@"标题")
    .LeeContent(@"内容2")
    .LeeAddTextField(^(UITextField *textField) {
        
        textField.placeholder = @"输入框2";
    })
    .LeeAction(@"好的", nil)
    .LeeCancelAction(@"取消", nil)
    .LeeShow();
}

- (IBAction)showActionSheet:(id)sender {
    
}


@end
