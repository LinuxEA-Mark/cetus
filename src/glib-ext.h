#ifndef _GLIB_EXT_H_
#define _GLIB_EXT_H_

#include <glib.h>
#include "config.h"
#include "chassis-exports.h"

#ifndef USE_GLIB_DEBUG_LOG

/* default: define g_debug() to nothing */
#ifdef g_debug
#undef g_debug
#define g_debug(...)
#endif /* g_debug */

#endif /* USE_G_DEBUG_LOG */

CHASSIS_API void g_string_true_free(gpointer data);

CHASSIS_API gboolean g_hash_table_true(gpointer key, gpointer value, gpointer user_data);
CHASSIS_API guint    g_hash_table_string_hash(gconstpointer _key);
CHASSIS_API gboolean g_hash_table_string_equal(gconstpointer _a, gconstpointer _b);
CHASSIS_API void     g_hash_table_string_free(gpointer data);

CHASSIS_API GString *g_string_dup(GString *);

CHASSIS_API gboolean strleq(const gchar *a, gsize a_len, const gchar *b, gsize b_len);

CHASSIS_API void ge_gtimeval_diff(GTimeVal *old, GTimeVal *new, gint64 *delay);
CHASSIS_API GString *g_string_assign_len(GString *s, const char *, gsize);
CHASSIS_API void g_debug_hexdump(const char *msg, const void *s, size_t len);

#endif