#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char in_path[256], out_path[256], linia[64];
    FILE *data_file = NULL, *output_file = NULL;
    double val;
    int number = 0;

    printf("Podaj nazwe pliku wraz z lokalizacja (np. C:\\folder\\plik.txt lub /home/user/plik.txt):\n");
    if (fgets(in_path, sizeof(in_path), stdin) == NULL) {
        printf("Blad odczytu wejscia.\n");
        return 1;
    }
    in_path[strcspn(in_path, "\n")] = 0;

    errno_t blad_dane = fopen_s(&data_file, in_path, "r");
    if (blad_dane != 0 || data_file == NULL) {
        printf("Blad: Nie mozna otworzyc pliku. Upewnij sie, ze in_path jest poprawna.\n");
        return 1;
    }

    //--------------

    printf("Podaj nazwe nowego pliku (np. C:\\folder\\nowy_plik.txt):\n");
    if (fgets(out_path, sizeof(out_path), stdin) == NULL) {
        printf("Blad odczytu wejscia.\n");
        return 1;
    }
    out_path[strcspn(out_path, "\n")] = 0;

    errno_t blad_wejscie = fopen_s(&output_file, out_path, "w");
    if (blad_wejscie != 0 || output_file == NULL) {
        printf("Blad: Nie mozna otworzyc pliku. Upewnij sie, ze in_path jest poprawna.\n");
        return 1;
    }

    fprintf(output_file, "x\ty\tz\n");

    while (fgets(linia, sizeof(linia), data_file) != NULL) {
        for (int i = 0; linia[i]; i++) if (linia[i] == ',') linia[i] = '.';

        if (sscanf_s(linia, "%lf", &val) == 1) {
            number++;
            if (number % 3 == 1) fprintf(output_file, "%g", val);
            else if (number % 3 == 2) fprintf(output_file, "\t%g", val);
            else fprintf(output_file, "\t%g\n", val);
        }
    }

    if (number % 3 != 0) fprintf(output_file, "\n");

    fclose(data_file);
    fclose(output_file);

    printf("Przetwarzanie zakoñczone sukcesem!\n");
    return 0;
}