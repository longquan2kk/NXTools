# Install .Net Assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[Windows.Forms.Application]::EnableVisualStyles()

# WinForm Setup
################################################################## Objects
# Main Form .Net Objects
$mainForm           = New-Object System.Windows.Forms.Form
$menuMain           = New-Object System.Windows.Forms.MenuStrip
$menuFile           = New-Object System.Windows.Forms.ToolStripMenuItem
$menuView           = New-Object System.Windows.Forms.ToolStripMenuItem
$menuTools          = New-Object System.Windows.Forms.ToolStripMenuItem
$menuOpen           = New-Object System.Windows.Forms.ToolStripMenuItem
$menuSave           = New-Object System.Windows.Forms.ToolStripMenuItem
$menuSaveAs         = New-Object System.Windows.Forms.ToolStripMenuItem
$menuFullScr        = New-Object System.Windows.Forms.ToolStripMenuItem
$menuOptions        = New-Object System.Windows.Forms.ToolStripMenuItem
$menuOptions1       = New-Object System.Windows.Forms.ToolStripMenuItem
$menuOptions2       = New-Object System.Windows.Forms.ToolStripMenuItem
$menuExit           = New-Object System.Windows.Forms.ToolStripMenuItem
$menuHelp           = New-Object System.Windows.Forms.ToolStripMenuItem
$menuAbout          = New-Object System.Windows.Forms.ToolStripMenuItem
$tabControl         = New-Object System.Windows.Forms.TabControl
$ytbTabPage         = New-Object System.Windows.Forms.TabPage
$ytbTitleLabel      = New-Object System.Windows.Forms.Label
$ytbDescrLabel      = New-Object System.Windows.Forms.Label
$ytbUrlTextbox      = New-Object System.Windows.Forms.TextBox
$ytbFormatComboBox  = New-Object System.Windows.Forms.ComboBox
$ytbDownloadButton  = New-Object System.Windows.Forms.Button
$cvTabPage          = New-Object System.Windows.Forms.TabPage
$cvTitleLabel       = New-Object System.Windows.Forms.Label
$cvFileNameTextBox  = New-Object System.Windows.Forms.TextBox
$cvFilePathTextBox  = New-Object System.Windows.Forms.TextBox
$cvBrowseButton     = New-Object System.Windows.Forms.Button
$cvConvertButton    = New-Object System.Windows.Forms.Button
$statusStrip        = New-Object System.Windows.Forms.StatusStrip
$statusLabel        = New-Object System.Windows.Forms.ToolStripStatusLabel

################################################################## Icons
# WinForms Icons
# Create Icon Extractor Assembly
$code = @"
using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace System
{
	public class IconExtractor
	{

	 public static Icon Extract(string file, int number, bool largeIcon)
	 {
	  IntPtr large;
	  IntPtr small;
	  ExtractIconEx(file, number, out large, out small, 1);
	  try
	  {
	   return Icon.FromHandle(largeIcon ? large : small);
	  }
	  catch
	  {
	   return null;
	  }

	 }
	 [DllImport("Shell32.dll", EntryPoint = "ExtractIconExW", CharSet = CharSet.Unicode, ExactSpelling = true, CallingConvention = CallingConvention.StdCall)]
	 private static extern int ExtractIconEx(string sFile, int iIndex, out IntPtr piLargeVersion, out IntPtr piSmallVersion, int amountIcons);

	}
}
"@
Add-Type -TypeDefinition $code -ReferencedAssemblies System.Drawing

# Extract PowerShell Icon from PowerShell Exe
$iconPS   = [Drawing.Icon]::ExtractAssociatedIcon((Get-Command powershell).Path)

################################################################## Main Form Setup
# Main Form
$mainForm.Width           = 560
$mainForm.Height          = 480
$mainForm.Icon            = $iconPS
$mainForm.MainMenuStrip   = $menuMain
$mainForm.StartPosition   = "CenterScreen"
$mainForm.Text            = " NhaiXinhTools - v1.1.0"
$mainForm.Controls.Add($menuMain)

################################################################## Main Menu
# Main Menu Bar
[void]$mainForm.Controls.Add($menuMain)

# Menu Options - File
$menuFile.Text = "&File"
[void]$menuMain.Items.Add($menuFile)

# Menu Options - File / Open
$menuOpen.Image        = [System.IconExtractor]::Extract("shell32.dll", 4, $true)
$menuOpen.ShortcutKeys = "Control, O"
$menuOpen.Text         = "&Open"
$menuOpen.Add_Click({OpenFile})
[void]$menuFile.DropDownItems.Add($menuOpen)

# Menu Options - File / Save
$menuSave.Image        = [System.IconExtractor]::Extract("shell32.dll", 36, $true)
$menuSave.ShortcutKeys = "F2"
$menuSave.Text         = "&Save"
$menuSave.Add_Click({SaveFile})
[void]$menuFile.DropDownItems.Add($menuSave)

# Menu Options - File / Save As
$menuSaveAs.Image        = [System.IconExtractor]::Extract("shell32.dll", 45, $true)
$menuSaveAs.ShortcutKeys = "Control, S"
$menuSaveAs.Text         = "&Save As"
$menuSaveAs.Add_Click({SaveAs})
[void]$menuFile.DropDownItems.Add($menuSaveAs)

# Menu Options - File / Exit
$menuExit.Image        = [System.IconExtractor]::Extract("shell32.dll", 10, $true)
$menuExit.ShortcutKeys = "Control, W"
$menuExit.Text         = "&Exit"
$menuExit.Add_Click({$mainForm.Close()})
[void]$menuFile.DropDownItems.Add($menuExit)

# Menu Options - View
$menuView.Text      = "&View"
[void]$menuMain.Items.Add($menuView)

# Menu Options - View / Full Screen
$menuFullScr.Image        = [System.IconExtractor]::Extract("shell32.dll",34, $true)
$menuFullScr.ShortcutKeys = "F11"
$menuFullScr.Text         = "&Full Screen"
$menuFullScr.Add_Click({FullScreen})
[void]$menuView.DropDownItems.Add($menuFullScr)

# Menu Options - Tools
$menuTools.Text      = "&Tools"
[void]$menuMain.Items.Add($menuTools)

# Menu Options - Tools / Options
$menuOptions.Image     = [System.IconExtractor]::Extract("shell32.dll", 21, $true)
$menuOptions.Text      = "&Options"
[void]$menuTools.DropDownItems.Add($menuOptions)

# Menu Options - Tools / Options / Options 1
$menuOptions1.Image     = [System.IconExtractor]::Extract("shell32.dll", 33, $true)
$menuOptions1.Text      = "&Options 1"
$menuOptions1.Add_Click({Options1})
[void]$menuOptions.DropDownItems.Add($menuOptions1)

# Menu Options - Tools / Options / Options 2
$menuOptions2.Image     = [System.IconExtractor]::Extract("shell32.dll", 35, $true)
$menuOptions2.Text      = "&Options 2"
$menuOptions2.Add_Click({Options2})
[void]$menuOptions.DropDownItems.Add($menuOptions2)

# Menu Options - Help
$menuHelp.Text      = "&Help"
[void]$menuMain.Items.Add($menuHelp)

# Menu Options - Help / About
$menuAbout.Image     = [System.Drawing.SystemIcons]::Information
$menuAbout.Text      = "About NhaiXinhTools"
$menuAbout.Add_Click({About})
[void]$menuHelp.DropDownItems.Add($menuAbout)

################################################################## Multiple Tabs
# Multiple Tab Set Up
$tabControl.Location    = New-Object System.Drawing.Point(0, 25)
$tabControl.Width       = $mainForm.Width - 14
$tabControl.Height      = $mainForm.Height - 85

# Main Form - Youtube Downloader Tab
$ytbTabPage.Text = "YouTube Downloader"
$ytbTabPage.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$tabControl.Controls.Add($ytbTabPage)

# Main Form - Youtube Downloader Tab / Header Panel
$ytbHeaderPanel = New-Object System.Windows.Forms.Panel
$ytbHeaderPanel.Size = New-Object System.Drawing.Point(($tabControl.Width), 50)
$ytbHeaderPanel.Location = New-Object System.Drawing.Point(0, 0)
$ytbHeaderPanel.BackColor = [System.Drawing.Color]::FromArgb(0, 0, 0)
$ytbTabPage.Controls.Add($ytbHeaderPanel)

# Main Form - Youtube Downloader Tab / URL Textbox
$ytbURLPlaceHolderText = "Enter a video URL to add to the queue"
$ytbUrlTextbox.Size = "425, 20"
$ytbUrlTextbox.Location = New-Object System.Drawing.Point(33, (($ytbHeaderPanel.Location.Y + $ytbHeaderPanel.Height - $ytbUrlTextbox.Height)/2))
$ytbUrlTextbox.Multiline = $true
$ytbUrlTextbox.Text = $ytbURLPlaceHolderText
$ytbUrlTextbox.ForeColor = [System.Drawing.Color]::Gray

$ytbUrlTextbox.Add_GotFocus({
    if ($ytbUrlTextbox.Text -eq $ytbURLPlaceHolderText) {
        $ytbUrlTextbox.Text = ""
        $ytbUrlTextbox.ForeColor = [System.Drawing.Color]::Black
    }
})

$ytbUrlTextbox.Add_LostFocus({
    if ([string]::IsNullOrWhiteSpace($ytbUrlTextbox.Text)) {
        $ytbUrlTextbox.Text = $ytbURLPlaceHolderText
        $ytbUrlTextbox.ForeColor = [System.Drawing.Color]::Gray
    }
})

$ytbHeaderPanel.Controls.Add($ytbUrlTextbox)

# Main Form - Youtube Downloader Tab / Button Add URL
$ytbAddButton = New-Object System.Windows.Forms.Button
$ytbAddButton.Size = New-Object System.Drawing.Size(50, 24)
$ytbAddButton.Location = New-Object System.Drawing.Point(($ytbUrlTextbox.Location.X + $ytbUrlTextbox.Width), (($ytbHeaderPanel.Location.Y + $ytbHeaderPanel.Height - $ytbAddButton.Height)/2))
$ytbAddButton.Text = "+"
$ytbAddButton.ForeColor = "White"
$ytbAddButton.Font = New-Object Drawing.Font("Microsoft Sans Serif", 14, [System.Drawing.FontStyle]::Bold)
$ytbAddButton.TextAlign = "MiddleCenter"
$ytbAddButton.Add_Click({addURL})
$ytbHeaderPanel.Controls.Add($ytbAddButton)

# Main Form - Youtube Downloader Tab / Content Panel
$ytbContentPanel = New-Object System.Windows.Forms.Panel
$ytbContentPanel.Size = New-Object System.Drawing.Point(($tabControl.Width), 250)
$ytbContentPanel.Location = New-Object System.Drawing.Point(0, $ytbHeaderPanel.Height)
$ytbContentPanel.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$ytbTabPage.Controls.Add($ytbContentPanel)

$ytbUpArrowPicPath = "D:\NXTools\resources\Image\arrow-up.png"
$ytbUpArrowPic = New-Object System.Windows.Forms.PictureBox
$ytbUpArrowPic.Image = [System.Drawing.Image]::FromFile($ytbUpArrowPicPath)
$ytbUpArrowPic.Size = "96, 96"
$ytbUpArrowPic.Location = New-Object System.Drawing.Point((($ytbContentPanel.Width - $ytbUpArrowPic.Width)/2), 30)
$ytbUpArrowPic.SizeMode = "StretchImage"
$ytbContentPanel.Controls.Add($ytbUpArrowPic)

# Main Form - Youtube Downloader Tab / Content Panel - Title
$ytbTitleLabel.Text       = "Your queue is empty"
$ytbTitleLabel.Size       = "260, 30"
$ytbTitleLabel.Location   = New-Object System.Drawing.Point((($tabControl.Width - $ytbTitleLabel.Width)/2), ($ytbUpArrowPic.Location.Y + $ytbUpArrowPic.Height + 20))
$ytbTitleLabel.Font       = New-Object Drawing.Font("Microsoft Sans Serif", 20)
$ytbTitleLabel.ForeColor  = "White"
$ytbContentPanel.Controls.Add($ytbTitleLabel)

# Main Form - Youtube Downloader Tab / Content Panel - Description
$ytbDescrLabel.Text       = "Add some videos to get started."
$ytbDescrLabel.Size       = "178, 30"
$ytbDescrLabel.Location   = New-Object System.Drawing.Point((($tabControl.Width - $ytbDescrLabel.Width)/2), ($ytbTitleLabel.Location.Y + $ytbTitleLabel.Height + 20))
$ytbDescrLabel.Font       = New-Object Drawing.Font("Microsoft Sans Serif", 9)
$ytbDescrLabel.ForeColor  = "White"
$ytbContentPanel.Controls.Add($ytbDescrLabel)

# Main Form - Youtube Downloader Tab / Information Panel
$ytbInforPanel = New-Object System.Windows.Forms.Panel
$ytbInforPanel.Size = $ytbContentPanel.Size
$ytbInforPanel.Location = $ytbContentPanel.Location
$ytbInforPanel.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$ytbInforPanel.Visible = $false
$ytbInforPanel.AutoScroll = $true
$ytbTabPage.Controls.Add($ytbInforPanel)

# Main Form - Youtube Downloader Tab / Footer Panel
$ytbFooterPanel = New-Object System.Windows.Forms.Panel
$ytbFooterPanel.Size = New-Object System.Drawing.Point(($tabControl.Width), 65)
$ytbFooterPanel.Location = New-Object System.Drawing.Point(0, ($ytbHeaderPanel.Height + $ytbContentPanel.Height))
$ytbFooterPanel.BackColor = [System.Drawing.Color]::FromArgb(0, 0, 0)
$ytbTabPage.Controls.Add($ytbFooterPanel)

# Main Form - Youtube Downloader Tab / Footer Panel - Download Format
$ytbFormatComboBox.Size = "50, 20"
$ytbFormatComboBox.Location = New-Object System.Drawing.Point(0, 0)
$ytbFormatComboBox.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$ytbFormatComboBox.Items.AddRange(@("mp3"<#, "mp4", "webm", "mkv"#>))
$ytbFormatComboBox.SelectedIndex = 0
$ytbFormatComboBox.Visible = $false
$ytbFooterPanel.Controls.Add($ytbFormatComboBox)

# Main Form - Youtube Downloader Tab / Footer Panel - Download Button
$downloadsPath = [Environment]::GetFolderPath("MyDocuments").Replace("Documents", "Downloads")
$ytbDownloadButton.Size = "80, 35"
$ytbDownloadButton.Location = New-Object System.Drawing.Point((($ytbFooterPanel.Width - $ytbDownloadButton.Width)/2), (($ytbFooterPanel.Height - $ytbDownloadButton.Height)/2))
$ytbDownloadButton.Text = "Download"
$ytbDownloadButton.ForeColor = "White"
$ytbDownloadButton.BackColor = [System.Drawing.Color]::FromArgb(0, 160, 0)
$ytbDownloadButton.Add_Click({downloadURL})
$ytbFooterPanel.Controls.Add($ytbDownloadButton)

# Main Form - Audio Converter Tab
$cvTabPage.Text = "Audio Converter"
$cvTabPage.BackColor = [System.Drawing.Color]::White
$tabControl.Controls.Add($cvTabPage)

# Main Form - Audio Converter Tab / Title
$cvTitleLabel.Text       = " Audio Converter"
$cvTitleLabel.Size       = "335, 50"
$cvTitleLabel.Location   = New-Object System.Drawing.Point((($tabControl.Width - $cvTitleLabel.Width)/2), 05)
$cvTitleLabel.Font       = New-Object Drawing.Font("Microsoft Sans Serif", 30, [System.Drawing.FontStyle]::Bold)
$cvTabPage.Controls.Add($cvTitleLabel)

# Main Form - Audio Converter Tab / Convert Panel
$ConverterPanel = New-Object System.Windows.Forms.Panel
$ConverterPanel.Size = "300, 200"
$ConverterPanel.Location = New-Object System.Drawing.Point((($tabControl.Width - $ConverterPanel.Width)/2), 70)
$ConverterPanel.BorderStyle = "None"
$ConverterPanel.BackColor = [System.Drawing.Color]::Transparent
$ConverterPanel.AllowDrop = $true

# Set up drag-and-drop event handlers
$ConverterPanel.Add_DragEnter({
    param($sender, $e)
    if ($e.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
        $e.Effect = [Windows.Forms.DragDropEffects]::Copy
    } else {
        $e.Effect = [Windows.Forms.DragDropEffects]::None
    }
})

$ConverterPanel.Add_DragDrop({
    param($sender, $e)
    $files = $e.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    if ($files.Count -gt 0) {
        $selectedFile = $files[0]  # Get the first dropped file

        $fileInfo = Get-Item -Path $selectedFile
        $cvFileNameTextBox.Text = "$($fileInfo.Name)" #`r`nPath: $($fileInfo.FullName)`r`nSize: $([Math]::Round($fileInfo.Length / 1KB, 2)) KB
        $cvFilePathTextBox.Text = "$($fileInfo.FullName)"
    }
})
$cvTabPage.Controls.Add($ConverterPanel)

# Main Form - Audio Converter Tab / Convert Border drawed by Paint
$cvTabPage.Add_Paint({
    param ($sender, $e)
    $graphics = $e.Graphics

    $pen            = New-Object System.Drawing.Pen([System.Drawing.Color]::BlueViolet, 2)
    $pen.DashStyle  = [System.Drawing.Drawing2D.DashStyle]::Dash

    $rectX      = $ConverterPanel.Location.X
    $rectY      = $ConverterPanel.Location.Y
    $rectWidth  = $ConverterPanel.Width
    $rectHeight = $ConverterPanel.Height

    $graphics.DrawRectangle($pen, $rectX, $rectY, $rectWidth, $rectHeight)

    $pen.Dispose()
})

# Main Form - Audio Converter Tab / Convert Panel / Drag & Drop Picture
$DragDropPicPath = "D:\NXTools\resources\Image\drag-and-drop.png"
$DragDropPic = New-Object System.Windows.Forms.PictureBox
$DragDropPic.Image = [System.Drawing.Image]::FromFile($DragDropPicPath)
$DragDropPic.Size = "64, 48"
$DragDropPic.Location = New-Object System.Drawing.Point((($ConverterPanel.Width - $DragDropPic.Width)/2), (($ConverterPanel.Location.Y + $ConverterPanel.Height)/10))
$DragDropPic.SizeMode = "StretchImage"
$ConverterPanel.Controls.Add($DragDropPic)

# Main Form - Audio Converter Tab / Convert Panel / Drag & Drop Title
$DragDropTitle              = New-Object System.Windows.Forms.Label
$DragDropTitle.Text         = "Drag && Drop to Select File"
$DragDropTitle.Width        = 220
$DragDropTitle.Location     = New-Object System.Drawing.Point((($ConverterPanel.Width - $DragDropTitle.Width)/2), ($DragDropPic.Location.Y + $DragDropPic.Height + 10))
$DragDropTitle.Font         = New-Object Drawing.Font("Microsoft Sans Serif", 13, [System.Drawing.FontStyle]::Bold)
$ConverterPanel.Controls.Add($DragDropTitle)

# Main Form - Audio Converter Tab / Convert Panel / Drag & Drop "Or" Label
$DragDropOrLabel            = New-Object System.Windows.Forms.Label
$DragDropOrLabel.Text       = "OR"
$DragDropOrLabel.Width      = 25
$DragDropOrLabel.Location   = New-Object System.Drawing.Point((($ConverterPanel.Width - $DragDropOrLabel.Width)/2), ($DragDropTitle.Location.Y + $DragDropTitle.Height + 10))
$DragDropOrLabel.Font       = New-Object Drawing.Font("Microsoft Sans Serif", 9)
$ConverterPanel.Controls.Add($DragDropOrLabel)

# Main Form - Audio Converter Tab / Convert Panel / Button Browse File
$cvBrowseButton.Size = "100, 30"
$cvBrowseButton.Location = New-Object System.Drawing.Point((($ConverterPanel.Width - $cvBrowseButton.Width)/2), ($DragDropOrLabel.Location.Y + $DragDropOrLabel.Height + 10))
$cvBrowseButton.Text = "Browse File"
$cvBrowseButton.Font = New-Object Drawing.Font("Microsoft Sans Serif", 9, [System.Drawing.FontStyle]::Bold)
$cvBrowseButton.ForeColor = "Blue"
$cvBrowseButton.Add_Click({browseAudioFile})
$ConverterPanel.Controls.Add($cvBrowseButton)

# Main Form - Audio Converter Tab / Convert Panel / TextBox File Info
$cvFileNameTextBox.Size = "220, 20"
$cvFileNameTextBox.Location = New-Object System.Drawing.Point(($ConverterPanel.Location.X), 285)
$cvFileNameTextBox.ReadOnly = $true
$cvFileNameTextBox.TextAlign = "Center"
$cvTabPage.Controls.Add($cvFileNameTextBox)

# Main Form - Audio Converter Tab / DropDownList Format
$dropDownFormat = New-Object System.Windows.Forms.ComboBox
$dropDownFormat.Size = "50, 20"
$dropDownFormat.Location = New-Object System.Drawing.Point(($ConverterPanel.Location.X + $ConverterPanel.Width - $dropDownFormat.Width), ($cvFileNameTextBox.Location.Y))
$dropDownFormat.DropDownStyle = 'DropDownList'
$dropDownFormat.Items.AddRange(@("MP3","MP4","M4A", "WAV", "FLAC", "AAC"))
$dropDownFormat.SelectedIndex = 0
$cvTabPage.Controls.Add($dropDownFormat)

$ToFormatLabel            = New-Object System.Windows.Forms.Label
$ToFormatLabel.Text       = "To"
$ToFormatLabel.Width      = ($ConverterPanel.Width) - ($cvFileNameTextBox.Width) - ($dropDownFormat.Width)
$ToFormatLabel.Height     = $cvFileNameTextBox.Height
$ToFormatLabel.Location   = New-Object System.Drawing.Point(($cvFileNameTextBox.Location.X + $cvFileNameTextBox.Width), ($cvFileNameTextBox.Location.Y))
$ToFormatLabel.Font       = New-Object Drawing.Font("Microsoft Sans Serif", 9, [System.Drawing.FontStyle]::Bold)
$ToFormatLabel.TextAlign  = "MiddleCenter"
$cvTabPage.Controls.Add($ToFormatLabel)

# Main Form - Audio Converter Tab / Button Convert
# Open File Dialog
$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "Audio Files (*.mp3;*.mp4;*.m4a;*.wav;*.flac;*.aac)|*.mp3;*.mp4;*.m4a;*.wav;*.flac;*.aac"
$openFileDialog.Title = "Select an Audio File"

$cvConvertButton.Width = $ConverterPanel.Width
$cvConvertButton.Height = 40
$cvConvertButton.Location = New-Object System.Drawing.Point((($tabControl.Width - $cvConvertButton.Width)/2), 320)
$cvConvertButton.Text = "CONVERT"
$cvConvertButton.Font = New-Object Drawing.Font("Microsoft Sans Serif", 11, [System.Drawing.FontStyle]::Bold)
$cvConvertButton.Add_Click({convertAudioFile})
$cvTabPage.Controls.Add($cvConvertButton)

# Add Tab Control to Main Form
$mainForm.Controls.Add($tabControl)

################################################################## Status Bar
# Status Bar & Label
[void]$statusStrip.Items.Add($statusLabel)
$statusLabel.AutoSize  = $true
$statusLabel.Text      = "Ready"
$mainForm.Controls.Add($statusStrip)

################################################################## Functions
function OpenFile {
    $statusLabel.Text = "Open File"
	$selectOpenForm = New-Object System.Windows.Forms.OpenFileDialog
	$selectOpenForm.Filter = "All Files (*.*)|*.*"
	$selectOpenForm.InitialDirectory = ".\"
	$selectOpenForm.Title = "Select a File to Open"
	$getKey = $selectOpenForm.ShowDialog()
	If ($getKey -eq "OK") {
            $inputFileName = $selectOpenForm.FileName
            Invoke-Item $inputFileName
	}
    $statusLabel.Text = "Ready"
}

function SaveAs {
    $statusLabel.Text = "Save As"
    $selectSaveAsForm = New-Object System.Windows.Forms.SaveFileDialog
	$selectSaveAsForm.Filter = "All Files (*.*)|*.*"
	$selectSaveAsForm.InitialDirectory = ".\"
	$selectSaveAsForm.Title = "Select a File to Save"
	$getKey = $selectSaveAsForm.ShowDialog()
	If ($getKey -eq "OK") {
            $outputFileName = $selectSaveAsForm.FileName
            $outputFileName
	}
    $statusLabel.Text = "Ready"
}

function SaveFile {
}

function FullScreen {
}

function Options1 {
}

function Options2 {
}

function About {
    $statusLabel.Text = "About"
    # About Form Objects
    $aboutForm          = New-Object System.Windows.Forms.Form
    $aboutFormExit      = New-Object System.Windows.Forms.Button
    $aboutFormImage     = New-Object System.Windows.Forms.PictureBox
    $aboutFormNameLabel = New-Object System.Windows.Forms.Label
    $aboutFormText      = New-Object System.Windows.Forms.Label

    # About Form
    $aboutForm.AcceptButton  = $aboutFormExit
    $aboutForm.CancelButton  = $aboutFormExit
    $aboutForm.ClientSize    = "350, 110"
    $aboutForm.ControlBox    = $false
    $aboutForm.ShowInTaskBar = $false
    $aboutForm.StartPosition = "CenterParent"
    $aboutForm.Text          = "About NhaiXinhTools"
    $aboutForm.Add_Load($aboutForm_Load)

    # About PictureBox
    $aboutFormImage.Image    = [System.IconExtractor]::Extract("shell32.dll", 272, $true).ToBitmap()
    $aboutFormImage.Location = "55, 15"
    $aboutFormImage.Size     = "32, 32"
    $aboutFormImage.SizeMode = "StretchImage"
    $aboutForm.Controls.Add($aboutFormImage)

    # About Name Label
    $aboutFormNameLabel.Font     = New-Object Drawing.Font("Microsoft Sans Serif", 9, [System.Drawing.FontStyle]::Bold)
    $aboutFormNameLabel.Location = "110, 20"
    $aboutFormNameLabel.Size     = "200, 18"
    $aboutFormNameLabel.Text     = "      NhaiXinhTools - v1.1.0"
    $aboutForm.Controls.Add($aboutFormNameLabel)

    # About Text Label
    $aboutFormText.Location = "100, 40"
    $aboutFormText.Size     = "300, 30"
    $aboutFormText.Text     = "          Author: Pham Long Quan `r`n Contact: long.quan.2kk@gmail.com"
    $aboutForm.Controls.Add($aboutFormText)

    # About Exit Button
    $aboutFormExit.Location = "135, 70"
    $aboutFormExit.Text     = "OK"
    $aboutForm.Controls.Add($aboutFormExit)

    [void]$aboutForm.ShowDialog()
    $statusLabel.Text = "Ready"
} # End About

function addURL {
    $posCutURL = $ytbUrlTextbox.Text.IndexOf("&")

    if ($posCutURL -gt 0) {
        $ytbUrlTextbox.Text = $ytbUrlTextbox.Text.Substring(0, $posCutURL)
    }

    $ytbContentPanel.Visible = $false
    $ytbInforPanel.Visible = $true

    $url = $ytbUrlTextbox.Text

    if ($url -match '^(https?://(?:www\.)?youtube\.com/watch\?v=([a-zA-Z0-9_-]+))') {
        $videoId = ($url -split "/")[-1]
        $videoId = $videoId.Replace("watch?v=", "")
        $title = Get-YouTubeTitleFromID -videoId $videoId
        $thumbnailUrl = "https://img.youtube.com/vi/$videoId/maxresdefault.jpg"
        
        $thumbnailImage = Get-ResizedThumbnail -thumbnailUrl $thumbnailUrl -width 150 -height 100

        if ($thumbnailImage) {
            $ytbInforPanel.Controls.Clear()

            # Tạo một Panel con để hiển thị video
            $videoPanel = New-Object System.Windows.Forms.Panel
            $videoPanel.Size = New-Object System.Drawing.Size(500, 120)
            $videoPanel.Location = New-Object System.Drawing.Point(20, 15)
            $videoPanel.BackColor = [System.Drawing.Color]::FromArgb(0, 0, 0)

            # Tạo PictureBox để hiển thị thumbnail
            $pictureBox = New-Object System.Windows.Forms.PictureBox
            $pictureBox.Size = New-Object System.Drawing.Size(150, 100)
            $pictureBox.Location = New-Object System.Drawing.Point(10, 10)
            $pictureBox.Image = $thumbnailImage
            $pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage

            # Tạo Label để hiển thị tên bài hát
            $label = New-Object System.Windows.Forms.Label
            $label.Size = New-Object System.Drawing.Size(340, 100)
            $label.Location = New-Object System.Drawing.Point(170, 10)
            $label.Text = $title
            $label.ForeColor = "White"
            $label.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
            $label.AutoEllipsis = $true

            # Thêm PictureBox và Label vào Panel con
            $videoPanel.Controls.Add($pictureBox)
            $videoPanel.Controls.Add($label)

            # Thêm Panel con vào Panel chính
            $ytbInforPanel.Controls.Add($videoPanel)
        }
    } else {
        $ytbContentPanel.Visible    = $true
        $ytbInforPanel.Visible      = $false
        [System.Windows.Forms.MessageBox]::Show("Invalid URL. Please enter a valid YouTube link to Add.")
    }
}

function Get-ResizedThumbnail {
    param([string]$thumbnailUrl, [int]$width, [int]$height)

    try {
        $image = [System.Drawing.Image]::FromStream((New-Object System.Net.WebClient).OpenRead($thumbnailUrl))
        $resizedImage = New-Object System.Drawing.Bitmap $width, $height
        $graphics = [System.Drawing.Graphics]::FromImage($resizedImage)
        $graphics.DrawImage($image, 0, 0, $width, $height)
        $graphics.Dispose()
        return $resizedImage
    } catch {
        Write-Host "Không thể tải thumbnail từ $thumbnailUrl"
        $ytbContentPanel.Visible    = $true 
        $ytbInforPanel.Visible      = $false
        [System.Windows.Forms.MessageBox]::Show("Invalid URL. Please enter a valid YouTube link to Add.")
        return $null
    }
}

function Get-YouTubeTitleFromID {
    param([string]$videoId)
    try {
        $url = "https://www.youtube.com/oembed?url=http://www.youtube.com/watch?v=$videoId&format=json"
        $response = Invoke-RestMethod -Uri $url -Method Get
        return $response.title
    } catch {
        return "Can not take title from video ID"
    }
}

function downloadURL {
    $url = $ytbUrlTextbox.Text
    $format = $ytbFormatComboBox.SelectedItem

    if (($url -match '^(https?://(?:www\.)?youtube\.com/watch\?v=([a-zA-Z0-9_-]+))') -and ($ytbInforPanel.Visible -eq $false)) {
        [System.Windows.Forms.MessageBox]::Show("The video has not been added to the download list.")
        return
    }

    if ($url -notmatch '^(https?://(?:www\.)?youtube\.com/watch\?v=([a-zA-Z0-9_-]+))') {
        [System.Windows.Forms.MessageBox]::Show("Invalid URL. Please enter a valid YouTube link to Download.")
        return
    } 
    try {
        $statusLabel.Text = "Downloading..."
        D:\NXTools\resources\yt-dlp.exe -x -i -w --no-mtime --audio-format $($format) --audio-quality 0 $($url) -o "$($downloadsPath)\%(title)s.%(ext)s"
        [System.Windows.Forms.MessageBox]::Show("File downloaded successfully to: $($downloadsPath)")
        $statusLabel.Text = "Ready"
    } catch {
        $statusLabel.Text = "Error: Download failed."
    }
}

function browseAudioFile {
    $statusLabel.Text = "Browse audio file"
    if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedFile = $openFileDialog.FileName
        $fileName = [System.IO.Path]::GetFileNameWithoutExtension($selectedFile)
        $fileExtension = [System.IO.Path]::GetExtension($selectedFile)
        $cvFileNameTextBox.Text = "$fileName$([System.Environment]::NewLine)$fileExtension"
    }
    $statusLabel.Text = "Ready"
}

function convertAudioFile {
    $statusLabel.Text = "Converting..."
    $selectedFormat = $dropDownFormat.SelectedItem
    
    if (![string]::IsNullOrEmpty($cvFileNameTextBox.Text)) {
        $cvInputFile = $openFileDialog.FileName
        if (![string]::IsNullOrEmpty($cvInputFile)) {
            $outputFile = [System.IO.Path]::ChangeExtension($cvInputFile, $selectedFormat.ToLower())
        }
        elseif (![string]::IsNullOrEmpty($cvFilePathTextBox.Text)) {
            $outputFile = [System.IO.Path]::ChangeExtension($cvFilePathTextBox.Text, $selectedFormat.ToLower())
            $cvInputFile = $cvFilePathTextBox.Text
        }

        #$outputFile = $outputFile.Replace(" ", "")
        #$outputFile -replace '[ \\\\:\*\?\|\"\<\>]', ''
        $outputFile = $outputFile.Replace(".mp3", "(NXT Convert).mp3")

        $ffmpegPath = "D:\NXTools\resources\ffmpeg.exe"

        $arguments = "-y -i `"$cvInputFile`" -vn -ar 44100 -ac 2 -b:a 128k `"$outputFile`""
        try {
            $process = Start-Process -FilePath $ffmpegPath -ArgumentList $arguments -NoNewWindow -PassThru -Wait

            if ($process.ExitCode -eq 0) {
                [System.Windows.Forms.MessageBox]::Show("File converted successfully to: $outputFile")
            } else {
                [System.Windows.Forms.MessageBox]::Show("Conversion failed. Exit Code: $($process.ExitCode)", "Error")
            }

            $statusLabel.Text = "Ready"
        } catch {
            [System.Windows.Forms.MessageBox]::Show("An error occurred: $_", "Error")
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please select an audio file first.", "Error")
        $statusLabel.Text = "Ready"
    }
}

# Show Main Form

$Base64 = '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'
$mainForm.Icon = [Drawing.Icon][IO.MemoryStream][Convert]::FromBase64String($Base64)
[void] $mainForm.ShowDialog()