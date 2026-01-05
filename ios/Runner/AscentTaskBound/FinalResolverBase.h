#import "LiteStandaloneMetadata.h"
#import "ReadSecondDependency.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FinalResolverBase : NSObject


- (void) loadImplementIntoText;

- (void) attachEphemeralCache;

@end

NS_ASSUME_NONNULL_END
        