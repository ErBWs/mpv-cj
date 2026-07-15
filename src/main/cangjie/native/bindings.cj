package ohos_app_cangjie_mpvcj.native

func __cjbind_read_CString_from_UInt64(storage: UInt64): CString {
    var s = storage
    return unsafe { CPointer<CString>(CPointer<UInt8>(inout s)).read() }
}

func __cjbind_write_CString_from_UInt64(storage: UInt64, val: CString): UInt64 {
    var s = storage
    unsafe { CPointer<CString>(CPointer<UInt8>(inout s)).write(val) }
    return s
}

func __cjbind_read_Int32_from_UInt64(storage: UInt64): Int32 {
    var s = storage
    return unsafe { CPointer<Int32>(CPointer<UInt8>(inout s)).read() }
}

func __cjbind_write_Int32_from_UInt64(storage: UInt64, val: Int32): UInt64 {
    var s = storage
    unsafe { CPointer<Int32>(CPointer<UInt8>(inout s)).write(val) }
    return s
}

func __cjbind_read_Int64_from_UInt64(storage: UInt64): Int64 {
    var s = storage
    return unsafe { CPointer<Int64>(CPointer<UInt8>(inout s)).read() }
}

func __cjbind_write_Int64_from_UInt64(storage: UInt64, val: Int64): UInt64 {
    var s = storage
    unsafe { CPointer<Int64>(CPointer<UInt8>(inout s)).write(val) }
    return s
}

func __cjbind_read_Float64_from_UInt64(storage: UInt64): Float64 {
    var s = storage
    return unsafe { CPointer<Float64>(CPointer<UInt8>(inout s)).read() }
}

func __cjbind_write_Float64_from_UInt64(storage: UInt64, val: Float64): UInt64 {
    var s = storage
    unsafe { CPointer<Float64>(CPointer<UInt8>(inout s)).write(val) }
    return s
}

func __cjbind_read_CPointer_mpv_node_list_mpv_node_list__from_UInt64(storage: UInt64): CPointer<mpv_node_list_mpv_node_list> {
    var s = storage
    return unsafe { CPointer<CPointer<mpv_node_list_mpv_node_list>>(CPointer<UInt8>(inout s)).read() }
}

func __cjbind_write_CPointer_mpv_node_list_mpv_node_list__from_UInt64(storage: UInt64, val: CPointer<mpv_node_list_mpv_node_list>): UInt64 {
    var s = storage
    unsafe { CPointer<CPointer<mpv_node_list_mpv_node_list>>(CPointer<UInt8>(inout s)).write(val) }
    return s
}

func __cjbind_read_CPointer_mpv_byte_array_mpv_byte_array__from_UInt64(storage: UInt64): CPointer<mpv_byte_array_mpv_byte_array> {
    var s = storage
    return unsafe { CPointer<CPointer<mpv_byte_array_mpv_byte_array>>(CPointer<UInt8>(inout s)).read() }
}

func __cjbind_write_CPointer_mpv_byte_array_mpv_byte_array__from_UInt64(storage: UInt64, val: CPointer<mpv_byte_array_mpv_byte_array>): UInt64 {
    var s = storage
    unsafe { CPointer<CPointer<mpv_byte_array_mpv_byte_array>>(CPointer<UInt8>(inout s)).write(val) }
    return s
}

public const MPV_CLIENT_API_VERSION_MPV_CLIENT_API_VERSION : UInt64 = 131077

public const MPV_ENABLE_DEPRECATED_MPV_ENABLE_DEPRECATED : Int64 = 1

// Return the MPV_CLIENT_API_VERSION the mpv source has been compiled with.
foreign func mpv_client_api_version (  ) : UInt32

@C
public struct mpv_handle_mpv_handle {

init() {
    throw Exception("type should not be inited")
}
}

// No error happened (used to signal successful operation).
// Keep in mind that many API functions returning error codes can also
// return positive values, which also indicate success. API users can
// hardcode the fact that ">= 0" means success.
public const mpv_error_MPV_ERROR_SUCCESS : mpv_error_mpv_error = 0

// The event ringbuffer is full. This means the client is choked, and can't
// receive any events. This can happen when too many asynchronous requests
// have been made, but not answered. Probably never happens in practice,
// unless the mpv core is frozen for some reason, and the client keeps
// making asynchronous requests. (Bugs in the client API implementation
// could also trigger this, e.g. if events become "lost".)
public const mpv_error_MPV_ERROR_EVENT_QUEUE_FULL : mpv_error_mpv_error = -1

// Memory allocation failed.
public const mpv_error_MPV_ERROR_NOMEM : mpv_error_mpv_error = -2

// The mpv core wasn't configured and initialized yet. See the notes in
// mpv_create().
public const mpv_error_MPV_ERROR_UNINITIALIZED : mpv_error_mpv_error = -3

// Generic catch-all error if a parameter is set to an invalid or
// unsupported value. This is used if there is no better error code.
public const mpv_error_MPV_ERROR_INVALID_PARAMETER : mpv_error_mpv_error = -4

// Trying to set an option that doesn't exist.
public const mpv_error_MPV_ERROR_OPTION_NOT_FOUND : mpv_error_mpv_error = -5

// Trying to set an option using an unsupported MPV_FORMAT.
public const mpv_error_MPV_ERROR_OPTION_FORMAT : mpv_error_mpv_error = -6

// Setting the option failed. Typically this happens if the provided option
// value could not be parsed.
public const mpv_error_MPV_ERROR_OPTION_ERROR : mpv_error_mpv_error = -7

// The accessed property doesn't exist.
public const mpv_error_MPV_ERROR_PROPERTY_NOT_FOUND : mpv_error_mpv_error = -8

// Trying to set or get a property using an unsupported MPV_FORMAT.
public const mpv_error_MPV_ERROR_PROPERTY_FORMAT : mpv_error_mpv_error = -9

// The property exists, but is not available. This usually happens when the
// associated subsystem is not active, e.g. querying audio parameters while
// audio is disabled.
public const mpv_error_MPV_ERROR_PROPERTY_UNAVAILABLE : mpv_error_mpv_error = -10

// Error setting or getting a property.
public const mpv_error_MPV_ERROR_PROPERTY_ERROR : mpv_error_mpv_error = -11

// General error when running a command with mpv_command and similar.
public const mpv_error_MPV_ERROR_COMMAND : mpv_error_mpv_error = -12

// Generic error on loading (usually used with mpv_event_end_file.error).
public const mpv_error_MPV_ERROR_LOADING_FAILED : mpv_error_mpv_error = -13

// Initializing the audio output failed.
public const mpv_error_MPV_ERROR_AO_INIT_FAILED : mpv_error_mpv_error = -14

// Initializing the video output failed.
public const mpv_error_MPV_ERROR_VO_INIT_FAILED : mpv_error_mpv_error = -15

// There was no audio or video data to play. This also happens if the
// file was recognized, but did not contain any audio or video streams,
// or no streams were selected.
public const mpv_error_MPV_ERROR_NOTHING_TO_PLAY : mpv_error_mpv_error = -16

// When trying to load the file, the file format could not be determined,
// or the file was too broken to open it.
public const mpv_error_MPV_ERROR_UNKNOWN_FORMAT : mpv_error_mpv_error = -17

// Generic error for signaling that certain system requirements are not
// fulfilled.
public const mpv_error_MPV_ERROR_UNSUPPORTED : mpv_error_mpv_error = -18

// The API function which was called is a stub only.
public const mpv_error_MPV_ERROR_NOT_IMPLEMENTED : mpv_error_mpv_error = -19

// Unspecified error.
public const mpv_error_MPV_ERROR_GENERIC : mpv_error_mpv_error = -20

// List of error codes than can be returned by API functions. 0 and positive
// return values always mean success, negative values are always errors.
public type mpv_error_mpv_error = Int32

// Return a string describing the error. For unknown errors, the string
// "unknown error" is returned.
//
// @param error error number, see enum mpv_error
// @return A static string describing the error. The string is completely
//         static, i.e. doesn't need to be deallocated, and is valid forever.
foreign func mpv_error_string ( error: Int32 ) : CString

// General function to deallocate memory returned by some of the API functions.
// Call this only if it's explicitly documented as allowed. Calling this on
// mpv memory not owned by the caller will lead to undefined behavior.
//
// @param data A valid pointer returned by the API, or NULL.
foreign func mpv_free ( data: CPointer<Unit> ) : Unit

// Return the name of this client handle. Every client has its own unique
// name, which is mostly used for user interface purposes.
//
// @return The client name. The string is read-only and is valid until the
//         mpv_handle is destroyed.
foreign func mpv_client_name ( ctx: CPointer<mpv_handle_mpv_handle> ) : CString

// Return the ID of this client handle. Every client has its own unique ID. This
// ID is never reused by the core, even if the mpv_handle at hand gets destroyed
// and new handles get allocated.
//
// IDs are never 0 or negative.
//
// Some mpv APIs (not necessarily all) accept a name in the form "@<id>" in
// addition of the proper mpv_client_name(), where "<id>" is the ID in decimal
// form (e.g. "@123"). For example, the "script-message-to" command takes the
// client name as first argument, but also accepts the client ID formatted in
// this manner.
//
// @return The client ID.
foreign func mpv_client_id ( ctx: CPointer<mpv_handle_mpv_handle> ) : Int64

// Create a new mpv instance and an associated client API handle to control
// the mpv instance. This instance is in a pre-initialized state,
// and needs to be initialized to be actually used with most other API
// functions.
//
// Some API functions will return MPV_ERROR_UNINITIALIZED in the uninitialized
// state. You can call mpv_set_property() (or mpv_set_property_string() and
// other variants, and before mpv 0.21.0 mpv_set_option() etc.) to set initial
// options. After this, call mpv_initialize() to start the player, and then use
// e.g. mpv_command() to start playback of a file.
//
// The point of separating handle creation and actual initialization is that
// you can configure things which can't be changed during runtime.
//
// Unlike the command line player, this will have initial settings suitable
// for embedding in applications. The following settings are different:
// - stdin/stdout/stderr and the terminal will never be accessed. This is
//   equivalent to setting the --no-terminal option.
//   (Technically, this also suppresses C signal handling.)
// - No config files will be loaded. This is roughly equivalent to using
//   --config=no. Since libmpv 1.15, you can actually re-enable this option,
//   which will make libmpv load config files during mpv_initialize(). If you
//   do this, you are strongly encouraged to set the "config-dir" option too.
//   (Otherwise it will load the mpv command line player's config.)
//   For example:
//      mpv_set_option_string(mpv, "config-dir", "/my/path"); // set config root
//      mpv_set_option_string(mpv, "config", "yes"); // enable config loading
//      (call mpv_initialize() _after_ this)
// - Idle mode is enabled, which means the playback core will enter idle mode
//   if there are no more files to play on the internal playlist, instead of
//   exiting. This is equivalent to the --idle option.
// - Disable parts of input handling.
// - Most of the different settings can be viewed with the command line player
//   by running "mpv --show-profile=libmpv".
//
// All this assumes that API users want a mpv instance that is strictly
// isolated from the command line player's configuration, user settings, and
// so on. You can re-enable disabled features by setting the appropriate
// options.
//
// The mpv command line parser is not available through this API, but you can
// set individual options with mpv_set_property(). Files for playback must be
// loaded with mpv_command() or others.
//
// Note that you should avoid doing concurrent accesses on the uninitialized
// client handle. (Whether concurrent access is definitely allowed or not has
// yet to be decided.)
//
// @return a new mpv client API handle. Returns NULL on error. Currently, this
//         can happen in the following situations:
//         - out of memory
//         - LC_NUMERIC is not set to "C" (see general remarks)
foreign func mpv_create (  ) : CPointer<mpv_handle_mpv_handle>

// Initialize an uninitialized mpv instance. If the mpv instance is already
// running, an error is returned.
//
// This function needs to be called to make full use of the client API if the
// client API handle was created with mpv_create().
//
// Only the following options are required to be set _before_ mpv_initialize():
//      - options which are only read at initialization time:
//        - config
//        - config-dir
//        - input-conf
//        - load-scripts
//        - script
//        - player-operation-mode
//        - input-app-events (macOS)
//      - all encoding mode options
//
// @return error code
foreign func mpv_initialize ( ctx: CPointer<mpv_handle_mpv_handle> ) : Int32

// Disconnect and destroy the mpv_handle. ctx will be deallocated with this
// API call.
//
// If the last mpv_handle is detached, the core player is destroyed. In
// addition, if there are only weak mpv_handles (such as created by
// mpv_create_weak_client() or internal scripts), these mpv_handles will
// be sent MPV_EVENT_SHUTDOWN. This function may block until these clients
// have responded to the shutdown event, and the core is finally destroyed.
foreign func mpv_destroy ( ctx: CPointer<mpv_handle_mpv_handle> ) : Unit

// Similar to mpv_destroy(), but brings the player and all clients down
// as well, and waits until all of them are destroyed. This function blocks. The
// advantage over mpv_destroy() is that while mpv_destroy() merely
// detaches the client handle from the player, this function quits the player,
// waits until all other clients are destroyed (i.e. all mpv_handles are
// detached), and also waits for the final termination of the player.
//
// Since mpv_destroy() is called somewhere on the way, it's not safe to
// call other functions concurrently on the same context.
//
// Since mpv client API version 1.29:
//  The first call on any mpv_handle will block until the core is destroyed.
//  This means it will wait until other mpv_handle have been destroyed. If you
//  want asynchronous destruction, just run the "quit" command, and then react
//  to the MPV_EVENT_SHUTDOWN event.
//  If another mpv_handle already called mpv_terminate_destroy(), this call will
//  not actually block. It will destroy the mpv_handle, and exit immediately,
//  while other mpv_handles might still be uninitializing.
//
// Before mpv client API version 1.29:
//  If this is called on a mpv_handle that was not created with mpv_create(),
//  this function will merely send a quit command and then call
//  mpv_destroy(), without waiting for the actual shutdown.
foreign func mpv_terminate_destroy ( ctx: CPointer<mpv_handle_mpv_handle> ) : Unit

// Create a new client handle connected to the same player core as ctx. This
// context has its own event queue, its own mpv_request_event() state, its own
// mpv_request_log_messages() state, its own set of observed properties, and
// its own state for asynchronous operations. Otherwise, everything is shared.
//
// This handle should be destroyed with mpv_destroy() if no longer
// needed. The core will live as long as there is at least 1 handle referencing
// it. Any handle can make the core quit, which will result in every handle
// receiving MPV_EVENT_SHUTDOWN.
//
// This function can not be called before the main handle was initialized with
// mpv_initialize(). The new handle is always initialized, unless ctx=NULL was
// passed.
//
// @param ctx Used to get the reference to the mpv core; handle-specific
//            settings and parameters are not used.
//            If NULL, this function behaves like mpv_create() (ignores name).
// @param name The client name. This will be returned by mpv_client_name(). If
//             the name is already in use, or contains non-alphanumeric
//             characters (other than '_'), the name is modified to fit.
//             If NULL, an arbitrary name is automatically chosen.
// @return a new handle, or NULL on error
foreign func mpv_create_client ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString ) : CPointer<mpv_handle_mpv_handle>

// This is the same as mpv_create_client(), but the created mpv_handle is
// treated as a weak reference. If all mpv_handles referencing a core are
// weak references, the core is automatically destroyed. (This still goes
// through normal uninit of course. Effectively, if the last non-weak mpv_handle
// is destroyed, then the weak mpv_handles receive MPV_EVENT_SHUTDOWN and are
// asked to terminate as well.)
//
// Note if you want to use this like refcounting: you have to be aware that
// mpv_terminate_destroy() _and_ mpv_destroy() for the last non-weak
// mpv_handle will block until all weak mpv_handles are destroyed.
foreign func mpv_create_weak_client ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString ) : CPointer<mpv_handle_mpv_handle>

// Load a config file. This loads and parses the file, and sets every entry in
// the config file's default section as if mpv_set_option_string() is called.
//
// The filename should be an absolute path. If it isn't, the actual path used
// is unspecified. (Note: an absolute path starts with '/' on UNIX.) If the
// file wasn't found, MPV_ERROR_INVALID_PARAMETER is returned.
//
// If a fatal error happens when parsing a config file, MPV_ERROR_OPTION_ERROR
// is returned. Errors when setting options as well as other types or errors
// are ignored (even if options do not exist). You can still try to capture
// the resulting error messages with mpv_request_log_messages(). Note that it's
// possible that some options were successfully set even if any of these errors
// happen.
//
// @param filename absolute path to the config file on the local filesystem
// @return error code
foreign func mpv_load_config_file ( ctx: CPointer<mpv_handle_mpv_handle> , filename: CString ) : Int32

// Return the internal time in nanoseconds. This has an arbitrary start offset,
// but will never wrap or go backwards.
//
// Note that this is always the real time, and doesn't necessarily have to do
// with playback time. For example, playback could go faster or slower due to
// playback speed, or due to playback being paused. Use the "time-pos" property
// instead to get the playback status.
//
// Unlike other libmpv APIs, this can be called at absolutely any time (even
// within wakeup callbacks), as long as the context is valid.
//
// Safe to be called from mpv render API threads.
foreign func mpv_get_time_ns ( ctx: CPointer<mpv_handle_mpv_handle> ) : Int64

// Same as mpv_get_time_ns but in microseconds.
foreign func mpv_get_time_us ( ctx: CPointer<mpv_handle_mpv_handle> ) : Int64

// Invalid. Sometimes used for empty values. This is always defined to 0,
// so a normal 0-init of mpv_format (or e.g. mpv_node) is guaranteed to set
// this it to MPV_FORMAT_NONE (which makes some things saner as consequence).
public const mpv_format_MPV_FORMAT_NONE : mpv_format_mpv_format = 0

// The basic type is char*. It returns the raw property string, like
// using ${=property} in input.conf (see input.rst).
//
// NULL isn't an allowed value.
//
// Warning: although the encoding is usually UTF-8, this is not always the
//          case. File tags often store strings in some legacy codepage,
//          and even filenames don't necessarily have to be in UTF-8 (at
//          least on Linux). If you pass the strings to code that requires
//          valid UTF-8, you have to sanitize it in some way.
//          On Windows, filenames are always UTF-8, and libmpv converts
//          between UTF-8 and UTF-16 when using win32 API functions. See
//          the "Encoding of filenames" section for details.
//
// Example for reading:
//
//     char *result = NULL;
//     if (mpv_get_property(ctx, "property", MPV_FORMAT_STRING, &result) < 0)
//         goto error;
//     printf("%s\n", result);
//     mpv_free(result);
//
// Or just use mpv_get_property_string().
//
// Example for writing:
//
//     char *value = "the new value";
//     // yep, you pass the address to the variable
//     // (needed for symmetry with other types and mpv_get_property)
//     mpv_set_property(ctx, "property", MPV_FORMAT_STRING, &value);
//
// Or just use mpv_set_property_string().
//
public const mpv_format_MPV_FORMAT_STRING : mpv_format_mpv_format = 1

// The basic type is char*. It returns the OSD property string, like
// using ${property} in input.conf (see input.rst). In many cases, this
// is the same as the raw string, but in other cases it's formatted for
// display on OSD. It's intended to be human readable. Do not attempt to
// parse these strings.
//
// Only valid when doing read access. The rest works like MPV_FORMAT_STRING.
public const mpv_format_MPV_FORMAT_OSD_STRING : mpv_format_mpv_format = 2

// The basic type is int. The only allowed values are 0 ("no")
// and 1 ("yes").
//
// Example for reading:
//
//     int result;
//     if (mpv_get_property(ctx, "property", MPV_FORMAT_FLAG, &result) < 0)
//         goto error;
//     printf("%s\n", result ? "true" : "false");
//
// Example for writing:
//
//     int flag = 1;
//     mpv_set_property(ctx, "property", MPV_FORMAT_FLAG, &flag);
public const mpv_format_MPV_FORMAT_FLAG : mpv_format_mpv_format = 3

// The basic type is int64_t.
public const mpv_format_MPV_FORMAT_INT64 : mpv_format_mpv_format = 4

// The basic type is double.
public const mpv_format_MPV_FORMAT_DOUBLE : mpv_format_mpv_format = 5

// The type is mpv_node.
//
// For reading, you usually would pass a pointer to a stack-allocated
// mpv_node value to mpv, and when you're done you call
// mpv_free_node_contents(&node).
// You're expected not to write to the data - if you have to, copy it
// first (which you have to do manually).
//
// For writing, you construct your own mpv_node, and pass a pointer to the
// API. The API will never write to your data (and copy it if needed), so
// you're free to use any form of allocation or memory management you like.
//
// Warning: when reading, always check the mpv_node.format member. For
//          example, properties might change their type in future versions
//          of mpv, or sometimes even during runtime.
//
// Example for reading:
//
//     mpv_node result;
//     if (mpv_get_property(ctx, "property", MPV_FORMAT_NODE, &result) < 0)
//         goto error;
//     printf("format=%d\n", (int)result.format);
//     mpv_free_node_contents(&result).
//
// Example for writing:
//
//     mpv_node value;
//     value.format = MPV_FORMAT_STRING;
//     value.u.string = "hello";
//     mpv_set_property(ctx, "property", MPV_FORMAT_NODE, &value);
public const mpv_format_MPV_FORMAT_NODE : mpv_format_mpv_format = 6

// Used with mpv_node only. Can usually not be used directly.
public const mpv_format_MPV_FORMAT_NODE_ARRAY : mpv_format_mpv_format = 7

// See MPV_FORMAT_NODE_ARRAY.
public const mpv_format_MPV_FORMAT_NODE_MAP : mpv_format_mpv_format = 8

// A raw, untyped byte array. Only used only with mpv_node, and only in
// some very specific situations. (Some commands use it.)
public const mpv_format_MPV_FORMAT_BYTE_ARRAY : mpv_format_mpv_format = 9

// Data format for options and properties. The API functions to get/set
// properties and options support multiple formats, and this enum describes
// them.
public type mpv_format_mpv_format = UInt32

@C
public struct mpv_node__cjbind_ty_1__cjbind_ty_1 {
var _storage: UInt64 = unsafe { zeroValue<UInt64>() }
public init() {}
public func string(): CString {
    return __cjbind_read_CString_from_UInt64(this._storage)
}
public mut func string(val!: CString): Unit {
    this._storage = __cjbind_write_CString_from_UInt64(this._storage, val)
}
public func flag(): Int32 {
    return __cjbind_read_Int32_from_UInt64(this._storage)
}
public mut func flag(val!: Int32): Unit {
    this._storage = __cjbind_write_Int32_from_UInt64(this._storage, val)
}
public func int64(): Int64 {
    return __cjbind_read_Int64_from_UInt64(this._storage)
}
public mut func int64(val!: Int64): Unit {
    this._storage = __cjbind_write_Int64_from_UInt64(this._storage, val)
}
public func double_(): Float64 {
    return __cjbind_read_Float64_from_UInt64(this._storage)
}
public mut func double_(val!: Float64): Unit {
    this._storage = __cjbind_write_Float64_from_UInt64(this._storage, val)
}
public func list(): CPointer<mpv_node_list_mpv_node_list> {
    return __cjbind_read_CPointer_mpv_node_list_mpv_node_list__from_UInt64(this._storage)
}
public mut func list(val!: CPointer<mpv_node_list_mpv_node_list>): Unit {
    this._storage = __cjbind_write_CPointer_mpv_node_list_mpv_node_list__from_UInt64(this._storage, val)
}
public func ba(): CPointer<mpv_byte_array_mpv_byte_array> {
    return __cjbind_read_CPointer_mpv_byte_array_mpv_byte_array__from_UInt64(this._storage)
}
public mut func ba(val!: CPointer<mpv_byte_array_mpv_byte_array>): Unit {
    this._storage = __cjbind_write_CPointer_mpv_byte_array_mpv_byte_array__from_UInt64(this._storage, val)
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_node__cjbind_ty_1__cjbind_ty_1>()
    if (size != 8) {
        throw Exception("Size of mpv_node__cjbind_ty_1__cjbind_ty_1 is not 8 but ${size} bytes")
    }
    let align = alignOf<mpv_node__cjbind_ty_1__cjbind_ty_1>()
    if (align != 8) {
        throw Exception("Alignment of mpv_node__cjbind_ty_1__cjbind_ty_1 is not 8 but ${align} bytes")
    }
}

// Generic data storage.
//
// If mpv writes this struct (e.g. via mpv_get_property()), you must not change
// the data. In some cases (mpv_get_property()), you have to free it with
// mpv_free_node_contents(). If you fill this struct yourself, you're also
// responsible for freeing it, and you must not call mpv_free_node_contents().
@C
public struct mpv_node_mpv_node {
public let u : mpv_node__cjbind_ty_1__cjbind_ty_1
// Type of the data stored in this struct. This value rules what members in
// the given union can be accessed. The following formats are currently
// defined to be allowed in mpv_node:
//
//  MPV_FORMAT_STRING       (u.string)
//  MPV_FORMAT_FLAG         (u.flag)
//  MPV_FORMAT_INT64        (u.int64)
//  MPV_FORMAT_DOUBLE       (u.double_)
//  MPV_FORMAT_NODE_ARRAY   (u.list)
//  MPV_FORMAT_NODE_MAP     (u.list)
//  MPV_FORMAT_BYTE_ARRAY   (u.ba)
//  MPV_FORMAT_NONE         (no member)
//
// If you encounter a value you don't know, you must not make any
// assumptions about the contents of union u.
public let format : mpv_format_mpv_format
public init(u : mpv_node__cjbind_ty_1__cjbind_ty_1 , format : mpv_format_mpv_format) {
    this.u = u
this.format = format
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_node_mpv_node>()
    if (size != 16) {
        throw Exception("Size of mpv_node_mpv_node is not 16 but ${size} bytes")
    }
    let align = alignOf<mpv_node_mpv_node>()
    if (align != 8) {
        throw Exception("Alignment of mpv_node_mpv_node is not 8 but ${align} bytes")
    }
}

// (see mpv_node)
@C
public struct mpv_node_list_mpv_node_list {
// Number of entries. Negative values are not allowed.
public let num : Int32
// MPV_FORMAT_NODE_ARRAY:
//  values[N] refers to value of the Nth item
//
// MPV_FORMAT_NODE_MAP:
//  values[N] refers to value of the Nth key/value pair
//
// If num > 0, values[0] to values[num-1] (inclusive) are valid.
// Otherwise, this can be NULL.
public let values : CPointer<mpv_node_mpv_node>
// MPV_FORMAT_NODE_ARRAY:
//  unused (typically NULL), access is not allowed
//
// MPV_FORMAT_NODE_MAP:
//  keys[N] refers to key of the Nth key/value pair. If num > 0, keys[0] to
//  keys[num-1] (inclusive) are valid. Otherwise, this can be NULL.
//  The keys are in random order. The only guarantee is that keys[N] belongs
//  to the value values[N]. NULL keys are not allowed.
public let keys : CPointer<CString>
public init(num : Int32 , values : CPointer<mpv_node_mpv_node> , keys : CPointer<CString>) {
    this.num = num
this.values = values
this.keys = keys
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_node_list_mpv_node_list>()
    if (size != 24) {
        throw Exception("Size of mpv_node_list_mpv_node_list is not 24 but ${size} bytes")
    }
    let align = alignOf<mpv_node_list_mpv_node_list>()
    if (align != 8) {
        throw Exception("Alignment of mpv_node_list_mpv_node_list is not 8 but ${align} bytes")
    }
}

// (see mpv_node)
@C
public struct mpv_byte_array_mpv_byte_array {
// Pointer to the data. In what format the data is stored is up to whatever
// uses MPV_FORMAT_BYTE_ARRAY.
public let data : CPointer<Unit>
// Size of the data pointed to by ptr.
public let size : UIntNative
public init(data : CPointer<Unit> , size : UIntNative) {
    this.data = data
this.size = size
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_byte_array_mpv_byte_array>()
    if (size != 16) {
        throw Exception("Size of mpv_byte_array_mpv_byte_array is not 16 but ${size} bytes")
    }
    let align = alignOf<mpv_byte_array_mpv_byte_array>()
    if (align != 8) {
        throw Exception("Alignment of mpv_byte_array_mpv_byte_array is not 8 but ${align} bytes")
    }
}

// Frees any data referenced by the node. It doesn't free the node itself.
// Call this only if the mpv client API set the node. If you constructed the
// node yourself (manually), you have to free it yourself.
//
// If node->format is MPV_FORMAT_NONE, this call does nothing. Likewise, if
// the client API sets a node with this format, this function doesn't need to
// be called. (This is just a clarification that there's no danger of anything
// strange happening in these cases.)
foreign func mpv_free_node_contents ( node: CPointer<mpv_node_mpv_node> ) : Unit

// Set an option. Note that you can't normally set options during runtime. It
// works in uninitialized state (see mpv_create()), and in some cases in at
// runtime.
//
// Using a format other than MPV_FORMAT_NODE is equivalent to constructing a
// mpv_node with the given format and data, and passing the mpv_node to this
// function.
//
// Note: this is semi-deprecated. For most purposes, this is not needed anymore.
//       Starting with mpv version 0.21.0 (version 1.23) most options can be set
//       with mpv_set_property() (and related functions), and even before
//       mpv_initialize(). In some obscure corner cases, using this function
//       to set options might still be required (see
//       "Inconsistencies between options and properties" in the manpage). Once
//       these are resolved, the option setting functions might be fully
//       deprecated.
//
// @param name Option name. This is the same as on the mpv command line, but
//             without the leading "--".
// @param format see enum mpv_format.
// @param[in] data Option value (according to the format).
// @return error code
foreign func mpv_set_option ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString , format: mpv_format_mpv_format , data: CPointer<Unit> ) : Int32

// Convenience function to set an option to a string value. This is like
// calling mpv_set_option() with MPV_FORMAT_STRING.
//
// @return error code
foreign func mpv_set_option_string ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString , data: CString ) : Int32

// Send a command to the player. Commands are the same as those used in
// input.conf, except that this function takes parameters in a pre-split
// form.
//
// The commands and their parameters are documented in input.rst.
//
// Does not use OSD and string expansion by default (unlike mpv_command_string()
// and input.conf).
//
// @param[in] args NULL-terminated list of strings. Usually, the first item
//                 is the command, and the following items are arguments.
// @return error code
foreign func mpv_command ( ctx: CPointer<mpv_handle_mpv_handle> , args: CPointer<CString> ) : Int32

// Same as mpv_command(), but allows passing structured data in any format.
// In particular, calling mpv_command() is exactly like calling
// mpv_command_node() with the format set to MPV_FORMAT_NODE_ARRAY, and
// every arg passed in order as MPV_FORMAT_STRING.
//
// Does not use OSD and string expansion by default.
//
// The args argument can have one of the following formats:
//
// MPV_FORMAT_NODE_ARRAY:
//      Positional arguments. Each entry is an argument using an arbitrary
//      format (the format must be compatible to the used command). Usually,
//      the first item is the command name (as MPV_FORMAT_STRING). The order
//      of arguments is as documented in each command description.
//
// MPV_FORMAT_NODE_MAP:
//      Named arguments. This requires at least an entry with the key "name"
//      to be present, which must be a string, and contains the command name.
//      The special entry "_flags" is optional, and if present, must be an
//      array of strings, each being a command prefix to apply. All other
//      entries are interpreted as arguments. They must use the argument names
//      as documented in each command description. Some commands do not
//      support named arguments at all, and must use MPV_FORMAT_NODE_ARRAY.
//
// @param[in] args mpv_node with format set to one of the values documented
//                 above (see there for details)
// @param[out] result Optional, pass NULL if unused. If not NULL, and if the
//                    function succeeds, this is set to command-specific return
//                    data. You must call mpv_free_node_contents() to free it
//                    (again, only if the command actually succeeds).
//                    Not many commands actually use this at all.
// @return error code (the result parameter is not set on error)
foreign func mpv_command_node ( ctx: CPointer<mpv_handle_mpv_handle> , args: CPointer<mpv_node_mpv_node> , result: CPointer<mpv_node_mpv_node> ) : Int32

// This is essentially identical to mpv_command() but it also returns a result.
//
// Does not use OSD and string expansion by default.
//
// @param[in] args NULL-terminated list of strings. Usually, the first item
//                 is the command, and the following items are arguments.
// @param[out] result Optional, pass NULL if unused. If not NULL, and if the
//                    function succeeds, this is set to command-specific return
//                    data. You must call mpv_free_node_contents() to free it
//                    (again, only if the command actually succeeds).
//                    Not many commands actually use this at all.
// @return error code (the result parameter is not set on error)
foreign func mpv_command_ret ( ctx: CPointer<mpv_handle_mpv_handle> , args: CPointer<CString> , result: CPointer<mpv_node_mpv_node> ) : Int32

// Same as mpv_command, but use input.conf parsing for splitting arguments.
// This is slightly simpler, but also more error prone, since arguments may
// need quoting/escaping.
//
// This also has OSD and string expansion enabled by default.
foreign func mpv_command_string ( ctx: CPointer<mpv_handle_mpv_handle> , args: CString ) : Int32

// Same as mpv_command, but run the command asynchronously.
//
// Commands are executed asynchronously. You will receive a
// MPV_EVENT_COMMAND_REPLY event. This event will also have an
// error code set if running the command failed. For commands that
// return data, the data is put into mpv_event_command.result.
//
// The only case when you do not receive an event is when the function call
// itself fails. This happens only if parsing the command itself (or otherwise
// validating it) fails, i.e. the return code of the API call is not 0 or
// positive.
//
// Safe to be called from mpv render API threads.
//
// @param reply_userdata the value mpv_event.reply_userdata of the reply will
//                       be set to (see section about asynchronous calls)
// @param args NULL-terminated list of strings (see mpv_command())
// @return error code (if parsing or queuing the command fails)
foreign func mpv_command_async ( ctx: CPointer<mpv_handle_mpv_handle> , reply_userdata: UInt64 , args: CPointer<CString> ) : Int32

// Same as mpv_command_node(), but run it asynchronously. Basically, this
// function is to mpv_command_node() what mpv_command_async() is to
// mpv_command().
//
// See mpv_command_async() for details.
//
// Safe to be called from mpv render API threads.
//
// @param reply_userdata the value mpv_event.reply_userdata of the reply will
//                       be set to (see section about asynchronous calls)
// @param args as in mpv_command_node()
// @return error code (if parsing or queuing the command fails)
foreign func mpv_command_node_async ( ctx: CPointer<mpv_handle_mpv_handle> , reply_userdata: UInt64 , args: CPointer<mpv_node_mpv_node> ) : Int32

// Signal to all async requests with the matching ID to abort. This affects
// the following API calls:
//
//      mpv_command_async
//      mpv_command_node_async
//
// All of these functions take a reply_userdata parameter. This API function
// tells all requests with the matching reply_userdata value to try to return
// as soon as possible. If there are multiple requests with matching ID, it
// aborts all of them.
//
// This API function is mostly asynchronous itself. It will not wait until the
// command is aborted. Instead, the command will terminate as usual, but with
// some work not done. How this is signaled depends on the specific command (for
// example, the "subprocess" command will indicate it by "killed_by_us" set to
// true in the result). How long it takes also depends on the situation. The
// aborting process is completely asynchronous.
//
// Not all commands may support this functionality. In this case, this function
// will have no effect. The same is true if the request using the passed
// reply_userdata has already terminated, has not been started yet, or was
// never in use at all.
//
// You have to be careful of race conditions: the time during which the abort
// request will be effective is _after_ e.g. mpv_command_async() has returned,
// and before the command has signaled completion with MPV_EVENT_COMMAND_REPLY.
//
// @param reply_userdata ID of the request to be aborted (see above)
foreign func mpv_abort_async_command ( ctx: CPointer<mpv_handle_mpv_handle> , reply_userdata: UInt64 ) : Unit

// Set a property to a given value. Properties are essentially variables which
// can be queried or set at runtime. For example, writing to the pause property
// will actually pause or unpause playback.
//
// If the format doesn't match with the internal format of the property, access
// usually will fail with MPV_ERROR_PROPERTY_FORMAT. In some cases, the data
// is automatically converted and access succeeds. For example, MPV_FORMAT_INT64
// is always converted to MPV_FORMAT_DOUBLE, and access using MPV_FORMAT_STRING
// usually invokes a string parser. The same happens when calling this function
// with MPV_FORMAT_NODE: the underlying format may be converted to another
// type if possible.
//
// Using a format other than MPV_FORMAT_NODE is equivalent to constructing a
// mpv_node with the given format and data, and passing the mpv_node to this
// function. (Before API version 1.21, this was different.)
//
// Note: starting with mpv 0.21.0 (client API version 1.23), this can be used to
//       set options in general. It even can be used before mpv_initialize()
//       has been called. If called before mpv_initialize(), setting properties
//       not backed by options will result in MPV_ERROR_PROPERTY_UNAVAILABLE.
//       In some cases, properties and options still conflict. In these cases,
//       mpv_set_property() accesses the options before mpv_initialize(), and
//       the properties after mpv_initialize(). These conflicts will be removed
//       in mpv 0.23.0. See mpv_set_option() for further remarks.
//
// @param name The property name. See input.rst for a list of properties.
// @param format see enum mpv_format.
// @param[in] data Option value.
// @return error code
foreign func mpv_set_property ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString , format: mpv_format_mpv_format , data: CPointer<Unit> ) : Int32

// Convenience function to set a property to a string value.
//
// This is like calling mpv_set_property() with MPV_FORMAT_STRING.
foreign func mpv_set_property_string ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString , data: CString ) : Int32

// Convenience function to delete a property.
//
// This is equivalent to running the command "del [name]".
//
// @param name The property name. See input.rst for a list of properties.
// @return error code
foreign func mpv_del_property ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString ) : Int32

// Set a property asynchronously. You will receive the result of the operation
// as MPV_EVENT_SET_PROPERTY_REPLY event. The mpv_event.error field will contain
// the result status of the operation. Otherwise, this function is similar to
// mpv_set_property().
//
// Safe to be called from mpv render API threads.
//
// @param reply_userdata see section about asynchronous calls
// @param name The property name.
// @param format see enum mpv_format.
// @param[in] data Option value. The value will be copied by the function. It
//                 will never be modified by the client API.
// @return error code if sending the request failed
foreign func mpv_set_property_async ( ctx: CPointer<mpv_handle_mpv_handle> , reply_userdata: UInt64 , name: CString , format: mpv_format_mpv_format , data: CPointer<Unit> ) : Int32

// Read the value of the given property.
//
// If the format doesn't match with the internal format of the property, access
// usually will fail with MPV_ERROR_PROPERTY_FORMAT. In some cases, the data
// is automatically converted and access succeeds. For example, MPV_FORMAT_INT64
// is always converted to MPV_FORMAT_DOUBLE, and access using MPV_FORMAT_STRING
// usually invokes a string formatter.
//
// @param name The property name.
// @param format see enum mpv_format.
// @param[out] data Pointer to the variable holding the option value. On
//                  success, the variable will be set to a copy of the option
//                  value. For formats that require dynamic memory allocation,
//                  you can free the value with mpv_free() (strings) or
//                  mpv_free_node_contents() (MPV_FORMAT_NODE).
// @return error code
foreign func mpv_get_property ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString , format: mpv_format_mpv_format , data: CPointer<Unit> ) : Int32

// Return the value of the property with the given name as string. This is
// equivalent to mpv_get_property() with MPV_FORMAT_STRING.
//
// See MPV_FORMAT_STRING for character encoding issues.
//
// On error, NULL is returned. Use mpv_get_property() if you want fine-grained
// error reporting.
//
// @param name The property name.
// @return Property value, or NULL if the property can't be retrieved. Free
//         the string with mpv_free().
foreign func mpv_get_property_string ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString ) : CString

// Return the property as "OSD" formatted string. This is the same as
// mpv_get_property_string, but using MPV_FORMAT_OSD_STRING.
//
// @return Property value, or NULL if the property can't be retrieved. Free
//         the string with mpv_free().
foreign func mpv_get_property_osd_string ( ctx: CPointer<mpv_handle_mpv_handle> , name: CString ) : CString

// Get a property asynchronously. You will receive the result of the operation
// as well as the property data with the MPV_EVENT_GET_PROPERTY_REPLY event.
// You should check the mpv_event.error field on the reply event.
//
// Safe to be called from mpv render API threads.
//
// @param reply_userdata see section about asynchronous calls
// @param name The property name.
// @param format see enum mpv_format.
// @return error code if sending the request failed
foreign func mpv_get_property_async ( ctx: CPointer<mpv_handle_mpv_handle> , reply_userdata: UInt64 , name: CString , format: mpv_format_mpv_format ) : Int32

// Get a notification whenever the given property changes. You will receive
// updates as MPV_EVENT_PROPERTY_CHANGE. Note that this is not very precise:
// for some properties, it may not send updates even if the property changed.
// This depends on the property, and it's a valid feature request to ask for
// better update handling of a specific property. (For some properties, like
// ``clock``, which shows the wall clock, this mechanism doesn't make too
// much sense anyway.)
//
// Property changes are coalesced: the change events are returned only once the
// event queue becomes empty (e.g. mpv_wait_event() would block or return
// MPV_EVENT_NONE), and then only one event per changed property is returned.
//
// You always get an initial change notification. This is meant to initialize
// the user's state to the current value of the property.
//
// Normally, change events are sent only if the property value changes according
// to the requested format. mpv_event_property will contain the property value
// as data member.
//
// Warning: if a property is unavailable or retrieving it caused an error,
//          MPV_FORMAT_NONE will be set in mpv_event_property, even if the
//          format parameter was set to a different value. In this case, the
//          mpv_event_property.data field is invalid.
//
// If the property is observed with the format parameter set to MPV_FORMAT_NONE,
// you get low-level notifications whether the property _may_ have changed, and
// the data member in mpv_event_property will be unset. With this mode, you
// will have to determine yourself whether the property really changed. On the
// other hand, this mechanism can be faster and uses less resources.
//
// Observing a property that doesn't exist is allowed. (Although it may still
// cause some sporadic change events.)
//
// Keep in mind that you will get change notifications even if you change a
// property yourself. Try to avoid endless feedback loops, which could happen
// if you react to the change notifications triggered by your own change.
//
// Only the mpv_handle on which this was called will receive the property
// change events, or can unobserve them.
//
// Safe to be called from mpv render API threads.
//
// @param reply_userdata This will be used for the mpv_event.reply_userdata
//                       field for the received MPV_EVENT_PROPERTY_CHANGE
//                       events. (Also see section about asynchronous calls,
//                       although this function is somewhat different from
//                       actual asynchronous calls.)
//                       If you have no use for this, pass 0.
//                       Also see mpv_unobserve_property().
// @param name The property name.
// @param format see enum mpv_format. Can be MPV_FORMAT_NONE to omit values
//               from the change events.
// @return error code (usually fails only on OOM or unsupported format)
foreign func mpv_observe_property ( mpv: CPointer<mpv_handle_mpv_handle> , reply_userdata: UInt64 , name: CString , format: mpv_format_mpv_format ) : Int32

// Undo mpv_observe_property(). This will remove all observed properties for
// which the given number was passed as reply_userdata to mpv_observe_property.
//
// Safe to be called from mpv render API threads.
//
// @param registered_reply_userdata ID that was passed to mpv_observe_property
// @return negative value is an error code, >=0 is number of removed properties
//         on success (includes the case when 0 were removed)
foreign func mpv_unobserve_property ( mpv: CPointer<mpv_handle_mpv_handle> , registered_reply_userdata: UInt64 ) : Int32

// Nothing happened. Happens on timeouts or sporadic wakeups.
public const mpv_event_id_MPV_EVENT_NONE : mpv_event_id_mpv_event_id = 0

// Happens when the player quits. The player enters a state where it tries
// to disconnect all clients. Most requests to the player will fail, and
// the client should react to this and quit with mpv_destroy() as soon as
// possible.
public const mpv_event_id_MPV_EVENT_SHUTDOWN : mpv_event_id_mpv_event_id = 1

// See mpv_request_log_messages().
public const mpv_event_id_MPV_EVENT_LOG_MESSAGE : mpv_event_id_mpv_event_id = 2

// Reply to a mpv_get_property_async() request.
// See also mpv_event and mpv_event_property.
public const mpv_event_id_MPV_EVENT_GET_PROPERTY_REPLY : mpv_event_id_mpv_event_id = 3

// Reply to a mpv_set_property_async() request.
// (Unlike MPV_EVENT_GET_PROPERTY, mpv_event_property is not used.)
public const mpv_event_id_MPV_EVENT_SET_PROPERTY_REPLY : mpv_event_id_mpv_event_id = 4

// Reply to a mpv_command_async() or mpv_command_node_async() request.
// See also mpv_event and mpv_event_command.
public const mpv_event_id_MPV_EVENT_COMMAND_REPLY : mpv_event_id_mpv_event_id = 5

// Notification before playback start of a file (before the file is loaded).
// See also mpv_event and mpv_event_start_file.
public const mpv_event_id_MPV_EVENT_START_FILE : mpv_event_id_mpv_event_id = 6

// Notification after playback end (after the file was unloaded).
// See also mpv_event and mpv_event_end_file.
public const mpv_event_id_MPV_EVENT_END_FILE : mpv_event_id_mpv_event_id = 7

// Notification when the file has been loaded (headers were read etc.), and
// decoding starts.
public const mpv_event_id_MPV_EVENT_FILE_LOADED : mpv_event_id_mpv_event_id = 8

// Idle mode was entered. In this mode, no file is played, and the playback
// core waits for new commands. (The command line player normally quits
// instead of entering idle mode, unless --idle was specified. If mpv
// was started with mpv_create(), idle mode is enabled by default.)
//
// @deprecated This is equivalent to using mpv_observe_property() on the
//             "idle-active" property. The event is redundant, and might be
//             removed in the far future. As a further warning, this event
//             is not necessarily sent at the right point anymore (at the
//             start of the program), while the property behaves correctly.
public const mpv_event_id_MPV_EVENT_IDLE : mpv_event_id_mpv_event_id = 11

// Sent every time after a video frame is displayed. Note that currently,
// this will be sent in lower frequency if there is no video, or playback
// is paused - but that will be removed in the future, and it will be
// restricted to video frames only.
//
// @deprecated Use mpv_observe_property() with relevant properties instead
//             (such as "playback-time").
public const mpv_event_id_MPV_EVENT_TICK : mpv_event_id_mpv_event_id = 14

// Triggered by the script-message input command. The command uses the
// first argument of the command as client name (see mpv_client_name()) to
// dispatch the message, and passes along all arguments starting from the
// second argument as strings.
// See also mpv_event and mpv_event_client_message.
public const mpv_event_id_MPV_EVENT_CLIENT_MESSAGE : mpv_event_id_mpv_event_id = 16

// Happens after video changed in some way. This can happen on resolution
// changes, pixel format changes, or video filter changes. The event is
// sent after the video filters and the VO are reconfigured. Applications
// embedding a mpv window should listen to this event in order to resize
// the window if needed.
// Note that this event can happen sporadically, and you should check
// yourself whether the video parameters really changed before doing
// something expensive.
public const mpv_event_id_MPV_EVENT_VIDEO_RECONFIG : mpv_event_id_mpv_event_id = 17

// Similar to MPV_EVENT_VIDEO_RECONFIG. This is relatively uninteresting,
// because there is no such thing as audio output embedding.
public const mpv_event_id_MPV_EVENT_AUDIO_RECONFIG : mpv_event_id_mpv_event_id = 18

// Happens when a seek was initiated. Playback stops. Usually it will
// resume with MPV_EVENT_PLAYBACK_RESTART as soon as the seek is finished.
public const mpv_event_id_MPV_EVENT_SEEK : mpv_event_id_mpv_event_id = 20

// There was a discontinuity of some sort (like a seek), and playback
// was reinitialized. Usually happens on start of playback and after
// seeking. The main purpose is allowing the client to detect when a seek
// request is finished.
public const mpv_event_id_MPV_EVENT_PLAYBACK_RESTART : mpv_event_id_mpv_event_id = 21

// Event sent due to mpv_observe_property().
// See also mpv_event and mpv_event_property.
public const mpv_event_id_MPV_EVENT_PROPERTY_CHANGE : mpv_event_id_mpv_event_id = 22

// Happens if the internal per-mpv_handle ringbuffer overflows, and at
// least 1 event had to be dropped. This can happen if the client doesn't
// read the event queue quickly enough with mpv_wait_event(), or if the
// client makes a very large number of asynchronous calls at once.
//
// Event delivery will continue normally once this event was returned
// (this forces the client to empty the queue completely).
public const mpv_event_id_MPV_EVENT_QUEUE_OVERFLOW : mpv_event_id_mpv_event_id = 24

// Triggered if a hook handler was registered with mpv_hook_add(), and the
// hook is invoked. If you receive this, you must handle it, and continue
// the hook with mpv_hook_continue().
// See also mpv_event and mpv_event_hook.
public const mpv_event_id_MPV_EVENT_HOOK : mpv_event_id_mpv_event_id = 25

public type mpv_event_id_mpv_event_id = UInt32

// Return a string describing the event. For unknown events, NULL is returned.
//
// Note that all events actually returned by the API will also yield a non-NULL
// string with this function.
//
// @param event event ID, see see enum mpv_event_id
// @return A static string giving a short symbolic name of the event. It
//         consists of lower-case alphanumeric characters and can include "-"
//         characters. This string is suitable for use in e.g. scripting
//         interfaces.
//         The string is completely static, i.e. doesn't need to be deallocated,
//         and is valid forever.
foreign func mpv_event_name ( event: mpv_event_id_mpv_event_id ) : CString

@C
public struct mpv_event_property_mpv_event_property {
// Name of the property.
public let name : CString
// Format of the data field in the same struct. See enum mpv_format.
// This is always the same format as the requested format, except when
// the property could not be retrieved (unavailable, or an error happened),
// in which case the format is MPV_FORMAT_NONE.
public let format : mpv_format_mpv_format
// Received property value. Depends on the format. This is like the
// pointer argument passed to mpv_get_property().
//
// For example, for MPV_FORMAT_STRING you get the string with:
//
//    char *value = *(char **)(event_property->data);
//
// Note that this is set to NULL if retrieving the property failed (the
// format will be MPV_FORMAT_NONE).
public let data : CPointer<Unit>
public init(name : CString , format : mpv_format_mpv_format , data : CPointer<Unit>) {
    this.name = name
this.format = format
this.data = data
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_event_property_mpv_event_property>()
    if (size != 24) {
        throw Exception("Size of mpv_event_property_mpv_event_property is not 24 but ${size} bytes")
    }
    let align = alignOf<mpv_event_property_mpv_event_property>()
    if (align != 8) {
        throw Exception("Alignment of mpv_event_property_mpv_event_property is not 8 but ${align} bytes")
    }
}

public const mpv_log_level_MPV_LOG_LEVEL_NONE : mpv_log_level_mpv_log_level = 0

// "no"    - disable absolutely all messages
public const mpv_log_level_MPV_LOG_LEVEL_FATAL : mpv_log_level_mpv_log_level = 10

// "fatal" - critical/aborting errors
public const mpv_log_level_MPV_LOG_LEVEL_ERROR : mpv_log_level_mpv_log_level = 20

// "error" - simple errors
public const mpv_log_level_MPV_LOG_LEVEL_WARN : mpv_log_level_mpv_log_level = 30

// "warn"  - possible problems
public const mpv_log_level_MPV_LOG_LEVEL_INFO : mpv_log_level_mpv_log_level = 40

// "info"  - informational message
public const mpv_log_level_MPV_LOG_LEVEL_V : mpv_log_level_mpv_log_level = 50

// "v"     - noisy informational message
public const mpv_log_level_MPV_LOG_LEVEL_DEBUG : mpv_log_level_mpv_log_level = 60

// "debug" - very noisy technical information
public const mpv_log_level_MPV_LOG_LEVEL_TRACE : mpv_log_level_mpv_log_level = 70

// Numeric log levels. The lower the number, the more important the message is.
// MPV_LOG_LEVEL_NONE is never used when receiving messages. The string in
// the comment after the value is the name of the log level as used for the
// mpv_request_log_messages() function.
// Unused numeric values are unused, but reserved for future use.
public type mpv_log_level_mpv_log_level = UInt32

@C
public struct mpv_event_log_message_mpv_event_log_message {
// The module prefix, identifies the sender of the message. As a special
// case, if the message buffer overflows, this will be set to the string
// "overflow" (which doesn't appear as prefix otherwise), and the text
// field will contain an informative message.
public let prefix : CString
// The log level as string. See mpv_request_log_messages() for possible
// values. The level "no" is never used here.
public let level : CString
// The log message. It consists of 1 line of text, and is terminated with
// a newline character. (Before API version 1.6, it could contain multiple
// or partial lines.)
public let text : CString
// The same contents as the level field, but as a numeric ID.
// Since API version 1.6.
public let log_level : mpv_log_level_mpv_log_level
public init(prefix : CString , level : CString , text : CString , log_level : mpv_log_level_mpv_log_level) {
    this.prefix = prefix
this.level = level
this.text = text
this.log_level = log_level
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_event_log_message_mpv_event_log_message>()
    if (size != 32) {
        throw Exception("Size of mpv_event_log_message_mpv_event_log_message is not 32 but ${size} bytes")
    }
    let align = alignOf<mpv_event_log_message_mpv_event_log_message>()
    if (align != 8) {
        throw Exception("Alignment of mpv_event_log_message_mpv_event_log_message is not 8 but ${align} bytes")
    }
}

// The end of file was reached. Sometimes this may also happen on
// incomplete or corrupted files, or if the network connection was
// interrupted when playing a remote file. It also happens if the
// playback range was restricted with --end or --frames or similar.
public const mpv_end_file_reason_MPV_END_FILE_REASON_EOF : mpv_end_file_reason_mpv_end_file_reason = 0

// Playback was stopped by an external action (e.g. playlist controls).
public const mpv_end_file_reason_MPV_END_FILE_REASON_STOP : mpv_end_file_reason_mpv_end_file_reason = 2

// Playback was stopped by the quit command or player shutdown.
public const mpv_end_file_reason_MPV_END_FILE_REASON_QUIT : mpv_end_file_reason_mpv_end_file_reason = 3

// Some kind of error happened that lead to playback abort. Does not
// necessarily happen on incomplete or broken files (in these cases, both
// MPV_END_FILE_REASON_ERROR or MPV_END_FILE_REASON_EOF are possible).
//
// mpv_event_end_file.error will be set.
public const mpv_end_file_reason_MPV_END_FILE_REASON_ERROR : mpv_end_file_reason_mpv_end_file_reason = 4

// The file was a playlist or similar. When the playlist is read, its
// entries will be appended to the playlist after the entry of the current
// file, the entry of the current file is removed, and a MPV_EVENT_END_FILE
// event is sent with reason set to MPV_END_FILE_REASON_REDIRECT. Then
// playback continues with the playlist contents.
// Since API version 1.18.
public const mpv_end_file_reason_MPV_END_FILE_REASON_REDIRECT : mpv_end_file_reason_mpv_end_file_reason = 5

// Since API version 1.9.
public type mpv_end_file_reason_mpv_end_file_reason = UInt32

// Since API version 1.108.
@C
public struct mpv_event_start_file_mpv_event_start_file {
// Playlist entry ID of the file being loaded now.
public let playlist_entry_id : Int64
public init(playlist_entry_id : Int64) {
    this.playlist_entry_id = playlist_entry_id
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_event_start_file_mpv_event_start_file>()
    if (size != 8) {
        throw Exception("Size of mpv_event_start_file_mpv_event_start_file is not 8 but ${size} bytes")
    }
    let align = alignOf<mpv_event_start_file_mpv_event_start_file>()
    if (align != 8) {
        throw Exception("Alignment of mpv_event_start_file_mpv_event_start_file is not 8 but ${align} bytes")
    }
}

@C
public struct mpv_event_end_file_mpv_event_end_file {
// Corresponds to the values in enum mpv_end_file_reason.
//
// Unknown values should be treated as unknown.
public let reason : mpv_end_file_reason_mpv_end_file_reason
// If reason==MPV_END_FILE_REASON_ERROR, this contains a mpv error code
// (one of MPV_ERROR_...) giving an approximate reason why playback
// failed. In other cases, this field is 0 (no error).
// Since API version 1.9.
public let error : Int32
// Playlist entry ID of the file that was being played or attempted to be
// played. This has the same value as the playlist_entry_id field in the
// corresponding mpv_event_start_file event.
// Since API version 1.108.
public let playlist_entry_id : Int64
// If loading ended, because the playlist entry to be played was for example
// a playlist, and the current playlist entry is replaced with a number of
// other entries. This may happen at least with MPV_END_FILE_REASON_REDIRECT
// (other event types may use this for similar but different purposes in the
// future). In this case, playlist_insert_id will be set to the playlist
// entry ID of the first inserted entry, and playlist_insert_num_entries to
// the total number of inserted playlist entries. Note this in this specific
// case, the ID of the last inserted entry is playlist_insert_id+num-1.
// Beware that depending on circumstances, you may observe the new playlist
// entries before seeing the event (e.g. reading the "playlist" property or
// getting a property change notification before receiving the event).
// Since API version 1.108.
public let playlist_insert_id : Int64
// See playlist_insert_id. Only non-0 if playlist_insert_id is valid. Never
// negative.
// Since API version 1.108.
public let playlist_insert_num_entries : Int32
public init(reason : mpv_end_file_reason_mpv_end_file_reason , error : Int32 , playlist_entry_id : Int64 , playlist_insert_id : Int64 , playlist_insert_num_entries : Int32) {
    this.reason = reason
this.error = error
this.playlist_entry_id = playlist_entry_id
this.playlist_insert_id = playlist_insert_id
this.playlist_insert_num_entries = playlist_insert_num_entries
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_event_end_file_mpv_event_end_file>()
    if (size != 32) {
        throw Exception("Size of mpv_event_end_file_mpv_event_end_file is not 32 but ${size} bytes")
    }
    let align = alignOf<mpv_event_end_file_mpv_event_end_file>()
    if (align != 8) {
        throw Exception("Alignment of mpv_event_end_file_mpv_event_end_file is not 8 but ${align} bytes")
    }
}

@C
public struct mpv_event_client_message_mpv_event_client_message {
// Arbitrary arguments chosen by the sender of the message. If num_args > 0,
// you can access args[0] through args[num_args - 1] (inclusive). What
// these arguments mean is up to the sender and receiver.
// None of the valid items are NULL.
public let num_args : Int32
public let args : CPointer<CString>
public init(num_args : Int32 , args : CPointer<CString>) {
    this.num_args = num_args
this.args = args
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_event_client_message_mpv_event_client_message>()
    if (size != 16) {
        throw Exception("Size of mpv_event_client_message_mpv_event_client_message is not 16 but ${size} bytes")
    }
    let align = alignOf<mpv_event_client_message_mpv_event_client_message>()
    if (align != 8) {
        throw Exception("Alignment of mpv_event_client_message_mpv_event_client_message is not 8 but ${align} bytes")
    }
}

@C
public struct mpv_event_hook_mpv_event_hook {
// The hook name as passed to mpv_hook_add().
public let name : CString
// Internal ID that must be passed to mpv_hook_continue().
public let id : UInt64
public init(name : CString , id : UInt64) {
    this.name = name
this.id = id
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_event_hook_mpv_event_hook>()
    if (size != 16) {
        throw Exception("Size of mpv_event_hook_mpv_event_hook is not 16 but ${size} bytes")
    }
    let align = alignOf<mpv_event_hook_mpv_event_hook>()
    if (align != 8) {
        throw Exception("Alignment of mpv_event_hook_mpv_event_hook is not 8 but ${align} bytes")
    }
}

@C
public struct mpv_event_command_mpv_event_command {
// Result data of the command. Note that success/failure is signaled
// separately via mpv_event.error. This field is only for result data
// in case of success. Most commands leave it at MPV_FORMAT_NONE. Set
// to MPV_FORMAT_NONE on failure.
public let result : mpv_node_mpv_node
public init(result : mpv_node_mpv_node) {
    this.result = result
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_event_command_mpv_event_command>()
    if (size != 16) {
        throw Exception("Size of mpv_event_command_mpv_event_command is not 16 but ${size} bytes")
    }
    let align = alignOf<mpv_event_command_mpv_event_command>()
    if (align != 8) {
        throw Exception("Alignment of mpv_event_command_mpv_event_command is not 8 but ${align} bytes")
    }
}

@C
public struct mpv_event_mpv_event {
// One of mpv_event. Keep in mind that later ABI compatible releases might
// add new event types. These should be ignored by the API user.
public let event_id : mpv_event_id_mpv_event_id
// This is mainly used for events that are replies to (asynchronous)
// requests. It contains a status code, which is >= 0 on success, or < 0
// on error (a mpv_error value). Usually, this will be set if an
// asynchronous request fails.
// Used for:
//  MPV_EVENT_GET_PROPERTY_REPLY
//  MPV_EVENT_SET_PROPERTY_REPLY
//  MPV_EVENT_COMMAND_REPLY
public let error : Int32
// If the event is in reply to a request (made with this API and this
// API handle), this is set to the reply_userdata parameter of the request
// call. Otherwise, this field is 0.
// Used for:
//  MPV_EVENT_GET_PROPERTY_REPLY
//  MPV_EVENT_SET_PROPERTY_REPLY
//  MPV_EVENT_COMMAND_REPLY
//  MPV_EVENT_PROPERTY_CHANGE
//  MPV_EVENT_HOOK
public let reply_userdata : UInt64
// The meaning and contents of the data member depend on the event_id:
//  MPV_EVENT_GET_PROPERTY_REPLY:     mpv_event_property*
//  MPV_EVENT_PROPERTY_CHANGE:        mpv_event_property*
//  MPV_EVENT_LOG_MESSAGE:            mpv_event_log_message*
//  MPV_EVENT_CLIENT_MESSAGE:         mpv_event_client_message*
//  MPV_EVENT_START_FILE:             mpv_event_start_file* (since v1.108)
//  MPV_EVENT_END_FILE:               mpv_event_end_file*
//  MPV_EVENT_HOOK:                   mpv_event_hook*
//  MPV_EVENT_COMMAND_REPLY*          mpv_event_command*
//  other: NULL
//
// Note: future enhancements might add new event structs for existing or new
//       event types.
public let data : CPointer<Unit>
public init(event_id : mpv_event_id_mpv_event_id , error : Int32 , reply_userdata : UInt64 , data : CPointer<Unit>) {
    this.event_id = event_id
this.error = error
this.reply_userdata = reply_userdata
this.data = data
}
}

@When[debug]
let _ = {
=>
    let size = sizeOf<mpv_event_mpv_event>()
    if (size != 24) {
        throw Exception("Size of mpv_event_mpv_event is not 24 but ${size} bytes")
    }
    let align = alignOf<mpv_event_mpv_event>()
    if (align != 8) {
        throw Exception("Alignment of mpv_event_mpv_event is not 8 but ${align} bytes")
    }
}

// Convert the given src event to a mpv_node, and set *dst to the result. *dst
// is set to a MPV_FORMAT_NODE_MAP, with fields for corresponding mpv_event and
// mpv_event.data/mpv_event_* fields.
//
// The exact details are not completely documented out of laziness. A start
// is located in the "Events" section of the manpage.
//
// *dst may point to newly allocated memory, or pointers in mpv_event. You must
// copy the entire mpv_node if you want to reference it after mpv_event becomes
// invalid (such as making a new mpv_wait_event() call, or destroying the
// mpv_handle from which it was returned). Call mpv_free_node_contents() to free
// any memory allocations made by this API function.
//
// Safe to be called from mpv render API threads.
//
// @param dst Target. This is not read and fully overwritten. Must be released
//            with mpv_free_node_contents(). Do not write to pointers returned
//            by it. (On error, this may be left as an empty node.)
// @param src The source event. Not modified (it's not const due to the author's
//            prejudice of the C version of const).
// @return error code (MPV_ERROR_NOMEM only, if at all)
foreign func mpv_event_to_node ( dst: CPointer<mpv_node_mpv_node> , src: CPointer<mpv_event_mpv_event> ) : Int32

// Enable or disable the given event.
//
// Some events are enabled by default. Some events can't be disabled.
//
// (Informational note: currently, all events are enabled by default, except
//  MPV_EVENT_TICK.)
//
// Safe to be called from mpv render API threads.
//
// @param event See enum mpv_event_id.
// @param enable 1 to enable receiving this event, 0 to disable it.
// @return error code
foreign func mpv_request_event ( ctx: CPointer<mpv_handle_mpv_handle> , event: mpv_event_id_mpv_event_id , enable: Int32 ) : Int32

// Enable or disable receiving of log messages. These are the messages the
// command line player prints to the terminal. This call sets the minimum
// required log level for a message to be received with MPV_EVENT_LOG_MESSAGE.
//
// @param min_level Minimal log level as string. Valid log levels:
//                      no fatal error warn info v debug trace
//                  The value "no" disables all messages. This is the default.
//                  An exception is the value "terminal-default", which uses the
//                  log level as set by the "--msg-level" option. This works
//                  even if the terminal is disabled. (Since API version 1.19.)
//                  Also see mpv_log_level.
// @return error code
foreign func mpv_request_log_messages ( ctx: CPointer<mpv_handle_mpv_handle> , min_level: CString ) : Int32

// Wait for the next event, or until the timeout expires, or if another thread
// makes a call to mpv_wakeup(). Passing 0 as timeout will never wait, and
// is suitable for polling.
//
// The internal event queue has a limited size (per client handle). If you
// don't empty the event queue quickly enough with mpv_wait_event(), it will
// overflow and silently discard further events. If this happens, making
// asynchronous requests will fail as well (with MPV_ERROR_EVENT_QUEUE_FULL).
//
// Only one thread is allowed to call this on the same mpv_handle at a time.
// The API won't complain if more than one thread calls this, but it will cause
// race conditions in the client when accessing the shared mpv_event struct.
// Note that most other API functions are not restricted by this, and no API
// function internally calls mpv_wait_event(). Additionally, concurrent calls
// to different mpv_handles are always safe.
//
// As long as the timeout is 0, this is safe to be called from mpv render API
// threads.
//
// @param timeout Timeout in seconds, after which the function returns even if
//                no event was received. A MPV_EVENT_NONE is returned on
//                timeout. A value of 0 will disable waiting. Negative values
//                will wait with an infinite timeout.
// @return A struct containing the event ID and other data. The pointer (and
//         fields in the struct) stay valid until the next mpv_wait_event()
//         call, or until the mpv_handle is destroyed. You must not write to
//         the struct, and all memory referenced by it will be automatically
//         released by the API on the next mpv_wait_event() call, or when the
//         context is destroyed. The return value is never NULL.
foreign func mpv_wait_event ( ctx: CPointer<mpv_handle_mpv_handle> , timeout: Float64 ) : CPointer<mpv_event_mpv_event>

// Interrupt the current mpv_wait_event() call. This will wake up the thread
// currently waiting in mpv_wait_event(). If no thread is waiting, the next
// mpv_wait_event() call will return immediately (this is to avoid lost
// wakeups).
//
// mpv_wait_event() will receive a MPV_EVENT_NONE if it's woken up due to
// this call. But note that this dummy event might be skipped if there are
// already other events queued. All what counts is that the waiting thread
// is woken up at all.
//
// Safe to be called from mpv render API threads.
foreign func mpv_wakeup ( ctx: CPointer<mpv_handle_mpv_handle> ) : Unit

// Set a custom function that should be called when there are new events. Use
// this if blocking in mpv_wait_event() to wait for new events is not feasible.
//
// Keep in mind that the callback will be called from foreign threads. You
// must not make any assumptions of the environment, and you must return as
// soon as possible (i.e. no long blocking waits). Exiting the callback through
// any other means than a normal return is forbidden (no throwing exceptions,
// no longjmp() calls). You must not change any local thread state (such as
// the C floating point environment).
//
// You are not allowed to call any client API functions inside of the callback.
// In particular, you should not do any processing in the callback, but wake up
// another thread that does all the work. The callback is meant strictly for
// notification only, and is called from arbitrary core parts of the player,
// that make no considerations for reentrant API use or allowing the callee to
// spend a lot of time doing other things. Keep in mind that it's also possible
// that the callback is called from a thread while a mpv API function is called
// (i.e. it can be reentrant).
//
// In general, the client API expects you to call mpv_wait_event() to receive
// notifications, and the wakeup callback is merely a helper utility to make
// this easier in certain situations. Note that it's possible that there's
// only one wakeup callback invocation for multiple events. You should call
// mpv_wait_event() with no timeout until MPV_EVENT_NONE is reached, at which
// point the event queue is empty.
//
// If you actually want to do processing in a callback, spawn a thread that
// does nothing but call mpv_wait_event() in a loop and dispatches the result
// to a callback.
//
// Only one wakeup callback can be set.
//
// @param cb function that should be called if a wakeup is required
// @param d arbitrary userdata passed to cb
foreign func mpv_set_wakeup_callback ( ctx: CPointer<mpv_handle_mpv_handle> , cb: CFunc<(d: CPointer<Unit>) -> Unit> , d: CPointer<Unit> ) : Unit

// Block until all asynchronous requests are done. This affects functions like
// mpv_command_async(), which return immediately and return their result as
// events.
//
// This is a helper, and somewhat equivalent to calling mpv_wait_event() in a
// loop until all known asynchronous requests have sent their reply as event,
// except that the event queue is not emptied.
//
// In case you called mpv_suspend() before, this will also forcibly reset the
// suspend counter of the given handle.
foreign func mpv_wait_async_requests ( ctx: CPointer<mpv_handle_mpv_handle> ) : Unit

// A hook is like a synchronous event that blocks the player. You register
// a hook handler with this function. You will get an event, which you need
// to handle, and once things are ready, you can let the player continue with
// mpv_hook_continue().
//
// Currently, hooks can't be removed explicitly. But they will be implicitly
// removed if the mpv_handle it was registered with is destroyed. This also
// continues the hook if it was being handled by the destroyed mpv_handle (but
// this should be avoided, as it might mess up order of hook execution).
//
// Hook handlers are ordered globally by priority and order of registration.
// Handlers for the same hook with same priority are invoked in order of
// registration (the handler registered first is run first). Handlers with
// lower priority are run first (which seems backward).
//
// See the "Hooks" section in the manpage to see which hooks are currently
// defined.
//
// Some hooks might be reentrant (so you get multiple MPV_EVENT_HOOK for the
// same hook). If this can happen for a specific hook type, it will be
// explicitly documented in the manpage.
//
// Only the mpv_handle on which this was called will receive the hook events,
// or can "continue" them.
//
// @param reply_userdata This will be used for the mpv_event.reply_userdata
//                       field for the received MPV_EVENT_HOOK events.
//                       If you have no use for this, pass 0.
// @param name The hook name. This should be one of the documented names. But
//             if the name is unknown, the hook event will simply be never
//             raised.
// @param priority See remarks above. Use 0 as a neutral default.
// @return error code (usually fails only on OOM)
foreign func mpv_hook_add ( ctx: CPointer<mpv_handle_mpv_handle> , reply_userdata: UInt64 , name: CString , priority: Int32 ) : Int32

// Respond to a MPV_EVENT_HOOK event. You must call this after you have handled
// the event. There is no way to "cancel" or "stop" the hook.
//
// Calling this will will typically unblock the player for whatever the hook
// is responsible for (e.g. for the "on_load" hook it lets it continue
// playback).
//
// It is explicitly undefined behavior to call this more than once for each
// MPV_EVENT_HOOK, to pass an incorrect ID, or to call this on a mpv_handle
// different from the one that registered the handler and received the event.
//
// @param id This must be the value of the mpv_event_hook.id field for the
//           corresponding MPV_EVENT_HOOK.
// @return error code
foreign func mpv_hook_continue ( ctx: CPointer<mpv_handle_mpv_handle> , id: UInt64 ) : Int32

// Return a UNIX file descriptor referring to the read end of a pipe. This
// pipe can be used to wake up a poll() based processing loop. The purpose of
// this function is very similar to mpv_set_wakeup_callback(), and provides
// a primitive mechanism to handle coordinating a foreign event loop and the
// libmpv event loop. The pipe is non-blocking. It's closed when the mpv_handle
// is destroyed. This function always returns the same value (on success).
//
// This is in fact implemented using the same underlying code as for
// mpv_set_wakeup_callback() (though they don't conflict), and it is as if each
// callback invocation writes a single 0 byte to the pipe. When the pipe
// becomes readable, the code calling poll() (or select()) on the pipe should
// read all contents of the pipe and then call mpv_wait_event(c, 0) until
// no new events are returned. The pipe contents do not matter and can just
// be discarded. There is not necessarily one byte per readable event in the
// pipe. For example, the pipes are non-blocking, and mpv won't block if the
// pipe is full. Pipes are normally limited to 4096 bytes, so if there are
// more than 4096 events, the number of readable bytes can not equal the number
// of events queued. Also, it's possible that mpv does not write to the pipe
// once it's guaranteed that the client was already signaled. See the example
// below how to do it correctly.
//
// Example:
//
//  int pipefd = mpv_get_wakeup_pipe(mpv);
//  if (pipefd < 0)
//      error();
//  while (1) {
//      struct pollfd pfds[1] = {
//          { .fd = pipefd, .events = POLLIN },
//      };
//      // Wait until there are possibly new mpv events.
//      poll(pfds, 1, -1);
//      if (pfds[0].revents & POLLIN) {
//          // Empty the pipe. Doing this before calling mpv_wait_event()
//          // ensures that no wakeups are missed. It's not so important to
//          // make sure the pipe is really empty (it will just cause some
//          // additional wakeups in unlikely corner cases).
//          char unused[256];
//          read(pipefd, unused, sizeof(unused));
//          while (1) {
//              mpv_event *ev = mpv_wait_event(mpv, 0);
//              // If MPV_EVENT_NONE is received, the event queue is empty.
//              if (ev->event_id == MPV_EVENT_NONE)
//                  break;
//              // Process the event.
//              ...
//          }
//      }
//  }
//
// @deprecated this function will be removed in the future. If you need this
//             functionality, use mpv_set_wakeup_callback(), create a pipe
//             manually, and call write() on your pipe in the callback.
//
// @return A UNIX FD of the read end of the wakeup pipe, or -1 on error.
//         On MS Windows/MinGW, this will always return -1.
foreign func mpv_get_wakeup_pipe ( ctx: CPointer<mpv_handle_mpv_handle> ) : Int32
