//
//  TouchPanel.h
//  XNI
//
//  Created by Matej Jan on 29.9.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Retronator.Xni.Framework.classes.h"
#import "Retronator.Xni.Framework.Input.Touch.classes.h"

@class GameView;

@interface TouchPanel : NSObject {
	GameView *view;
	
	int displayWidth;
	int displayHeight;
	DisplayOrientation displayOrientation;
	GestureType enabledGestures;
	
	NSMutableSet *addTouches;
	NSMutableSet *removeTouches;
	NSMutableSet *releaseTouches;
	NSMutableSet *lateReleaseTouches;
	NSMutableDictionary *touchLocations;
	NSMutableDictionary *uiTouchesForLocations;
}

@property (nonatomic) int displayWidth;
@property (nonatomic) int displayHeight;
@property (nonatomic) DisplayOrientation displayOrientation;
@property (nonatomic) GestureType enabledGestures;
@property (nonatomic, readonly) BOOL isGestureAvailable;

+ (TouchCollection*) getState;
+ (GestureSample*) readGesture;

+ (TouchPanel*) getInstance;

- (TouchCollection*) getState;
- (GestureSample*) readGesture;

@end
