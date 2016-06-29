#include "smsh1.h"

extern int process(char **arglist) {
  int rv = 0;

  if (arglist == NULL)
    rv = 0;
  else if (is_control_command(arglist[0]))
    rv = do_control_command(arglist);
  else if (ok_to_execute()){
      if(!builtin_command(arglist, &rv))
            rv = execute(arglist);
  }

  return rv;
}
