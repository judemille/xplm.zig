const std = @import("std");
const config = @import("config");

pub const PluginID = c_int;

pub const KeyFlags = packed struct(c_int) {
    shift: bool,
    option_alt: bool,
    control: bool,
    down: bool,
    up: bool,
};

pub const FixedString150 = extern struct {
    buffer: [150]u8 = std.mem.zeroes([150]u8),
};

pub const CameraControlDuration = enum(c_int) {
    until_view_changes,
    forever,
    _,
};

pub const CameraPosition = extern struct {
    x: f32 = std.mem.zeroes(f32),
    y: f32 = std.mem.zeroes(f32),
    z: f32 = std.mem.zeroes(f32),
    pitch: f32 = std.mem.zeroes(f32),
    heading: f32 = std.mem.zeroes(f32),
    roll: f32 = std.mem.zeroes(f32),
    zoom: f32 = std.mem.zeroes(f32),
};

pub const CameraControlCallback = ?*const fn ([*c]CameraPosition, c_int, ?*anyopaque) callconv(.C) c_int;
pub extern fn XPLMControlCamera(inHowLong: CameraControlDuration, inControlFunc: CameraControlCallback, inRefcon: ?*anyopaque) void;
pub extern fn XPLMDontControlCamera() void;
pub extern fn XPLMIsCameraBeingControlled(outCameraControlDuration: [*c]CameraControlDuration) c_int;
pub extern fn XPLMReadCameraPosition(outCameraPosition: [*c]CameraPosition) void;

pub const DataRefHandle = ?*anyopaque;
pub const DataTypeID = packed struct(c_int) {
    int: bool,
    float: bool,
    double: bool,
    float_array: bool,
    int_array: bool,
    bytes: bool,
};
pub extern fn XPLMCountDataRefs() c_int;
pub extern fn XPLMGetDataRefsByIndex(offset: c_int, count: c_int, outDataRefs: [*c]DataRefHandle) void;
pub const DataRefInfo = extern struct {
    structSize: c_int = std.mem.zeroes(c_int),
    name: [*c]const u8 = std.mem.zeroes([*c]const u8),
    type: DataTypeID = std.mem.zeroes(DataTypeID),
    writable: c_int = std.mem.zeroes(c_int),
    owner: PluginID = std.mem.zeroes(PluginID),
};
pub extern fn XPLMGetDataRefInfo(inDataRef: DataRefHandle, outInfo: [*c]DataRefInfo) void;
pub extern fn XPLMFindDataRef(inDataRefName: [*c]const u8) DataRefHandle;
pub extern fn XPLMCanWriteDataRef(inDataRef: DataRefHandle) c_int;
pub extern fn XPLMIsDataRefGood(inDataRef: DataRefHandle) c_int;
pub extern fn XPLMGetDataRefTypes(inDataRef: DataRefHandle) DataTypeID;
pub extern fn XPLMGetDatai(inDataRef: DataRefHandle) c_int;
pub extern fn XPLMSetDatai(inDataRef: DataRefHandle, inValue: c_int) void;
pub extern fn XPLMGetDataf(inDataRef: DataRefHandle) f32;
pub extern fn XPLMSetDataf(inDataRef: DataRefHandle, inValue: f32) void;
pub extern fn XPLMGetDatad(inDataRef: DataRefHandle) f64;
pub extern fn XPLMSetDatad(inDataRef: DataRefHandle, inValue: f64) void;
pub extern fn XPLMGetDatavi(inDataRef: DataRefHandle, outValues: [*c]c_int, inOffset: c_int, inMax: c_int) c_int;
pub extern fn XPLMSetDatavi(inDataRef: DataRefHandle, inValues: [*c]c_int, inoffset: c_int, inCount: c_int) void;
pub extern fn XPLMGetDatavf(inDataRef: DataRefHandle, outValues: [*c]f32, inOffset: c_int, inMax: c_int) c_int;
pub extern fn XPLMSetDatavf(inDataRef: DataRefHandle, inValues: [*c]f32, inoffset: c_int, inCount: c_int) void;
pub extern fn XPLMGetDatab(inDataRef: DataRefHandle, outValue: ?*anyopaque, inOffset: c_int, inMaxBytes: c_int) c_int;
pub extern fn XPLMSetDatab(inDataRef: DataRefHandle, inValue: ?*anyopaque, inOffset: c_int, inLength: c_int) void;
pub const GetDataIntCallback = ?*const fn (?*anyopaque) callconv(.C) c_int;
pub const SetDataIntCallback = ?*const fn (?*anyopaque, c_int) callconv(.C) void;
pub const GetDataFloatCallback = ?*const fn (?*anyopaque) callconv(.C) f32;
pub const SetDataFloatCallback = ?*const fn (?*anyopaque, f32) callconv(.C) void;
pub const GetDataDoubleCallback = ?*const fn (?*anyopaque) callconv(.C) f64;
pub const SetDataDoubleCallback = ?*const fn (?*anyopaque, f64) callconv(.C) void;
pub const GetDataIntArrayCallback = ?*const fn (?*anyopaque, [*c]c_int, c_int, c_int) callconv(.C) c_int;
pub const SetDataIntArrayCallback = ?*const fn (?*anyopaque, [*c]c_int, c_int, c_int) callconv(.C) void;
pub const GetDataFloatArrayCallback = ?*const fn (?*anyopaque, [*c]f32, c_int, c_int) callconv(.C) c_int;
pub const SetDataFloatArrayCallback = ?*const fn (?*anyopaque, [*c]f32, c_int, c_int) callconv(.C) void;
pub const GetDataBytesCallback = ?*const fn (?*anyopaque, ?*anyopaque, c_int, c_int) callconv(.C) c_int;
pub const SetDataBytesCallback = ?*const fn (?*anyopaque, ?*anyopaque, c_int, c_int) callconv(.C) void;
pub extern fn XPLMRegisterDataAccessor(inDataName: [*c]const u8, inDataType: DataTypeID, inIsWritable: c_int, inReadInt: GetDataIntCallback, inWriteInt: SetDataIntCallback, inReadFloat: GetDataFloatCallback, inWriteFloat: SetDataFloatCallback, inReadDouble: GetDataDoubleCallback, inWriteDouble: SetDataDoubleCallback, inReadIntArray: GetDataIntArrayCallback, inWriteIntArray: SetDataIntArrayCallback, inReadFloatArray: GetDataFloatArrayCallback, inWriteFloatArray: SetDataFloatArrayCallback, inReadData: GetDataBytesCallback, inWriteData: SetDataBytesCallback, inReadRefcon: ?*anyopaque, inWriteRefcon: ?*anyopaque) DataRefHandle;
pub extern fn XPLMUnregisterDataAccessor(inDataRef: DataRefHandle) void;
pub const DataChangedCallback = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn XPLMShareData(inDataName: [*c]const u8, inDataType: DataTypeID, inNotificationFunc: DataChangedCallback, inNotificationRefcon: ?*anyopaque) c_int;
pub extern fn XPLMUnshareData(inDataName: [*c]const u8, inDataType: DataTypeID, inNotificationFunc: DataChangedCallback, inNotificationRefcon: ?*anyopaque) c_int;

pub const DrawingPhase = enum(c_int) {
    first_cockpit = 35,
    panel = 40,
    gauges = 45,
    window = 50,
    last_cockpit = 55,
    local_map_3d = 100,
    local_map_2d = 101,
    local_map_profile = 102,
    _,
};
pub const DrawCallback = ?*const fn (DrawingPhase, c_int, ?*anyopaque) callconv(.C) c_int;
pub extern fn XPLMRegisterDrawCallback(inCallback: DrawCallback, inPhase: DrawingPhase, inWantsBefore: c_int, inRefcon: ?*anyopaque) c_int;
pub extern fn XPLMUnregisterDrawCallback(inCallback: DrawCallback, inPhase: DrawingPhase, inWantsBefore: c_int, inRefcon: ?*anyopaque) c_int;

pub const AvionicsDeviceID = enum(c_int) {
    gns430_pilot = 0,
    gns430_copilot = 1,
    gns530_pilot = 2,
    gns530_copilot = 3,
    cdu739_pilot = 4,
    cdu739_copilot = 5,
    g1000_pfd_pilot = 6,
    g1000_mfd = 7,
    g1000_pfd_copilot = 8,
    cdu815_pilot = 9,
    cdu815_copilot = 10,
    primus_pfd_pilot = 11,
    primus_pfd_copilot = 12,
    primus_mfd_pilot = 13,
    primus_mfd_copilot = 14,
    primus_mfd_center = 15,
    primus_rmu_pilot = 16,
    primus_rmu_copilot = 17,
    _,
};
pub const XPLMAvionicsCallback_f = ?*const fn (AvionicsDeviceID, c_int, ?*anyopaque) callconv(.C) c_int;
pub const XPLMAvionicsID = ?*anyopaque;
pub const XPLMCustomizeAvionics_t = extern struct {
    structSize: c_int = std.mem.zeroes(c_int),
    deviceId: AvionicsDeviceID = std.mem.zeroes(AvionicsDeviceID),
    drawCallbackBefore: XPLMAvionicsCallback_f = std.mem.zeroes(XPLMAvionicsCallback_f),
    drawCallbackAfter: XPLMAvionicsCallback_f = std.mem.zeroes(XPLMAvionicsCallback_f),
    refcon: ?*anyopaque = std.mem.zeroes(?*anyopaque),
};
pub extern fn XPLMRegisterAvionicsCallbacksEx(inParams: [*c]XPLMCustomizeAvionics_t) XPLMAvionicsID;
pub extern fn XPLMUnregisterAvionicsCallbacks(inAvionicsId: XPLMAvionicsID) void;
pub const WindowID = ?*anyopaque;
pub const XPLMDrawWindow_f = ?*const fn (WindowID, ?*anyopaque) callconv(.C) void;
pub const XPLMHandleKey_f = ?*const fn (WindowID, u8, KeyFlags, u8, ?*anyopaque, c_int) callconv(.C) void;
pub const MouseStatus = enum(c_int) {
    down = 1,
    drag = 2,
    up = 3,
    _,
};
pub const XPLMHandleMouseClick_f = ?*const fn (WindowID, c_int, c_int, MouseStatus, ?*anyopaque) callconv(.C) c_int;
pub const CursorStatus = enum(c_int) {
    default = 0,
    hidden = 1,
    arrow = 2,
    custom = 3,
    _,
};
pub const XPLMHandleCursor_f = ?*const fn (WindowID, c_int, c_int, ?*anyopaque) callconv(.C) CursorStatus;
pub const XPLMHandleMouseWheel_f = ?*const fn (WindowID, c_int, c_int, c_int, c_int, ?*anyopaque) callconv(.C) c_int;
pub const WindowLayer = enum(c_int) {
    flight_overlay = 0,
    floating_windows = 1,
    modal = 2,
    growl_notifications = 3,
    _,
};
pub const WindowDecoration = enum(c_int) {
    none = 0,
    round_rectangle = 1,
    self_decorated = 2,
    self_decorated_resizable = 3,
    _,
};
pub const XPLMCreateWindow_t = extern struct {
    structSize: c_int = std.mem.zeroes(c_int),
    left: c_int = std.mem.zeroes(c_int),
    top: c_int = std.mem.zeroes(c_int),
    right: c_int = std.mem.zeroes(c_int),
    bottom: c_int = std.mem.zeroes(c_int),
    visible: c_int = std.mem.zeroes(c_int),
    drawWindowFunc: XPLMDrawWindow_f = std.mem.zeroes(XPLMDrawWindow_f),
    handleMouseClickFunc: XPLMHandleMouseClick_f = std.mem.zeroes(XPLMHandleMouseClick_f),
    handleKeyFunc: XPLMHandleKey_f = std.mem.zeroes(XPLMHandleKey_f),
    handleCursorFunc: XPLMHandleCursor_f = std.mem.zeroes(XPLMHandleCursor_f),
    handleMouseWheelFunc: XPLMHandleMouseWheel_f = std.mem.zeroes(XPLMHandleMouseWheel_f),
    refcon: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    decorateAsFloatingWindow: WindowDecoration = std.mem.zeroes(WindowDecoration),
    layer: WindowLayer = std.mem.zeroes(WindowLayer),
    handleRightClickFunc: XPLMHandleMouseClick_f = std.mem.zeroes(XPLMHandleMouseClick_f),
};
pub extern fn XPLMCreateWindowEx(inParams: [*c]XPLMCreateWindow_t) WindowID;
pub extern fn XPLMCreateWindow(inLeft: c_int, inTop: c_int, inRight: c_int, inBottom: c_int, inIsVisible: c_int, inDrawCallback: XPLMDrawWindow_f, inKeyCallback: XPLMHandleKey_f, inMouseCallback: XPLMHandleMouseClick_f, inRefcon: ?*anyopaque) WindowID;
pub extern fn XPLMDestroyWindow(inWindowID: WindowID) void;
pub extern fn XPLMGetScreenSize(outWidth: [*c]c_int, outHeight: [*c]c_int) void;
pub extern fn XPLMGetScreenBoundsGlobal(outLeft: [*c]c_int, outTop: [*c]c_int, outRight: [*c]c_int, outBottom: [*c]c_int) void;
pub const XPLMReceiveMonitorBoundsGlobal_f = ?*const fn (c_int, c_int, c_int, c_int, c_int, ?*anyopaque) callconv(.C) void;
pub extern fn XPLMGetAllMonitorBoundsGlobal(inMonitorBoundsCallback: XPLMReceiveMonitorBoundsGlobal_f, inRefcon: ?*anyopaque) void;
pub const XPLMReceiveMonitorBoundsOS_f = ?*const fn (c_int, c_int, c_int, c_int, c_int, ?*anyopaque) callconv(.C) void;
pub extern fn XPLMGetAllMonitorBoundsOS(inMonitorBoundsCallback: XPLMReceiveMonitorBoundsOS_f, inRefcon: ?*anyopaque) void;
pub extern fn XPLMGetMouseLocation(outX: [*c]c_int, outY: [*c]c_int) void;
pub extern fn XPLMGetMouseLocationGlobal(outX: [*c]c_int, outY: [*c]c_int) void;
pub extern fn XPLMGetWindowGeometry(inWindowID: WindowID, outLeft: [*c]c_int, outTop: [*c]c_int, outRight: [*c]c_int, outBottom: [*c]c_int) void;
pub extern fn XPLMSetWindowGeometry(inWindowID: WindowID, inLeft: c_int, inTop: c_int, inRight: c_int, inBottom: c_int) void;
pub extern fn XPLMGetWindowGeometryOS(inWindowID: WindowID, outLeft: [*c]c_int, outTop: [*c]c_int, outRight: [*c]c_int, outBottom: [*c]c_int) void;
pub extern fn XPLMSetWindowGeometryOS(inWindowID: WindowID, inLeft: c_int, inTop: c_int, inRight: c_int, inBottom: c_int) void;
pub extern fn XPLMGetWindowGeometryVR(inWindowID: WindowID, outWidthBoxels: [*c]c_int, outHeightBoxels: [*c]c_int) void;
pub extern fn XPLMSetWindowGeometryVR(inWindowID: WindowID, widthBoxels: c_int, heightBoxels: c_int) void;
pub extern fn XPLMGetWindowIsVisible(inWindowID: WindowID) c_int;
pub extern fn XPLMSetWindowIsVisible(inWindowID: WindowID, inIsVisible: c_int) void;
pub extern fn XPLMWindowIsPoppedOut(inWindowID: WindowID) c_int;
pub extern fn XPLMWindowIsInVR(inWindowID: WindowID) c_int;
pub extern fn XPLMSetWindowGravity(inWindowID: WindowID, inLeftGravity: f32, inTopGravity: f32, inRightGravity: f32, inBottomGravity: f32) void;
pub extern fn XPLMSetWindowResizingLimits(inWindowID: WindowID, inMinWidthBoxels: c_int, inMinHeightBoxels: c_int, inMaxWidthBoxels: c_int, inMaxHeightBoxels: c_int) void;
pub const XPLMWindowPositioningMode = enum(c_int) {
    position_free = 0,
    center_on_monitor = 1,
    full_screen_on_monitor = 2,
    full_screen_on_all_monitors = 3,
    pop_out = 4,
    vr = 5,
    _,
};
pub extern fn XPLMSetWindowPositioningMode(inWindowID: WindowID, inPositioningMode: XPLMWindowPositioningMode, inMonitorIndex: c_int) void;
pub extern fn XPLMSetWindowTitle(inWindowID: WindowID, inWindowTitle: [*c]const u8) void;
pub extern fn XPLMGetWindowRefCon(inWindowID: WindowID) ?*anyopaque;
pub extern fn XPLMSetWindowRefCon(inWindowID: WindowID, inRefcon: ?*anyopaque) void;
pub extern fn XPLMTakeKeyboardFocus(inWindow: WindowID) void;
pub extern fn XPLMHasKeyboardFocus(inWindow: WindowID) c_int;
pub extern fn XPLMBringWindowToFront(inWindow: WindowID) void;
pub extern fn XPLMIsWindowInFront(inWindow: WindowID) c_int;
pub const KeySnifferCallback = ?*const fn (u8, KeyFlags, u8, ?*anyopaque) callconv(.C) c_int;
pub extern fn XPLMRegisterKeySniffer(inCallback: KeySnifferCallback, inBeforeWindows: c_int, inRefcon: ?*anyopaque) c_int;
pub extern fn XPLMUnregisterKeySniffer(inCallback: KeySnifferCallback, inBeforeWindows: c_int, inRefcon: ?*anyopaque) c_int;
pub const HotKeyCallback = ?*const fn (?*anyopaque) callconv(.C) void;
pub const XPLMHotKeyID = ?*anyopaque;
pub extern fn XPLMRegisterHotKey(inVirtualKey: u8, inFlags: KeyFlags, inDescription: [*c]const u8, inCallback: HotKeyCallback, inRefcon: ?*anyopaque) XPLMHotKeyID;
pub extern fn XPLMUnregisterHotKey(inHotKey: XPLMHotKeyID) void;
pub extern fn XPLMCountHotKeys() c_int;
pub extern fn XPLMGetNthHotKey(inIndex: c_int) XPLMHotKeyID;
pub extern fn XPLMGetHotKeyInfo(inHotKey: XPLMHotKeyID, outVirtualKey: [*c]u8, outFlags: [*c]KeyFlags, outDescription: [*c]u8, outPlugin: [*c]PluginID) void;
pub extern fn XPLMSetHotKeyCombination(inHotKey: XPLMHotKeyID, inVirtualKey: u8, inFlags: KeyFlags) void;
pub const TextureID = enum(c_int) {
    general_interface = 0,
    _,
};
pub extern fn XPLMSetGraphicsState(inEnableFog: c_int, inNumberTexUnits: c_int, inEnableLighting: c_int, inEnableAlphaTesting: c_int, inEnableAlphaBlending: c_int, inEnableDepthTesting: c_int, inEnableDepthWriting: c_int) void;
pub extern fn XPLMBindTexture2d(inTextureNum: c_int, inTextureUnit: c_int) void;
pub extern fn XPLMGenerateTextureNumbers(outTextureIDs: [*c]c_int, inCount: c_int) void;
pub extern fn XPLMWorldToLocal(inLatitude: f64, inLongitude: f64, inAltitude: f64, outX: [*c]f64, outY: [*c]f64, outZ: [*c]f64) void;
pub extern fn XPLMLocalToWorld(inX: f64, inY: f64, inZ: f64, outLatitude: [*c]f64, outLongitude: [*c]f64, outAltitude: [*c]f64) void;
pub extern fn XPLMDrawTranslucentDarkBox(inLeft: c_int, inTop: c_int, inRight: c_int, inBottom: c_int) void;
pub const FontID = enum(c_int) {
    basic = 0,
    proportional = 18,
    _,
};
pub extern fn XPLMDrawString(inColorRGB: [*c]f32, inXOffset: c_int, inYOffset: c_int, inChar: [*c]u8, inWordWrapWidth: [*c]c_int, inFontID: FontID) void;
pub extern fn XPLMDrawNumber(inColorRGB: [*c]f32, inXOffset: c_int, inYOffset: c_int, inValue: f64, inDigits: c_int, inDecimals: c_int, inShowSign: c_int, inFontID: FontID) void;
pub extern fn XPLMGetFontDimensions(inFontID: FontID, outCharWidth: [*c]c_int, outCharHeight: [*c]c_int, outDigitsOnly: [*c]c_int) void;
pub extern fn XPLMMeasureString(inFontID: FontID, inChar: [*c]const u8, inNumChars: c_int) f32;
pub const SceneryProbeType = enum(c_int) {
    y = 0,
    _,
};
pub const ProbeResult = enum(c_int) {
    hit_terrain = 0,
    err = 1,
    missed = 2,
    _,
};
pub const SceneryProbeHandle = ?*anyopaque;
pub const XPLMProbeInfo_t = extern struct {
    structSize: c_int = std.mem.zeroes(c_int),
    locationX: f32 = std.mem.zeroes(f32),
    locationY: f32 = std.mem.zeroes(f32),
    locationZ: f32 = std.mem.zeroes(f32),
    normalX: f32 = std.mem.zeroes(f32),
    normalY: f32 = std.mem.zeroes(f32),
    normalZ: f32 = std.mem.zeroes(f32),
    velocityX: f32 = std.mem.zeroes(f32),
    velocityY: f32 = std.mem.zeroes(f32),
    velocityZ: f32 = std.mem.zeroes(f32),
    is_wet: c_int = std.mem.zeroes(c_int),
};
pub extern fn XPLMCreateProbe(inProbeType: SceneryProbeType) SceneryProbeHandle;
pub extern fn XPLMDestroyProbe(inProbe: SceneryProbeHandle) void;
pub extern fn XPLMProbeTerrainXYZ(inProbe: SceneryProbeHandle, inX: f32, inY: f32, inZ: f32, outInfo: [*c]XPLMProbeInfo_t) ProbeResult;
pub extern fn XPLMGetMagneticVariation(latitude: f64, longitude: f64) f32;
pub extern fn XPLMDegTrueToDegMagnetic(headingDegreesTrue: f32) f32;
pub extern fn XPLMDegMagneticToDegTrue(headingDegreesMagnetic: f32) f32;
pub const SceneryObjectHandle = ?*anyopaque;
pub const DrawInfo = extern struct {
    structSize: c_int = std.mem.zeroes(c_int),
    x: f32 = std.mem.zeroes(f32),
    y: f32 = std.mem.zeroes(f32),
    z: f32 = std.mem.zeroes(f32),
    pitch: f32 = std.mem.zeroes(f32),
    heading: f32 = std.mem.zeroes(f32),
    roll: f32 = std.mem.zeroes(f32),
};
pub const ObjectLoadedCallback = ?*const fn (SceneryObjectHandle, ?*anyopaque) callconv(.C) void;
pub extern fn XPLMLoadObject(inPath: [*c]const u8) SceneryObjectHandle;
pub extern fn XPLMLoadObjectAsync(inPath: [*c]const u8, inCallback: ObjectLoadedCallback, inRefcon: ?*anyopaque) void;
pub extern fn XPLMUnloadObject(inObject: SceneryObjectHandle) void;
pub const XPLMLibraryEnumerator_f = ?*const fn ([*c]const u8, ?*anyopaque) callconv(.C) void;
pub extern fn XPLMLookupObjects(inPath: [*c]const u8, inLatitude: f32, inLongitude: f32, enumerator: XPLMLibraryEnumerator_f, ref: ?*anyopaque) c_int;
pub const ObjectInstanceHandle = ?*anyopaque;
pub extern fn XPLMCreateInstance(obj: SceneryObjectHandle, datarefs: [*c][*c]const u8) ObjectInstanceHandle;
pub extern fn XPLMDestroyInstance(instance: ObjectInstanceHandle) void;
pub extern fn XPLMInstanceSetPosition(instance: ObjectInstanceHandle, new_position: [*c]const DrawInfo, data: [*c]const f32) void;

pub const MapLayerID = ?*anyopaque;
pub const MapProjectionID = ?*anyopaque;
pub const MapStyle = enum(c_int) {
    vfr_sectional = 0,
    ifr_low_enroute = 1,
    ifr_high_enroute = 2,
    _,
};

pub const MapDrawingCallback = ?*const fn (MapLayerID, [*c]const f32, f32, f32, MapStyle, MapProjectionID, ?*anyopaque) callconv(.C) void;
pub const MapIconDrawingCallback = ?*const fn (MapLayerID, [*c]const f32, f32, f32, MapStyle, MapProjectionID, ?*anyopaque) callconv(.C) void;
pub const MapLabelDrawingCallback = ?*const fn (MapLayerID, [*c]const f32, f32, f32, MapStyle, MapProjectionID, ?*anyopaque) callconv(.C) void;
pub const MapPrepareCacheCallback = ?*const fn (MapLayerID, [*c]const f32, MapProjectionID, ?*anyopaque) callconv(.C) void;
pub const MapWillBeDeletedCallback = ?*const fn (MapLayerID, ?*anyopaque) callconv(.C) void;

pub const MapLayerType = enum(c_int) {
    Fill = 0,
    Markings = 1,
    _,
};
pub const XPLMCreateMapLayer_t = extern struct {
    structSize: c_int = std.mem.zeroes(c_int),
    mapToCreateLayerIn: [*c]const u8 = std.mem.zeroes([*c]const u8),
    layerType: MapLayerType = std.mem.zeroes(MapLayerType),
    willBeDeletedCallback: MapWillBeDeletedCallback = std.mem.zeroes(MapWillBeDeletedCallback),
    prepCacheCallback: MapPrepareCacheCallback = std.mem.zeroes(MapPrepareCacheCallback),
    drawCallback: MapDrawingCallback = std.mem.zeroes(MapDrawingCallback),
    iconCallback: MapIconDrawingCallback = std.mem.zeroes(MapIconDrawingCallback),
    labelCallback: MapLabelDrawingCallback = std.mem.zeroes(MapLabelDrawingCallback),
    showUiToggle: c_int = std.mem.zeroes(c_int),
    layerName: [*c]const u8 = std.mem.zeroes([*c]const u8),
    refcon: ?*anyopaque = std.mem.zeroes(?*anyopaque),
};
pub extern fn XPLMCreateMapLayer(inParams: [*c]XPLMCreateMapLayer_t) MapLayerID;
pub extern fn XPLMDestroyMapLayer(inLayer: MapLayerID) c_int;
pub const XPLMMapCreatedCallback_f = ?*const fn ([*c]const u8, ?*anyopaque) callconv(.C) void;
pub extern fn XPLMRegisterMapCreationHook(callback: XPLMMapCreatedCallback_f, refcon: ?*anyopaque) void;
pub extern fn XPLMMapExists(mapIdentifier: [*c]const u8) c_int;
pub const MapOrientation = enum(c_int) {
    map = 0,
    ui = 1,
    _,
};
pub extern fn XPLMDrawMapIconFromSheet(layer: MapLayerID, inPngPath: [*c]const u8, s: c_int, t: c_int, ds: c_int, dt: c_int, mapX: f32, mapY: f32, orientation: MapOrientation, rotationDegrees: f32, mapWidth: f32) void;
pub extern fn XPLMDrawMapLabel(layer: MapLayerID, inText: [*c]const u8, mapX: f32, mapY: f32, orientation: MapOrientation, rotationDegrees: f32) void;
pub extern fn XPLMMapProject(projection: MapProjectionID, latitude: f64, longitude: f64, outX: [*c]f32, outY: [*c]f32) void;
pub extern fn XPLMMapUnproject(projection: MapProjectionID, mapX: f32, mapY: f32, outLatitude: [*c]f64, outLongitude: [*c]f64) void;
pub extern fn XPLMMapScaleMeter(projection: MapProjectionID, mapX: f32, mapY: f32) f32;
pub extern fn XPLMMapGetNorthHeading(projection: MapProjectionID, mapX: f32, mapY: f32) f32;
pub const DataFileType = enum(c_int) {
    situation = 1,
    replay_movie = 2,
    _,
};
pub extern fn XPLMGetSystemPath(outSystemPath: [*c]u8) void;
pub extern fn XPLMGetPrefsPath(outPrefsPath: [*c]u8) void;
pub extern fn XPLMGetDirectorySeparator() [*c]const u8;
pub extern fn XPLMExtractFileAndPath(inFullPath: [*c]u8) [*c]u8;
pub extern fn XPLMGetDirectoryContents(inDirectoryPath: [*c]const u8, inFirstReturn: c_int, outFileNames: [*c]u8, inFileNameBufSize: c_int, outIndices: [*c][*c]u8, inIndexCount: c_int, outTotalFiles: [*c]c_int, outReturnedFiles: [*c]c_int) c_int;
pub extern fn XPLMLoadDataFile(inFileType: DataFileType, inFilePath: [*c]const u8) c_int;
pub extern fn XPLMSaveDataFile(inFileType: DataFileType, inFilePath: [*c]const u8) c_int;
pub const HostApplicationID = enum(c_int) {
    unknown = 0,
    xplane = 1,
    _,
};
pub const LanguageCode = enum(c_int) {
    unknown = 0,
    english = 1,
    french = 2,
    german = 3,
    italian = 4,
    spanish = 5,
    korean = 6,
    russian = 7,
    greek = 8,
    japanese = 9,
    chinese = 10,
    _,
};
pub const ErrorCallback = ?*const fn ([*c]const u8) callconv(.C) void;
pub extern fn XPLMGetVersions(outXPlaneVersion: [*c]c_int, outXPLMVersion: [*c]c_int, outHostID: [*c]HostApplicationID) void;
pub extern fn XPLMGetLanguage() LanguageCode;
pub extern fn XPLMFindSymbol(inString: [*c]const u8) ?*anyopaque;
pub extern fn XPLMSetErrorCallback(inCallback: ErrorCallback) void;
pub extern fn XPLMDebugString(inString: [*c]const u8) void;
pub extern fn XPLMSpeakString(inString: [*c]const u8) void;
pub extern fn XPLMGetVirtualKeyDescription(inVirtualKey: u8) [*c]const u8;
pub extern fn XPLMReloadScenery() void;
pub const CommandPhase = enum(c_int) {
    begin = 0,
    continues = 1,
    end = 2,
    _,
};
pub const CommandHandle = ?*anyopaque;
pub const CommandCallback = ?*const fn (CommandHandle, CommandPhase, ?*anyopaque) callconv(.C) c_int;
pub extern fn XPLMFindCommand(inName: [*c]const u8) CommandHandle;
pub extern fn XPLMCommandBegin(inCommand: CommandHandle) void;
pub extern fn XPLMCommandEnd(inCommand: CommandHandle) void;
pub extern fn XPLMCommandOnce(inCommand: CommandHandle) void;
pub extern fn XPLMCreateCommand(inName: [*c]const u8, inDescription: [*c]const u8) CommandHandle;
pub extern fn XPLMRegisterCommandHandler(inComand: CommandHandle, inHandler: CommandCallback, inBefore: c_int, inRefcon: ?*anyopaque) void;
pub const MenuCheck = enum(c_int) {
    no_check = 0,
    unchecked = 1,
    checked = 2,
    _,
};
pub const MenuID = ?*anyopaque;
pub const MenuEventCallback = ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void;
pub extern fn XPLMFindPluginsMenu() MenuID;
pub extern fn XPLMFindAircraftMenu() MenuID;
pub extern fn XPLMCreateMenu(inName: [*c]const u8, inParentMenu: MenuID, inParentItem: c_int, inHandler: MenuEventCallback, inMenuRef: ?*anyopaque) MenuID;
pub extern fn XPLMDestroyMenu(inMenuID: MenuID) void;
pub extern fn XPLMClearAllMenuItems(inMenuID: MenuID) void;
pub extern fn XPLMAppendMenuItem(inMenu: MenuID, inItemName: [*c]const u8, inItemRef: ?*anyopaque, inDeprecatedAndIgnored: c_int) c_int;
pub extern fn XPLMAppendMenuItemWithCommand(inMenu: MenuID, inItemName: [*c]const u8, inCommandToExecute: CommandHandle) c_int;
pub extern fn XPLMAppendMenuSeparator(inMenu: MenuID) void;
pub extern fn XPLMSetMenuItemName(inMenu: MenuID, inIndex: c_int, inItemName: [*c]const u8, inDeprecatedAndIgnored: c_int) void;
pub extern fn XPLMCheckMenuItem(inMenu: MenuID, index: c_int, inCheck: MenuCheck) void;
pub extern fn XPLMCheckMenuItemState(inMenu: MenuID, index: c_int, outCheck: [*c]MenuCheck) void;
pub extern fn XPLMEnableMenuItem(inMenu: MenuID, index: c_int, enabled: c_int) void;
pub extern fn XPLMRemoveMenuItem(inMenu: MenuID, inIndex: c_int) void;
pub const NavaidType = packed struct(c_int) {
    airport: bool,
    ndb: bool,
    vor: bool,
    ils: bool,
    localizer: bool,
    glideslope: bool,
    outer_marker: bool,
    middle_marker: bool,
    inner_marker: bool,
    fix: bool,
    dme: bool,
    lat_lon: bool,
};
pub const NavaidHandle = c_int;
pub extern fn XPLMGetFirstNavAid() NavaidHandle;
pub extern fn XPLMGetNextNavAid(inNavAidRef: NavaidHandle) NavaidHandle;
pub extern fn XPLMFindFirstNavAidOfType(inType: NavaidType) NavaidHandle;
pub extern fn XPLMFindLastNavAidOfType(inType: NavaidType) NavaidHandle;
pub extern fn XPLMFindNavAid(inNameFragment: [*c]const u8, inIDFragment: [*c]const u8, inLat: [*c]f32, inLon: [*c]f32, inFrequency: [*c]c_int, inType: NavaidType) NavaidHandle;
pub extern fn XPLMGetNavAidInfo(inRef: NavaidHandle, outType: [*c]NavaidType, outLatitude: [*c]f32, outLongitude: [*c]f32, outHeight: [*c]f32, outFrequency: [*c]c_int, outHeading: [*c]f32, outID: [*c]u8, outName: [*c]u8, outReg: [*c]u8) void;
pub extern fn XPLMCountFMSEntries() c_int;
pub extern fn XPLMGetDisplayedFMSEntry() c_int;
pub extern fn XPLMGetDestinationFMSEntry() c_int;
pub extern fn XPLMSetDisplayedFMSEntry(inIndex: c_int) void;
pub extern fn XPLMSetDestinationFMSEntry(inIndex: c_int) void;
pub extern fn XPLMGetFMSEntryInfo(inIndex: c_int, outType: [*c]NavaidType, outID: [*c]u8, outRef: [*c]NavaidHandle, outAltitude: [*c]c_int, outLat: [*c]f32, outLon: [*c]f32) void;
pub extern fn XPLMSetFMSEntryInfo(inIndex: c_int, inRef: NavaidHandle, inAltitude: c_int) void;
pub extern fn XPLMSetFMSEntryLatLon(inIndex: c_int, inLat: f32, inLon: f32, inAltitude: c_int) void;
pub extern fn XPLMClearFMSEntry(inIndex: c_int) void;
pub extern fn XPLMGetGPSDestinationType() NavaidType;
pub extern fn XPLMGetGPSDestination() NavaidHandle;
pub extern fn XPLMSetUsersAircraft(inAircraftPath: [*c]const u8) void;
pub extern fn XPLMPlaceUserAtAirport(inAirportCode: [*c]const u8) void;
pub extern fn XPLMPlaceUserAtLocation(latitudeDegrees: f64, longitudeDegrees: f64, elevationMetersMSL: f32, headingDegreesTrue: f32, speedMetersPerSecond: f32) void;
pub extern fn XPLMCountAircraft(outTotalAircraft: [*c]c_int, outActiveAircraft: [*c]c_int, outController: [*c]PluginID) void;
pub extern fn XPLMGetNthAircraftModel(inIndex: c_int, outFileName: [*c]u8, outPath: [*c]u8) void;
pub const PlanesAvailableCallback = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn XPLMAcquirePlanes(inAircraft: [*c][*c]u8, inCallback: PlanesAvailableCallback, inRefcon: ?*anyopaque) c_int;
pub extern fn XPLMReleasePlanes() void;
pub extern fn XPLMSetActiveAircraftCount(inCount: c_int) void;
pub extern fn XPLMSetAircraftModel(inIndex: c_int, inAircraftPath: [*c]const u8) void;
pub extern fn XPLMDisableAIForPlane(inPlaneIndex: c_int) void;
pub extern fn XPLMGetMyID() PluginID;
pub extern fn XPLMCountPlugins() c_int;
pub extern fn XPLMGetNthPlugin(inIndex: c_int) PluginID;
pub extern fn XPLMFindPluginByPath(inPath: [*c]const u8) PluginID;
pub extern fn XPLMFindPluginBySignature(inSignature: [*c]const u8) PluginID;
pub extern fn XPLMGetPluginInfo(inPlugin: PluginID, outName: [*c]u8, outFilePath: [*c]u8, outSignature: [*c]u8, outDescription: [*c]u8) void;
pub extern fn XPLMIsPluginEnabled(inPluginID: PluginID) c_int;
pub extern fn XPLMEnablePlugin(inPluginID: PluginID) c_int;
pub extern fn XPLMDisablePlugin(inPluginID: PluginID) void;
pub extern fn XPLMReloadPlugins() void;
pub extern fn XPLMSendMessageToPlugin(inPlugin: PluginID, inMessage: c_int, inParam: ?*anyopaque) void;
pub const XPLMFeatureEnumerator_f = ?*const fn ([*c]const u8, ?*anyopaque) callconv(.C) void;
pub extern fn XPLMHasFeature(inFeature: [*c]const u8) c_int;
pub extern fn XPLMIsFeatureEnabled(inFeature: [*c]const u8) c_int;
pub extern fn XPLMEnableFeature(inFeature: [*c]const u8, inEnable: c_int) void;
pub extern fn XPLMEnumerateFeatures(inEnumerator: XPLMFeatureEnumerator_f, inRef: ?*anyopaque) void;
pub const FlightLoopPhase = enum(c_int) {
    before_flight_model = 0,
    after_flight_model = 1,
    _,
};
pub const FlightLoopHandle = ?*anyopaque;
pub const FlightLoopCallback = ?*const fn (f32, f32, c_int, ?*anyopaque) callconv(.C) f32;
pub const XPLMCreateFlightLoop_t = extern struct {
    structSize: c_int = std.mem.zeroes(c_int),
    phase: FlightLoopPhase = std.mem.zeroes(FlightLoopPhase),
    callbackFunc: FlightLoopCallback = std.mem.zeroes(FlightLoopCallback),
    refcon: ?*anyopaque = std.mem.zeroes(?*anyopaque),
};
pub extern fn XPLMGetElapsedTime() f32;
pub extern fn XPLMGetCycleNumber() c_int;
pub extern fn XPLMRegisterFlightLoopCallback(inFlightLoop: FlightLoopCallback, inInterval: f32, inRefcon: ?*anyopaque) void;
pub extern fn XPLMUnregisterFlightLoopCallback(inFlightLoop: FlightLoopCallback, inRefcon: ?*anyopaque) void;
pub extern fn XPLMSetFlightLoopCallbackInterval(inFlightLoop: FlightLoopCallback, inInterval: f32, inRelativeToNow: c_int, inRefcon: ?*anyopaque) void;
pub extern fn XPLMCreateFlightLoop(inParams: [*c]XPLMCreateFlightLoop_t) FlightLoopHandle;
pub extern fn XPLMDestroyFlightLoop(inFlightLoopID: FlightLoopHandle) void;
pub extern fn XPLMScheduleFlightLoop(inFlightLoopID: FlightLoopHandle, inInterval: f32, inRelativeToNow: c_int) void;
pub const AudioBus = enum(c_int) {
    radio_com1 = 0,
    radio_com2 = 1,
    radio_pilot = 2,
    radio_copilot = 3,
    exterior_aircraft = 4,
    exterior_environment = 5,
    exterior_unprocessed = 6,
    interior = 7,
    ui = 8,
    ground = 9,
    master = 10,
    _,
};
pub const AudioBankID = enum(c_int) {
    master = 0,
    radio = 1,
    _,
};
pub const FMOD_OK: c_int = 0;
pub const enum_FMOD_RESULT = c_int;
pub const FMOD_RESULT = enum_FMOD_RESULT;
pub const FMOD_SOUND_FORMAT_PCM16: c_int = 2;
pub const enum_FMOD_SOUND_FORMAT = c_int;
pub const FMOD_SOUND_FORMAT = enum_FMOD_SOUND_FORMAT;
pub const struct_FMOD_VECTOR = extern struct {
    x: f32 = std.mem.zeroes(f32),
    y: f32 = std.mem.zeroes(f32),
    z: f32 = std.mem.zeroes(f32),
};
pub const FMOD_VECTOR = struct_FMOD_VECTOR;
pub const FMOD_CHANNEL = anyopaque;
pub const XPLMPCMComplete_f = ?*const fn (?*anyopaque, FMOD_RESULT) callconv(.C) void;
pub extern fn XPLMPlayPCMOnBus(audioBuffer: ?*anyopaque, bufferSize: u32, soundFormat: FMOD_SOUND_FORMAT, freqHz: c_int, numChannels: c_int, loop: c_int, audioType: AudioBus, inCallback: XPLMPCMComplete_f, inRefcon: ?*anyopaque) ?*FMOD_CHANNEL;
pub extern fn XPLMStopAudio(fmod_channel: ?*FMOD_CHANNEL) FMOD_RESULT;
pub extern fn XPLMSetAudioPosition(fmod_channel: ?*FMOD_CHANNEL, position: [*c]FMOD_VECTOR, velocity: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn XPLMSetAudioFadeDistance(fmod_channel: ?*FMOD_CHANNEL, min_fade_distance: f32, max_fade_distance: f32) FMOD_RESULT;
pub extern fn XPLMSetAudioVolume(fmod_channel: ?*FMOD_CHANNEL, source_volume: f32) FMOD_RESULT;
pub extern fn XPLMSetAudioPitch(fmod_channel: ?*FMOD_CHANNEL, audio_pitch_hz: f32) FMOD_RESULT;
pub extern fn XPLMSetAudioCone(fmod_channel: ?*FMOD_CHANNEL, inside_angle: f32, outside_angle: f32, outside_volume: f32, orientation: [*c]FMOD_VECTOR) FMOD_RESULT;
pub const XPLMWeatherInfoWinds_t = extern struct {
    alt_msl: f32 = std.mem.zeroes(f32),
    speed: f32 = std.mem.zeroes(f32),
    direction: f32 = std.mem.zeroes(f32),
    gust_speed: f32 = std.mem.zeroes(f32),
    shear: f32 = std.mem.zeroes(f32),
    turbulence: f32 = std.mem.zeroes(f32),
};
pub const XPLMWeatherInfoClouds_t = extern struct {
    cloud_type: f32 = std.mem.zeroes(f32),
    coverage: f32 = std.mem.zeroes(f32),
    alt_top: f32 = std.mem.zeroes(f32),
    alt_base: f32 = std.mem.zeroes(f32),
};
pub const XPLMWeatherInfo_t = extern struct {
    structSize: c_int = std.mem.zeroes(c_int),
    temperature_alt: f32 = std.mem.zeroes(f32),
    dewpoint_alt: f32 = std.mem.zeroes(f32),
    pressure_alt: f32 = std.mem.zeroes(f32),
    precip_rate_alt: f32 = std.mem.zeroes(f32),
    wind_dir_alt: f32 = std.mem.zeroes(f32),
    wind_spd_alt: f32 = std.mem.zeroes(f32),
    turbulence_alt: f32 = std.mem.zeroes(f32),
    wave_height: f32 = std.mem.zeroes(f32),
    wave_length: f32 = std.mem.zeroes(f32),
    wave_dir: c_int = std.mem.zeroes(c_int),
    wave_speed: f32 = std.mem.zeroes(f32),
    visibility: f32 = std.mem.zeroes(f32),
    precip_rate: f32 = std.mem.zeroes(f32),
    thermal_climb: f32 = std.mem.zeroes(f32),
    pressure_sl: f32 = std.mem.zeroes(f32),
    wind_layers: [13]XPLMWeatherInfoWinds_t = std.mem.zeroes([13]XPLMWeatherInfoWinds_t),
    cloud_layers: [3]XPLMWeatherInfoClouds_t = std.mem.zeroes([3]XPLMWeatherInfoClouds_t),
};
pub extern fn XPLMGetMETARForAirport(airport_id: [*c]const u8, outMETAR: [*c]FixedString150) void;
pub extern fn XPLMGetWeatherAtLocation(latitude: f64, longitude: f64, altitude_m: f64, out_info: [*c]XPLMWeatherInfo_t) c_int;
