//
//  UIImage+ninePatch.h
//  ninePatchImage
//
//  Created by yamyee on 2020/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ninePatch)
- (NSArray<NSArray<NSNumber *> *>*)yy_getNinePatchAlpha;
///点九图设置的insets,非点九图没有
- (UIEdgeInsets)yy_ninePatchImageCapInsets;
@end

NS_ASSUME_NONNULL_END
