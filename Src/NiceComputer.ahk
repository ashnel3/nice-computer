#Requires AutoHotkey v2.0
#InputLevel 1
#NoTrayIcon
#SingleInstance
#Warn

class NiceComputerGui extends Gui {
  static VIDEO_PATH := A_Temp "\ಠ_ಠ.mp4"

  __New() {
    super.__New('+AlwaysOnTop -Border +Disabled -SysMenu +Owner', 'NiceComputer', this)
    try
      FileInstall("Assets\Mario-Head-Collection-9tQWLg4E90M.mp4", NiceComputerGui.VIDEO_PATH, 0)
    this.MediaPlayer := this.AddActiveX('x0 y0 w320 h240', 'WMPLayer.OCX')
    this.MediaPlayer.Value.uiMode := 'none'
    this.MediaPlayer.Value.stretchToFit := true
    this.MediaPlayer.Value.enableContextMenu := false
    this.OnEvent('Close', this._Close.Bind(this))
    this.OnEvent('Size', this._Size.Bind(this))
  }

  _Close(_Gui) {
    return true
  }

  _Size(_Gui, MinMax, w, h) {
    this.MediaPlayer.Move(0, 0, w, h)
  }

  Close() {
    if (A_Args.length > 1) {
      Command := ''
      for arg in A_Args {
        Command .= arg A_Space
      }
      Run(Command)
    }
    return ExitApp(0)
  }

  Main() {
    Video := this.MediaPlayer.Value.newMedia(NiceComputerGui.VIDEO_PATH)
    VideoDuration := Video.getItemInfo('Duration')
    this.MediaPlayer.Value.currentMedia := Video
    this.Show(
      Format('w{1} h{2}', A_ScreenWidth / 2, A_ScreenHeight / 2)
    )
    this.MediaPlayer.Value.controls.play()
    Sleep(VideoDuration * 1000 + 666)
    this.Close()
  }
}

;; Main
~RButton::
~LButton:: {
  _Gui := NiceComputerGui()
  Sleep(Random() * 60000)
  _Gui.Main()
}
