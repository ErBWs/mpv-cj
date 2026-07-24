# @mpv-ohos/mpv-cj

使用仓颉编写的基于 mpv 的 HarmonyOS 音视频播放器。

## 功能特性

> [!IMPORTANT]
> 
> 该模块仅支持 `aarch64-linux-ohos`

- [x] 基础音视频播放及控制
- [x] 硬件解码
- [x] Audio Vivid (菁彩三维声) 播放
- [x] 播放列表控制及循环模式选择
- [x] 音量和播放速度调节
- [x] 视频、音频和字幕轨道选择
- [x] 加载外部音轨和字幕
- [x] 同步读取状态和订阅事件流
- [x] 自定义 http headers

## 安装

在模块级 `oh-package.json5` 中将 `@mpv-ohos/mpv-cj` 添加到 `dependencies`：

```json5
{
  "dependencies": {
    "@mpv-ohos/mpv-cj": "1.0.0",
  }
}
```

### 网络媒体权限

如果应用需要播放网络媒体，请在模块级的 `module.json5` 中声明网络权限：

```json5
{
  "module": {
    "requestPermissions": [
      {
        "name": "ohos.permission.INTERNET"
      }
    ]
  }
}
```

## 快速上手

```cangjie
package ohos_app_cangjie_entry

import kit.UIKit.*
import ohos.state_macro_manage.*
import ohos.state_manage.*
import ohos_app_cangjie_mpvcj.PlayerSurface
import ohos_app_cangjie_mpvcj.Player
import ohos_app_cangjie_mpvcj.models.Media

@Entry
@Component
class EntryView {
    private let player = Player()

    protected override func aboutToAppear() {
        player.open(Media("https://example.com/video.mp4"))
    }

    protected override func aboutToDisappear() {
        player.destroy()
    }

    func build() {
        Row {
            PlayerSurface(player: player)
        }
        .height(100.percent)
        .width(100.percent)
    }
}
```

## 使用指南

### 目录

- [创建播放器](#创建播放器)
- [打开媒体或播放列表](#打开媒体或播放列表)
- [渲染视频](#渲染视频)
- [播放控制](#播放控制)
- [设置播放列表模式](#设置播放列表模式)
- [播放器状态](#播放器状态)
- [选择轨道](#选择轨道)
- [截图](#截图)
- [销毁播放器](#销毁播放器)

### 创建播放器

创建一个 `Player` 实例

```cangjie
let player = Player()
```

可以通过 `PlayerConfig` 自定义播放器初始化参数：

```cangjie
let player = Player(config: PlayerConfig(
    deinterlace: true,
    logLevel: MpvLogLevel.Warn
))
```

### 打开媒体或播放列表

#### `Media`

`Media` 可以接收文件 uri，或网络媒体链接：

```cangjie
player.open(Media("file://media/Photo/1310/VID_1/VID_1.mp4"))
```

通过设置命名参数 `play`，可以控制加载媒体后是否立即开始播放：

```cangjie
player.open(Media("https://example.com/video.mp4"), play: false)
```

#### `Playlist`

播放器默认从 `0` 开始播放，可以通过命名参数 `index` 进行控制。

```cangjie
let playlist = Playlist(
    ArrayList<Media>([
        Media("https://example.com/1.mp4"),
        Media("https://example.com/2.mp4"),
        Media("https://example.com/3.mp4")
    ]),
    index: 1
)
player.open(playlist)
```

#### 媒体额外参数

可通过命名参数额外配置每个媒体的 http 请求头、播放开始时间和播放结束时间

```cangjie
player.open(Media(
    "https://example.com/1.mp4",
    httpHeaders: HashMap<String, String>([("Referer", "https://example.com/")]),
    start: Duration.Zero,
    end: 12 * Duration.minute + 50 * Duration.second,
))
```

### 渲染视频

将 `PlayerSurface` 放入组件树，并传入 `Player` 实例：

```cangjie
PlayerSurface(player: player)
    .width(100.percent)
    .height(100.percent)
```

### 播放控制

#### 播放/暂停

```cangjie
player.play()
player.pause()
player.playOrPause()
```

#### 停止

停止当前播放的媒体或播放列表，但不会销毁播放器。

```cangjie
player.stop()
```

#### 定位

使用绝对播放位置进行定位。

```cangjie
player.seek(90 * Duration.second)
```

#### 播放列表

```cangjie
player.next()
player.previous()
player.jump(2)
```

#### 音量/倍速

```cangjie
player.setVolume(80.0)
player.setSpeed(1.25)
```

### 设置播放列表模式

- `PlaylistMode.None`：播完暂停
- `PlaylistMode.File`：单集循环
- `PlaylistMode.Playlist`：播放列表循环
- `PlaylistMode.Random`：随机播放

```cangjie
player.setPlaylistMode(PlaylistMode.File)
```

### 播放器状态

通过 `player.state` 立即读取当前状态：

```cangjie
let track = player.state.track
let chapters = player.state.chapters
let duration = player.state.duration
```

通过 `player.stream` 绑定状态变量：

```cangjie
@State
var playing: Bool = false

player.stream.playing.listen {
    isPlaying => playing = isPlaying
}
```

支持以下状态和事件流：

| 名称                    | 类型                   | 说明              |
|-----------------------|----------------------|-----------------|
| `playlist`            | `Playlist`           | 当前播放列表          |
| `playing`             | `Bool`               | 播放状态            |
| `eof`                 | `Bool`               | 是否播放完成          |
| `duration`            | `Duration`           | 视频总时长           |
| `position`            | `Duration`           | 播放位置            |
| `volume`              | `Float64`            | 音量              |
| `speed`               | `Float64`            | 播放速度            |
| `buffering`           | `Bool`               | 是否因等待缓存而暂停播放    |
| `bufferingPercentage` | `Float64`            | 缓存百分比           |
| `buffer`              | `Duration`           | 缓冲位置            |
| `playlistMode`        | `PlaylistMode`       | 播放列表模式          |
| `track`               | `Track`              | 当前选中的视频、音频和字幕轨道 |
| `tracks`              | `Tracks`             | 可用的视频、音频和字幕轨道   |
| `chapters`            | `ArrayList<Chapter>` | 可用章节            |
| `videoParams`         | `VideoParams`        | 视频参数            |
| `videoBitrate`        | `Float64`            | 视频码率            |
| `audioParams`         | `AudioParams`        | 音频参数            |
| `audioBitrate`        | `Float64`            | 音频码率            |
| `log`                 | `Stream<PlayerLog>`  | mpv 日志 (仅事件流)   |
| `error`               | `Stream<String>`     | mpv 错误日志 (仅事件流) |

### 选择轨道

可以通过 `player.state.tracks` 和 `player.stream.tracks` 获取可用轨道：

```cangjie
let tracks = player.state.tracks

if (!tracks.video.isEmpty()) {
    player.setVideoTrack(tracks.video[0])
}
if (!tracks.audio.isEmpty()) {
    player.setAudioTrack(tracks.audio[0])
}
if (!tracks.subs.isEmpty()) {
    player.setSubtitleTrack(tracks.subs[0])
}
```

#### 自动选择轨道

```cangjie
player.setVideoTrack(VideoTrack.auto())
player.setAudioTrack(AudioTrack.auto())
player.setSubtitleTrack(SubtitleTrack.auto())
```

#### 禁用轨道

```cangjie
player.setVideoTrack(VideoTrack.no())
player.setAudioTrack(AudioTrack.no())
player.setSubtitleTrack(SubtitleTrack.no())
```

#### 加载外部音频或字幕轨道

```cangjie
player.setAudioTrack(AudioTrack.uri(
    "https://example.com/audio.m4a",
    lang: "chi",
    title: "external"
))

player.setSubtitleTrack(SubtitleTrack.uri(
    "https://example.com/subtitles.vtt",
    lang: "eng",
    title: "external"
))
```

### 截图

可以通过命名参数选择截图是否携带字幕，默认携带。返回 `PixelMap`。

```cangjie
let pic = player.screenshot()
let picWithSub = player.screenshot(withSub: false)
```

### 销毁播放器

不再使用播放器时应使用 `destroy` 销毁播放器。播放器销毁后不能再次使用。

```cangjie
player.destroy()
```

## 开发者指南

1. 模块自定义了 Hvigor 任务，编译时会自动检测并下载 libmpv 二进制文件。该文件托管在 GitHub 上，注意网络连通性 (需要开启虚拟网卡 / TUN 模式)。
2. Linux 下需要安装 `unzip` 来解压下载的二进制文件。

## 开源协议

Apache 许可证第 2.0 版 (Apache License 2.0)
