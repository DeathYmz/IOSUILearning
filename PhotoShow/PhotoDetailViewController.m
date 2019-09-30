//
//  PhotoDetailViewController.m
//  NewXcode11Scene
//
//  Created by yumengzhen on 2019/9/5.
//  Copyright © 2019 yumengzhen. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "FLAnimatedImage.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AlertViewController.h"
#import "NSObject+Extensions.h"
@interface PhotoDetailViewController ()
@end

@implementation PhotoDetailViewController

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = nil;
    self.imageView.animationImages = nil;
    [self setupRightMoreItem];
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}



-(void)setupRightMoreItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[self mw_imageNamed:@"add" inBundle:@"PhotoShowResource"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectedImage) forControlEvents:UIControlEventTouchUpInside];
    //button.frame.size = CGSizeMake(40, 40);
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)selectedImage{
    NSLog(@"miaomiao??");
    AlertViewController *AVC = [[AlertViewController alloc] init];
    AVC.imagePath = self.path;
    AVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];// 背景色透明
    AVC.modalPresentationStyle = UIModalPresentationOverFullScreen;//关键
    [self presentViewController:AVC animated:NO completion:^(void){
//        AVC.view.superview.backgroundColor = [UIColor  clearColor];
    }];
}
-(void)loadPhoto:(UIImage *)image {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.scrollView.contentSize = self.imageView.image.size;
    self.imageView.center = _scrollView.center;
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 5.0;
    [self.scrollView setZoomScale:0.5 animated:YES];
    self.scrollView.delegate = self;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    [self.scrollView addGestureRecognizer:swipe];
    self.scrollView.userInteractionEnabled =YES;
    [self.view addSubview:self.scrollView];
    
}
- (void)loadImage:(NSString *)path {
    self.path = path;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
    //2、利用三方框架FLAnimatedImage
    if([[path pathExtension] isEqualToString:@"gif"]){
        NSURL *url = [NSURL fileURLWithPath:path];
        FLAnimatedImage *gest = [FLAnimatedImage animatedImageWithGIFData: [NSData dataWithContentsOfURL:url]];
        FLAnimatedImageView *gestImageView = [[FLAnimatedImageView alloc] init];
        gestImageView.animatedImage = gest;
        gestImageView.frame = CGRectMake(100, 311, gest.size.width, gest.size.height);
        self.scrollView.contentSize = gestImageView.frame.size;
        gestImageView.center = self.scrollView.center;
        [self.scrollView addSubview:gestImageView];
        self.gestImageView = gestImageView;//存储gif
        NSLog(@"this is  gif====%@",[path pathExtension]);
        
    } else {//静态图片
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        self.scrollView.contentSize = self.imageView.image.size;
        self.imageView.center = _scrollView.center;
        [self.scrollView addSubview:self.imageView];
        self.scrollView.minimumZoomScale = 0.1;
        self.scrollView.maximumZoomScale = 5.0;
        [self.scrollView setZoomScale:0.5 animated:YES];
        self.scrollView.delegate = self;
    }
    //swipe的手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    [self.scrollView addGestureRecognizer:swipe];
    self.scrollView.userInteractionEnabled =YES;
    [self.view addSubview:self.scrollView];
}
//

- (void)swipeImage:(id)sender {
    //next image
    
}

-(void)clickImage:(id)sender{
    NSLog(@"you click me!!!");
   
    if(self.imageView.image!=nil){
       NSLog(@"image.jpg save"); UIImageWriteToSavedPhotosAlbum(self.imageView.image,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
        
    } else{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    NSDictionary *metadata = @{@"UTI":(__bridge NSString *)kUTTypeGIF};
    NSData *gifData = [NSData dataWithContentsOfFile:self.path];
    [library writeImageDataToSavedPhotosAlbum:gifData metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            NSLog(@"you fail to save gif");//not found????
            }else{
                NSLog(@"you success to save gif");
            }
        }] ;
    }
    
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if(error) {
        NSLog(@"failer");
    }else{
        NSLog(@"success");
    }
}
//在SscrollView中zoom的目标视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
/* scrollview将要开始Zooming */
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    NSLog(@"Begin Zooming");
}
//scrollview完成Zooming
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
//    NSLog(@"----scale is %f",scale);
//    [_scrollView setZoomScale:scale animated:NO];
    if (self.scrollView.zoomScale > 1) {
        _imageView.center = CGPointMake(self.scrollView.contentSize.width / 2, self.scrollView.contentSize.height / 2);
        }else {
            _imageView.center = self.view.center;
    }
}


- (void)loadPicture {
    // Do any additional setup after loading the view.
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    //获取网络图片地址
    //    NSURL *url = [NSURL URLWithString:@"https://img-blog.csdnimg.cn/20190821144126296.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L01pcmFuZGFfeW16,size_16,color_FFFFFF,t_70"];
    //    //将网络地址的NSString类型转化为NSData类型
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    //image与data的相互转换
    //    UIImage *image = [UIImage imageWithData:data];
    //    //配置图片到imageView上
    //    imageView.image = image;
    //    //将imageView添加到当前视图上去   网络图片是ok的
    //    [self.view addSubview:imageView];// 错误，图片未能正确加载
    
    //    NSArray *bundles = [NSBundle allBundles];
    //    NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"13-1PR0144F2"
    //                                              withExtension:@"jpg"];
    //    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        
    //    UIImage *image = [UIImage imageNamed:@"13-1PR0144F2.jpg"];
    //    [self.view addSubview:[[UIImageView alloc] initWithImage:image]];
    //
        
    //    NSBundle *mainBundle = [NSBundle bundleForClass:self.class];
    //    NSString *path = [mainBundle pathForResource:@"Bundle" ofType:@"bundle"];
    //    NSLog(@"%@",path);
    //    UIImage *image = [UIImage imageNamed:@"6380ddbdbc35432b81c81973beb4fbf3.gif" inBundle:[NSBundle bundleWithPath:path] compatibleWithTraitCollection:nil];
    //    [self.view addSubview:[[UIImageView alloc] initWithImage:image]];

    //
    //    //以上是静态图片加载
        
        //下面是动态图的加载
        //1、正常方法
        //不知道修改了什么又看不到了
        
        NSString *bundlePath = [[ NSBundle mainBundle] pathForResource:@"Bundle" ofType :@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *img_path = [bundle pathForResource:@"6380ddbdbc35432b81c81973beb4fbf3" ofType:@"gif"];
        //1.加载Gif图片，转换成Data类型
        NSData *data = [NSData dataWithContentsOfFile:img_path];
        //2.将data数据转换成CGImageSource对象
        CGImageSourceRef imageSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
        size_t imageCount = CGImageSourceGetCount(imageSource);
        //3.遍历所有图片
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval totalDuration = 0;
        for (int i = 0; i<imageCount; i++) {
            //取出每一张图片
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            [images addObject:image];

            //持续时间
            NSDictionary *properties = (__bridge_transfer  NSDictionary*)CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil);
            NSDictionary *gifDict = [properties objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *frameDuration =
            [gifDict objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime];
            totalDuration += frameDuration.doubleValue;
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 350, 200)];//设置大小
        //4.设置imageView属性
        imageView.animationImages = images;
        imageView.animationDuration = totalDuration;
        imageView.animationRepeatCount = 0;
        //5.开始播放
        [imageView startAnimating];// 刚才把这个删掉了。emm图就就没了
        
        //2、利用三方框架FLAnimatedImage
        NSURL *url = [NSURL fileURLWithPath:img_path];
        FLAnimatedImage *gest = [FLAnimatedImage animatedImageWithGIFData: [NSData dataWithContentsOfURL:url]];
        FLAnimatedImageView *gestImageView = [[FLAnimatedImageView alloc] init];
        gestImageView.animatedImage = gest;
        gestImageView.frame = CGRectMake(100, 311, gest.size.width, gest.size.height);
        
        //3、利用webView 加载
        //将gif文件转化为apng格式，再用方法三的方式用UIWebView加载就不卡顿了。[webView.scrollView addSubview:t_ImageView];不用这样add的，直接request
        NSString *t_imagePath = [bundle pathForResource:@"bxf8j-w5mcm" ofType:@"png"];//这样的apng图片可以用普通方式加载
        NSData *t_data = [NSData dataWithContentsOfFile:t_imagePath];
        UIWebView * webView= [[UIWebView alloc] initWithFrame:CGRectMake(10, 250, 400,280)];
        NSURL *t_url = [NSURL fileURLWithPath:t_imagePath];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.scrollView addSubview:imageView];
        [self.scrollView  addSubview:gestImageView];
        [self.scrollView addSubview:webView];
        [webView loadRequest:[NSURLRequest requestWithURL:t_url]];//ok
        [self.view addSubview:self.scrollView];

}



@end
