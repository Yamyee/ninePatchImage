//
//  UIImage+ninePatch.m
//  ninePatchImage
//
//  Created by yamyee on 2020/12/16.
//

#import "UIImage+ninePatch.h"

typedef struct{
    unsigned char r;
    unsigned char g;
    unsigned char b;
    unsigned char a;
} yy_rgba;

@implementation UIImage (ninePatch)

- (NSArray<NSArray<NSNumber *> *>*)yy_getNinePatchAlpha
{

    // First get the image into your data buffer
    CGImageRef imageRef = [self CGImage];
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);

    yy_rgba *rawData = malloc(sizeof(yy_rgba) * width * height);
    memset(rawData, 0, sizeof(yy_rgba) * width * height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bitsPerComponent = 8;//rgba每个颜色8位(1字节)
    size_t bytesPerRow = 4 * width;//每行像素占用字节数,每个像素4字节（32位）
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    // 只需要获取第一行 和 第一列的alpha值
   
    size_t byteIndex = width;
    
    size_t count = width * height;
    
    NSMutableArray *cloumn = [NSMutableArray array];
    NSMutableArray *raw = [NSMutableArray array];
    while (byteIndex < count) {
        
        unsigned char a = rawData[byteIndex].a;
        int alpha = a / 255.0;
//        ///第一行
        if (byteIndex / width < 1) {
            printf("column %ld alpha = %d\n",byteIndex,alpha);
            [cloumn addObject:@(alpha)];
            byteIndex++;
        }else {
            printf("row %ld alpha = %d\n",byteIndex / width,alpha);
            [raw addObject:@(alpha)];
            byteIndex+=width;
        }
    }
    free(rawData);
    
    return @[[cloumn copy],[raw copy]];
}
-(UIEdgeInsets)yy_ninePatchImageCapInsets{
    return [self capInsets];
}
@end
