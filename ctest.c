/* * Test File for Treesitter Syntax Highlighting
 * Look for different colors for types, macros, and functions.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Macros usually appear in a distinct color (often purple or orange)
#define MAX_BUFFER_SIZE 1024
#define STATUS_OK 0

// Struct definitions
typedef struct {
    int id;
    char *name;
    float value;
} Item;

// Function prototype
void process_item(Item *item);

int main(int argc, char *argv[]) {
    // Keywords (int, return, if) should be distinct
    int counter = 0;
    
    // Strings should be a unique color (often green or yellow)
    printf("Starting Treesitter Test...\n");

    // Dynamic allocation
    Item *my_item = (Item *)malloc(sizeof(Item));

    if (my_item == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        fprintf(stderr, "mama");
        return 1;
    }

    // Struct member access
    my_item->id = 1;
    my_item->name = "Test Item";
    my_item->value = 99.99;

    // Loops
    for (int i = 0; i < 5; i++) {
        counter += i;
        process_item(my_item);
    }

    free(my_item);
    return STATUS_OK;
}

// Function definition
void process_item(Item *item) {
    // 'item' (parameter) should look different than 'id' (property)
    if (item->value > 50.0) {
        printf("Processing large item: %s\n", item->name);
        printf("hi etash");
    }
}
