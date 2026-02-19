#include <cstdio>
#include <cstdlib>

int main(int argc, char** argv) {
    if (argc < 3) {
        std::printf("Missing file arguments.\n");
        return 1;
    }
    char* output_file = argv[1];
    char* data_string = argv[2];

    FILE *fp = fopen(output_file, "w");
    if (fp == 0) {
        std::printf("Bad file handle.\n");
    }
    fprintf(fp, data_string);
    fprintf(fp, "\n");
    fclose(fp);
}
