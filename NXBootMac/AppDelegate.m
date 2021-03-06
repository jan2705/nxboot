/**
 * @file app delegate
 * @author Oliver Kuckertz <oliver.kuckertz@mologie.de>
 */

#import "AppDelegate.h"

@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;

@interface AppDelegate ()
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {}

- (void)applicationWillTerminate:(NSNotification *)aNotification {}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

#pragma mark - Core Data Stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    if (_persistentContainer == nil) {
        @synchronized (self) {
            if (_persistentContainer == nil) {
                [self createPersistentContainer];
            }
        }
    }
    return _persistentContainer;
}

- (void)createPersistentContainer {
    _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
    [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
        if (error) {
            // Typical reasons for an error here include:
            // * The parent directory does not exist, cannot be created, or disallows writing.
            // * The persistent store is not accessible, due to permissions or data protection when the device is locked.
            // * The device is out of space.
            // * The store could not be migrated to the current model version.
            /*
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't Create Database"
                                                                           message:error.localizedDescription
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Quit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                exit(1);
            }]];
            [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
            */
            exit(1);
        }
    }];
}

@end
