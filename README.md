# Sharp Image Scoring - ImageGalleryViewer

<div align="center">

**A native Windows WPF application for browsing and managing scored images**

[![.NET](https://img.shields.io/badge/.NET-8.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[Features](#features) • [Installation](#installation) • [Usage](#usage) • [Architecture](#architecture)

</div>

---

## Overview

ImageGalleryViewer is a high-performance Windows desktop application that provides a native viewing experience for images processed by the [image-scoring](https://github.com/synthet/musiq-image-scoring) project. Built with WPF and .NET 8, it directly reads from the Firebird database to display scored photos with advanced filtering capabilities.

## Features

### 🚀 Performance
- **Native Windows Shell Thumbnails**: Uses `IShellItemImageFactory` for lightning-fast thumbnail extraction
- **GPU-Accelerated Rendering**: Leverages WPF's hardware acceleration
- **Lazy Loading**: Efficient memory management for large collections

### 🎨 User Experience
- **Dark Modern UI**: Sleek dark theme matching modern design standards
- **Windows Photos Integration**: Double-click to open images in Windows Photos with full navigation
- **Keyboard Shortcuts**: Full keyboard navigation and control
- **Advanced Filtering**: Multi-dimensional filtering by rating, labels, scores, dates, and keywords

### 📊 Image Management
- **Folder Tree Navigation**: Browse images by directory structure
- **Stack Visualization**: View and filter by image stacks/groups
- **Metadata Panel**: Comprehensive EXIF, IPTC, and scoring data display
- **Smart Search**: Filter by keywords and metadata

## Installation

### Prerequisites
- **Windows 10/11** (version 1809 or later)
- **.NET 8 Runtime** ([Download](https://dotnet.microsoft.com/download/dotnet/8.0))
- **Firebird Database** from image-scoring project

### Quick Start

```powershell
# Clone the repository
git clone git@github.com:synthet/sharp-image-scoring.git
cd sharp-image-scoring

# Build
dotnet build ImageGalleryViewer.sln

# Run
dotnet run --project ImageGalleryViewer/ImageGalleryViewer
```

### Configuration

On first run, configure the database path in:
```
%LOCALAPPDATA%\ImageGalleryViewer\settings.json
```

Example configuration:
```json
{
  "DatabasePath": "D:\\Projects\\image-scoring\\SCORING_HISTORY.FDB",
  "PageSize": 50,
  "ThumbnailCacheSizeMb": 200
}
```

## Usage

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Enter` | Open selected image in Windows Photos |
| `F5` | Refresh gallery |
| `Page Down` / `Page Up` | Navigate pages |
| `Ctrl+Home` / `Ctrl+End` | First / Last page |
| `Ctrl+E` | Show in Explorer |
| `Ctrl+Shift+C` | Copy file path |

### Filtering Images

1. **By Rating**: Use the star filter dropdown
2. **By Color Label**: Filter by Red, Yellow, Green, Blue, Purple
3. **By Score Range**: Slider for General/Technical/Aesthetic scores
4. **By Folder**: Select folder from the tree view
5. **By Keywords**: Type keywords in the search box
6. **By Stack**: Click stack badge to filter by image group

## Architecture

```
ImageGalleryViewer/
├── Models/              # Data models (ImageRecord, FilterState, FolderNode)
├── Services/            # Business logic layer
│   ├── DatabaseService.cs    # Firebird/SQLite query abstraction
│   ├── PathResolver.cs       # WSL ↔ Windows path conversion
│   ├── ThumbnailService.cs   # Shell thumbnail extraction
│   ├── PhotosLauncher.cs     # Windows Photos integration
│   └── SettingsService.cs    # User settings persistence
├── ViewModels/          # MVVM ViewModels with INotifyPropertyChanged
├── Views/               # WPF XAML views
│   └── MainWindow.xaml       # Main application window
└── Converters/          # Value converters for XAML binding

ImageGalleryViewer.Tests/
├── FolderNodeTests.cs
├── PathResolverTests.cs
├── PhotosLauncherTests.cs
└── NullToVisibilityConverterTests.cs
```

### Design Patterns

- **MVVM**: Clear separation between UI and business logic
- **Dependency Injection**: Service locator pattern for testability
- **Repository Pattern**: Database abstraction layer
- **Observer Pattern**: Property change notifications

## Integration with Image-Scoring

ImageGalleryViewer is designed to work seamlessly with the Python-based [image-scoring](https://github.com/synthet/musiq-image-scoring) project:

1. **Shared Database**: Reads from the same Firebird database
2. **Path Conversion**: Handles WSL ↔ Windows path translation automatically
3. **Real-time Updates**: F5 refresh shows latest scoring results
4. **No Dependencies**: Runs independently; doesn't require Python installation

### Workflow

```mermaid
graph LR
    A[Score Images<br/>Python Pipeline] -->|Writes to| B[(Firebird DB)]
    B -->|Reads from| C[ImageGalleryViewer<br/>WPF App]
    C -->|Opens| D[Windows Photos]
```

## Testing

```powershell
# Run all tests
dotnet test

# Run with verbose output
dotnet test -v detailed

# Run specific test
dotnet test --filter "TestName~PathResolver"
```

## Development

### Building from Source

```powershell
# Debug build
dotnet build ImageGalleryViewer.sln -c Debug

# Release build
dotnet build ImageGalleryViewer.sln -c Release

#Publish self-contained executable
dotnet publish ImageGalleryViewer/ImageGalleryViewer.csproj `
  -c Release `
  -r win-x64 `
  --self-contained true `
  -p:PublishSingleFile=true
```

### Project Structure

- **Target Framework**: .NET 8.0-windows
- **Language**: C# 12
- **UI Framework**: Windows Presentation Foundation (WPF)
- **Test Framework**: xUnit
- **Database**: Firebird via FirebirdSql.Data.FirebirdClient

## Troubleshooting

### Database Connection Issues

If the viewer can't connect to the database:

1. Check database path in settings.json
2. Verify Firebird server is running (if using server mode)
3. Ensure file path uses Windows format (not WSL)
4. Check file permissions

### Thumbnail Display Issues

If thumbnails don't appear:

1. Verify image files exist at specified paths
2. Check path conversion (WSL → Windows)
3. Clear thumbnail cache: delete `%LOCALAPPDATA%\ImageGalleryViewer\cache`
4. Rebuild thumbnails from image-scoring WebUI

### Windows Photos Integration

If images don't open in Windows Photos:

1. Verify Windows Photos app is installed
2. Check default photo viewer settings
3. Ensure file associations are correct
4. Try opening image manually to verify file integrity

## License

MIT License - See [LICENSE](LICENSE) for details

## Related Projects

- **[musiq-image-scoring](https://github.com/synthet/musiq-image-scoring)**: Python image quality scoring pipeline
- Main scoring engine and database management
- GPU-accelerated ML models for image quality assessment

## History

This project was extracted from the image-scoring repository on 2026-01-31 using `git subtree split` to preserve its complete git history (21 commits). The separation allows independent development while maintaining integration through the shared Firebird database.

---

<div align="center">

**Made with ❤️ for photographers**

[Report Bug](https://github.com/synthet/sharp-image-scoring/issues) • [Request Feature](https://github.com/synthet/sharp-image-scoring/issues)

</div>
