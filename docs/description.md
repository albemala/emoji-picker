# Core Glyph Engine

**Overview:** Unified glyph processing pipeline handling Emoji, Symbols, and Kaomoji via a normalized data model.

**Purpose:** Loads, normalizes, and searches extensive glyph databases from JSON assets to provide fast, searchable access to unicode characters.

**Technical Architecture:**
*   **Engine:** `GlyphsDataController` (Cubit) loads JSON assets → Maps to raw models (`Emoji`, `Symbol`, `Kaomoji`) → Normalizes to unified `Glyph` model.
*   **Search:** `SearchGlyphsDataController` (Cubit) implements `fuzzywuzzy` weighted ratio matching (>80 threshold) on names and keywords.
*   **Inputs:** JSON assets (`emoji.json`, `symbols.json`, `kaomoji.json`).
*   **Outputs:** `IList<Glyph>` (immutable lists for filtered/unfiltered data).

**Key Features:**
1.  **Unified Data Model:** Single `Glyph` class abstracts differences between Emoji, Symbols, and Kaomoji.
2.  **Fuzzy Search:** Weighted ratio matching enables natural language discovery.
3.  **Categorization:** Group-based organization for browsing.
4.  **Performance:** Fast lookups via unified `IMap` and immutable state.

**Supported Formats:**

| Type | Fields |
| :--- | :--- |
| **Emoji** | `char`, `name`, `group`, `skinToneSupport`, `keywords` |
| **Symbol** | `charcode`, `name`, `group` |
| **Kaomoji** | `string`, `keywords` |

**Tests:**
*   Golden tests (`golden_screenshot`) for UI verification.
*   Unit tests implied for core logic.

---

# Ejimo App

**Overview:** Cross-platform Flutter application wrapping the Core Glyph Engine.

**Features:**
*   **Multi-Platform:** Android, iOS, macOS, Windows, Linux, Web.
*   **Interaction:** Real-time search, clipboard copy, drag-and-drop.
*   **Personalization:** Favorites and Recent history persistence.
*   **UI:** Responsive design with `flex_color_scheme` and `google_fonts`.

**Architecture:**
*   **Pattern:** Feature-first directory structure.
*   **State Management:** `flutter_bloc` (Cubit) for view/data controllers.
*   **Persistence:** `flutter_data_storage` for local data.
