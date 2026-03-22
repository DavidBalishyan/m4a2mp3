param(
    [string]$Input = ".",
    [string]$Output = "mp3",
    [int]$Threads = 4,
    [int]$Quality = 2,
    [switch]$Verbose
)

if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Error "ffmpeg is not installed or not in PATH"
    exit 1
}

New-Item -ItemType Directory -Force -Path $Output | Out-Null

$files = Get-ChildItem -Path $Input -Filter *.m4a

$files | ForEach-Object -Parallel {
    $out = Join-Path $using:Output ($_.BaseName + ".mp3")
    if ($using:Verbose) {
        ffmpeg -i $_.FullName -vn -q:a $using:Quality $out
    } else {
        ffmpeg -loglevel error -i $_.FullName -vn -q:a $using:Quality $out
    }
} -ThrottleLimit $Threads