# Cue2Cue

An AutoHotkey utility for rapidly switching between track templates in REAPER DAW during live theatrical sound design.

## Overview

Cue2Cue automates the workflow of a live sound designer/engineer who needs to quickly load different track configurations (cues) during theatrical performances. It bridges the gap between a CSV-based cue sheet and REAPER's track template system, enabling one-button navigation between complex audio routing setups.

## The Problem It Solves

In theatrical sound design, each scene or moment ("cue") often requires:
- Different microphone assignments
- Unique VCA/bus routing
- Specific effects configurations
- Character-based track layouts

Manually creating and loading dozens of track templates for each cue in a show is time-consuming. Cue2Cue automates this entire workflow.

## Safety Considerations

⚠️ **Important:** This script **deletes all tracks** in your current REAPER project when switching cues.

**Best practices:**
1. Use a dedicated REAPER project for live performance
2. Save your project before running the script
3. Test all cues during technical rehearsal
4. Have a backup plan (manual templates or saved project states)

## How It Works

### Workflow

1. **Design your cue structure** in a CSV spreadsheet
2. **Convert CSV to REAPER templates** using the built-in converter
3. **Navigate cues during performance** using keyboard shortcuts or GUI buttons

### CSV to Template Conversion

The script reads a CSV file where:
- Each **row** represents a cue (moment in the show)
- Each **column** represents a VCA/bus/routing assignment
- Each **cell** contains a track name (character, SFX, ensemble group, etc.)

**Example from `sample-cues.csv`:**

```csv
VCA1,VCA2,VCA3,VCA4,VCA5,VCA6,VCA7,VCA8
BERT,JANE,MICHAEL,KATIE NANA,ADMIRAL,POLICEMAN,MLARK,Pit
BERT,WINIFRED,,KATIE NANA,BRILL,,MLARK,Pit
GOERGE,WINIFRED,,KATIE NANA,BRILL,ALL,,Pit
```

This generates individual `.RTrackTemplate` files:
- `Cue 1.RTrackTemplate` - First cue with BERT, JANE, MICHAEL, etc.
- `Cue 2.RTrackTemplate` - Second cue with BERT, WINIFRED, KATIE NANA, etc.
- `Cue 3.RTrackTemplate` - Third cue configuration

Each template file contains REAPER-formatted track definitions:
```
<TRACK
  NAME BERT
>
<TRACK
  NAME JANE
>
```

## Features

### GUI Interface
- **Prev/Next Buttons** - Step through cues sequentially
- **Go to** - Jump directly to a specific cue number
- **Convert CSV** - Generate all template files from a CSV file

### Keyboard Shortcuts
- **`Ctrl+Shift+Right`** - Next cue
- **`Ctrl+Shift+Left`** - Previous cue
- **`Ctrl+Shift+Up`** - Go to specific cue
- **`Ctrl+Shift+Down`** - Convert CSV file

### Automation
- Automatically deletes all tracks in REAPER
- Loads the selected template
- Shows brief confirmation with cue number (0.5 seconds)
- Prevents navigation below Cue 1

## Installation & Setup

### Prerequisites
- **REAPER** - Digital Audio Workstation
- **AutoHotkey** - Windows automation scripting language

### Setup

1. **Clone or download this repository**

2. **Configure the template directory** in `cue2cue.ahk`:
   ```ahk
   TemplateDir = C:\Users\Roscoe\Desktop\Cue2Cue\cues
   ```
   Change this path to where you want your cue templates stored.

3. **Create your cue sheet** in Excel or any CSV editor:
   - Row 1: Headers (VCA1, VCA2, etc.) - optional but recommended
   - Row 2+: Each row is a cue
   - Columns: Each column is a track/routing assignment
   - Cells: Track names (characters, SFX labels, etc.)
   - Empty cells: No track for that assignment in that cue

4. **Run the AutoHotkey script**:
   ```
   cue2cue.ahk
   ```

5. **Convert your CSV**:
   - Click "Convert CSV" or press `Ctrl+Shift+Down`
   - Select your CSV file
   - Templates will be generated in the `cues` subdirectory

## Usage Example: Musical Theatre Sound

For a production of *Mary Poppins*, your CSV might look like:

```csv
Lead1,Lead2,Lead3,Child1,Child2,Ensemble,SFX,Orchestra
BERT,,,,,,,Pit
BERT,MARY,,,,,ALL,Pit
GEORGE,WINIFRED,MARY,JANE,MICHAEL,,,Pit
,,MARY,JANE,MICHAEL,,SFX,
BERT,KEEPER,MARY,JANE,MICHAEL,ALL,,
```

This creates 5 cue templates. During performance:
- **Opening:** Load Cue 1 (BERT solo + Orchestra)
- **Mary arrives:** Press `Ctrl+Shift+Right` → Cue 2 (BERT, MARY, Ensemble)
- **Family scene:** Next → Cue 3 (Full family + Orchestra)
- **Children scene:** Next → Cue 4 (Just children + SFX)
- **Zoo scene:** Next → Cue 5 (Children + BERT + Ensemble)

## Technical Details

### REAPER Integration

The script uses Windows automation to interact with REAPER:
- **Window detection:** `ahk_class REAPRwnd` (REAPER's window class)
- **Menu automation:** Accesses Edit → Select all items/tracks via menu selection
- **Keyboard simulation:** Sends `Delete` key to clear tracks
- **File execution:** Runs `.RTrackTemplate` files which REAPER imports

### File Format

REAPER Track Templates (`.RTrackTemplate`) use a simple text format:
```
<TRACK
  NAME TrackName
>
```

The script generates these programmatically from CSV data.

### Cue Navigation Logic

```ahk
// Prevents going below cue 1
if (TemplateNumber <= 1) {
    TemplateNumber = 1
}

// Infinite forward navigation
// (stops when template file doesn't exist)
TemplateNumber := TemplateNumber + 1
```

## Files

```
cue2cue/
├── cue2cue.ahk           # Main AutoHotkey script
├── sample-cues.csv       # Example cue sheet (Mary Poppins)
├── .gitattributes        # Git configuration
└── README.md             # This file
```

## Use Cases

### Theatre Sound Design
- Quick mic assignment changes between scenes
- Routing changes for different musical numbers
- Effect send configurations per cue

### Live Mixing
- Pre-configured track layouts for different song sections
- Instant recall of complex routing setups
- Backup system for console snapshots

### Recording Sessions
- Different mic configurations per take
- Genre-specific track templates
- Artist-specific routing setups

## Limitations

- **Windows only** (AutoHotkey limitation)
- **REAPER-specific** (uses REAPER menu automation)
- **Destructive** (deletes all existing tracks before loading template)
- **Linear CSV structure** (each row = one cue, no complex nesting)
- **No undo** (make sure your REAPER project is saved)

## Example: Mary Poppins Production

The included `sample-cues.csv` shows a real-world example from a *Mary Poppins* production with:

- **Characters:** BERT, MARY, GEORGE, WINIFRED, JANE, MICHAEL, KATIE NANA
- **Ensemble:** ALL, KEEPER, NELEUS, ADMIRAL, POLICEMAN, BRILL, ROBERTSON
- **Special:** LARK (bird SFX), SFX (general effects), Pit (orchestra)

19 cues covering the entire show with varying track combinations.
