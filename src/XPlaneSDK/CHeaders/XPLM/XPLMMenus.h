#ifndef _XPLMMenus_h_
#define _XPLMMenus_h_

/*
 * Copyright 2005-2022 Laminar Research, Sandy Barbour and Ben Supnik All
 * rights reserved.  See license.txt for usage. X-Plane SDK Version: 4.0.0
 *
 */

/***************************************************************************
 * XPLMMenus
 ***************************************************************************/
/*
 * Plug-ins can create menus in the menu bar of X-Plane.  This is done by
 * creating a menu and then creating items.  Menus are referred to by an
 * opaque ID.  Items are referred to by (zero-based) index number.
 * 
 * Menus are "sandboxed" between plugins - no plugin can access the menus of
 * any other plugin. Furthermore, all menu indices are relative to your
 * plugin's menus only; if your plugin creates two sub-menus in the Plugins
 * menu at different times, it doesn't matter how many other plugins also
 * create sub-menus of Plugins in the intervening time: your sub-menus will be
 * given menu indices 0 and 1. (The SDK does some work in the back-end to
 * filter out menus that are irrelevant to your plugin in order to deliver
 * this consistency for each plugin.)
 * 
 * When you create a menu item, you specify how we should handle clicks on
 * that menu item. You can either have the XPLM trigger a callback (the
 * XPLMMenuHandler_f associated with the menu that contains the item), or you
 * can simply have a command be triggered (with no associated call to your
 * menu handler). The advantage of the latter method is that X-Plane will
 * display any keyboard shortcuts associated with the command. (In contrast,
 * there are no keyboard shortcuts associated with menu handler callbacks with
 * specific parameters.)
 * 
 * Menu text in X-Plane is UTF8; X-Plane's character set covers latin, greek
 * and cyrillic characters, Katakana, as well as some Japanese symbols. Some
 * APIs have a inDeprecatedAndIgnored parameter that used to select a
 * character set; since X-Plane 9 all localization is done via UTF-8 only.
 *
 */

#include "XPLMDefs.h"
#include "XPLMUtilities.h"

#ifdef __cplusplus
extern "C" {
#endif

/***************************************************************************
 * XPLM MENUS
 ***************************************************************************/

/*
 * XPLMMenuCheck
 * 
 * These enumerations define the various 'check' states for an X-Plane menu. 
 * 'Checking' in X-Plane actually appears as a light which may or may not be
 * lit.  So there are three possible states.
 *
 */

typedef enum {
  /* There is no symbol to the left of the menu item. */
  xplm_Menu_NoCheck = 0,

  /* The menu has a mark next to it that is unmarked (not lit). */
  xplm_Menu_Unchecked = 1,

  /* The menu has a mark next to it that is checked (lit). */
  xplm_Menu_Checked = 2,
} XPLMMenuCheck;

/*
 * XPLMMenuID
 * 
 * This is a unique ID for each menu you create.
 *
 */
typedef void * XPLMMenuID;

/*
 * XPLMMenuHandler_f
 * 
 * A menu handler function takes two reference pointers, one for the menu
 * (specified when the menu was created) and one for the item (specified when
 * the item was created).
 *
 */
typedef void (* XPLMMenuHandler_f)(
                         void *               inMenuRef,
                         void *               inItemRef);

/*
 * XPLMFindPluginsMenu
 * 
 * This function returns the ID of the plug-ins menu, which is created for you
 * at startup.
 *
 */
XPLM_API XPLMMenuID XPLMFindPluginsMenu(void);

#if defined(XPLM300)
/*
 * XPLMFindAircraftMenu
 * 
 * This function returns the ID of the menu for the currently-loaded aircraft,
 * used for showing aircraft-specific commands.
 * 
 * The aircraft menu is created by X-Plane at startup, but it remains hidden
 * until it is populated via XPLMAppendMenuItem() or
 * XPLMAppendMenuItemWithCommand().
 * 
 * Only plugins loaded with the user's current aircraft are allowed to access
 * the aircraft menu. For all other plugins, this will return NULL, and any
 * attempts to add menu items to it will fail.
 *
 */
XPLM_API XPLMMenuID XPLMFindAircraftMenu(void);
#endif /* XPLM300 */

/*
 * XPLMCreateMenu
 * 
 * This function creates a new menu and returns its ID.  It returns NULL if
 * the menu cannot be created.  Pass in a parent menu ID and an item index to
 * create a submenu, or NULL for the parent menu to put the menu in the menu
 * bar.  The menu's name is only used if the menu is in the menubar.  You also
 * pass a handler function and a menu reference value. Pass NULL for the
 * handler if you do not need callbacks from the menu (for example, if it only
 * contains submenus).
 * 
 * Important: you must pass a valid, non-empty menu title even if the menu is
 * a submenu where the title is not visible.
 *
 */
XPLM_API XPLMMenuID XPLMCreateMenu(
                         const char *         inName,
                         XPLMMenuID           inParentMenu,
                         int                  inParentItem,
                         XPLMMenuHandler_f    inHandler,
                         void *               inMenuRef);

/*
 * XPLMDestroyMenu
 * 
 * This function destroys a menu that you have created.  Use this to remove a
 * submenu if necessary.  (Normally this function will not be necessary.)
 *
 */
XPLM_API void       XPLMDestroyMenu(
                         XPLMMenuID           inMenuID);

/*
 * XPLMClearAllMenuItems
 * 
 * This function removes all menu items from a menu, allowing you to rebuild
 * it.  Use this function if you need to change the number of items on a menu.
 *
 */
XPLM_API void       XPLMClearAllMenuItems(
                         XPLMMenuID           inMenuID);

/*
 * XPLMAppendMenuItem
 * 
 * This routine appends a new menu item to the bottom of a menu and returns
 * its index. Pass in the menu to add the item to, the items name, and a void
 * * ref for this item.
 * 
 * Returns a negative index if the append failed (due to an invalid parent
 * menu argument).
 * 
 * Note that all menu indices returned are relative to your plugin's menus
 * only; if your plugin creates two sub-menus in the Plugins menu at different
 * times, it doesn't matter how many other plugins also create sub-menus of
 * Plugins in the intervening time: your sub-menus will be given menu indices
 * 0 and 1. (The SDK does some work in the back-end to filter out menus that
 * are irrelevant to your plugin in order to deliver this consistency for each
 * plugin.)
 *
 */
XPLM_API int        XPLMAppendMenuItem(
                         XPLMMenuID           inMenu,
                         const char *         inItemName,
                         void *               inItemRef,
                         int                  inDeprecatedAndIgnored);

#if defined(XPLM300)
/*
 * XPLMAppendMenuItemWithCommand
 * 
 * Like XPLMAppendMenuItem(), but instead of the new menu item triggering the
 * XPLMMenuHandler_f of the containiner menu, it will simply execute the
 * command you pass in. Using a command for your menu item allows the user to
 * bind a keyboard shortcut to the command and see that shortcut represented
 * in the menu.
 * 
 * Returns a negative index if the append failed (due to an invalid parent
 * menu argument).
 * 
 * Like XPLMAppendMenuItem(), all menu indices are relative to your plugin's
 * menus only.
 *
 */
XPLM_API int        XPLMAppendMenuItemWithCommand(
                         XPLMMenuID           inMenu,
                         const char *         inItemName,
                         XPLMCommandRef       inCommandToExecute);
#endif /* XPLM300 */

/*
 * XPLMAppendMenuSeparator
 * 
 * This routine adds a separator to the end of a menu.
 * 
 * Returns a negative index if the append failed (due to an invalid parent
 * menu argument).
 *
 */
XPLM_API void       XPLMAppendMenuSeparator(
                         XPLMMenuID           inMenu);

/*
 * XPLMSetMenuItemName
 * 
 * This routine changes the name of an existing menu item.  Pass in the menu
 * ID and the index of the menu item.
 *
 */
XPLM_API void       XPLMSetMenuItemName(
                         XPLMMenuID           inMenu,
                         int                  inIndex,
                         const char *         inItemName,
                         int                  inDeprecatedAndIgnored);

/*
 * XPLMCheckMenuItem
 * 
 * Set whether a menu item is checked.  Pass in the menu ID and item index.
 *
 */
XPLM_API void       XPLMCheckMenuItem(
                         XPLMMenuID           inMenu,
                         int                  index,
                         XPLMMenuCheck        inCheck);

/*
 * XPLMCheckMenuItemState
 * 
 * This routine returns whether a menu item is checked or not. A menu item's
 * check mark may be on or off, or a menu may not have an icon at all.
 *
 */
XPLM_API void       XPLMCheckMenuItemState(
                         XPLMMenuID           inMenu,
                         int                  index,
                         XPLMMenuCheck *      outCheck);

/*
 * XPLMEnableMenuItem
 * 
 * Sets whether this menu item is enabled.  Items start out enabled.
 *
 */
XPLM_API void       XPLMEnableMenuItem(
                         XPLMMenuID           inMenu,
                         int                  index,
                         int                  enabled);

#if defined(XPLM210)
/*
 * XPLMRemoveMenuItem
 * 
 * Removes one item from a menu.  Note that all menu items below are moved up
 * one; your plugin must track the change in index numbers.
 *
 */
XPLM_API void       XPLMRemoveMenuItem(
                         XPLMMenuID           inMenu,
                         int                  inIndex);
#endif /* XPLM210 */

#ifdef __cplusplus
}
#endif

#endif
