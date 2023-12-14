const std = @import("std");
const config = @import("config");
const xplm = @import("./xplm.zig");

pub const WidgetID = ?*anyopaque;
pub const PropertyID = enum(c_int) {
    refcon = 0,
    dragging = 1,
    drag_x_off = 2,
    drag_y_off = 3,
    hilited = 4,
    object = 5,
    clip = 6,
    enabled = 7,
    user_start = 10000,
    _,
};
pub const MouseState = extern struct {
    x: c_int = std.mem.zeroes(c_int),
    y: c_int = std.mem.zeroes(c_int),
    button: c_int = std.mem.zeroes(c_int),
    delta: c_int = std.mem.zeroes(c_int),
};
pub const KeyState = extern struct {
    key: u8 = std.mem.zeroes(u8),
    flags: xplm.KeyFlags = std.mem.zeroes(xplm.KeyFlags),
    vkey: u8 = std.mem.zeroes(u8),
};
pub const WidgetGeometryChange = extern struct {
    dx: c_int = std.mem.zeroes(c_int),
    dy: c_int = std.mem.zeroes(c_int),
    dwidth: c_int = std.mem.zeroes(c_int),
    dheight: c_int = std.mem.zeroes(c_int),
};
pub const DispatchMode = enum(c_int) {
    direct = 0,
    up_chain = 1,
    recursive = 2,
    direct_all_callbacks = 3,
    once = 4,
    _,
};
pub const XPWidgetClass = c_int;
pub const xpMsg_None: c_int = 0;
pub const xpMsg_Create: c_int = 1;
pub const xpMsg_Destroy: c_int = 2;
pub const xpMsg_Paint: c_int = 3;
pub const xpMsg_Draw: c_int = 4;
pub const xpMsg_KeyPress: c_int = 5;
pub const xpMsg_KeyTakeFocus: c_int = 6;
pub const xpMsg_KeyLoseFocus: c_int = 7;
pub const xpMsg_MouseDown: c_int = 8;
pub const xpMsg_MouseDrag: c_int = 9;
pub const xpMsg_MouseUp: c_int = 10;
pub const xpMsg_Reshape: c_int = 11;
pub const xpMsg_ExposedChanged: c_int = 12;
pub const xpMsg_AcceptChild: c_int = 13;
pub const xpMsg_LoseChild: c_int = 14;
pub const xpMsg_AcceptParent: c_int = 15;
pub const xpMsg_Shown: c_int = 16;
pub const xpMsg_Hidden: c_int = 17;
pub const xpMsg_DescriptorChanged: c_int = 18;
pub const xpMsg_PropertyChanged: c_int = 19;
pub const xpMsg_MouseWheel: c_int = 20;
pub const xpMsg_CursorAdjust: c_int = 21;
pub const xpMsg_UserStart: c_int = 10000;
pub const Message = enum(c_int) {

};
pub const XPWidgetFunc_t = ?*const fn (Message, WidgetID, isize, isize) callconv(.C) c_int;
pub const xpMainWindowStyle_MainWindow: c_int = 0;
pub const xpMainWindowStyle_Translucent: c_int = 1;
pub const XPMainWindowType = c_int;
pub const xpProperty_MainWindowType: c_int = 1100;
pub const xpProperty_MainWindowHasCloseBoxes: c_int = 1200;
pub const XPMainWindowProperty = c_int;
pub const xpMessage_CloseButtonPushed: c_int = 1200;
pub const XPMainWindowMessage = c_int;
pub const xpSubWindowStyle_SubWindow: c_int = 0;
pub const xpSubWindowStyle_Screen: c_int = 2;
pub const xpSubWindowStyle_ListView: c_int = 3;
pub const XPSubWindowType = c_int;
pub const xpProperty_SubWindowType: c_int = 1200;
pub const XPSubWindowProperty = c_int;
pub const xpPushButton: c_int = 0;
pub const xpRadioButton: c_int = 1;
pub const xpWindowCloseBox: c_int = 3;
pub const xpLittleDownArrow: c_int = 5;
pub const xpLittleUpArrow: c_int = 6;
pub const XPButtonType = c_int;
pub const xpButtonBehaviorPushButton: c_int = 0;
pub const xpButtonBehaviorCheckBox: c_int = 1;
pub const xpButtonBehaviorRadioButton: c_int = 2;
pub const XPButtonBehavior = c_int;
pub const xpProperty_ButtonType: c_int = 1300;
pub const xpProperty_ButtonBehavior: c_int = 1301;
pub const xpProperty_ButtonState: c_int = 1302;
pub const XPButtonProperty = c_int;
pub const xpMsg_PushButtonPressed: c_int = 1300;
pub const xpMsg_ButtonStateChanged: c_int = 1301;
pub const XPButtonMessage = c_int;
pub const xpTextEntryField: c_int = 0;
pub const xpTextTransparent: c_int = 3;
pub const xpTextTranslucent: c_int = 4;
pub const XPTextFieldType = c_int;
pub const xpProperty_EditFieldSelStart: c_int = 1400;
pub const xpProperty_EditFieldSelEnd: c_int = 1401;
pub const xpProperty_EditFieldSelDragStart: c_int = 1402;
pub const xpProperty_TextFieldType: c_int = 1403;
pub const xpProperty_PasswordMode: c_int = 1404;
pub const xpProperty_MaxCharacters: c_int = 1405;
pub const xpProperty_ScrollPosition: c_int = 1406;
pub const xpProperty_Font: c_int = 1407;
pub const xpProperty_ActiveEditSide: c_int = 1408;
pub const XPTextFieldProperty = c_int;
pub const xpMsg_TextFieldChanged: c_int = 1400;
pub const XPTextFieldMessage = c_int;
pub const xpScrollBarTypeScrollBar: c_int = 0;
pub const xpScrollBarTypeSlider: c_int = 1;
pub const XPScrollBarType = c_int;
pub const xpProperty_ScrollBarSliderPosition: c_int = 1500;
pub const xpProperty_ScrollBarMin: c_int = 1501;
pub const xpProperty_ScrollBarMax: c_int = 1502;
pub const xpProperty_ScrollBarPageAmount: c_int = 1503;
pub const xpProperty_ScrollBarType: c_int = 1504;
pub const xpProperty_ScrollBarSlop: c_int = 1505;
pub const XPScrollBarProperty = c_int;
pub const xpMsg_ScrollBarSliderPositionChanged: c_int = 1500;
pub const XPScrollBarMessage = c_int;
pub const xpProperty_CaptionLit: c_int = 1600;
pub const XPCaptionProperty = c_int;
pub const xpShip: c_int = 4;
pub const xpILSGlideScope: c_int = 5;
pub const xpMarkerLeft: c_int = 6;
pub const xp_Airport: c_int = 7;
pub const xpNDB: c_int = 8;
pub const xpVOR: c_int = 9;
pub const xpRadioTower: c_int = 10;
pub const xpAircraftCarrier: c_int = 11;
pub const xpFire: c_int = 12;
pub const xpMarkerRight: c_int = 13;
pub const xpCustomObject: c_int = 14;
pub const xpCoolingTower: c_int = 15;
pub const xpSmokeStack: c_int = 16;
pub const xpBuilding: c_int = 17;
pub const xpPowerLine: c_int = 18;
pub const xpVORWithCompassRose: c_int = 19;
pub const xpOilPlatform: c_int = 21;
pub const xpOilPlatformSmall: c_int = 22;
pub const xpWayPoint: c_int = 23;
pub const XPGeneralGraphicsType = c_int;
pub const xpProperty_GeneralGraphicsType: c_int = 1700;
pub const XPGeneralGraphicsProperty = c_int;
pub const xpProperty_ProgressPosition: c_int = 1800;
pub const xpProperty_ProgressMin: c_int = 1801;
pub const xpProperty_ProgressMax: c_int = 1802;
pub const XPProgressIndicatorProperty = c_int;
pub const xpWindow_Help: c_int = 0;
pub const xpWindow_MainWindow: c_int = 1;
pub const xpWindow_SubWindow: c_int = 2;
pub const xpWindow_Screen: c_int = 4;
pub const xpWindow_ListView: c_int = 5;
pub const XPWindowStyle = c_int;
pub extern fn XPDrawWindow(inX1: c_int, inY1: c_int, inX2: c_int, inY2: c_int, inStyle: XPWindowStyle) void;
pub extern fn XPGetWindowDefaultDimensions(inStyle: XPWindowStyle, outWidth: [*c]c_int, outHeight: [*c]c_int) void;
pub const xpElement_TextField: c_int = 6;
pub const xpElement_CheckBox: c_int = 9;
pub const xpElement_CheckBoxLit: c_int = 10;
pub const xpElement_WindowCloseBox: c_int = 14;
pub const xpElement_WindowCloseBoxPressed: c_int = 15;
pub const xpElement_PushButton: c_int = 16;
pub const xpElement_PushButtonLit: c_int = 17;
pub const xpElement_OilPlatform: c_int = 24;
pub const xpElement_OilPlatformSmall: c_int = 25;
pub const xpElement_Ship: c_int = 26;
pub const xpElement_ILSGlideScope: c_int = 27;
pub const xpElement_MarkerLeft: c_int = 28;
pub const xpElement_Airport: c_int = 29;
pub const xpElement_Waypoint: c_int = 30;
pub const xpElement_NDB: c_int = 31;
pub const xpElement_VOR: c_int = 32;
pub const xpElement_RadioTower: c_int = 33;
pub const xpElement_AircraftCarrier: c_int = 34;
pub const xpElement_Fire: c_int = 35;
pub const xpElement_MarkerRight: c_int = 36;
pub const xpElement_CustomObject: c_int = 37;
pub const xpElement_CoolingTower: c_int = 38;
pub const xpElement_SmokeStack: c_int = 39;
pub const xpElement_Building: c_int = 40;
pub const xpElement_PowerLine: c_int = 41;
pub const xpElement_CopyButtons: c_int = 45;
pub const xpElement_CopyButtonsWithEditingGrid: c_int = 46;
pub const xpElement_EditingGrid: c_int = 47;
pub const xpElement_ScrollBar: c_int = 48;
pub const xpElement_VORWithCompassRose: c_int = 49;
pub const xpElement_Zoomer: c_int = 51;
pub const xpElement_TextFieldMiddle: c_int = 52;
pub const xpElement_LittleDownArrow: c_int = 53;
pub const xpElement_LittleUpArrow: c_int = 54;
pub const xpElement_WindowDragBar: c_int = 61;
pub const xpElement_WindowDragBarSmooth: c_int = 62;
pub const XPElementStyle = c_int;
pub extern fn XPDrawElement(inX1: c_int, inY1: c_int, inX2: c_int, inY2: c_int, inStyle: XPElementStyle, inLit: c_int) void;
pub extern fn XPGetElementDefaultDimensions(inStyle: XPElementStyle, outWidth: [*c]c_int, outHeight: [*c]c_int, outCanBeLit: [*c]c_int) void;
pub const xpTrack_ScrollBar: c_int = 0;
pub const xpTrack_Slider: c_int = 1;
pub const xpTrack_Progress: c_int = 2;
pub const XPTrackStyle = c_int;
pub extern fn XPDrawTrack(inX1: c_int, inY1: c_int, inX2: c_int, inY2: c_int, inMin: c_int, inMax: c_int, inValue: c_int, inTrackStyle: XPTrackStyle, inLit: c_int) void;
pub extern fn XPGetTrackDefaultDimensions(inStyle: XPTrackStyle, outWidth: [*c]c_int, outCanBeLit: [*c]c_int) void;
pub extern fn XPGetTrackMetrics(inX1: c_int, inY1: c_int, inX2: c_int, inY2: c_int, inMin: c_int, inMax: c_int, inValue: c_int, inTrackStyle: XPTrackStyle, outIsVertical: [*c]c_int, outDownBtnSize: [*c]c_int, outDownPageSize: [*c]c_int, outThumbSize: [*c]c_int, outUpPageSize: [*c]c_int, outUpBtnSize: [*c]c_int) void;
pub extern fn XPCreateWidget(inLeft: c_int, inTop: c_int, inRight: c_int, inBottom: c_int, inVisible: c_int, inDescriptor: [*c]const u8, inIsRoot: c_int, inContainer: WidgetID, inClass: XPWidgetClass) WidgetID;
pub extern fn XPCreateCustomWidget(inLeft: c_int, inTop: c_int, inRight: c_int, inBottom: c_int, inVisible: c_int, inDescriptor: [*c]const u8, inIsRoot: c_int, inContainer: WidgetID, inCallback: XPWidgetFunc_t) WidgetID;
pub extern fn XPDestroyWidget(inWidget: WidgetID, inDestroyChildren: c_int) void;
pub extern fn XPSendMessageToWidget(inWidget: WidgetID, inMessage: Message, inMode: DispatchMode, inParam1: isize, inParam2: isize) c_int;
pub extern fn XPPlaceWidgetWithin(inSubWidget: WidgetID, inContainer: WidgetID) void;
pub extern fn XPCountChildWidgets(inWidget: WidgetID) c_int;
pub extern fn XPGetNthChildWidget(inWidget: WidgetID, inIndex: c_int) WidgetID;
pub extern fn XPGetParentWidget(inWidget: WidgetID) WidgetID;
pub extern fn XPShowWidget(inWidget: WidgetID) void;
pub extern fn XPHideWidget(inWidget: WidgetID) void;
pub extern fn XPIsWidgetVisible(inWidget: WidgetID) c_int;
pub extern fn XPFindRootWidget(inWidget: WidgetID) WidgetID;
pub extern fn XPBringRootWidgetToFront(inWidget: WidgetID) void;
pub extern fn XPIsWidgetInFront(inWidget: WidgetID) c_int;
pub extern fn XPGetWidgetGeometry(inWidget: WidgetID, outLeft: [*c]c_int, outTop: [*c]c_int, outRight: [*c]c_int, outBottom: [*c]c_int) void;
pub extern fn XPSetWidgetGeometry(inWidget: WidgetID, inLeft: c_int, inTop: c_int, inRight: c_int, inBottom: c_int) void;
pub extern fn XPGetWidgetForLocation(inContainer: WidgetID, inXOffset: c_int, inYOffset: c_int, inRecursive: c_int, inVisibleOnly: c_int) WidgetID;
pub extern fn XPGetWidgetExposedGeometry(inWidgetID: WidgetID, outLeft: [*c]c_int, outTop: [*c]c_int, outRight: [*c]c_int, outBottom: [*c]c_int) void;
pub extern fn XPSetWidgetDescriptor(inWidget: WidgetID, inDescriptor: [*c]const u8) void;
pub extern fn XPGetWidgetDescriptor(inWidget: WidgetID, outDescriptor: [*c]u8, inMaxDescLength: c_int) c_int;
pub extern fn XPGetWidgetUnderlyingWindow(inWidget: WidgetID) xplm.WindowID;
pub extern fn XPSetWidgetProperty(inWidget: WidgetID, inProperty: PropertyID, inValue: isize) void;
pub extern fn XPGetWidgetProperty(inWidget: WidgetID, inProperty: PropertyID, inExists: [*c]c_int) isize;
pub extern fn XPSetKeyboardFocus(inWidget: WidgetID) WidgetID;
pub extern fn XPLoseKeyboardFocus(inWidget: WidgetID) void;
pub extern fn XPGetWidgetWithFocus() WidgetID;
pub extern fn XPAddWidgetCallback(inWidget: WidgetID, inNewCallback: XPWidgetFunc_t) void;
pub extern fn XPGetWidgetClassFunc(inWidgetClass: XPWidgetClass) XPWidgetFunc_t;
pub const XPWidgetCreate_t = extern struct {
    left: c_int = std.mem.zeroes(c_int),
    top: c_int = std.mem.zeroes(c_int),
    right: c_int = std.mem.zeroes(c_int),
    bottom: c_int = std.mem.zeroes(c_int),
    visible: c_int = std.mem.zeroes(c_int),
    descriptor: [*c]const u8 = std.mem.zeroes([*c]const u8),
    isRoot: c_int = std.mem.zeroes(c_int),
    containerIndex: c_int = std.mem.zeroes(c_int),
    widgetClass: XPWidgetClass = std.mem.zeroes(XPWidgetClass),
};
pub extern fn XPUCreateWidgets(inWidgetDefs: [*c]const XPWidgetCreate_t, inCount: c_int, inParamParent: WidgetID, ioWidgets: [*c]WidgetID) void;
pub extern fn XPUMoveWidgetBy(inWidget: WidgetID, inDeltaX: c_int, inDeltaY: c_int) void;
pub extern fn XPUFixedLayout(inMessage: Message, inWidget: WidgetID, inParam1: isize, inParam2: isize) c_int;
pub extern fn XPUSelectIfNeeded(inMessage: Message, inWidget: WidgetID, inParam1: isize, inParam2: isize, inEatClick: c_int) c_int;
pub extern fn XPUDefocusKeyboard(inMessage: Message, inWidget: WidgetID, inParam1: isize, inParam2: isize, inEatClick: c_int) c_int;
pub extern fn XPUDragWidget(inMessage: Message, inWidget: WidgetID, inParam1: isize, inParam2: isize, inLeft: c_int, inTop: c_int, inRight: c_int, inBottom: c_int) c_int;
