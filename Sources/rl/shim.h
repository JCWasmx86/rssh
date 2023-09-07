#ifndef __CLIBRL_SHIM_H__
#define __CLIBRL_SHIM_H__

#include <stdio.h>
#include <readline/readline.h>
#include <readline/history.h>

static char *rssh_previous_history(void)
{
  HIST_ENTRY* last_item = previous_history();
  if (!last_item)
      return NULL;
  return last_item->line != NULL ? strdup(last_item->line) : NULL;
}
#endif
