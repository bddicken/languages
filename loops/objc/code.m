#import <Foundation/Foundation.h> 
  
int main(int argc, const char * argv[]) { 
    int u = [[NSString stringWithUTF8String:argv[1]] intValue];
    int r = arc4random() % 10000;            
    
    NSMutableArray *a = [NSMutableArray arrayWithCapacity:10000];
    for (int i = 0; i < 10000; i++) {
        [a addObject: @0];
    }
    
    for (int i = 0; i < 10000; i++) {    
        for (int j = 0; j < 100000; j++) { 
            a[i] = @([a[i] intValue] + j % u);
        }
        a[i] = @([a[i] intValue] + r);
    }
    NSLog(@"%d\n", [a[r] intValue]);

    return 0; 
} 

