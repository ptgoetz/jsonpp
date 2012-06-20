//
//  main.m
//  jsonpp
//
//  Created by P. Taylor Goetz on 6/20/12.
//  Copyright (c) 2012 InstanceOne, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        if(argc > 2){
            printf("Usage: %s [file]\n", argv[0]);
            return 1;
        }
        
        NSLog(@"Argument count: %i", argc);
        for (int i = 0; i < argc; i++) {
            NSLog(@"argv[%i] %s", i, argv[i]);
            NSString* arg = [[NSString alloc ] initWithCString:argv[i]encoding:NSUTF8StringEncoding];
            NSLog(@"Current arg: %@", arg);
        }
        
        NSData* dataIn = nil;
        NSString* str = nil;
        if(argc == 2){
            NSString* file = [[NSString alloc ] initWithCString:argv[1]encoding:NSUTF8StringEncoding];
            NSString* str = [[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
            dataIn = [str dataUsingEncoding:NSUTF8StringEncoding];
        } else {
            dataIn = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
        }
        
        NSError *theError = nil;
        NSData* jsonDataIn = [NSJSONSerialization JSONObjectWithData:dataIn options:NSJSONReadingAllowFragments error:&theError];
        
        if(theError == nil){
            NSData* jsonDataOut = [NSJSONSerialization dataWithJSONObject:jsonDataIn 
                                                                  options:NSJSONWritingPrettyPrinted error:&theError];
            str = [[NSString alloc] initWithData:jsonDataOut encoding:NSUTF8StringEncoding];
            const char* c = [str UTF8String];
            
            printf("%s\n", c);
            return 0;
        } else{
            printf("Parse Error: %s\n", [[[theError userInfo] valueForKey:@"NSDebugDescription"] UTF8String]);
            return 1;
        }
        
    }
}

