//
//  NSString+Utils.m
//  BeardedSpice
//
//  Created by Roman Sokolov on 14.03.15.
//  Copyright (c) 2015 Tyler Rhodes / Jose Falcon. All rights reserved.
//

#import "NSString+Utils.h"

// FIXME change filename to match namespacing of category
@implementation NSString (BSUtils)

#pragma mark - Query Operations

+ (BOOL)isNullOrEmpty:(NSString *)str {
    return (!str || [str length] == 0);
}

+ (BOOL)isNullOrWhiteSpace:(NSString *)str {
    return (!str ||
            [[str stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]] length] == 0);
}

+ (NSString *)stringByTrim:(NSString *)str {
    // TODO: WARINING
    // Old (commented) variant may be true
    // return [str stringByTrimmingCharactersInSet:[NSCharacterSet
    // whitespaceCharacterSet]];
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)trimToLength:(NSInteger)max
{
    if ([self length] > max) {
        return [NSString stringWithFormat:@"%@...", [self substringToIndex:(max - 3)]];
    }
    return [self substringToIndex: [self length]];
}

- (NSInteger)indexOf:(NSString *)string fromIndex:(NSUInteger)index {
    NSRange range =
        [self rangeOfString:string
                    options:NSLiteralSearch
                      range:NSMakeRange(index, self.length - index)];

    if (range.location == NSNotFound)
        return -1;
    return range.location;
}
- (NSInteger)indexOf:(NSString *)string {
    return [self indexOf:string fromIndex:0];
}

- (BOOL)contains:(NSString * _Nonnull)str caseSensitive:(BOOL)sensitive {
    if (sensitive)
        return ([self rangeOfString:str]).location != NSNotFound;

    return ([self rangeOfString:str options:NSCaseInsensitiveSearch]) .location != NSNotFound;
}

- (NSString * _Nonnull)addExecutionStringToScript
{
    // TODO add checks before hand to make sure we don't double execute
    // TODO add checks before hand ot make sure this is actually a func
    return [[NSString alloc] initWithFormat:@"(%@)();", self];
}

- (NSString *_Nonnull)stringForSubstitutionInJavascriptPlaceholder{

    NSString *sb = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    sb = [sb stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    sb = [sb stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
    return [sb stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}


@end
