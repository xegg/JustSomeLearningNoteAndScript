#include<locale.h>
#include<stdio.h>
#include <stdlib.h>
#include <string.h>

/*int main(void)*/
/*{*/
  /*struct lconv locale_structure;*/
  /*struct lconv *locale_ptr=&locale_structure;*/

  /*locale_ptr=localeconv();*/
  /*locale_ptr->decimal_point = "--";*/
  /*printf("Decimal point:                   %f%s\n",123.56,locale_ptr->decimal_point);*/
  /*printf("Thousands Separator:             %s\n",locale_ptr->thousands_sep);*/
  /*printf("Grouping:                        %s\n",locale_ptr->grouping);*/
  /*printf("International Currency Symbol:   %s\n",locale_ptr->int_curr_symbol);*/
  /*printf("Currency Symbol:                 %s\n",locale_ptr->currency_symbol);*/
  /*printf("Monetary Decimal Point:          %s\n",locale_ptr->mon_decimal_point);*/
  /*printf("Monetary Thousands Separator:    %s\n",locale_ptr->mon_thousands_sep);*/
  /*printf("Monetary Grouping:               %s\n",locale_ptr->mon_grouping);*/
  /*printf("Monetary Positive Sign:          %s\n",locale_ptr->positive_sign);*/
  /*printf("Monetary Negative Sign:          %s\n",locale_ptr->negative_sign);*/
  /*printf("Monetary Intl Decimal Digits:    %c\n",locale_ptr->int_frac_digits);*/
  /*printf("Monetary Decimal Digits:         %c\n",locale_ptr->frac_digits);*/
  /*printf("Monetary + Precedes:             %c\n",locale_ptr->p_cs_precedes);*/
  /*printf("Monetary + Space:                %c\n",locale_ptr->p_sep_by_space);*/
  /*printf("Monetary - Precedes:             %c\n",locale_ptr->n_cs_precedes);*/
  /*printf("Monetary - Space:                %c\n",locale_ptr->n_sep_by_space);*/
  /*printf("Monetary + Sign Posn:            %c\n",locale_ptr->p_sign_posn);*/
  /*printf("Monetary - Sign Posn:            %c\n",locale_ptr->n_sign_posn);*/
/*}*/

char *countries[] =
{
   "US",
   "ITALY",
   "NORWAY",
   "CHINA",
    NULL
};

void main()
{
  char *loc;
  char *currency;
  int i;
  struct lconv *lcptr;
  int money = 100; /* Something to display */

  /* setlocale can be called with a NULL
     locale to check on its current setting
   */
  loc = setlocale(LC_ALL, NULL);
  printf("The default locale is the \"%s\" locale\n", loc);

  for (i = 0; countries[i]; i++)
  {
    loc = setlocale(LC_ALL, countries[i]);
    lcptr = localeconv();
    currency = malloc(strlen(lcptr->currency_symbol) + 1);
    strcpy(currency, lcptr->currency_symbol);
    if (loc)
      printf("Monetary figure for %s locale: %s%d\n", loc, currency, money);
    free(currency);
 }
}
