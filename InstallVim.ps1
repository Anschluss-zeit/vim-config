# ����7-Zip�����й���
$7ZipUrl = "https://github.com/Anschluss-zeit/vim-config/raw/main/7z2301-x64.exe"
$7ZipInstallerPath = "$env:TEMP\7z_installer.exe"
$7ZipPath = "C:\Program Files\7-Zip"
echo "�������ز���װ 7Zip"
Invoke-WebRequest -Uri $7ZipUrl -OutFile $7ZipInstallerPath

# ��װ7-Zip�����й���
Start-Process -Wait -FilePath $7ZipInstallerPath -ArgumentList "/S"
Remove-Item $7ZipInstallerPath

$existingPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
$newPaths = $7ZipPath
$newPath = $newPaths -join ';'
$newPath = $newPath + ';' + $existingPath
[System.Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)

# ���ز���װVim
$VimInstallerUrl = "https://github.com/vim/vim-win32-installer/releases/download/v9.0.0000/gvim_9.0.0000_x86_signed.exe"
$VimInstallerPath = "$env:TEMP\vim_installer.exe"
$VimInstallDir = "D:\Vim"

echo "�������ز���װ Vim90"
Invoke-WebRequest -Uri $VimInstallerUrl -OutFile $VimInstallerPath
Start-Process -Wait -FilePath $VimInstallerPath -ArgumentList "/S /D=$VimInstallDir"
Remove-Item $VimInstallerPath

# ���ز���װGit
$GitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.1/Git-2.42.0-64-bit.exe"
$GitInstallerPath = "$env:TEMP\git_installer.exe"
$GitInstallDir = "D:\Git"

# ���ز���װMingw-w64

# ����mingw-w64��7zѹ����
$MingwArchiveUrl = "https://github.com/niXman/mingw-builds-binaries/releases/download/12.2.0-rt_v10-rev2/x86_64-12.2.0-release-win32-seh-ucrt-rt_v10-rev2.7z"
$MingwArchivePath = "$env:TEMP\mingw-w64.7z"

# Git
echo "�������ز���װ Git v2.42.0"
Invoke-WebRequest -Uri $GitInstallerUrl -OutFile $GitInstallerPath
Start-Process -Wait -FilePath $GitInstallerPath -ArgumentList "/SILENT /DIR=$GitInstallDir"
Remove-Item $GitInstallerPath

# Mingw-w64
echo "�������ز���װ Mingw-w64"
Invoke-WebRequest -Uri $MingwArchiveUrl -OutFile $MingwArchivePath

# ʹ��7-Zip��ѹmingw-w64
$MingwInstallDir = "D:\Mingw-w64"
$7ZipExecutableFile = $7ZipPath + "\7z.exe"
Start-Process -Wait -FilePath "$7ZipExecutableFile" -ArgumentList "x $MingwArchivePath -o$MingwInstallDir"
Remove-Item $MingwArchivePath

# Windows Terminal
echo "�������ز���װ Windows Terminal"
$TerminalZipUrl = "https://github.com/Anschluss-zeit/vim-config/raw/main/terminal.zip"
$TerminalInstallDir = "D:\terminal"
$TerminalZipPath = "$env:TEMP\terminal.zip"

# ���� Windows Terminal
Invoke-WebRequest -Uri $TerminalZipUrl -OutFile $TerminalZipPath
Start-Process -Wait -FilePath "$7ZipExecutableFile" -ArgumentList "x $TerminalZipPath -o$TerminalInstallDir"
Remove-Item $TerminalZipPath

# ����Ŀ¼���ļ�
echo "��װVim-Plug����������ļ�"
$VimPlugPath = "$env:USERPROFILE\vimfiles\autoload\plug.vim"
$VimrcPath = "$env:USERPROFILE\_vimrc"
$VimPlugUri = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
$VimrcUri = "https://raw.githubusercontent.com/Anschluss-zeit/vim-config/main/.vimrc"
New-Item -ItemType Directory -Force -Path $env:USERPROFILE\vimfiles\autoload
Invoke-WebRequest -Uri $VimPlugUri -OutFile $VimPlugPath
Invoke-WebRequest -Uri $VimrcUri -OutFile $VimrcPath

# ���ļ�����ӵ�Path��������
echo "���ļ�����ӵ�Path��������"
$existingPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
$newPaths = "$VimInstallDir\vim90", "$GitInstallDir\bin", "$MingwInstallDir\mingw64\bin"
$newPath = $newPaths -join ';'
$newPath = $newPath + ';' + $existingPath
[System.Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)

Read-Host -Prompt "�ű�ִ����ϣ����»س����Լ���..."