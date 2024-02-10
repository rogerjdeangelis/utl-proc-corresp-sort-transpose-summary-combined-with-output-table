%let pgm=utl-proc-corresp-sort-transpose-summary-combined-with-output-table;

Proc corresp sort transpose summary combined with output table

github
http://tinyurl.com/5e9vssdd
https://github.com/rogerjdeangelis/utl-proc-corresp-sort-transpose-summary-combined-with-output-table

Most sas procrdures that do crosstabs do not create a fat output dataset

Related Repos

https://github.com/rogerjdeangelis/utl-create-a-state-diagram-table-hash-corresp-and-transpose
https://github.com/rogerjdeangelis/utl-crosstab-output-tables-from-corresp-report-not-static-tabulate
https://github.com/rogerjdeangelis/utl-minimum-code-for-a-crosstab-output_dataset-with-sums-using-proc-corresp
https://github.com/rogerjdeangelis/utl-three-dimensional-crosstab-proc-freq-tabulate-corresp-and-report
https://github.com/rogerjdeangelis/utl-transposing-sorting-and-summarizing-with-a-single-proc-corresp-freq-tabulate-and-report
https://github.com/rogerjdeangelis/utl-use-freq-and-corresp-table-output-to-avoid-tabulate-static-printouts
https://github.com/rogerjdeangelis/utl_compare_corresp_vs_report_output_datasets
https://github.com/rogerjdeangelis/utl_proc_corresp_crosstab

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  WORK.HAVE TOTAL OBS=19                         PROCESS                                      OUTPUT                    */
/*                                                                                                                        */
/*  Obs Address Account Period Amount     Ods Output Observed=want            Expenses        Jan    Jul    Mar    Sum    */
/*                                           (Rename=Label=Expenses);                                                     */
/*    1  Apt1    Rent    Jan     450      Proc Corresp                        Apt1 * Food     100     65     35    200    */
/*    2  Apt1    Food    Jan     100        Data=have                         Apt1 * Fuel     150     15     50    215    */
/*    3  Apt1    Fuel    Jan      50        Observed                          Apt1 * Rent     450    450    350   1250    */
/*    4  Apt1    Rent    Jul     450        dimens=1                          Apt2 * Food      60     80    100    240    */
/*    5  Apt1    Fuel    Jul      15        cross=row;                        Apt2 * Fuel     600     60     55    715    */
/*    6  Apt1    Food    Jul      65         Tables address account, period;  Apt2 * Rent     600    600    700   1900    */
/*    7  Apt1    Fuel    Mar      50         weight amount;                                                               */
/*    8  Apt1    Food    Mar      35      Run;                                Sum            1960   1270   1290   4520    */
/*    9  Apt1    Rent    Mar     350      Ods Select All;                                                                 */
/*   10  Apt1    Fuel    Jan     100      proc print data=want;                                                           */
/*   11  Apt2    Rent    Jan     600      run;                                                                            */
/*   12  Apt2    Fuel    Jan     600                                                                                      */
/*   13  Apt2    Food    Jan      60                                                                                      */
/*   14  Apt2    Food    Jul      80                                                                                      */
/*   15  Apt2    Rent    Jul     600                                                                                      */
/*   16  Apt2    Fuel    Jul      60                                                                                      */
/*   17  Apt2    Rent    Mar     700                                                                                      */
/*   18  Apt2    Fuel    Mar      55                                                                                      */
/*   19  Apt2    Food    Mar     100                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data have;
 input Address$ Account$ Period$ Amount;
cards4;
Apt1 Rent Jan 450
Apt1 Food Jan 100
Apt1 Fuel Jan 50
Apt1 Rent Jul 450
Apt1 Fuel Jul 15
Apt1 Food Jul 65
Apt1 Fuel Mar 50
Apt1 Food Mar 35
Apt1 Rent Mar 350
Apt1 Fuel Jan 100
Apt2 Rent Jan 600
Apt2 Fuel Jan 600
Apt2 Food Jan 60
Apt2 Food Jul 80
Apt2 Rent Jul 600
Apt2 Fuel Jul 60
Apt2 Rent Mar 700
Apt2 Fuel Mar 55
Apt2 Food Mar 100
;;;;
run;quit;

/*         _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| `_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

*/

Ods Output Observed=want
   (Rename=Label=Expenses);
Proc Corresp
  Data=have
  Observed
  dims=1
  cross=row;
   Tables address account, period;
   weight amount;
Run;
Ods Select All;
proc print data=want;
run;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                     OUTPUT                                                                                             */
/*                                                                                                                        */
/*   Expenses        Jan    Jul    Mar    Sum                                                                             */
/*                                                                                                                        */
/*   Apt1 * Food     100     65     35    200                                                                             */
/*   Apt1 * Fuel     150     15     50    215                                                                             */
/*   Apt1 * Rent     450    450    350   1250                                                                             */
/*   Apt2 * Food      60     80    100    240                                                                             */
/*   Apt2 * Fuel     600     60     55    715                                                                             */
/*   Apt2 * Rent     600    600    700   1900                                                                             */
/*                                                                                                                        */
/*   Sum            1960   1270   1290   4520                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
