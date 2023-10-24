# Put this script into the folder you want to clean up before you run it. Or optionally, define a -Path in each Get-ChildItem command.
"Checking files in this folder: $((Get-Location).ProviderPath)`nPlease wait...`n"

# Get all files older than 30 days in the current directory. Feel free to adjust this number.
$FilesToDelete = (Get-ChildItem -Recurse -Force -File).Where({$_.LastWriteTime -lt (Get-Date).AddDays(-30)})

Read-Host "CAUTION: Press ENTER to permanently delete $($FilesToDelete.count) files that are older than 1 month, and then empty folders, from this folder $((Get-Location).ProviderPath) !!! If you do NOT wish to do this, close the script now!"
$FilesToDelete | Remove-Item -Confirm:$false # Delete files before folders

# Get all empty folders (including folders that contain only empty folders recursively) in the current directory and delete them. Feel free to remove this if you only care about removing the files above.
$FoldersToDelete = (Get-ChildItem -Recurse -Force -Directory).Where({$_.GetFileSystemInfos().Count -eq 0}) 
$FoldersToDelete | Remove-Item -Recurse -Confirm:$false -ErrorAction SilentlyContinue
