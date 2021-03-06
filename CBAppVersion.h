//
// CBAppVersion.h
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

#import <Foundation/Foundation.h>

//
// CBAppVersion is a simple class that represents an immutable application version, with a 
// major and minor version, and an optional subminor version. The subminor version is
// assumed to be zero when not otherwise given, and is omitted from printing when zero
// Version strings are in the form "x.y.z", where x, y, and z must all be unsigned integers 
// (z is optional). Badly-formatted input will either except or parse as zeros, depending.
//

@interface CBAppVersion : NSObject 
{
    @private
    NSUInteger major;
    NSUInteger minor;
    NSUInteger subminor;
}
@property (nonatomic, readonly) NSUInteger major;
@property (nonatomic, readonly) NSUInteger minor;
@property (nonatomic, readonly) NSUInteger subminor;

+ (CBAppVersion *)versionFromString:(NSString *)versionString;
- (id)initWithString:(NSString *)versionString;
- (id)initWithMajor:(NSUInteger)majorVersion minor:(NSUInteger)minorVersion subminor:(NSUInteger)subminorVersion;

- (NSComparisonResult)compare:(CBAppVersion *)version;
- (BOOL)isEarlierThanVersion:(CBAppVersion *)version;
- (BOOL)isLaterThanVersion:(CBAppVersion *)version;
- (NSString *)versionString;

// NSObject protocol
- (BOOL)isEqual:(id)anObject;
- (NSUInteger)hash;
- (NSString *)description;
@end
