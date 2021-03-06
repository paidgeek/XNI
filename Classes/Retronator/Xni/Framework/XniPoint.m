//
//  XniPoint.m
//  XNI
//
//  Created by Matej Jan on 8.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "XniPoint.h"


@implementation XniPoint

// CONSTRUCTORS

- (id) initWithIntX:(int)x y:(int)y {
	if (self = [super init]) {
		data = PointMake(x, y);
	}
	return self;
}

- (id) initWithPointStruct:(PointStruct*) pointStruct {
	if (self = [super init]) {
		data = *pointStruct;
	}
	return self;
}

- (id) initWithPoint:(XniPoint*) point {
	return [self initWithPointStruct:point.data];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    return [self initWithIntX:[aDecoder decodeIntForKey:@"x"] y:[aDecoder decodeIntForKey:@"y"]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:data.x forKey:@"x"];
    [aCoder encodeInt:data.y forKey:@"y"];
}

+ (XniPoint*) pointWithX:(int)x y:(int)y {
	return [[[XniPoint alloc] initWithIntX:x y:y] autorelease];
}

+ (XniPoint*) pointWithStruct:(PointStruct*) pointStruct {
	return [[[XniPoint alloc] initWithPointStruct:pointStruct] autorelease];
}

+ (XniPoint*) pointWithPoint:(XniPoint*) point {
	return [[[XniPoint alloc] initWithPoint:point] autorelease];
}

+ (XniPoint*) pointWithCGPoint:(CGPoint) cgPoint {
	return [XniPoint pointWithX:cgPoint.x y:cgPoint.y];
}

// PROPERTIES

- (int) x {return data.x;}
- (void) setX:(int)value {data.x = value;}

- (int) y {return data.y;}
- (void) setY:(int)value {data.y = value;}

- (PointStruct*) data {return &data;}

// METHODS

+ (XniPoint *)add:(XniPoint *)value1 to:(XniPoint *)value2 {
    PointStruct resultData;
    PointAdd(value1.data, value2.data, &resultData);
    return [XniPoint pointWithStruct:&resultData];
}

+ (XniPoint *)subtract:(XniPoint *)value1 by:(XniPoint *)value2 {
    PointStruct resultData;
    PointSubtract(value1.data, value2.data, &resultData);
    return [XniPoint pointWithStruct:&resultData];
}

- (XniPoint*) set:(XniPoint*)value {
	data = *value.data;
	return self;
}

- (XniPoint *)add:(XniPoint *)value {
    PointAdd(&data, value.data, &data);
    return self;
}

- (XniPoint *)subtract:(XniPoint *)value {
    PointSubtract(&data, value.data, &data);
    return self;
}

- (id) copyWithZone:(NSZone *)zone {
	return [[XniPoint allocWithZone:zone] initWithPointStruct:&data];
}

- (BOOL) equals:(XniPoint*)point {
	if (!point) return NO;
	return point.data->x == data.x && point.data->y == data.y;
}

- (BOOL) isEqual:(id)object {
    if ([object isKindOfClass:[XniPoint class]]) {
        return [self equals:object];
    }
    return NO;
}

- (NSUInteger) hash {
    return data.x ^ data.y;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"Point(%i, %i)", data.x, data.y];
}

// CONSTANTS

+ (XniPoint*) zero {return [XniPoint pointWithX:0 y:0];}

@end
