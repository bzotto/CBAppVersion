//
// CBAppVersion.m
//
// Copyright (c) 2010 Ben Zotto
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//

#import "CBAppVersion.h"

@implementation CBAppVersion
@synthesize major, minor, subminor;

+ (CBAppVersion *)versionFromString:(NSString *)versionString
{
    return [[[CBAppVersion alloc] initWithString:versionString] autorelease];
}

// designated initializer
- (id)initWithMajor:(NSUInteger)majorVersion minor:(NSUInteger)minorVersion subminor:(NSUInteger)subminorVersion;
{
    if (self = [super init]) {
        major = majorVersion;
        minor = minorVersion;
        subminor = subminorVersion;
    }
    return self;
}

- (id)initWithString:(NSString *)versionString
{
    NSArray * parts = [versionString componentsSeparatedByString: @"."];
    if ([parts count] < 2 || [parts count] > 3) {
        [NSException raise:@"Invalid version string" format:@"Format of %@ is not valid.", versionString];        
    }
    
    NSUInteger majorVersion = (NSUInteger)[[parts objectAtIndex:0] integerValue];
    NSUInteger minorVersion = (NSUInteger)[[parts objectAtIndex:1] integerValue];
    NSUInteger subminorVersion = 0;
    if ([parts count] == 3) {
        subminorVersion = (NSUInteger)[[parts objectAtIndex:2] integerValue];
    }
    return [self initWithMajor:majorVersion minor:minorVersion subminor:subminorVersion];    
}

- (NSComparisonResult)compare:(CBAppVersion *)version
{
    if ([self major] < [version major]) {
        return NSOrderedAscending;
    }
    if ([self major] > [version major]) {
        return NSOrderedDescending;
    }
    if ([self minor] < [version minor]) {
        return NSOrderedAscending;
    }
    if ([self minor] > [version minor]) {
        return NSOrderedDescending;
    }
    if ([self subminor] < [version subminor]) {
        return NSOrderedAscending;
    }
    if ([self subminor] > [version subminor]) {
        return NSOrderedDescending;
    }    
    return NSOrderedSame;
}

- (BOOL)isEarlierThanVersion:(CBAppVersion *)version
{
    return ([self compare:version] == NSOrderedAscending);
}

- (BOOL)isLaterThanVersion:(CBAppVersion *)version
{
    return ([self compare:version] == NSOrderedDescending);    
}

- (NSString *)versionString
{
    if (subminor != 0) {
        return [NSString stringWithFormat:@"%d.%d.%d", major, minor, subminor];        
    } else {
        return [NSString stringWithFormat:@"%d.%d", major, minor];
    }
}

- (BOOL)isEqual:(id)anObject
{
    return ([anObject isKindOfClass:[CBAppVersion class]] &&
            [self compare:anObject] == NSOrderedSame);
}

- (NSUInteger)hash
{
    // This doesn't uniquefy, but works fine as a hash value.
    return (major * 1000) + (minor * 100) + (subminor * 10);
}

- (NSString *)description
{
    return [self versionString];
}

@end
