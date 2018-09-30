//
//  LGActivityIndicatorView.h
//  LGActivityIndicatorExample
//
//  Created by Danil Gontovnik on 5/23/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGActivityIndicatorAnimationType) {
    LGActivityIndicatorAnimationTypeNineDots,
    LGActivityIndicatorAnimationTypeTriplePulse,
    LGActivityIndicatorAnimationTypeFiveDots,
    LGActivityIndicatorAnimationTypeRotatingSquares,
    LGActivityIndicatorAnimationTypeDoubleBounce,
    LGActivityIndicatorAnimationTypeTwoDots,
    LGActivityIndicatorAnimationTypeThreeDots,
    LGActivityIndicatorAnimationTypeBallPulse,
    LGActivityIndicatorAnimationTypeBallClipRotate,
    LGActivityIndicatorAnimationTypeBallClipRotatePulse,
    LGActivityIndicatorAnimationTypeBallClipRotateMultiple,
    LGActivityIndicatorAnimationTypeBallRotate,
    LGActivityIndicatorAnimationTypeBallZigZag,
    LGActivityIndicatorAnimationTypeBallZigZagDeflect,
    LGActivityIndicatorAnimationTypeBallTrianglePath,
    LGActivityIndicatorAnimationTypeBallScale,
    LGActivityIndicatorAnimationTypeLineScale,
    LGActivityIndicatorAnimationTypeLineScaleParty,
    LGActivityIndicatorAnimationTypeBallScaleMultiple,
    LGActivityIndicatorAnimationTypeBallPulseSync,
    LGActivityIndicatorAnimationTypeBallBeat,
    LGActivityIndicatorAnimationTypeLineScalePulseOut,
    LGActivityIndicatorAnimationTypeLineScalePulseOutRapid,
    LGActivityIndicatorAnimationTypeBallScaleRipple,
    LGActivityIndicatorAnimationTypeBallScaleRippleMultiple,
    LGActivityIndicatorAnimationTypeTriangleSkewSpin,
    LGActivityIndicatorAnimationTypeBallGridBeat,
    LGActivityIndicatorAnimationTypeBallGridPulse,
    LGActivityIndicatorAnimationTypeRotatingSandglass,
    LGActivityIndicatorAnimationTypeRotatingTrigons,
    LGActivityIndicatorAnimationTypeTripleRings,
    LGActivityIndicatorAnimationTypeCookieTerminator,
    LGActivityIndicatorAnimationTypeBallSpinFadeLoader
};

@interface LGActivityIndicatorView : UIView

- (id)initWithType:(LGActivityIndicatorAnimationType)type;
- (id)initWithType:(LGActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor;
- (id)initWithType:(LGActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor size:(CGFloat)size;

@property (nonatomic) LGActivityIndicatorAnimationType type;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) CGFloat size;

@property (nonatomic, readonly) BOOL animating;

- (void)startAnimating;
- (void)stopAnimating;

@end
