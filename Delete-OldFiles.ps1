# Put this script into the folder you want to clean up before you run it. Or optionally, define a -Path in each Get-ChildItem command.
"Warning: this script is designed to help you clean up user-created folders. It will permanently delete old files, including hidden files. Do not run this in system directories!"
Read-Host "Ready to check files in this folder: $((Get-Location).ProviderPath)`nPress ENTER to proceed. (Or close this script to exit.)"
"Please wait...`n"

# Get all files older than 30 days (feel free to adjust this number) in the current folder, plus subfolders, including hidden files.
$FilesToDelete = (Get-ChildItem -Recurse -Force -File).Where({$_.LastWriteTime -lt (Get-Date).AddDays(-30)})

Read-Host "CAUTION: Press ENTER to PERMANENTLY DELETE $($FilesToDelete.count) files that are older than 30 days, and then empty folders, from this folder $((Get-Location).ProviderPath)!!!`nIf you do NOT wish to do this, close the script now!"
$FilesToDelete | Remove-Item -Confirm:$false # Delete files before folders

# Get all empty folders (including folders that contain only empty folders recursively) in the current directory and delete them. Feel free to remove this if you only care about removing the files above.
$FoldersToDelete = (Get-ChildItem -Recurse -Force -Directory).Where({$_.GetFileSystemInfos().Count -eq 0}) 
$FoldersToDelete | Remove-Item -Recurse -Confirm:$false -ErrorAction SilentlyContinue
