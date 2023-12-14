#define XPLM200
#define XPLM210

#if XPLM_MIN >= 300
#define XPLM300
#endif

#if XPLM_MIN >= 301
#define XPLM301
#endif

#if XPLM_MIN >= 303
#define XPLM303
#endif

#if XPLM_MIN >= 400
#define XPLM400
#endif

#include <XPLMDefs.h>

#if XPLM_MIN > kXPLM_Version
#error "The requested minimum XPLM version is higher than what this SDK provides!"
#endif

#include <XPLMCamera.h>
#include <XPLMDataAccess.h>
#include <XPLMDisplay.h>
#include <XPLMGraphics.h>
#include <XPLMInstance.h>
#include <XPLMMap.h>
#include <XPLMMenus.h>
#include <XPLMNavigation.h>
#include <XPLMPlanes.h>
#include <XPLMPlugin.h>
#include <XPLMProcessing.h>
#include <XPLMScenery.h>
#include <XPLMSound.h>
#include <XPLMUtilities.h>
#include <XPLMWeather.h>

#include <XPStandardWidgets.h>
#include <XPUIGraphics.h>
#include <XPWidgetDefs.h>
#include <XPWidgets.h>
#include <XPWidgetUtils.h>
